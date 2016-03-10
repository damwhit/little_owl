class Product < ActiveRecord::Base
  belongs_to :category
  has_many :order_products
  has_many :orders, through: :order_products

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :description, presence: true
  validates :category_id, presence: true

  has_attached_file :image,
      styles: { index: '275x175>', show: '550x350<', small: '137.5x87.5>' },
      default_url: '/assets/nav-logo-dcbacebfd4a74e9dd03a8b25e54dd394ae20fa2d62a47a2c08a4b27fd80962d3.png'

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  scope :active_products, -> { where(inactive: false) }

  def display_price
    "$#{price.to_i / 100}"
  end

  def self.active_index
    where(inactive: false).order(:name)
  end

  def self.inactive_index
    where(inactive: true).order(:name)
  end

  def inactive?
    inactive
  end

  def self.category_distribution
    group(:category).count.map { |k, v| [k.name, v] }
  end
end
