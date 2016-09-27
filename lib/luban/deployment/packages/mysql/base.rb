module Luban
  module Deployment
    module Packages
      class Mysql < Luban::Deployment::Service::Base
        def self.decompose_version(version)
          vers = version.split('.')
          { major_version: "#{vers[0]}.#{vers[1]}", patch_level: vers[2] }
        end

        %i(reload_process reopen_logs ping_process).each do |action|
          service_action action, dispatch_to: :controller
        end

        protected

        def include_default_templates_path
          default_templates_paths.unshift(base_templates_path(__FILE__))
        end

        def setup_provision_tasks
          super
          provision_tasks[:install].option :dist, "Binary distribution"
        end

        def setup_control_tasks
          super

          commands[:control].alter do
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
end
