class Product < ApplicationRecord
  validates :price, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :name, presence: true

  def is_discounted?
    price <= 10
  end

  def tax
    price * 0.09
  end

  def total
    price + tax
  end
end
