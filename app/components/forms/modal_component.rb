# frozen_string_literal: true

module Forms
  # Forms::ModalComponent
  class ModalComponent < ApplicationComponent
    def initialize(
      id_modal:,
      title:,
      primary_actions: nil,
      secondary_actions: nil
    )
      super
      @id_modal = id_modal
      @title = title
      pry_actions = primary_actions.present? ? { **PRIMARY_ACTIONS, **primary_actions } : PRIMARY_ACTIONS
      sec_actions = secondary_actions.present? ? { **SECONDARY_ACTIONS, **secondary_actions } : SECONDARY_ACTIONS
      @primary_actions = pry_actions
      @secondary_actions = sec_actions
    end

    private

    attr_reader :id_modal, :title, :primary_actions, :secondary_actions

    PRIMARY_ACTIONS = {
      name: 'Continue',
      action: nil
    }.freeze

    SECONDARY_ACTIONS = {
      name: 'Close',
      action: nil
    }.freeze
  end
end
