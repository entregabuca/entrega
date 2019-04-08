class LocationsController < ApplicationController
  def geocode
  	respond_to do |format|
  		format.js
  	end
  end
end
