# frozen_string_literal: true

class User < ApplicationRecord
  enum role: %i[comtor developer lead_comtor]

  validates :name, presence: true, length: { minimum: 5, maximum: 100 }
end
