module Luban
  module Deployment
    module Packages
      class Mysql < Luban::Deployment::Service::Base
        def default_templates_path
          @default_templates_path ||= Pathname.new(File.join(File.dirname(__FILE__), 'templates')).realpath
        end

        %i(reload_process reopen_logs ping_process).each do |action|
          service_action action, dispatch_to: :controller
        end

        def decompose_version(version)
          vers = version.split('.')
          { major_version: "#{vers[0]}.#{vers[1]}", patch_level: vers[2] }
        end

        protected

        def setup_install_tasks
          super
          commands[:install].option :dist, "Binary distribution"
        end

        def setup_control_tasks
          super

          task :reload do
            desc "Reload process"
            action! :reload_process
          end

          task :reopen do
            desc "Reopen log files"
            action! :reopen_logs
          end

          task :ping do
            desc "Ping process"
            action! :ping_process
          end
        end
      end
    end
  end
end
