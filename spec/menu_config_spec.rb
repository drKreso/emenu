require 'spec_helper'

describe MenuConfig do
  
  it 'should know how to mark selected menu' do
    subject.item :djuka
    subject.selected = :djuka
    subject.selected.should == :djuka
  end

  it 'should know how to mark opened menus' do
    subject.open :djuka
    subject.open :marko
    subject.opened?(:djuka).should == true
    subject.opened?(:marko).should == true
    subject.opened?(:petar).should == false
  end

  it 'should open all parent nodes when child is selected' do
    subject.item :products do
      item :napkin do
        item :cool_napkin
      end
    end
    subject.opened?(:products).should == false
    subject.opened?(:napkin).should == false
    subject.selected = :cool_napkin
    subject.opened?(:products).should == true
    subject.opened?(:napkin).should == true 
  end

  it 'should know to add menu' do
    subject.item :company
    subject.config.size.should == 1
    subject.config[:company].title.should == :company
  end

  it 'should know to add two menus' do
    subject.item :company
    subject.item :better_company
    subject.config.size.should == 2
    subject.config[:company].title.should == :company
    subject.config[:better_company].title.should == :better_company
  end

  it 'should dissalow same root menu neme' do
    lambda do
      subject.item :products
      subject.item :products
    end.should raise_error "It's not allowed to have same menu keys: products"
  end

  it 'should enforce menu item uniqueness across all menus' do
    lambda do
      subject.item :products do
        item :napkin
          item :cool_napkin
      end
      subject.item :second do
        item :something
          item :napkin
      end
    end.should raise_error("It's not allowed to have same menu keys: napkin")
  end

  it 'should generate valid #menu tag and move menus for spacing to the right' do
    subject.item :company do
      item :napkin, '/napkin'
    end
    subject.item :better_company do
      item :cars
    end
    subject.to_haml.should == <<-DEF.indent
                                    #menu
                                      %h6#h-menu-company
                                        %a{ :href => '#company'}
                                          %span Company
                                      %ul#menu-company.closed
                                        %li= link_to 'Napkin', '/napkin'
                                      %h6#h-menu-better_company
                                        %a{ :href => '#better_company'}
                                          %span Better company
                                      %ul#menu-better_company.closed
                                        %li= link_to 'Cars', '#'
                                  DEF
  end

  it 'should generate valid html' do
    subject.item :transportation do
      item :cars
    end
    subject.to_html.should == <<-DEF.indent
       <div id='menu'>
         <h6 id='h-menu-transportation'>
           <a href='#transportation'>
             <span>Transportation</span>
           </a>
         </h6>
         <ul class='closed' id='menu-transportation'>
           <li><a href="#">Cars</a></li>
         </ul>
       </div>
    DEF
  end

  it 'should generate valid html with render method' do
    subject.item :transportation do
      item :cars
    end
    subject.render.should == <<-DEF.indent
       <div id='menu'>
         <h6 id='h-menu-transportation'>
           <a href='#transportation'>
             <span>Transportation</span>
           </a>
         </h6>
         <ul class='closed' id='menu-transportation'>
           <li><a href="#">Cars</a></li>
         </ul>
       </div>
    DEF
  end

  it 'should know how to create menu config with static factory method' do
    subject.item :transportation do
        item :cars
        item :trains do
          item :fast_trains 
          item :slow_trains
        end
    end
    subject.item :orders do
      item :bananas
    end

    MenuConfig.define do |menu|
      menu.item :transportation do
        item :cars
        item :trains do
          item :fast_trains 
          item :slow_trains
        end
      end
      menu.item :orders do
        item :bananas
      end
    end.to_html.should == subject.to_html
  end
end
