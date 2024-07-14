# frozen_string_literal: true

# Class ApplicationComponent
class ApplicationComponent < ViewComponent::Base
  def current_user
    helpers.current_user
  end
end
