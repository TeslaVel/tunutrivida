# frozen_string_literal: true

module Elements
  # Elements::LinkComponent
  class LinkComponent < ApplicationComponent
    attr_reader :url, :label, :action_method, :classes

    def initialize(label:, url:, classes: '', action_method: nil)
      super
      @label = label
      @url = url
      @action_method = action_method
      @classes = classes
    end
  end
end
