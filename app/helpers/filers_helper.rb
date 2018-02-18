module FilersHelper

  def formatted_address(filer)
    "<span>#{filer.filer_location_1_address}</span></br>" \
    "<span>#{filer.filer_location_1_city},</span> " \
    "<span>#{filer.filer_location_1_state}</span> " \
    "<span>#{filer.filer_location_1_zip}</span>"
    .html_safe
  end

end