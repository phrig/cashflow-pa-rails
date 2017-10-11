class ReceiptsController < ApplicationController

    def index
    @receipts = Receipt.all.limit(50)

    render json: @receipts, status: 200
  end

end
