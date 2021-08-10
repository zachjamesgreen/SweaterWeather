class ApplicationController < ActionController::API
  # before_action :ensure_json_request

  # def ensure_json_request
  #   return if request.format == :json && request.content_type == "application/json"
  #   render head: :not_acceptable, json: {error: 'only json requests are accepted on this endpoint'}
  # end
end
