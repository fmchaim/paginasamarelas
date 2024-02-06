class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @services = Service.all
    @markers = @services.geocoded.map do |service|
      {
        lat: service.latitude,
        lng: service.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { service: service })

      }
    end
  end

  def dashboard
    @services = current_user.services
    @user = current_user
  end

end
