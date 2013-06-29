class Admin::UnscheduledEventsController < Admin::ApplicationController

  inherit_resources

  custom_actions resource: :sort

  def sort
    respond_to do |format|
      if resource.update_attribute(:sort_order_position, params[:position])
        format.js do
          render json: :ok
        end
      else
        format.js do
          render json: 422
        end
      end
    end
  end

  private

  def collection
    @unscheduled_events ||= end_of_association_chain.pending
  end

end
