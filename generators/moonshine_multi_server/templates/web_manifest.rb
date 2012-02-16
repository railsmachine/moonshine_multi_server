require "#{File.dirname(__FILE__)}/base_manifest.rb"

class WebManifest < BaseManifest

  recipe :default_system_config
  recipe :non_rails_recipes
  
  configure :ssl => build_ssl_configuration
  configure :haproxy => build_haproxy_configuration
  recipe :haproxy
  
  configure :heartbeat => build_heartbeat_configuration
  recipe :heartbeat
  
  configure :iptables => build_web_iptables_configuration
  recipe :iptables
    
  def scout_dependencies
    gem 'fastercsv'
  end   
        
end
