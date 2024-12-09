class UrlsController < ApplicationController
  def index
    @urls = ShortUrl.all
  end

  def new
    @url = ShortUrl.new
  end

  def create
    @url = ShortUrl.create(url_params)
    redirect_to urls_path, notice: 'URL shortened successfully!'
  rescue StandardError => e
    flash.now[:alert] = "Error: #{e.message}"
    render :new
  end

  def show
    @url = ShortUrl.find_by_short_path(params[:id])
    @visits = Visit.all.select { |v| v.short_url_id == @url.id }
  end

  def visit
    @url = ShortUrl.find_by_short_path(params[:short_path])
    
    if @url
      Visit.create(
        short_url_id: @url.id,
        ip_address: request.remote_ip
      )
      redirect_to @url.target_url, allow_other_host: true
    else
      redirect_to root_path, alert: 'URL not found'
    end
  end

  private

  def url_params
    params.require(:short_url).permit(:target_url)
  end
end 