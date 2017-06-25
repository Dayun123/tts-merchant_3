class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand

  # Paperclip setup. The :avatar field will represent an image of the Product. :style_missing.png will translate to medium_missing.png, thumb_missing.png, and original_missing.png. You get access to these through image_tag @product.avatar.url(:thumb/:medium) if you don't pass in a param to url, it will assume you want the :original. The docs say to use a path like '/images/:style/missing.png' but this doesn't work, something to do with the way the asset pipeline works. You'll see a path in the image tag that is like '/images/medium/missing.png' and you can have that path and file in your app/assets/images/medium/ directory, but the asset pipeline won't find it. I guess leaving off /images is the way to go, as it somehow knows to look there by default.
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ":style_missing.png"

  # Validates that the content_type of the :avatar attribute of this product is an image.
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end

# == Schema Information
#
# Table name: products
#
#  id                  :integer          not null, primary key
#  name                :string
#  price               :decimal(, )
#  quantity            :integer
#  description         :text
#  category_id         :integer
#  brand_id            :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#
# Indexes
#
#  index_products_on_brand_id     (brand_id)
#  index_products_on_category_id  (category_id)
#
