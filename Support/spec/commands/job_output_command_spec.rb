require 'spec_helper'

describe GitLabTmBundle::Commands::JobOutput do
  subject { GitLabTmBundle::Commands::JobOutput.new(stdout_sync: nil) }

  describe 'bold' do
    def bold(string)
      subject.send(:bold, string)
    end

    it 'returns the given string in bold' do
      expect(bold('foo')).to eq('<b>foo</b>')
    end
  end

  describe 'build_title' do
    let(:job) { double(:job) }
    let(:commit) { double(:commit) }
    let(:title) { 'title' }
    let(:id) { 1 }

    before do
      allow(job).to receive(:id).and_return(id)
      allow(job).to receive(:commit).and_return(commit)
      allow(commit).to receive(:title).and_return(title)
    end

    def build_title
      subject.send(:build_title, job)
    end

    it 'builds and returns a title for the job' do
      expect(build_title).to eq("Job ##{id} - #{title}")
    end
  end

  describe 'output' do
    # rubocop:disable Style/ClassAndModuleChildren
    class self::HTMLOutput
      def self.show(_options)
        str = ''
        yield str
        str
      end
    end
    # rubocop:enable Style/ClassAndModuleChildren

    let(:default_options) do
      { title: 'Build Output', html_head: subject.class::HTML_HEADER }
    end

    before do
      define_html_output
    end

    def define_html_output
      base = self.class
      base = base.superclass until base.const_defined?('HTMLOutput')
      stub_const('TextMate::HTMLOutput', base::HTMLOutput)
    end

    def output(&block)
      subject.send(:output, given_options, &block)
    end

    context 'when no options are given' do
      let(:given_options) { {} }
      let(:expected_options) { default_options }
      let(:io) { '' }

      it 'calls TextMate::HTMLOutput.show with the default options' do
        expect(TextMate::HTMLOutput).to receive(:show).with(expected_options)
        output
      end

      it 'yields the object yielded TextMate::HTMLOutput.show' do
        allow(TextMate::HTMLOutput).to receive(:show)
          .with(expected_options)
          .and_yield(io)

        output { |io| io << 'foo' }
        expect(io).to eq('<pre>foo</pre>')
      end

      it 'prepends <pre> to the yielded object' do
        allow(TextMate::HTMLOutput).to receive(:show)
          .with(expected_options)
          .and_yield(io)

        output {}
        expect(io).to start_with('<pre>')
      end

      it 'appends <pre> to the yielded object' do
        allow(TextMate::HTMLOutput).to receive(:show)
          .with(expected_options)
          .and_yield(io)

        output {}
        expect(io).to end_with('</pre>')
      end
    end

    context 'when options are given' do
      let(:given_options) { { foo: 3 } }
      let(:expected_options) { default_options.merge(given_options) }

      it 'adds the default options before calling TextMate::HTMLOutput.show ' do
        expect(TextMate::HTMLOutput).to receive(:show).with(expected_options)
        output
      end
    end
  end
end
