class BillingItem < ApplicationRecord
  belongs_to :billing
  # belongs_to :patient_packages
  belongs_to :itemable, polymorphic: true


  after_create :set_after_values
  after_destroy :recalculate_parent

  scope :inprocess, -> { where(status: :inprocess) }
  scope :processed, -> { where(status: :processed) }

  ItemTypes = %i[
    package
    product
    discount
  ].freeze

  enum item_type: ItemTypes

  StatusTypes = %i[
    inprocess
    processed
  ].freeze

  enum status: StatusTypes



  private

  def set_after_values

    unless description.present?
      self.description = "Item #{itemable.name.humanize}".parameterize
    end

    self.amount = itemable.price.to_f

    self.total = case item_type.to_sym
                 when :discount
                  -itemable.price.to_f
                 else
                  self.quantity * itemable.price.to_f
                 end

    self.save

    recalculate_parent
  end

  def recalculate_parent
    billing_total = subtotal = self.billing.billing_items.sum(:total)
    self.billing.update(total: billing_total, sub_total: subtotal)
  end
end
