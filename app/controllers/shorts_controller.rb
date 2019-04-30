class ShortsController < ApplicationController
  
  def index
    UrlCrawlerJob.perform_later(true)
    shorts = Short.all.order(click_count: :desc).limit(100)
    render json: { shorts: shorts, root_url: "#{request.protocol}#{request.host_with_port}/s/" }
  end

  def create
    @short = Short.new(short_param)
    if @short.save
      render json: { url: "#{request.protocol}#{request.host_with_port}/s/#{@short.url_digest}" }
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

  private
    def short_param
      params.require(:short).permit(:url)
    end
end
