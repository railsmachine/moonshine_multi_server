module Moonshine
  module MultiServer

    def default_web_stack
      recipe :apache_server
      recipe :passenger_gem, :passenger_configure_gem_path, :passenger_apache_module, :passenger_site
      recipe :default_system_config
    end
    
    def default_database_stack
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

    def default_rails_stack
      recipe :rails_rake_environment, :rails_gems, :rails_directories, :rails_bootstrap, :rails_migrations, :rails_logrotate  
      recipe :default_system_config
    end

    def default_system_config
      recipe :ntp, :time_zone, :postfix, :cron_packages, :motd, :security_updates, :apt_sources
    end

    def default_stack
      recipe :default_web_stack
      recipe :default_database_stack
      recipe :default_rails_stack
      recipe :default_system_config
    end
  end
end