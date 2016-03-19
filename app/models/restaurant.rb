class Restaurant < ActiveRecord::Base
  belongs_to :category
  belongs_to :prefecture
end

