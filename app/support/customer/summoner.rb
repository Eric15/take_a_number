class Customer
  class Summoner

    BODY = "We're almost ready for you! Can you be here in 15 minutes? If not, text '1' to delay. Text '2' to cancel."

    def self.summon(*args)
      new(*args).summon!
    end

    def initialize(customer)
      @customer = customer
    end

    def summon!
      sms(BODY)
    end

    private

    attr_reader :customer

    def sms(body)
      Notifier.sms(customer, body)
    end

  end
end
