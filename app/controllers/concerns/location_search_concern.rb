module LocationSearchConcern
  extend ActiveSupport::Concern

  def in_pennsylvania?(location)
    if location.state == 'Pennsylvania'
      true
    else
      false
    end
  end
  def safe_geocode_search(string,retry_count=1)
    begin
      Geocoder.search(string)
    rescue Geocoder::OverQueryLimitError
      Rails.logger.warn("Rescue: Geocoder::OverQueryLimitError. Re-trying search. Retry count currently at #{retry_count}")
      raise  "Geocoder::OverQueryLimitError. No more retry attempts left" if retry_count > 5 
      retry_count += 1
      sleep 1
      safe_geocode_search(string,retry_count)
    end
  end

end
