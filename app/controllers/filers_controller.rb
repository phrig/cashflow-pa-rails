class FilersController < ApplicationController

  def index
    @filers = Filer.all.limit(50)

    render json: @filers, status: 200
  end

end
