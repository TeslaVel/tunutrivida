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
      Indicator.where(indicator_types: 1, gender_id:)
    end

    def resource_indicator_dpc(gender_id)
      Indicator.where(indicator_types: 2, gender_id:)
    end

    def resource_indicators_icc(gender_id)
      Indicator.where(indicator_types: 3, gender_id:)
    end

    def resource_diagnosis_imc(query, imc)
      # @diagnosisImc = @indicatorsImc.find {|ind| @instant_session.imc >= ind.value_min && @instant_session.imc <= ind.value_max}
      query.where('value_min <= ? AND value_max >= ?', imc, imc).first
    end

    def resource_diagnosis_dpc(query, waist)
     # @diagnosisDpc = @indicatorsDpc.find {|ind| @instant_session.waist >= ind.value_min && @instant_session.waist < ind.value_max}
      query.where('value_min <= ? AND value_max > ?', waist, waist).first
    end

    def resource_diagnosis_icc(query, icc)
      # @diagnosisIcc = @indicatorsIcc.find { |ind| icc > ind.value_min && icc <= ind.value_max }
      query.where('value_min < ? AND value_max >= ?', icc, icc).first
    end

    def resource_icc(waist, hip)
      return 0 if waist.blank? || hip.blank?

      (waist / hip).round(2)
    end
  end
end
