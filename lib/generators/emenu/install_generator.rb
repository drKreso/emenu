require 'rails/generators'

module Emenu
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)  
      def generate_install
        puts "Hello from generator"
      end

      def manifest
        puts "Hello from manifest"
      end
    end  
end
