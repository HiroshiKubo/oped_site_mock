class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  def search_keyword
  end

  def admin_select_search
    oped         = params[:oped]
    language     = params[:language]
    @id          = params[:id]
    @search_site = params[:search_site]

    @keyword     = AnimeDatum.find(@id)[language].to_s + " " + oped.to_s

    if @search_site == "youtube"
      @videos = ApplicationController.helpers.searchYoutubeVideos(@keyword, 20)
    elsif @search_site == "youku"
      @videos = ApplicationController.helpers.searchYoukuVideos(@keyword, 2)
    end
  end

  def admin_search
    @search_site = params[:search_site]
    @keyword     = params[:keyword]

    if @search_site == "youtube"
      @videos = ApplicationController.helpers.searchYoutubeVideos(@keyword, 20)
    elsif @search_site == "youku"
      @videos = ApplicationController.helpers.searchYoukuVideos(@keyword, 2)
      #binding.pry
    end
    #"ハルチカ〜ハルタとチカは青春する〜+op"
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_video
    get_videos  = params[:animes_checked]
    search_site = params[:search_site]
    anime_id    = params[:anime_id]

    keyword     = params[:keyword]
    if search_site == "youtube"
      videos = ApplicationController.helpers.searchYoutubeVideos(keyword, 20)
    elsif search_site == "youku"
      videos = ApplicationController.helpers.searchYoukuVideos(keyword, 2)
    end

    get_videos.map { |data|
      videos.map { |video|
        if data[1] == video[:video_url]
          video[:anime_id] = anime_id
          video.save
          break
        end
      }
    }
    redirect_to videos_path

  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:anime_id, :video_url, :frame, :release)
    end
end
