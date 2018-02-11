class FilersController < ApplicationController

  before_action :get_filer, only: :show

  def index
  end

  def show
  end

  def get_filer
    @filer = Filer.find(params[:id])
  end
end

