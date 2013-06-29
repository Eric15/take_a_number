class Customer
  class Response

    CONFIRM_CODE  = '^1$'
    POSTPONE_CODE = '^2$'
    VALID_CODES   = [
      CONFIRM_CODE,
      POSTPONE_CODE
    ]

    def initialize(response)
      @response = response
    end

    def valid?
      match?(VALID_CODES)
    end

    def did_confirm?
      match?(CONFIRM_CODE)
    end

    def did_postpone?
      match?(POSTPONE_CODE)
    end

    def customer
      Customer.where(phone: from).last
    end

    private

    attr_reader :response

    def match?(codes)
      !!body.match(Regexp.new([codes].flatten.join("|")))
    end

    def body
      response.fetch("Body").strip
    end

    def from
      response.fetch("From").strip[2..-1]
    end

  end
end
