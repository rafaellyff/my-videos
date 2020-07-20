class VideosController < ApplicationController
  before_action :set_video, only: [:show,:edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @comments = Comment.where(video_id: params[:id])
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Vídeo criado com sucesso' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Vídeo atualizada com sucesso' }
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
      format.html { redirect_to videos_url, notice: 'Vídeo deletado com sucesso' }
      format.json { head :no_content }
    end
  end

  def favorites
    @categories = Category.all
    @favorites = Video.joins(:category).where("categories.favorite = ?", true).group_by(&:category)
  end

  def by_category
    @categories = Category.all
    unless params[:id].blank?
      @category = Category.select(:name).find(params[:id]).name
      @videos = Video.where(category_id: params[:id])
    else
      @category = "Sem categoria" 
      @videos = Video.where(category_id: nil)
    end
  end

  def create_comment
    @comment = Comment.new
    @comment.author = params[:author]
    @comment.text = params[:text]
    @comment.video_id = params[:video_id]
    @comment.save!

    @comments = Comment.where(video_id: params[:video_id])
    render :partial => 'videos/comments'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :youtube_url, :category_id, :youtube_embed_id)
    end
end
