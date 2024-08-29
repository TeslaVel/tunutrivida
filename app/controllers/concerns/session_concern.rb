# frozen_string_literal: true

module SessionConcern
  extend ActiveSupport::Concern

  included do
    # include Devise::Controllers::Helpers

    before_action :session_qty, only: %i[new create]

    private

    def session_qty
      (@patient_package.package.weeks * @patient_package.package.session_quantity).to_i
    end

    def resource_indicators_imc(gender_id = 4)
      Indicator.indicators_by_type('imc').where(gender_id:)
    end

    def resource_indicator_pdc(gender_id)
      Indicator.indicators_by_type('pdc').where(gender_id:)
    end

    def resource_indicators_icc(gender_id)
      Indicator.indicators_by_type('icc').where(gender_id:)
    end

    def resource_diagnosis(query, value)
      query.within_range(value).first
    end

    def resource_icc(waist, hip)
      return 0 if waist.blank? || hip.blank?

      (waist / hip).round(2)
    end
  end
end
