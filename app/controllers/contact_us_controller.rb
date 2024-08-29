# frozen_string_literal: true

# ContactUsController
class ContactUsController < ApplicationController
  before_action :set_contact_us, only: %i[show edit update destroy mark_notification_seen]
  after_action :mark_notification_seen, only: [:show]

  def index
    @all_contact_us = ContactUs.all
  end

  def show
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_contact_us
    @contact_us = ContactUs.find_by_id(params[:id])
  end

  def mark_notification_seen
    @contact_us.update(seen: true)
    Notification.where(associated_object_id: @contact_us.id, notification_type: :contactus).update_all(seen: true)
  end
end
