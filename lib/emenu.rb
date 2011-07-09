require 'active_support/core_ext/array'
require 'action_view'

require 'emenu/string.rb'
require 'emenu/menu.rb'
require 'emenu/menu_config.rb'
module Emenu
  require 'emenu/engine' if defined?(Rails)
end
