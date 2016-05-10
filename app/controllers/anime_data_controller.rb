class AnimeDataController < ApplicationController
  before_action :set_anime_datum, only: [:show, :edit, :update, :destroy,:select_search_language]

  helper_method :getAnimeData
  # GET /anime_data
  # GET /anime_data.json
  def index
    @anime_data = AnimeDatum.all
  end

  # GET /anime_data/1
  # GET /anime_data/1.json
  def show
  end

  # GET /anime_data/new
  def new
    @anime_datum = AnimeDatum.new
  end

  def anime_schedule
  end

  def select_search_language
  end

  def data_list
    #anime_data.helper_method
    @year  = params[:year]
    @month = params[:month]
    session[:search_year]  = @year
    session[:search_month] = @month
    #ApplicationController.helpers.
    @animes_data = getAnimeData(@year, @month)
  end

  def create_anime_schedule
    @checkd_animes_number = params[:animes_checked]
    @animes_data = getAnimeData(session[:search_year], session[:search_month])

    @checkd_animes_number.map{ |num|
      @animes_data[num.to_i-1].save unless num.to_i == 0
    }

    redirect_to anime_data_path
  end

  # GET /anime_data/1/edit
  def edit
  end

  # POST /anime_data
  # POST /anime_data.json
  def create
    @anime_datum = AnimeDatum.new(anime_datum_params)

    respond_to do |format|
      if @anime_datum.save
        format.html { redirect_to @anime_datum, notice: 'Anime datum was successfully created.' }
        format.json { render :show, status: :created, location: @anime_datum }
      else
        format.html { render :new }
        format.json { render json: @anime_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /anime_data/1
  # PATCH/PUT /anime_data/1.json
  def update
    respond_to do |format|
      if @anime_datum.update(anime_datum_params)
        format.html { redirect_to @anime_datum, notice: 'Anime datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @anime_datum }
      else
        format.html { render :edit }
        format.json { render json: @anime_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /anime_data/1
  # DELETE /anime_data/1.json
  def destroy
    @anime_datum.destroy
    respond_to do |format|
      format.html { redirect_to anime_data_url, notice: 'Anime datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_anime_datum
      @anime_datum = AnimeDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def anime_datum_params
      params.require(:anime_datum).permit(:japanese, :english, :chinese, :year, :month, :url)
    end
end
