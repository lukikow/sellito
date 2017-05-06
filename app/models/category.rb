class Category < ApplicationRecord
  #wymagalnosc parametrow - walidacja
  validates :name, presence: true, uniqueness: true
  #TODO: po wpisaniu w konsoli rake notes wyswietli wszystkie todo calym kodzie
end
