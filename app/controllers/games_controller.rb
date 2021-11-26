class GamesController < ApplicationController
  before_filter :set_game, only: %i[ show edit update destroy ]

  # GET /games or /games.json
  def index
    @games = Game.order(:name).page(params[:page])
  end

  # GET /games/1 or /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    search_genre = params[:genre]
    search_platform = params[:platform]

    if search_genre == ""
      genre = Game.all
    else
      genre = Game.joins(game_genres: :genre).where("Genres.id LIKE ?", search_genre)
    end

    if search_platform == ""
      platform = genre
    else
      platform = genre.joins(game_platforms: :platform).where("Platforms.id LIKE ?", search_platform)
    end

    #search = Game.where("Games.name LIKE ? OR Games.description LIKE ?", wildcard_search, wildcard_search).order(:name).page(params[:page])
    #genre = Game.joins(game_genres: :genre).where("Genres.id LIKE ?", search_genre)
    #platform = genre.joins(game_platforms: :platforms).where("Platforms.id LIKE ?", search_platform)
    @games = platform.where("Games.name LIKE ? OR Games.description LIKE ?", wildcard_search, wildcard_search).order(:name).page(params[:page])
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: "Game was successfully updated." }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:name, :description, :price, :score, :rating)
    end
end
