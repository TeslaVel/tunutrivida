# frozen_string_literal: true

# DashboardController
class DashboardController < ApplicationController
  before_action :check_auth_for_all_origin

  def index
    current_time = Time.zone.now.strftime("%H:%M")
    start_date = Time.zone.today
    end_date = start_date + 3.days
    @appointments = current_user.dietitian_appointments
                                .where(start_date: start_date..end_date, status: %w[pending happening])

  end
end
