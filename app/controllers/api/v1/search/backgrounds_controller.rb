class Api::V1::Search::BackgroundsController < ApplicationController
  def index
    render status: :bad_request, json: { error: 'need city and/or state' } and return unless params[:location].present?

    background = UnsplashFacade.backgrounds(params[:location])
    render json: {
      data: {
        type: 'background',
        id: background.id,
        attributes: {
          urls: background.urls,
          width: background.width,
          height: background.height,
          description: background.description,
          user: {
            name: background.user.name,
            link: background.user.link,
          }
        }
      }
    }
  end
end