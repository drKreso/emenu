require 'haml'

include ActionView::Helpers::UrlHelper

class MenuConfig
  attr_reader :config
  attr_accessor :selected

  def initialize()
    @config = {}
    @opened = {}
  end

  def item(title, &block)
    raise "It's not allowed to have same menu keys: #{title}" unless @config[title].nil?
    current = @config[title] = Menu.new(title, nil, self)
    current.instance_eval(&block) unless block.nil?
    MenuConfig.enforce_uniqueness @config.each_value.map(&:names)
  end

  def self.enforce_uniqueness(names)
    counted_names = names.flatten.inject(Hash.new(0)) { |count, name| count[name] += 1 ; count }
    more_than_one = counted_names.map { |key, count| key if count > 1 }.compact
    raise "It's not allowed to have same menu keys: #{more_than_one.join(", ")}" unless more_than_one.size == 0
  end

  def open(name)
    @opened[name] = :opened
  end

  def opened?(name)
    @opened[name] == :opened
  end

  def header_haml
    "#menu\n"
  end

  def to_html
    Haml::Engine.new(to_haml).render
  end

  def to_haml
    @config.each_value.inject(header_haml) { |result, menu| result << menu.to_haml.split("\n").map { |token| Menu::DEFAULT_SPACE + token + "\n" }.join }
  end

end
