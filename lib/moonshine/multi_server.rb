module Moonshine
  module MultiServer
    def default_web_stack
      recipe :apache_server
    end

    def standalone_web_stack
      recipe :default_web_stack
      recipe :default_system_config
      recipe :non_app_recipes
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
      recipe :default_db_stack
      recipe :default_system_config
      recipe :non_app_recipes
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

    def non_rails_recipes
      # Set up gemrc and the 'gem' package helper, but not Rails app gems.
      def gemrc
        exec 'rails_gems', :command => 'true'
        gemrc = {
          :verbose => true,
          :gem => "--no-ri --no-rdoc",
          :update_sources => true,
          :sources => [ 'http://rubygems.org' ]
        }
        gemrc.merge!(configuration[:rubygems]) if configuration[:rubygems]
        file '/etc/gemrc',
          :ensure   => :present,
          :mode     => '744',
          :owner    => 'root',
          :group    => 'root',
          :content  => gemrc.to_yaml
      end

      def non_rails_rake_environment
        package 'rake', :provider => :gem, :ensure => :installed
        exec 'rake tasks', :command => 'true'
      end
      recipe :non_rails_rake_environment, :gemrc
      recipe :rails_directories, :rails_logrotate
    end
  end
end