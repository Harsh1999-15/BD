class Book < ApplicationRecord
   resourcify
   belongs_to :user
   validates :name, presence:true, uniqueness:true
end
