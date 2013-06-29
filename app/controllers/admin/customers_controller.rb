class Admin::CustomersController < Admin::ApplicationController

  inherit_resources

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(resource_params)

    if @customer.save
      redirect_to collection_path
    else
      render :new
    end
  end

  def update
    @customer = Customer.find(params[:id])

    if @customer.update_attributes(resource_params)
      redirect_to collection_path
    else
      render :new
    end
  end

  private

  def resource_params
    params.require(:customer).permit!
  end

end
