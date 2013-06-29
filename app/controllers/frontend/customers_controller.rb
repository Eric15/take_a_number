class Frontend::CustomersController < Frontend::ApplicationController

  before_filter :set_service_providers!

  def new
    @customer = Customer.new
    @customer.unscheduled_events.build
  end

  def create
    @customer = Customer.new(resource_params)

    if @customer.save
      redirect_to frontend_root_url, notice: "Success! Your appointment has been created"
    else
      flash[:alert] = "Error! We were unable to save your appointment at this point" 
      render :new
    end
  end

  private


  def set_service_providers!
    @service_providers = ServiceProvider.where(location_id: params[:location_id])
  end

  def resource_params
    params.require(:customer).permit([
      :first_name,
      :last_name,
      :phone,
      unscheduled_events_attributes: [
        requested: []
      ]
    ])
  end

end
