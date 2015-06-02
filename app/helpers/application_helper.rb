module ApplicationHelper

  def setPlacemarkViewStatus
    if @story.user_id != current_or_guest_user.id
      @placemarks_owner_class = 'not-owner'
    end
    if @placemarks.none?
    	@no_placemarks = true
    	@placemarks_link_class = 'disabled'
    end
  end

end