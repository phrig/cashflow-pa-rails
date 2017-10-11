class ContributionsController < ApplicationController

  def index
    @contributions = Contribution.all.limit(50)

    render json: @contributions, status: 200
  end

end
