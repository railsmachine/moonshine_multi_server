require "#{File.dirname(__FILE__)}/../lib/moonshine/multi_server.rb"

# Instead of including the Moonshine::MultiServer module here, 
# we need to include it in the manifests so that we can 
# redefine some methods from Moonshine::Manifest::Rails
