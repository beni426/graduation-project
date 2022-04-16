module ApplicationHelper
    def full_title(page_title = "")
      base_title = "KIRAIBAR"
      if page_title.empty?
        base_title
      else
        "#{page_title} | #{base_title}"
      end
    end
 
      def i18n_url_for(options)
        if options[:locale] == I18n.default_locale
          options[:locale] = nil
        end
        url_for(options)
      end
    
end
