class Menu

  IDENTATION = 2
  SPACE = " "
  DEFAULT_SPACE = SPACE*IDENTATION

  attr_reader :title, :items, :type

  def initialize(title, parent, config)
    @title = title
    @parent = parent
    @config = config
    @items = []
    @type = @parent.nil? ? :title : :menu 
  end

  def item(name, &block)
    current = self.add(name)
    current.instance_eval(&block) unless block.nil?
  end

  def add(item_name, &block)
    items << Menu.new(item_name, self, @config)
    @type = :collapsible_menu if @type == :menu # when we add subitems to menu it becomes collapsible menu
    instance_eval(&block) unless block.nil?
    MenuConfig.enforce_uniqueness names
    return items.last
  end

  def names
    items.inject([@title.to_s]) { |result, item| result << item.names }
  end

  def to_haml
    items.inject(eval "#{type}_haml") { |result, item| result <<  item.to_haml }
  end

  def title_haml
    "#{spacing}%h6#h-menu-#{@title}#{opened? ? '{ :class => "selected" }' : ""}\n" <<
    "#{spacing_subitem}%a{ :href => '##{@title}'}\n" <<
    "#{spacing_subitem*2}%span #{humanized_title}\n" <<
    "%ul#menu-#{@title}.#{opened? ? "opened" : "closed"}\n" 
  end

  def menu_haml
    "#{spacing}%li#{selected? ? '{ :class => "selected" }' : ""}= link_to '#{humanized_title}', '#', :onclick => \"submitMenu('#{@title}')\"\n"
  end

  def collapsible_menu_haml
    "#{spacing}%li.collapsible\n" <<
    "#{spacing_subitem}%a{ :href => '#', :class => 'collapsible #{opened? ? "minus" : "plus"}'} #{humanized_title}\n" <<
    "#{spacing_subitem}%ul##{@title}.#{opened? ? "expanded" : "collapsed"}\n"
  end

  def humanized_title
    @title.to_s.humanize
  end

  def selected?
    @config.selected == @title
  end

  def opened?
    @config.opened? @title
  end

  def indent
    result = @parent.nil? ? 0 : @parent.indent + IDENTATION * (@parent.type == :collapsible_menu ? 2 : 1)
  end

  def spacing
    SPACE*indent
  end
  
  def spacing_subitem
    spacing + DEFAULT_SPACE
  end

end
