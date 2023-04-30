class ContactUsController < ApplicationController
  before_action :set_contact_us, only: %i[ show edit update destroy]

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
end
