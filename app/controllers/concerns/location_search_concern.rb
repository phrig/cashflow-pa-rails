module LocationSearchConcern
  extend ActiveSupport::Concern

  def in_pennsylvania?(location)
    if location.state == 'Pennsylvania'
      true
    else
      false
    end
  end

end