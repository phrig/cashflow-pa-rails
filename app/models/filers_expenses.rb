class FilersExpenses < ApplicationRecord
  belongs_to :filer
  belongs_to :expense
end