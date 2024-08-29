# frozen_string_literal: true

module TopBar
  # TopBar::EmailsComponent
  class EmailsComponent < ApplicationComponent
    attr_reader :emails

    def initialize
      super
      @emails = Notification.where(seen: false, notification_type: :contactus)
    end
  end
end
