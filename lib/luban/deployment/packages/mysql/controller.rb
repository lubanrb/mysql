module Luban
  module Deployment
    module Packages
      class Mysql
        class Controller < Luban::Deployment::Service::Controller
          module Commands
            def self.included(base)
              base.define_executable 'mysqld_safe'
              base.define_executable 'mysqladmin'
              base.define_executable 'mysqld'
            end

            def mysqld_safe_command
              @mysqld_safe_command ||= "#{mysqld_safe_executable} --defaults-file=#{control_file_path}"
            end

            def mysqldadmin_command
              @mysqldadmin_command ||= "#{mysqladmin_executable} --defaults-file=#{admin_control_file_path}"
            end

            def process_pattern
              @process_pattern ||= "^#{mysqld_executable} --defaults-file=#{control_file_path}"
            end

            alias_method :start_command, :mysqld_safe_command

            def start_command
              @start_command ||= "#{mysqld_safe_command}"
            end

            def stop_command
              @stop_command ||= "kill $(cat #{pid_file_path} 2>/dev/null)"
            end

            def ping_command
              @ping_command ||= "#{mysqldadmin_command} ping"
            end

            def reopen_logs_command
              @reopen_logs_command ||= "#{mysqldadmin_command} flush-logs #{log_types.join(' ')}"
            end

            def log_types
              @log_types ||= %w(error general slow)
            end
          end

          include Paths
          include Commands

          %w(reload_process reopen_logs ping_process).each do |method|
            define_method(method) do
              update_result send("#{method}!")
            end
          end

          def default_pending_interval; 5; end

          protected

          def start_process!
            within install_path do
              capture(:nohup, "#{start_command} >/dev/null 2>&1 &")
            end
          end

          def reload_process!
            capture("kill -HUP $(cat #{pid_file_path} 2>/dev/null) 2>&1")
          end

          def reopen_logs!
            capture("#{reopen_logs_command} 2>&1")
          end

          def ping_process!
            capture("#{ping_command} 2>&1")
          end
        end
      end
    end
  end
end
