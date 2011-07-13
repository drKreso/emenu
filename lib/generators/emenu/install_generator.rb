require 'rails/generators'

module Emenu
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)  
      def copy_images
        directory 'images', 'public/images/emenu'
      end

      def copy_javscript
        copy_file 'javascripts/jquery-1.4.2.min.js', 'public/javascripts/jquery-1.4.2.min.js'
        copy_file 'javascripts/emenu.js', 'public/javascripts/emenu.js'
      end

      def copy_stylesheets
        copy_file 'stylesheets/emenu.css', 'public/stylesheets/emenu.css'
        copy_file 'stylesheets/reset.css', 'public/stylesheets/reset.css'
      end

      def copy_initializer
        copy_file 'default_menu/navigation.rb', 'app/navigation/navigation.rb'
      end

      def include_emenu_into_application_controller
        inject_into_class "app/controllers/application_controller.rb", ApplicationController,  "  include Emenu\n"
      end

      def add_route
        route "match 'emenu_state' => 'application#emenu_state'\n"
      end

      def explain
        puts ""
        puts "  You need to link 'reset.css' and 'emenu.css' from layout file"
        puts "  You need to link 'jquery-1.4.2.min.js' and 'emenu.js' from layot file"
      end
    end  
end
