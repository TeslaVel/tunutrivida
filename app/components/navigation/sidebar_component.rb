# frozen_string_literal: true

module Navigation
  # Navigation::SidebarComponent
  class SidebarComponent < ApplicationComponent
    def initialize(organization:, device:)
      @organization = organization
      @device = device
      super
    end

    def modules
      {
        patient_modules: [
          { name: 'instant_sessions', path: instant_sessions_path},
          { name: 'patients', path: patients_path },
          { name: 'billings', path: billings_path },
          { name: 'tasks', path: tasks_path },
          { name: 'diets', path: diets_path },
          { name: 'meals', path: meals_path },
          { name: 'conditions', path: conditions_path },
          { name: 'restricted_ingredient_conditions', title: 'Restricted Ingredientes', path: restricted_ingredient_conditions_path },
          { name: 'appointments', path: appointments_path },
          { name: 'availabilities', path: availabilities_path },
          { name: 'entries', path: entries_path }
        ],
        admin_modules: [
          { name: 'discounts', path: discounts_path },
          { name: 'products', path: products_path },
          { name: 'packages', path: packages_path },
          { name: 'indicators', path: indicators_path },
          { name: 'genders', path: genders_path },
          { name: 'activity_factors', path: activity_factors_path },
          { name: 'indicator_types', path: indicator_types_path },
          { name: 'bmr_factors', path: bmr_factors_path },
        ]
      }
    end

    private

    attr_reader :organization, :device
  end
end
