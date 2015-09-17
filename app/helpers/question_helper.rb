module QuestionHelper
  def link_to_add_option(name, f, association, i)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render("option", :item => builder )
    end
    link_to_function(name.html_safe, raw("add_option(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), html_options = { href: "javascript:void(0)", class: "create_access_primary appmsg_add" } )
  end

  def link_to_add_question(name, f, association, i)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      # render("article_item2", :item => builder )
    end
    link_to_function(name.html_safe, raw("add_question(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), html_options = { href: "javascript:void(0)", class: "create_access_primary appmsg_add" } )
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_function(name, *args, &block)
     html_options = args.extract_options!.symbolize_keys

     function = block_given? ? update_page(&block) : args[0] || ''
     onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
     href = html_options[:href] || '#'
     content_tag(:a, name, html_options.merge(:href => href, :onclick => onclick))
  end
end
