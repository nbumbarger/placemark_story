class PlacemarksController < ApplicationController

  def new
    @story = Story.find(params[:story_id])
    @placemark = Placemark.new
  end

  def create
    @story = Story.find(params[:story_id])
    @placemark = @story.placemarks.new(placemark_params)
    if params[:commit] === "Add Next Placemark"
      if @placemark.save
        redirect_to new_story_placemark_path(@story)
      else
        @placemark = @story.placemarks.new(placemark_params)
        render :new
      end
    elsif params[:commit] == "Finish Story"
      if @placemark.save
        redirect_to @story
      else
        render :new
      end
    end
  end

  def edit
    @story = Story.find(params[:story_id])
    @placemark = @story.placemarks.find(params[:id])
  end

  def update
    @story = Story.find(params[:story_id])
    @placemark = @story.placemarks.find(params[:id])
    if @placemark.update(placemark_params)
      # @next_placemark = @story.placemarks.new(placemark_params)
      redirect_to edit_story_placemark_path(@story, @placemark.next)
    else
      render :edit
    end
  end

  def destroy
    @story = Story.find(params[:story_id])
    @placemark = @story.placemarks.find(params[:id])
    @placemark.destroy
    redirect_to @story
  end

  private
  def placemark_params
    params.require(:placemark).permit(:name, :description, :lat, :lng, :image_data, :image_alt)
  end

end