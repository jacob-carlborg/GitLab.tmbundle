module GitLabTmBundle
  module Commands
    class Base
      def self.inherited(subclass)
        @subclasses ||= {}
        name = subclass.name.underscore.split('::').last
        @subclasses[name] = subclass
      end

      def self.create(command)
        @subclasses[command.to_s].new
      end
    end
  end
end
