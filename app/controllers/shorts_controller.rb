class ShortsController < ApplicationController
  
  def index
    render json: Short.all.order(click_count: :desc)
  end

  def create
    @short = Short.new(short_param)
    if @short.save
      render json: @short
    else
      render json: {errors: @short.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def redirect
    short = Short.find_by_url_digest(params[:key])
    if short
      Thread.new do
        short.increment!(:click_count)
      end
      head :temporary_redirect, :location => short.url
    else
      head :temporary_redirect, :location => root_url
    end
  end

  def delete
  end

  private
    def short_param
      params.require(:short).permit(:url)
    end
end
