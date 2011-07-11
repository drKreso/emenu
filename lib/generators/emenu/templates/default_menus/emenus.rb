# Be sure to restart your server if you modify this file

module Emenu
  # menu method is uses as a hook to provide menu to render
  def menu
    MenuConfig.define do |menu|
      #first menu group named Transportation
      menu.item :transportation do
        item :cars
        item :trains do
          item :fast_trains 
          item :slow_trains
        end
        item :planes do
          item :boeing do
            item :boeing747 do
              item :older_ready_to_crash
              item :brand_new
            end
            item :boeing474
          end
          item :airbus
        end
      end
      #second menu group named Orders
      menu.item :orders do
        item :bread
        item :butter
        item :chunky_bacon
      end
    end
  end
end
