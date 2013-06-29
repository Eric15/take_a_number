class Customer
  class Notifier

    def self.sms(*args)
      new(*args).sms
    end

    def initialize(customer, body)
      @customer, @body = customer, body
    end

    def sms
      message.save if Sms.send(message)
    end

    private

    attr_reader :customer, :body

    def message
      Message.new(customer_id: customer.id, body: body)
    end

  end
end
