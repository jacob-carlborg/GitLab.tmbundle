module GitLabTmBundle
  module Commands
    # rubocop:disable Metrics/ClassLength
    class JobOutput < Base
      include GitLabBuildOutput

      class Outputter < HtmlOutputter
        attr_reader :io

        def initialize(io)
          @io = io
        end

        def output(trace)
          io << ansi_to_html(trace) unless trace.empty?
        end
      end

      HTML_HEADER = <<-HTML.freeze
        <style type="text/css" media="screen">
          .term-bold {
            font-weight: bold
          }

          .term-italic {
            font-style: italic
          }

          .term-conceal {
            visibility: hidden
          }

          .term-underline {
            text-decoration: underline
          }

          .term-cross {
            text-decoration: line-through
          }

          .term-fg-black {
            color: #000
          }

          .term-fg-red {
            color: #c66
          }

          .term-fg-green {
            color: #05a20b
          }

          .term-fg-yellow {
            color: #cdcd00
          }

          .term-fg-blue {
            color: #00e
          }

          .term-fg-magenta {
            color: #cd00cd
          }

          .term-fg-cyan {
            color: #00cdcd
          }

          .term-fg-white {
            color: #e5e5e5
          }

          .term-fg-l-black {
            color: #373b41
          }

          .term-fg-l-red {
            color: #c66
          }

          .term-fg-l-green {
            color: #05a20b
          }

          .term-fg-l-yellow {
            color: #f0c674
          }

          .term-fg-l-blue {
            color: #81a2be
          }

          .term-fg-l-magenta {
            color: #b294bb
          }

          .term-fg-l-cyan {
            color: #8abeb7
          }

          .term-fg-l-white {
            color: #c4c4c4
          }

          .term-bg-black {
            background-color: #000
          }

          .term-bg-red {
            background-color: #cd0000
          }

          .term-bg-green {
            background-color: #00cd00
          }

          .term-bg-yellow {
            background-color: #cdcd00
          }

          .term-bg-blue {
            background-color: #00e
          }

          .term-bg-magenta {
            background-color: #cd00cd
          }

          .term-bg-cyan {
            background-color: #00cdcd
          }

          .term-bg-white {
            background-color: #e5e5e5
          }

          .term-bg-l-black {
            background-color: #373b41
          }

          .term-bg-l-red {
            background-color: #c66
          }

          .term-bg-l-green {
            background-color: #b5bd68
          }

          .term-bg-l-yellow {
            background-color: #f0c674
          }

          .term-bg-l-blue {
            background-color: #81a2be
          }

          .term-bg-l-magenta {
            background-color: #b294bb
          }

          .term-bg-l-cyan {
            background-color: #8abeb7
          }

          .term-bg-l-white {
            background-color: #c4c4c4
          }

          .xterm-fg-0 {
            color: #000
          }

          .xterm-fg-1 {
            color: #800000
          }

          .xterm-fg-2 {
            color: #008000
          }

          .xterm-fg-3 {
            color: #808000
          }

          .xterm-fg-4 {
            color: #000080
          }

          .xterm-fg-5 {
            color: #800080
          }

          .xterm-fg-6 {
            color: #008080
          }

          .xterm-fg-7 {
            color: #c0c0c0
          }

          .xterm-fg-8 {
            color: #808080
          }

          .xterm-fg-9 {
            color: #f00
          }

          .xterm-fg-10 {
            color: #0f0
          }

          .xterm-fg-11 {
            color: #ff0
          }

          .xterm-fg-12 {
            color: #00f
          }

          .xterm-fg-13 {
            color: #f0f
          }

          .xterm-fg-14 {
            color: #0ff
          }

          .xterm-fg-15 {
            color: #fff
          }

          .xterm-fg-16 {
            color: #000
          }

          .xterm-fg-17 {
            color: #00005f
          }

          .xterm-fg-18 {
            color: #000087
          }

          .xterm-fg-19 {
            color: #0000af
          }

          .xterm-fg-20 {
            color: #0000d7
          }

          .xterm-fg-21 {
            color: #00f
          }

          .xterm-fg-22 {
            color: #005f00
          }

          .xterm-fg-23 {
            color: #005f5f
          }

          .xterm-fg-24 {
            color: #005f87
          }

          .xterm-fg-25 {
            color: #005faf
          }

          .xterm-fg-26 {
            color: #005fd7
          }

          .xterm-fg-27 {
            color: #005fff
          }

          .xterm-fg-28 {
            color: #008700
          }

          .xterm-fg-29 {
            color: #00875f
          }

          .xterm-fg-30 {
            color: #008787
          }

          .xterm-fg-31 {
            color: #0087af
          }

          .xterm-fg-32 {
            color: #0087d7
          }

          .xterm-fg-33 {
            color: #0087ff
          }

          .xterm-fg-34 {
            color: #00af00
          }

          .xterm-fg-35 {
            color: #00af5f
          }

          .xterm-fg-36 {
            color: #00af87
          }

          .xterm-fg-37 {
            color: #00afaf
          }

          .xterm-fg-38 {
            color: #00afd7
          }

          .xterm-fg-39 {
            color: #00afff
          }

          .xterm-fg-40 {
            color: #00d700
          }

          .xterm-fg-41 {
            color: #00d75f
          }

          .xterm-fg-42 {
            color: #00d787
          }

          .xterm-fg-43 {
            color: #00d7af
          }

          .xterm-fg-44 {
            color: #00d7d7
          }

          .xterm-fg-45 {
            color: #00d7ff
          }

          .xterm-fg-46 {
            color: #0f0
          }

          .xterm-fg-47 {
            color: #00ff5f
          }

          .xterm-fg-48 {
            color: #00ff87
          }

          .xterm-fg-49 {
            color: #00ffaf
          }

          .xterm-fg-50 {
            color: #00ffd7
          }

          .xterm-fg-51 {
            color: #0ff
          }

          .xterm-fg-52 {
            color: #5f0000
          }

          .xterm-fg-53 {
            color: #5f005f
          }

          .xterm-fg-54 {
            color: #5f0087
          }

          .xterm-fg-55 {
            color: #5f00af
          }

          .xterm-fg-56 {
            color: #5f00d7
          }

          .xterm-fg-57 {
            color: #5f00ff
          }

          .xterm-fg-58 {
            color: #5f5f00
          }

          .xterm-fg-59 {
            color: #5f5f5f
          }

          .xterm-fg-60 {
            color: #5f5f87
          }

          .xterm-fg-61 {
            color: #5f5faf
          }

          .xterm-fg-62 {
            color: #5f5fd7
          }

          .xterm-fg-63 {
            color: #5f5fff
          }

          .xterm-fg-64 {
            color: #5f8700
          }

          .xterm-fg-65 {
            color: #5f875f
          }

          .xterm-fg-66 {
            color: #5f8787
          }

          .xterm-fg-67 {
            color: #5f87af
          }

          .xterm-fg-68 {
            color: #5f87d7
          }

          .xterm-fg-69 {
            color: #5f87ff
          }

          .xterm-fg-70 {
            color: #5faf00
          }

          .xterm-fg-71 {
            color: #5faf5f
          }

          .xterm-fg-72 {
            color: #5faf87
          }

          .xterm-fg-73 {
            color: #5fafaf
          }

          .xterm-fg-74 {
            color: #5fafd7
          }

          .xterm-fg-75 {
            color: #5fafff
          }

          .xterm-fg-76 {
            color: #5fd700
          }

          .xterm-fg-77 {
            color: #5fd75f
          }

          .xterm-fg-78 {
            color: #5fd787
          }

          .xterm-fg-79 {
            color: #5fd7af
          }

          .xterm-fg-80 {
            color: #5fd7d7
          }

          .xterm-fg-81 {
            color: #5fd7ff
          }

          .xterm-fg-82 {
            color: #5fff00
          }

          .xterm-fg-83 {
            color: #5fff5f
          }

          .xterm-fg-84 {
            color: #5fff87
          }

          .xterm-fg-85 {
            color: #5fffaf
          }

          .xterm-fg-86 {
            color: #5fffd7
          }

          .xterm-fg-87 {
            color: #5fffff
          }

          .xterm-fg-88 {
            color: #870000
          }

          .xterm-fg-89 {
            color: #87005f
          }

          .xterm-fg-90 {
            color: #870087
          }

          .xterm-fg-91 {
            color: #8700af
          }

          .xterm-fg-92 {
            color: #8700d7
          }

          .xterm-fg-93 {
            color: #8700ff
          }

          .xterm-fg-94 {
            color: #875f00
          }

          .xterm-fg-95 {
            color: #875f5f
          }

          .xterm-fg-96 {
            color: #875f87
          }

          .xterm-fg-97 {
            color: #875faf
          }

          .xterm-fg-98 {
            color: #875fd7
          }

          .xterm-fg-99 {
            color: #875fff
          }

          .xterm-fg-100 {
            color: #878700
          }

          .xterm-fg-101 {
            color: #87875f
          }

          .xterm-fg-102 {
            color: #878787
          }

          .xterm-fg-103 {
            color: #8787af
          }

          .xterm-fg-104 {
            color: #8787d7
          }

          .xterm-fg-105 {
            color: #8787ff
          }

          .xterm-fg-106 {
            color: #87af00
          }

          .xterm-fg-107 {
            color: #87af5f
          }

          .xterm-fg-108 {
            color: #87af87
          }

          .xterm-fg-109 {
            color: #87afaf
          }

          .xterm-fg-110 {
            color: #87afd7
          }

          .xterm-fg-111 {
            color: #87afff
          }

          .xterm-fg-112 {
            color: #87d700
          }

          .xterm-fg-113 {
            color: #87d75f
          }

          .xterm-fg-114 {
            color: #87d787
          }

          .xterm-fg-115 {
            color: #87d7af
          }

          .xterm-fg-116 {
            color: #87d7d7
          }

          .xterm-fg-117 {
            color: #87d7ff
          }

          .xterm-fg-118 {
            color: #87ff00
          }

          .xterm-fg-119 {
            color: #87ff5f
          }

          .xterm-fg-120 {
            color: #87ff87
          }

          .xterm-fg-121 {
            color: #87ffaf
          }

          .xterm-fg-122 {
            color: #87ffd7
          }

          .xterm-fg-123 {
            color: #87ffff
          }

          .xterm-fg-124 {
            color: #af0000
          }

          .xterm-fg-125 {
            color: #af005f
          }

          .xterm-fg-126 {
            color: #af0087
          }

          .xterm-fg-127 {
            color: #af00af
          }

          .xterm-fg-128 {
            color: #af00d7
          }

          .xterm-fg-129 {
            color: #af00ff
          }

          .xterm-fg-130 {
            color: #af5f00
          }

          .xterm-fg-131 {
            color: #af5f5f
          }

          .xterm-fg-132 {
            color: #af5f87
          }

          .xterm-fg-133 {
            color: #af5faf
          }

          .xterm-fg-134 {
            color: #af5fd7
          }

          .xterm-fg-135 {
            color: #af5fff
          }

          .xterm-fg-136 {
            color: #af8700
          }

          .xterm-fg-137 {
            color: #af875f
          }

          .xterm-fg-138 {
            color: #af8787
          }

          .xterm-fg-139 {
            color: #af87af
          }

          .xterm-fg-140 {
            color: #af87d7
          }

          .xterm-fg-141 {
            color: #af87ff
          }

          .xterm-fg-142 {
            color: #afaf00
          }

          .xterm-fg-143 {
            color: #afaf5f
          }

          .xterm-fg-144 {
            color: #afaf87
          }

          .xterm-fg-145 {
            color: #afafaf
          }

          .xterm-fg-146 {
            color: #afafd7
          }

          .xterm-fg-147 {
            color: #afafff
          }

          .xterm-fg-148 {
            color: #afd700
          }

          .xterm-fg-149 {
            color: #afd75f
          }

          .xterm-fg-150 {
            color: #afd787
          }

          .xterm-fg-151 {
            color: #afd7af
          }

          .xterm-fg-152 {
            color: #afd7d7
          }

          .xterm-fg-153 {
            color: #afd7ff
          }

          .xterm-fg-154 {
            color: #afff00
          }

          .xterm-fg-155 {
            color: #afff5f
          }

          .xterm-fg-156 {
            color: #afff87
          }

          .xterm-fg-157 {
            color: #afffaf
          }

          .xterm-fg-158 {
            color: #afffd7
          }

          .xterm-fg-159 {
            color: #afffff
          }

          .xterm-fg-160 {
            color: #d70000
          }

          .xterm-fg-161 {
            color: #d7005f
          }

          .xterm-fg-162 {
            color: #d70087
          }

          .xterm-fg-163 {
            color: #d700af
          }

          .xterm-fg-164 {
            color: #d700d7
          }

          .xterm-fg-165 {
            color: #d700ff
          }

          .xterm-fg-166 {
            color: #d75f00
          }

          .xterm-fg-167 {
            color: #d75f5f
          }

          .xterm-fg-168 {
            color: #d75f87
          }

          .xterm-fg-169 {
            color: #d75faf
          }

          .xterm-fg-170 {
            color: #d75fd7
          }

          .xterm-fg-171 {
            color: #d75fff
          }

          .xterm-fg-172 {
            color: #d78700
          }

          .xterm-fg-173 {
            color: #d7875f
          }

          .xterm-fg-174 {
            color: #d78787
          }

          .xterm-fg-175 {
            color: #d787af
          }

          .xterm-fg-176 {
            color: #d787d7
          }

          .xterm-fg-177 {
            color: #d787ff
          }

          .xterm-fg-178 {
            color: #d7af00
          }

          .xterm-fg-179 {
            color: #d7af5f
          }

          .xterm-fg-180 {
            color: #d7af87
          }

          .xterm-fg-181 {
            color: #d7afaf
          }

          .xterm-fg-182 {
            color: #d7afd7
          }

          .xterm-fg-183 {
            color: #d7afff
          }

          .xterm-fg-184 {
            color: #d7d700
          }

          .xterm-fg-185 {
            color: #d7d75f
          }

          .xterm-fg-186 {
            color: #d7d787
          }

          .xterm-fg-187 {
            color: #d7d7af
          }

          .xterm-fg-188 {
            color: #d7d7d7
          }

          .xterm-fg-189 {
            color: #d7d7ff
          }

          .xterm-fg-190 {
            color: #d7ff00
          }

          .xterm-fg-191 {
            color: #d7ff5f
          }

          .xterm-fg-192 {
            color: #d7ff87
          }

          .xterm-fg-193 {
            color: #d7ffaf
          }

          .xterm-fg-194 {
            color: #d7ffd7
          }

          .xterm-fg-195 {
            color: #d7ffff
          }

          .xterm-fg-196 {
            color: #f00
          }

          .xterm-fg-197 {
            color: #ff005f
          }

          .xterm-fg-198 {
            color: #ff0087
          }

          .xterm-fg-199 {
            color: #ff00af
          }

          .xterm-fg-200 {
            color: #ff00d7
          }

          .xterm-fg-201 {
            color: #f0f
          }

          .xterm-fg-202 {
            color: #ff5f00
          }

          .xterm-fg-203 {
            color: #ff5f5f
          }

          .xterm-fg-204 {
            color: #ff5f87
          }

          .xterm-fg-205 {
            color: #ff5faf
          }

          .xterm-fg-206 {
            color: #ff5fd7
          }

          .xterm-fg-207 {
            color: #ff5fff
          }

          .xterm-fg-208 {
            color: #ff8700
          }

          .xterm-fg-209 {
            color: #ff875f
          }

          .xterm-fg-210 {
            color: #ff8787
          }

          .xterm-fg-211 {
            color: #ff87af
          }

          .xterm-fg-212 {
            color: #ff87d7
          }

          .xterm-fg-213 {
            color: #ff87ff
          }

          .xterm-fg-214 {
            color: #ffaf00
          }

          .xterm-fg-215 {
            color: #ffaf5f
          }

          .xterm-fg-216 {
            color: #ffaf87
          }

          .xterm-fg-217 {
            color: #ffafaf
          }

          .xterm-fg-218 {
            color: #ffafd7
          }

          .xterm-fg-219 {
            color: #ffafff
          }

          .xterm-fg-220 {
            color: #ffd700
          }

          .xterm-fg-221 {
            color: #ffd75f
          }

          .xterm-fg-222 {
            color: #ffd787
          }

          .xterm-fg-223 {
            color: #ffd7af
          }

          .xterm-fg-224 {
            color: #ffd7d7
          }

          .xterm-fg-225 {
            color: #ffd7ff
          }

          .xterm-fg-226 {
            color: #ff0
          }

          .xterm-fg-227 {
            color: #ffff5f
          }

          .xterm-fg-228 {
            color: #ffff87
          }

          .xterm-fg-229 {
            color: #ffffaf
          }

          .xterm-fg-230 {
            color: #ffffd7
          }

          .xterm-fg-231 {
            color: #fff
          }

          .xterm-fg-232 {
            color: #080808
          }

          .xterm-fg-233 {
            color: #121212
          }

          .xterm-fg-234 {
            color: #1c1c1c
          }

          .xterm-fg-235 {
            color: #262626
          }

          .xterm-fg-236 {
            color: #303030
          }

          .xterm-fg-237 {
            color: #3a3a3a
          }

          .xterm-fg-238 {
            color: #444
          }

          .xterm-fg-239 {
            color: #4e4e4e
          }

          .xterm-fg-240 {
            color: #585858
          }

          .xterm-fg-241 {
            color: #626262
          }

          .xterm-fg-242 {
            color: #6c6c6c
          }

          .xterm-fg-243 {
            color: #767676
          }

          .xterm-fg-244 {
            color: #808080
          }

          .xterm-fg-245 {
            color: #8a8a8a
          }

          .xterm-fg-246 {
            color: #949494
          }

          .xterm-fg-247 {
            color: #9e9e9e
          }

          .xterm-fg-248 {
            color: #a8a8a8
          }

          .xterm-fg-249 {
            color: #b2b2b2
          }

          .xterm-fg-250 {
            color: #bcbcbc
          }

          .xterm-fg-251 {
            color: #c6c6c6
          }

          .xterm-fg-252 {
            color: #d0d0d0
          }

          .xterm-fg-253 {
            color: #dadada
          }

          .xterm-fg-254 {
            color: #e4e4e4
          }

          .xterm-fg-255 {
            color: #eee
          }
        </style>
      HTML

      def initialize(stdout_sync: true)
        $stdout.sync = stdout_sync unless stdout_sync.nil?
      end

      def run
        job = validated_job!
        output_job(job) { |io| runner(io).run }
      rescue Gitlab::Error::Error => e
        puts e.message
      end

      private

      def personal_access_token
        @personal_access_token ||= ENV['TM_GITLAB_PERSONAL_ACCESS_TOKEN']
      end

      def git_repository
        @git_repository ||= ENV['TM_PROJECT_DIRECTORY']
      end

      def job_tracer
        @job_tracer ||= JobTracer.new(personal_access_token, git_repository)
      end

      def runner(io)
        @runner ||= LoopRunner.new(job_tracer, outputter(io), 0.5)
      end

      def outputter(io)
        @outputter ||= Outputter.new(io)
      end

      def validated_job!
        job = job_tracer.last_job
        return job if job
        error("Failed to find job for commit: #{job_tracer.last_commit}")
      rescue Gitlab::Error::Error => e
        output_job(job) { |io| io << e.message }
        exit
      end

      def bold(string)
        "<b>#{string}</b>"
      end

      def build_title(job)
        "Job ##{job.id} - #{job.commit.title}"
      end

      # rubocop:disable Metrics/AbcSize
      def build_subtitle(build)
        build_id = bold('#' + build.id.to_s)
        pipeline_id = bold('#' + build.pipeline.id.to_s)
        commit = bold(build.commit.short_id)
        ref = bold(build.pipeline.ref)
        author = bold(build.commit.author_name)
        "Job #{build_id} in pipeline #{pipeline_id} for commit #{commit} " \
          "from #{ref} by #{author}"
      end
      # rubocop:enable Metrics/AbcSize

      def output_job(job, &block)
        options =
          if job
            { title: build_title(job), sub_title: build_subtitle(job) }
          else
            {}
          end

        output(options, &block)
      end

      def error(message)
        output { |io| io << message }
        exit
      end

      def output(options = {})
        default_options = { title: 'Build Output', html_head: HTML_HEADER }
        options = default_options.merge(options)

        TextMate::HTMLOutput.show(options) do |io|
          io << '<pre>'
          begin
            yield io
          ensure
            io << '</pre>'
          end
        end
      end
    end
    # rubocop:enable Metrics/ClassLength
  end
end
