require "#{File.dirname(__FILE__)}/base_manifest.rb"
class MemcachedManifest < BaseManifest

  recipe :non_rails_recipes

  configure :memcached => build_memcached_configuration
  recipe :memcached

  configure :iptables => build_memcached_iptables_configuration
  recipe :iptables

end
