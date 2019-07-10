# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  enum role: %i[comtor developer lead_comtor]

  validates :name, presence: true, length: { minimum: 5, maximum: 100 }
end
