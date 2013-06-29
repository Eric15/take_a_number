class Admin::ScheduledEventsController < Admin::ApplicationController

  inherit_resources

  before_filter :set_customers!, only: [ :new, :edit ]
  before_filter :set_service_providers!

  def new
    @scheduled_event = ScheduledEvent.new
  end

  def create
    @scheduled_event = ScheduledEvent.new(resource_params)

    if @scheduled_event.save
      redirect_to collection_path
    else
      render :new
    end
  end

  def update
    @scheduled_event = ScheduledEvent.find(params[:id])

    if @scheduled_event.update_attributes(resource_params)
      redirect_to collection_path
    else
      render :new
    end
  end

  private

  def set_customers!
    @customers = Customer.all
  end

  def set_service_providers!
    @service_providers = ServiceProvider.all
  end

  def collection
    @collection ||= end_of_association_chain.pending
  end

  def resource_params
    params.require(:scheduled_event).permit!
  end

end
