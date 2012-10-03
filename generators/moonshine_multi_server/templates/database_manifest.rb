require "#{File.dirname(__FILE__)}/base_manifest.rb"

class DatabaseManifest < BaseManifest
  recipe :standalone_database_stack

  configure :iptables => { :rules => build_database_iptables_rules }
  recipe    :iptables

  recipe :sysctl

  def scout_dependencies
    # TODO database specific scout dependencies
  end
end
