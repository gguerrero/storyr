# Include View and Controller helpers on Rails base
module ActionView # :nodoc: all
  module Helpers

    module FormTagHelper
      def labeled_field_tag(name = nil, value = nil, 
                            input_type = :text_field_tag, html_opts = {})
        label_tag = label_tag(name)
        input_tag = send(input_type, name, value, html_opts)
        content_tag(:div, class: "field") do
          content_tag(:div, label_tag, class: "label") +
          content_tag(:div, input_tag, class: "input")
        end
      end
    end

    module FormHelper
      def labeled_field(object_name, method, input_type, html_opts)
        label_tag = label(object_name, method)
        input_tag = send(input_type, object_name, method, html_opts)
        content_tag(:div, class: "field") do
          content_tag(:div, label_tag, class: "label") +
          content_tag(:div, input_tag, class: "input")
        end
      end
    end

    class FormBuilder
      def labeled_field(method, input_type = :text_field, html_opts = {})
        @template.labeled_field(@object_name, method, input_type,
                                objectify_options(html_opts))
      end
    end

  end
end
