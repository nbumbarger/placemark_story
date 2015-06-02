class StoriesController < ApplicationController
helper_method :current_or_guest_user

  def index
    @stories = current_or_guest_user.stories.all
  end

  def show
    @story = current_or_guest_user.stories.find(params[:id])
    @placemarks = @story.placemarks.all
    respond_to do |format|
      format.html {render :show}
      format.json {render json: @story.generate_GeoJSON}
    end
  end

  def new
    @story = current_or_guest_user.stories.new
  end

  def create
    @story = current_or_guest_user.stories.new(story_params)
      if @story.save
        @placemark = @story.placemarks.new
        redirect_to new_story_placemark_path(@story)
      else
        render :new
      end
  end

  def edit
    @story = current_or_guest_user.stories.find(params[:id])
  end

  def update
    @story = current_or_guest_user.stories.find(params[:id])
    if @story.update(story_params)
      redirect_to @story
    else
      render :edit
    end
  end

  def destroy
    @story = current_or_guest_user.stories.find(params[:id])
    @story.destroy
    redirect_to stories_path
  end

  def map
    @story = Story.find(params[:story_id])
    render :layout => false
  end

  private
  def story_params
    params.require(:story).permit(:name, :description)
  end

end