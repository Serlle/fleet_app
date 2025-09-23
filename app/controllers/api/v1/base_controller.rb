module Api
  module V1
    class BaseController < ApplicationController
      include Authenticable

      # For API endpoints we don't use Rails session CSRF protection; use
      # null_session so JSON requests without CSRF token don't raise.
      protect_from_forgery with: :null_session
      # Also explicitly skip the verify_authenticity_token callback for API controllers
      # so non-browser JSON clients can POST without a CSRF token.
      skip_before_action :verify_authenticity_token

      # API controllers should render JSON and skip views/layouts
      before_action :ensure_json_request

      private

      def ensure_json_request
        request.format = :json
      end

      def render_error(code:, message:, details: nil, status: :unprocessable_entity)
        payload = { error: { code: code, message: message } }
        payload[:error][:details] = details if details.present?
        render json: payload, status: status
      end

      def pagination_meta(collection)
        {
          current_page: collection.current_page,
          next_page: collection.next_page,
          prev_page: collection.prev_page,
          total_pages: collection.total_pages,
          total_count: collection.total_count
        }
      end
    end
  end
end
