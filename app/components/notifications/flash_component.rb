# frozen_string_literal: true

module Notifications
  # Notifications::FlashComponent
  class FlashComponent < ApplicationComponent
    attr_reader :emails

    def initialize
      super
      @emails = Notification.where(seen: false, notification_type: :contactus)
    end
  end
end
