class Province < ApplicationRecord
    has_many :users

    validates :name, :total_tax, presence: true
    validates :total_tax, numericality: true
end
