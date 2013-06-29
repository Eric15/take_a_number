class Api::MessagesController < Api::ApplicationController

  def handle_response
    @response = Customer::Response.new(params)

    if @response.did_confirm?
      raise "CONFIRMED"
    elsif @response.did_postpone?
      raise "POSTPONED"
    end
  end

end
