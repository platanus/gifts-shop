class Product < ApplicationRecord
  include PowerTypes::Observable
  include Rails.application.routes.url_helpers
  include AASM

  has_one_attached :image
  belongs_to :store
  belongs_to :category, optional: true
  has_many :product_actions, dependent: :destroy
  has_many :product_share, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :link, presence: true
  validates :email, presence: true
  validates :description, presence: true

  aasm column: :status do
    state :awaiting_approval, initial: true
    state :approved, :rejected

    event :approve do
      transitions from: [:awaiting_approval, :rejected], to: :approved, guard: :image_attached?
    end

    event :reject do
      transitions from: [:awaiting_approval, :approved], to: :rejected
    end
  end

  def attach_image_from_url(url)
    require 'open-uri'
    downloaded_image = open(url)
    filename = File.basename(URI.parse(url).path)
    image.attach(io: downloaded_image, filename: "#{filename}_#{id}.jpg")
  end

  def update_image(image_param)
    image.attach(image_param)
  end

  def validate_image
    update(display: false) if !image.attached?
  end

  def image_attached?
    image.attached?
  end

  def add_click
    clicks = self.clicks + 1
    update(clicks: clicks)
  end
end

# == Schema Information
#
# Table name: products
#
#  id            :bigint(8)        not null, primary key
#  name          :string
#  price         :float
#  clicks        :integer          default(0)
#  link          :string
#  store_id      :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deleted       :boolean          default(FALSE)
#  average_color :text             default("#000000")
#  gender        :integer          default("either")
#  age           :integer          default("any")
#  novelty       :integer
#  status        :string
#  category_id   :bigint(8)
#  email         :string
#  description   :text
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_store_id     (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
