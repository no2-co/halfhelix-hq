class Item < ApplicationRecord

  # Validations
  validates :quantity, :presence => true, :numericality => { :integer => true }
  validates :amount, :presence => true, :numericality => true
  validates :title, :presence => true

  def total
    self.quantity * self.amount
  end
end
