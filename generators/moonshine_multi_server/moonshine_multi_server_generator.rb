class MoonshineMultiServerGenerator < Rails::Generator::Base

  KNOWN_ROLES = %w(app haproxy database redis memcached mongodb dj sphinx)

  def initialize(runtime_args, runtime_options = {})
    super
    @roles = runtime_args.dup
  end

  def manifest
    recorded_session = record do |m|
      m.directory 'app/manifests'

      m.template 'base_manifest.rb', 'app/manifests/base_manifest.rb'

      m.directory 'app/manifests/lib'
      m.template 'configuration_builders.rb', 'app/manifests/lib/configuration_builders.rb'

      @roles.each do |role|

        template_file = if KNOWN_ROLES.include?(role)
                          "#{role}_manifest.rb"
                        else
                          'role_manifest.rb'
                        end

        m.template template_file, "app/manifests/#{role}_manifest.rb", :assigns => {:role => role}
      end

    end
  end

  protected

  # FIXME metaprogram using KNOWN_ROLES?

  def app?
    @roles.include?('app') || @roles.include?('application')
  end

  def haproxy?
    @roles.include?('haproxy')
  end

  def database?
    @roles.include?('database')
  end

  def redis?
    @roles.include?('redis')
  end

  def memcached?
    @roles.include?('memcached')
  end

  def sphinx?
    @roles.include?('sphinx')
  end

  def mongodb?
    @roles.include?('mongodb')
  end

end
