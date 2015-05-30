module ApplicationHelper

  def setPlacemarkViewStatus
    if @placemarks.none?
      @no_placemarks = true
      @placemarks_link_class = 'disabled'
    end
  end

end
