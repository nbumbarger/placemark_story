class PlacemarksController < ApplicationController

  def new
    @story = Story.find(params[:story_id])
    @placemark = Placemark.new()
  end

  def create
    @story = Story.find(params[:story_id])
    @placemark = @story.placemarks.new(placemark_params)
    if @placemark.save
      if params[:commit] === "Save Placemark"
        redirect_to new_story_placemark_path(@story)
      else
        redirect_to @story
      end
    else
      render :new
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
      if params[:commit] === "Save Placemark"
        if @placemark.next
          redirect_to edit_story_placemark_path(@story, @placemark.next)
        else
          redirect_to new_story_placemark_path(@story)
        end
      else
        redirect_to @story
      end
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
    params.require(:placemark).permit(:name, :description, :lat, :lng, :image_data, :image_alt, :link, :story_order)
  end

end