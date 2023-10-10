class Product < ApplicationRecord
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description, presence: true

  belongs_to :supplier
  has_many :images
  has_many :carted_products
  has_many :orders, through: :carted_products
  has_many :category_products
  has_many :categories, through: :category_products

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
