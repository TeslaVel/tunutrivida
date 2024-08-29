# frozen_string_literal: true

# FooterComponent
class FooterComponent < ApplicationComponent
  def initialize(text:)
    super
    @text = text
  end

  private

  attr_reader :text
end
