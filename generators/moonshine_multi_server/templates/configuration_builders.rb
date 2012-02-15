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
 
  end
end
