class SitemapController < ApplicationController
  layout nil
 
  def index
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml {}
    end
  end
  
end