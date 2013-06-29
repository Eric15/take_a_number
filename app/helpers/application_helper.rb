module ApplicationHelper

  def icon(tag)
    content_tag :i, nil, class: "icon-#{tag}"
  end

  def block_to_partial(partial_name, options = {}, &block)
    options.merge!(body: capture(&block))
    render(partial_name, options)
  end

end
