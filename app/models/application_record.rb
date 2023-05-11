# frozen_string_literal: true

# ApplicationRecord
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  CurrencyTypes = {
    usd: {
      cu: 'USD',
      code: '$'
    },
    ves: {
      cu: 'VES',
      code: 'BsF'
    }
  }
end
