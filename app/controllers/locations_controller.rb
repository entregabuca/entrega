class LocationsController < ApplicationController
  def geocode
  	@map_id = params[:map_id]
  	respond_to do |format|
  		format.js
  	end
  end
end
