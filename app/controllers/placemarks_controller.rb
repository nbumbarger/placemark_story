class PlacemarksController < ApplicationController

  def new
    @story = Story.find(params[:story_id])
    @placemark = Placemark.new()
  end

  def create
    @story = Story.find(params[:story_id])
    @placemark = @story.placemarks.new(placemark_params)
    if params[:commit] === "Save Placemark"
      if @placemark.save
        redirect_to new_story_placemark_path(@story)
      else
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
    if params[:commit] === "Save Placemark"
      if @placemark.update(placemark_params)
        if @placemark.next
          redirect_to edit_story_placemark_path(@story, @placemark.next)
        else
          redirect_to @story
        end
      else
        render :edit
      end
    elsif params[:commit] == "Finish Story"
      if @placemark.save
        redirect_to @story
      else
        render :edit
      end
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