class Article < ApplicationRecord
   validates :title, presence: true, length: { minimun: 3, maximum: 100 }
   validates :description, presence: true, length: { minimum: 10, maximum: 1000 }

end