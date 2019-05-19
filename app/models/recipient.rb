class Recipient < ApplicationRecord
  belongs_to :order, optional: true
end
