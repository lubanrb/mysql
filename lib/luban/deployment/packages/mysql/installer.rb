module Luban
  module Deployment
    module Packages
      class Mysql
        class Installer < Luban::Deployment::Service::Installer
          include Paths

          define_executable 'mysql'

          def package_dist; task.opts.dist; end
          def package_full_name; "#{super}-#{package_dist}"; end

          def source_repo
            @source_repo ||= "http://dev.mysql.com"
          end

          def source_url_root
            @source_url_root ||= "get/Downloads/MySQL-#{package_major_version}"
          end

          def installed?
            return false unless file?(mysql_executable)
            pattern = Regexp.new("mysql  Ver \.* Distrib #{Regexp.escape(package_version)}")
            match?("#{mysql_executable} --version 2>&1", pattern)
          end

          protected

          def bootstrap_install
            super
            assure_dirs(data_path, ssl_rsa_path, 
                        innodb_log_group_home_path, bin_log_path,
                        error_log_path, general_log_path, slow_query_log_path)
            assure(:directory, secure_file_priv_path) do
              mkdir(secure_file_priv_path)
              chmod('750', secure_file_priv_path)
            end
          end

          def configure_build_options
            super
            @configure_opts.delete(install_prefix)
            @configure_opts << "--user=#{user}"
            @configure_opts << "--basedir=#{install_path}"
            @configure_opts << "--datadir=#{data_path}"
            @configure_opts << "--log-error=#{error_log_file_path}"
            @configure_opts << "--innodb_log_group_home_dir=#{innodb_log_group_home_path}"
          end

          def build_package
            info "Building #{package_full_name}"
            within install_path do
              rm('-r', '*') # Clean up install path
              execute(:mv, build_path.join('*'), '.', ">> #{install_log_file_path} 2>&1")
              execute(:"bin/mysqld", "--initialize-insecure #{compose_build_options} >> #{install_log_file_path} 2>&1")
              execute(:"bin/mysql_ssl_rsa_setup", "--datadir=#{ssl_rsa_path}", ">> #{install_log_file_path} 2>&1")
            end
          end
        end
      end
    end
  end
end
