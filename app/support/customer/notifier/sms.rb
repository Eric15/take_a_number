class Customer
  class Notifier
    class Sms

      def self.send(message)
        new(message).send
      end

      def initialize(message)
        @message = message
      end

      def send
        client.account.sms.messages.create(
          from: from,
          to:   to,
          body: body
        )
      end

      private

      attr_reader :message

      def to
        message.to
      end

      def from
        Settings.twilio.phone
      end

      def body
        message.body
      end

      def account_sid
        Settings.twilio.account_sid
      end

      def auth_token
        Settings.twilio.auth_token
      end

      def client
        @client ||= Twilio::REST::Client.new(account_sid, auth_token)
      end

    end
  end
end
