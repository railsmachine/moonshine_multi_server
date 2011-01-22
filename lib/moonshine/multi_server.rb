module Moonshine
  module MultiServer
    def default_web_stack
      recipe :apache_server
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
      recipe :default_system_config
    end

    def default_app_stack
      recipe :default_web_stack
      recipe :passenger_gem, :passenger_configure_gem_path, :passenger_apache_module, :passenger_site
      recipe :rails_rake_environment, :rails_gems, :rails_directories, :rails_bootstrap, :rails_migrations, :rails_logrotate  
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