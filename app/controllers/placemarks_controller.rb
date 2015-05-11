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
    if @placemark.save
      redirect_to @story
    else
      render :new
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
    params.require(:placemark).permit(:name, :synopsis, :full_text, :lat, :lon)
  end

end