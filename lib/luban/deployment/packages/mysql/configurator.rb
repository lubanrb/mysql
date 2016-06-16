module Luban
  module Deployment
    module Packages
      class Mysql
        class Configurator < Luban::Deployment::Service::Configurator
          include Paths
          include Controller::Commands

          alias_method :log_file_path, :general_log_file_path
        end
      end
    end
  end
end
