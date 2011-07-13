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
    session[:menu_state] ||= {}
    @menu = menu
    selected_key = @menu.find_path(request.env['PATH_INFO'])
    unless selected_key.nil?
      @menu.selected = selected_key 
      @menu.find(selected_key).parents.each { |menu| session[:menu_state][menu.title.to_s] = "opened" }
    end
    session[:menu_state].each { |key, value| @menu.open(key.to_sym) if value == "opened"} unless session[:menu_state].nil?
  end

  def self.included(base)
    base.before_filter :emenu
    base.send :helper_method, :menu_will_render
    base.module_eval { include Navigation } unless $install == true
  end

  def menu_will_render
    @menu.render
  end

end

