class Frontend::LocationsController < Frontend::ApplicationController

  before_filter :set_locations!, only: [ :index ]

  private

  def set_locations!
    @locations = Location.open
  end

end
