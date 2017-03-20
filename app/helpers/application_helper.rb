module ApplicationHelper
  def dropdown_link(text, options={})
    extra_classes = options.delete(:class)
    extra_data = options.delete(:data)
    data = {toggle: "dropdown"}
    data.merge!(extra_data) if extra_data
    classes = ["dropdown-toggle", extra_classes].compact.join(" ")
    base_options = {class: classes, data: data}
    full_options = options.merge(base_options)
    label = "#{text} <span class='caret'></span>".html_safe
    link_to(label, "#", full_options)
  end

end
