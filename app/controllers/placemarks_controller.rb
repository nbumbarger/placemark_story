class PlacemarksController < ApplicationController

  def index
    @placemarks = Placemark.all
  end

  def show
    @placemark = Placemark.find(:id)
  end

  def new
    @story = Story.find(params[:story_id])
    @placemark = Placemark.new
  end

  def create
    @story = Story.find(params[:story_id])
    @placemark = @story.placemarks.new(placemark_params)
    if params[:commit] === "Add Next Placemark"
      puts "\n\n\nadd next\n\n\n"
      if @placemark.save
        redirect_to new_story_placemark_path
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

  def destroy
    @story = Story.find(params[:story_id])
    @placemark = @story.placemarks.find(params[:id])
    @placemark.destroy
    redirect_to @story
  end

  private
  def placemark_params
    params.require(:placemark).permit(:name, :synopsis, :full_text, :lat, :lon, :image_data)
  end

end