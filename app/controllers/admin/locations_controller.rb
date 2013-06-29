class Admin::LocationsController < Admin::ApplicationController

  before_filter :set_service_providers!, only: [ :show ]

  inherit_resources

  custom_actions member: [ :open, :close, :refresh ]

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(resource_params)

    if @location.save
      redirect_to collection_path
    else
      render :new
    end
  end

  def update
    @location = Location.find(params[:id])

    if @location.update_attributes(resource_params)
      redirect_to collection_path
    else
      render :edit
    end
  end

  def open
    resource.open!
    redirect_to collection_url
  end

  def close
    resource.close!
    redirect_to collection_url
  end

  def refresh
    ServiceProvider::Enqueuer.perform
    render :show
  end

  private

  def set_service_providers!
    @service_providers = ServiceProvider.all
  end

  def resource_params
    params.require(:location).permit!
  end

end
