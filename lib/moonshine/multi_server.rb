module Moonshine
  module MultiServer
    def default_web_stack
      recipe :apache_server
    end

    def standalone_web_stack
      # TODO: add non_rails_rack_environment
      recipe :default_web_stack
      recipe :default_system_config      
    end
    
    def default_db_stack
      case database_environment[:adapter]
      when 'mysql', 'mysql2'
        recipe :mysql_server, :mysql_gem, :mysql_database, :mysql_user, :mysql_fixup_debian_start
      when 'postgresql'
        recipe :postgresql_server, :postgresql_gem, :postgresql_user, :postgresql_database
      when 'sqlite', 'sqlite3'
        recipe :sqlite3
      end
    end
    
    def standalone_db_stack
      # TODO: add modified mysql_database
      # TODO: add modified mysql_user
      # TODO: add non_rails_rack_environment
      recipe :default_db_stack
      recipe :default_system_config
    end

    def default_app_stack
      recipe :default_web_stack
      recipe :passenger_gem, :passenger_configure_gem_path, :passenger_apache_module, :passenger_site
      recipe :rails_rake_environment, :rails_gems, :rails_directories, :rails_bootstrap, :rails_migrations, :rails_logrotate  
    end

    def standalone_app_stack
      # TODO add modified rails_migrations
      # TODO add modified rails_bootstrap
      recipe :default_app_stack
      recipe :default_system_config      
    end

    def default_system_config
      recipe :ntp, :time_zone, :postfix, :cron_packages, :motd, :security_updates, :apt_sources
    end

    def default_stack
      recipe :default_web_stack
      recipe :default_database_stack
      recipe :default_app_stack
      recipe :default_system_config
    end
  end
end