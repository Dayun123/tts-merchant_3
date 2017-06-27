class Category < ApplicationRecord

# TODO: Make sure Category is unique in DB as well
validates :name, presence: true, uniqueness: true

end

# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
