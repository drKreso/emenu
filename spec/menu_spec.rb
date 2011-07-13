require 'spec_helper'

describe Menu do

  subject do
    @config = stub(:config)
    @config.stubs(:open)
    @config.stubs(:selected=)
    @config.stubs(:selected).returns nil
    @config.stubs(:opened?).with(anything).returns false

    Menu.new(:company, nil, @config)
  end


  it 'should have title' do
    subject.title.should == :company
    subject.type.should == :title
  end

  it 'should accept new items' do
    subject.add(:napkin)
    subject.add(:car)
    subject.items.count.should == 2
    subject.items.first.type.should == :menu
    subject.items[1].type.should == :menu
  end

  it 'should know subitems titles' do
    subject.add(:napkin)
    subject.add(:car)
    subject.items.first.title.should == :napkin
  end

  it 'should support collapsible items of sub items' do
    subject.add(:napkin)
    subject.items.first.type.should == :menu
    subject.items.first.add(:cool_napkins)
    subject.items.first.type.should == :collapsible_menu
    subject.items.first.items.first.type.should == :menu
  end

  it 'should enforce menu keys uniqueness' do
    lambda { subject.add(:company) }.should raise_error("It's not allowed to have same menu keys: company")
  end
  
  it 'should enforce keys uniqueness in colapslible items' do
    lambda do 
      subject.add(:napkin) 
      subject.items.first.add(:cars)
      subject.items.first.add(:cars)
    end.should raise_error("It's not allowed to have same menu keys: cars")
  end

  it 'should generate valid haml for simple meni' do
    subject.add(:table)
    subject.add(:napkin)
    subject.to_haml.should == <<-DEF.indent
                           %h6#h-menu-company
                             %a{ :href => '#company'}
                               %span Company
                           %ul#menu-company.closed
                             %li= link_to 'Table', '#'
                             %li= link_to 'Napkin', '#'
                           DEF
  end

  it 'should generate haml for simple opened menu' do
    subject.add(:table)
    subject.add(:napkin)
    @config.open(:company)
    @config.selected = :napkin

    @config.stubs(:opened?).with(:company).returns true
    @config.stubs(:selected).returns :napkin

    subject.to_haml.should == <<-DEF.indent
                           %h6#h-menu-company{ :class => "selected" }
                             %a{ :href => '#company'}
                               %span Company
                           %ul#menu-company.opened
                             %li= link_to 'Table', '#'
                             %li{ :class => "selected" }= link_to 'Napkin', '#'
                           DEF
  end


  it 'should generate valid haml for complex meni' do
    subject.add(:table)
    subject.add(:napkin)
    subject.items[1].add(:cool_napkins)
    subject.add(:cars)
    subject.to_haml.should == <<-DEF.indent
                           %h6#h-menu-company
                             %a{ :href => '#company'}
                               %span Company
                           %ul#menu-company.closed
                             %li= link_to 'Table', '#'
                             %li.collapsible
                               %a{ :href => '#', :class => 'collapsible plus'} Napkin
                               %ul#napkin.collapsed
                                 %li= link_to 'Cool napkins', '#'
                             %li= link_to 'Cars', '#'
                           DEF
  end

  it 'should generate valid haml for complex opened meni' do
    subject.add(:table)
    subject.add(:napkin)
    subject.items[1].add(:cool_napkins)
    subject.add(:cars)
    @config.open(:company)
    @config.open(:napkin)
    @config.selected = :cool_napkins

    @config.stubs(:opened?).with(anything).returns true
    @config.stubs(:selected).returns :cool_napkins

    subject.to_haml.should == <<-DEF.indent
                           %h6#h-menu-company{ :class => "selected" }
                             %a{ :href => '#company'}
                               %span Company
                           %ul#menu-company.opened
                             %li= link_to 'Table', '#'
                             %li.collapsible
                               %a{ :href => '#', :class => 'collapsible minus'} Napkin
                               %ul#napkin.expanded
                                 %li{ :class => "selected" }= link_to 'Cool napkins', '#'
                             %li= link_to 'Cars', '#'
                           DEF
  end

  it 'should generate valid haml for collapsible of collapsible meni' do
    subject.add(:table)
    subject.add(:napkin)
    subject.items[1].add(:cool_napkins)
    something = subject.items[1].add(:something)
    something.add(:collapsible2)
    subject.add(:cars)
    subject.to_haml.should == <<-DEF.indent
                           %h6#h-menu-company
                             %a{ :href => '#company'}
                               %span Company
                           %ul#menu-company.closed
                             %li= link_to 'Table', '#'
                             %li.collapsible
                               %a{ :href => '#', :class => 'collapsible plus'} Napkin
                               %ul#napkin.collapsed
                                 %li= link_to 'Cool napkins', '#'
                                 %li.collapsible
                                   %a{ :href => '#', :class => 'collapsible plus'} Something
                                   %ul#something.collapsed
                                     %li= link_to 'Collapsible2', '#'
                             %li= link_to 'Cars', '#'
                           DEF
  end

  it 'should enumerate all items' do
    subject.add(:table)
    subject.add(:napkin)
    subject.items[1].add(:cool_napkins)
    subject.all_items.count.should == 3
  end

  it 'should enumerate item parents' do
    subject.add(:table)
    subject.add(:napkin)
    subject.items[1].add(:cool_napkins)
    subject.parents.count.should == 0
    subject.items[0].parents.count.should == 1
    subject.items[1].items[0].parents.count.should == 2
  end

end

