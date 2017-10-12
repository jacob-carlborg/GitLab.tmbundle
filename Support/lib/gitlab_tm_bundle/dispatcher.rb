module GitLabTmBundle
  class Dispatcher
    def self.dispatch(command)
      Commands::Base.create(command).run
    end
  end
end
