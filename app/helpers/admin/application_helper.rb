module Admin::ApplicationHelper

  def menu_item_for(collection_name)
    classes = []

    if controller_name == collection_name.to_s
      classes << "active"
    end

    content_tag(:li, class: classes.join(" ")) do
      link_to collection_name.to_s.titleize, eval("admin_#{collection_name}_path")
    end
  end

  def menu_item(name, controller, action)
    classes = []

    if controller_name == controller
      classes << "active"
    end

    content_tag(:li, class: classes.join(" ")) do
      link_to name, controller: controller, action: action
    end
  end

  def resource_name
    resource_instance_name.to_s.titleize
  end

  def collection_name
    resource_collection_name.to_s.titleize
  end

end
