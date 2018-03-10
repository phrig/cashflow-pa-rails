module LocationSearchConcern
  extend ActiveSupport::Concern

  def in_pennsylvania?(location)
    if location.state == 'Pennsylvania'
      true
    else
      false
    end
  end
  def safe_geocode_search(string,retry_count=5)
    begin
      Geocoder.search(string)
    rescue Geocoder::Oversafe_geocode_searchLimitError
      sleep 0.5
      Rails.logger.warn("Rescue: Oversafe_geocode_searchLimitError. Re-trying search")
      raise  "Geocode retry over limit" if retry_count > 4 
      retry_count += 1
      safe_geocode_search(string,retry_count)
    end
  end

end
