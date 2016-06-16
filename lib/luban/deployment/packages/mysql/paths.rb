module Luban
  module Deployment
    module Packages
      class Mysql
        module Paths
          def control_file_name
            @control_file_name ||= "my.cnf"
          end

          def data_path
            @data_path ||= shared_path.join('data')
          end

          def ssl_rsa_path
            @ssl_rsa_path ||= shared_path.join('ssl_rsa')
          end

          def ssl_ca_path
            @ssl_ca_path ||= ssl_rsa_path.join('ca.pem')
          end

          def ssl_cert_path
            @ssl_cert_path ||= ssl_rsa_path.join('server-cert.pem')
          end

          def ssl_key_path
            @ssl_key_path ||= ssl_rsa_path.join('server-key.pem')
          end

          def innodb_log_group_home_path
            @innodb_log_group_home_path ||= shared_path.join('innodb_log')
          end

          def bin_log_path
            @bin_log_path ||= shared_path.join('bin_log')
          end

          def bin_log_file_path
            @bin_log_file_path ||= bin_log_path.join('mysql-bin')
          end

          def error_log_path
            @error_log_path ||= log_path.join('error')
          end

          def error_log_file_path
            @error_log_file_path ||= error_log_path.join('mysql-err.log')
          end

          def general_log_path
            @general_log_path ||= log_path.join('general')
          end

          def general_log_file_path
            @general_log_file_path ||= general_log_path.join(log_file_name)
          end

          def slow_query_log_path
            @slow_query_log_path ||= log_path.join('slow')
          end

          def slow_query_log_file_path
            @slow_query_log_file_path ||= slow_query_log_path.join('mysql-slow.log')
          end

          def admin_control_file_path
            @admin_control_file_path ||= profile_path.join('myadmin.cnf')
          end

          def socket_path
            @socket_path ||= app_tmp_path.join('mysql.sock')
          end

          def secure_file_priv_path
            @secure_file_priv_path ||= shared_path.join('mysql-files')
          end
        end
      end
    end
  end
end
