module Api
  module V1
    class BaseController < ApplicationController
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
    end
  end
end
