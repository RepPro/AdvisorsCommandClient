module AdvisorsCommandClient
  module Models
    class AccountCollection
      def initialize(args = {})
        @connection = args[:connection]
      end

      def create(contact_id, params)
        account = AdvisorsCommandClient::Models::Account.new(params)
        account_json = account.as_json
        account_json = account_json.merge(default_contact: contact_id)
        resp = @connection.post("accounts", { account: account_json })

        if resp.success?
          account.id = resp.body['id']
          account
        else
          return false
        end
      end
    end
  end
end