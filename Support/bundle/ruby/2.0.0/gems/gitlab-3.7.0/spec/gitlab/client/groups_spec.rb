require 'spec_helper'

describe Gitlab::Client do
  describe ".groups" do
    before do
      stub_get("/groups", "groups")
      stub_get("/groups/3", "group")
      @group = Gitlab.group(3)
      @groups = Gitlab.groups
    end

    it "should get the correct resource" do
      expect(a_get("/groups")).to have_been_made
      expect(a_get("/groups/3")).to have_been_made
    end

    it "should return a paginated response of groups" do
      expect(@groups).to be_a Gitlab::PaginatedResponse
      expect(@groups.first.path).to eq("threegroup")
    end
  end

  describe ".create_group" do
    context "without description" do
      before do
        stub_post("/groups", "group_create")
        @group = Gitlab.create_group('GitLab-Group', 'gitlab-path')
      end

      it "should get the correct resource" do
        expect(a_post("/groups").
            with(body: { path: 'gitlab-path', name: 'GitLab-Group' })).to have_been_made
      end

      it "should return information about a created group" do
        expect(@group.name).to eq("Gitlab-Group")
        expect(@group.path).to eq("gitlab-group")
      end
    end

    context "with description" do
      before do
        stub_post("/groups", "group_create_with_description")
        @group = Gitlab.create_group('GitLab-Group', 'gitlab-path', description: 'gitlab group description')
      end

      it "should get the correct resource" do
        expect(a_post("/groups").
                 with(body: { path: 'gitlab-path', name: 'GitLab-Group',
                              description: 'gitlab group description' })).to have_been_made
      end

      it "should return information about a created group" do
        expect(@group.name).to eq("Gitlab-Group")
        expect(@group.path).to eq("gitlab-group")
        expect(@group.description).to eq("gitlab group description")
      end
    end
  end

  describe ".delete_group" do
    context "without description" do
      before do
        stub_delete("/groups/42", "group_delete")
        @group = Gitlab.delete_group(42)
      end

      it "should get the correct resource" do
        expect(a_delete("/groups/42")).to have_been_made
      end

      it "should return information about a deleted group" do
        expect(@group.name).to eq("Gitlab-Group")
        expect(@group.path).to eq("gitlab-group")
      end
    end
  end

  describe ".transfer_project_to_group" do
    before do
      stub_post("/projects", "project")
      @project = Gitlab.create_project('Gitlab')
      stub_post("/groups", "group_create")
      @group = Gitlab.create_group('GitLab-Group', 'gitlab-path')

      stub_post("/groups/#{@group.id}/projects/#{@project.id}", "group_create")
      @group_transfer = Gitlab.transfer_project_to_group(@group.id, @project.id)
    end

    it "should post to the correct resource" do
      expect(a_post("/groups/#{@group.id}/projects/#{@project.id}").with(body: { id: @group.id.to_s, project_id: @project.id.to_s })).to have_been_made
    end

    it "should return information about the group" do
      expect(@group_transfer.name).to eq(@group.name)
      expect(@group_transfer.path).to eq(@group.path)
      expect(@group_transfer.id).to eq(@group.id)
    end
  end

  describe ".group_members" do
    before do
      stub_get("/groups/3/members", "group_members")
      @members = Gitlab.group_members(3)
    end

    it "should get the correct resource" do
      expect(a_get("/groups/3/members")).to have_been_made
    end

    it "should return information about a group members" do
      expect(@members).to be_a Gitlab::PaginatedResponse
      expect(@members.size).to eq(2)
      expect(@members[1].name).to eq("John Smith")
    end
  end

  describe ".add_group_member" do
    before do
      stub_post("/groups/3/members", "group_member")
      @member = Gitlab.add_group_member(3, 1, 40)
    end

    it "should get the correct resource" do
      expect(a_post("/groups/3/members").
        with(body: { user_id: '1', access_level: '40' })).to have_been_made
    end

    it "should return information about the added member" do
      expect(@member.name).to eq("John Smith")
    end
  end

  describe ".edit_group_member" do
    before do
      stub_put("/groups/3/members/1", "group_member_edit")
      @member = Gitlab.edit_group_member(3, 1, 50)
    end

    it "should get the correct resource" do
      expect(a_put("/groups/3/members/1")
          .with(body: { access_level: '50'})).to have_been_made
    end

    it "should return information about the edited member" do
      expect(@member.access_level).to eq(50)
    end
  end

  describe ".remove_group_member" do
    before do
      stub_delete("/groups/3/members/1", "group_member_delete")
      @group = Gitlab.remove_group_member(3, 1)
    end

    it "should get the correct resource" do
      expect(a_delete("/groups/3/members/1")).to have_been_made
    end

    it "should return information about the group the member was removed from" do
      expect(@group.group_id).to eq(3)
    end
  end

  describe ".group_projects" do
    before do
      stub_get("/groups/4/projects", "group_projects")
      @projects = Gitlab.group_projects(4)
    end

    it "should get the list of projects" do
      expect(a_get("/groups/4/projects")).to have_been_made
    end

    it "should return a list of of projects under a group" do
      expect(@projects).to be_a Gitlab::PaginatedResponse
      expect(@projects.size).to eq(1)
      expect(@projects[0].name).to eq("Diaspora Client")
    end
  end

  describe ".group_search" do
    before do
      stub_get("/groups?search=Group", "group_search")
      @groups = Gitlab.group_search('Group')
    end

    it "should get the correct resource" do
      expect(a_get("/groups?search=Group")).to have_been_made
    end

    it "should return an array of groups found" do
      expect(@groups.first.id).to eq(5)
      expect(@groups.last.id).to eq(8)
    end
  end
end
