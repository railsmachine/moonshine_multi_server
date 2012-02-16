module ConfigurationBuilders

  def self.included(base)
    base.extend(ClassMethods)
  end 

  module ClassMethods
<% if web? %>
    def build_haproxy_configuration
      raise 'FIXME needs implementation'
    end

    def build_heartbeat_configuration
      raise 'FIXME needs implementation'
    end

    def build_iptables_configuration
      raise 'FIXME needs implementation'
    end
<% end %>
<% if database? %>
    def build_database_iptables_rules
      raise 'FIXME needs implementation'
    end
<% end %>
<% if redis? %>
    def build_redis_iptables_configuration
      raise 'FIXME needs implementation'
    end

    def build_redis_configuration
      raise 'FIXME needs implementation'
    end
<% end %>
<% if memcached? %>
    def build_memcached_configuration
      raise 'FIXME needs implementation'
    end

    def build_memcached_iptables_configuration
      raise 'FIXME needs implementation'
    end
<% end %>
<% if sphinx? %>
    def build_sphinx_iptables_rules
      raise 'FIXME needs implementation'
    end
<% end %>
<% if mongodb? %>
    def build_mongodb_iptables_configuration
      raise 'FIXME needs implementation'
    end

    def mongodb_replset
      configuration[:application]
    end

    def build_mongodb_configuration
      {
        :replset => mongodb_replset,
        :bind_ip => Facter.ipaddress_eth1
      }
    end

    def build_mongodb_replset_initiate_config_object
      members = mongodb_servers.map do |host|
        id = host[:hostname].match(/mongo(\d+)\./)[1]
        "{_id: #{id}, host: '#{host[:internal_ip]}'}"
      end

    "{_id: '#{mongodb_replset}', members: [#{members.join(', ')}]}"
    end
<% end %>
 
  end
end
