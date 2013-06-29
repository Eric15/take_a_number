class Admin::ServiceProvidersController < Admin::ApplicationController

  inherit_resources

  custom_actions resource: [ :finish, :activate, :deactivate ]

  def new
    @service_provider = ServiceProvider.new
  end

  def create
    @service_provider = ServiceProvider.new(resource_params)

    if @service_provider.save
      redirect_to collection_path
    else
      render :new
    end
  end

  def update
    @service_provider = ServiceProvider.find(params[:id])

    if @service_provider.update_attributes(resource_params)
      redirect_to collection_path
    else
      render :new
    end
  end

  def activate
    if resource.activate!(params[:location_id])
      redirect_to :back
    end
  end

  def deactivate
    if resource.deactivate!
      redirect_to :back
    end
  end

  def finish
    if resource.finish!
      redirect_to :back
    end
  end

  private

  def resource_params
    params.require(:service_provider).permit!
  end

end
