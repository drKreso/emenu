require 'action_view'

require 'emenu/string.rb'
require 'emenu/menu.rb'
require 'emenu/menu_config.rb'

module Emenu
  def emenu_state
    session[:menu_state] ||= {}
    session[:menu_state][params[:id]] = params[:state] unless params[:id].nil?
    render :json => { :data => :ok } 
  end

  def emenu 
    @menu = menu
    session[:menu_state].each { |key, value| @menu.open(key.to_sym) if value == "opened"} unless session[:menu_state].nil?
  end

  def self.included(base)
    base.before_filter :emenu
  end
end

module EmenuHelper
  def menu_will_render
    @menu.render
  end
end
