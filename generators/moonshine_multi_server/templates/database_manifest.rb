class DatabaseManifest < BaseManifest
  recipe :standalone_database_stack

  configure :iptables => { :rules => build_database_iptables_rules }
  recipe    :iptables

  recipe :sysctl
end
