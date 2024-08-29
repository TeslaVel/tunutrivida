# frozen_string_literal: true

# BillingItem
class BillingItem < ApplicationRecord
  ItemTypes = %i[
    package
    product
    discount
  ].freeze

  StatusTypes = %i[
    inprocess
    processed
  ].freeze

  belongs_to :billing
  belongs_to :itemable, polymorphic: true

  after_create :set_after_values
  after_destroy :recalculate_parent
  after_save :recalculate_parent

  scope :inprocess, -> { where(status: :inprocess) }
  scope :processed, -> { where(status: :processed) }
  scope :discount_percentage_items, -> {
    joins("INNER JOIN discounts ON itemable_id = discounts.id AND itemable_type = 'Discount'").where('discounts.discount_type = 1')
  }

  # scope :not_discount_percentage_items, -> {
  #  joins("INNER JOIN discounts ON itemable_id = discounts.id AND itemable_type = 'Discount'").where("discounts.discount_type != 1")
  # }

  enum item_type: ItemTypes
  enum status: StatusTypes

  def show_correct_mount_text
    simbol = '$' # @gbl_configuration.currency_code
    converted = (amount * target_conversion).round(2)
    result = "#{simbol} #{amount} | #{converted}"

    if item_type == 'discount' && itemable.discount_type == 'percentage'
      simbol = '%'
      result = "#{simbol} #{amount}"
    end

    result
  end

  def show_correct_total_text
    simbol = '$' # @gbl_configuration.currency_code
    converted = (self.total * self.target_conversion).round(2)
    result = "#{simbol} #{self.total} | #{converted}"

    if self.item_type == 'discount' && self.itemable.discount_type == 'percentage'
      result = 0
    end

    result
  end
  private

  def set_after_values
    unless description.present?
      self.description = "Item #{itemable.name.humanize}".parameterize
    end

    self.amount = itemable.price.to_f

    self.total = case item_type.to_sym
                 when :discount
                  if self.itemable.discount_type == 'value'
                    -itemable.price.to_f
                  else
                    0
                  end
                 else
                  self.quantity * itemable.price.to_f
                 end

    convers = if self.billing.created_at.strftime('%d-%M-%Y') != Time.now.strftime('%d-%M-%Y') && self.billing.target_conversion != target_conversion
                target_conversion
              else
                self.billing.target_conversion
              end
    

    self.total_conversion = self.total * convers
    self.target_conversion = convers
    self.target_currency = self.billing.target_currency
    self.target_currency_code = self.billing.target_currency_code

    self.save

    recalculate_parent
  end

  def recalculate_parent
    total = self.billing.billing_items.sum(:total).to_f || 0
    discount_percentage = self.billing.billing_items&.discount_percentage_items&.first&.amount.to_f || 0
    total = (total - (total * (discount_percentage / 100))).round(2) || 0
    total_conversion = sub_total_conversion = (total * self.billing.target_conversion.to_f).round(2)
    self.billing.update(
      total: total,
      sub_total: total,
      total_conversion: total_conversion,
      sub_total_conversion: sub_total_conversion
    )
  end
end
