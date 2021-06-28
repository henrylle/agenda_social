class DestinationPostsController < ApplicationController
  before_action :set_destination_post, only: %i[ show edit update destroy ]

  # GET /destination_posts or /destination_posts.json
  def index
    @destination_posts = DestinationPost.all
  end

  # GET /destination_posts/1 or /destination_posts/1.json
  def show
  end

  # GET /destination_posts/new
  def new
    @destination_post = DestinationPost.new
  end

  # GET /destination_posts/1/edit
  def edit
  end

  # POST /destination_posts or /destination_posts.json
  def create
    @destination_post = DestinationPost.new(destination_post_params)

    respond_to do |format|
      if @destination_post.save
        format.html { redirect_to @destination_post, notice: "Destination post was successfully created." }
        format.json { render :show, status: :created, location: @destination_post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @destination_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /destination_posts/1 or /destination_posts/1.json
  def update
    respond_to do |format|
      if @destination_post.update(destination_post_params)
        format.html { redirect_to @destination_post, notice: "Destination post was successfully updated." }
        format.json { render :show, status: :ok, location: @destination_post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @destination_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /destination_posts/1 or /destination_posts/1.json
  def destroy
    @destination_post.destroy
    respond_to do |format|
      format.html { redirect_to destination_posts_url, notice: "Destination post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_destination_post
      @destination_post = DestinationPost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def destination_post_params
      params.require(:destination_post).permit(:name, :link)
    end
end
