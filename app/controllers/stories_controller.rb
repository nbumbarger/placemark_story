class StoriesController < ApplicationController

  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
    @placemarks = @story.placemarks.all
    if @placemarks.none?
      @no_placemarks = true
      @placemarks_link_class = 'disabled'
    end
    respond_to do |format|
      format.html {render :show}
      format.json {render json: @story.generate_GeoJSON}
    end
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
      if @story.save
        @placemark = @story.placemarks.new
        redirect_to new_story_placemark_path(@story)
      else
        render :new
      end
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])
    if @story.update(story_params)
      redirect_to @story
    else
      render :edit
    end
  end

  def destroy
    @story = Story.find(params[:id])
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