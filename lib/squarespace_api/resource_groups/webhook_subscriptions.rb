module SquarespaceApi
  module ResourceGroups
    class WebhookSubscriptions < ResourceGroup
      PATH = 'webhook_subscriptions'.freeze
      allowed_actions :all, :create, :update, :find, :delete

      def send_test_notification(id = nil, params)
        parse(
          connection
          .post(UriComponentBuidler.construct(resource_path, id: id) + "/actions/sendTestNotification", params: params.to_json)
        )
      end

      def rotate_secret(id)
        parse(
          connection
          .post(UriComponentBuidler.construct(resource_path, id: id) + "/actions/rotateSecret")
        )
      end
    end
  end
end
