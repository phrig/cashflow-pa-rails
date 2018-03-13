class FilersReceipts < ApplicationRecord
  belongs_to :filer
  belongs_to :receipt
end