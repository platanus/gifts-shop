class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :store
  has_many :product_actions, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5 }
  validates :price, presence: true
  validates :link, presence: true

  def set_average_color
    variant = image.variant(resize: "1x1").processed
    image = MiniMagick::Image.open(
      variant.service.send(:path_for, variant.key)
    )
    red, blue, green = image.get_pixels[0][0]
    update(average_color: hex_value(red, blue, green))
  end

  def attach_image_from_url(url)
    require 'open-uri'
    downloaded_image = open(url)
    filename = File.basename(URI.parse(url).path)
    image.attach(io: downloaded_image, filename: "#{filename}_#{id}.jpg")
  end

  def update_image(image_param)
    image.attach(image_param)
    set_average_color
  end

  private

  def hex_value(red, green, blue)
    "##{to_hex red}#{to_hex green}#{to_hex blue}"
  end

  def to_hex(value)
    value.to_s(16).rjust(2, '0').upcase
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
#  clicks_cost   :float
#  store_id      :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  display       :boolean          default(FALSE)
#  promoted      :boolean          default(FALSE)
#  deleted       :boolean          default(FALSE)
#  average_color :text             default("#000000")
#
# Indexes
#
#  index_products_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
