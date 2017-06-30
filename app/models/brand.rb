class Brand < ApplicationRecord
  has_many :products

  # The uniqueness validation will only validate that the object is unique right before being saved, it DOES NOT put a uniqueness constraint on the DB though, you have to do that through a migration.
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

# == Schema Information
#
# Table name: brands
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_brands_on_name  (name) UNIQUE
#
