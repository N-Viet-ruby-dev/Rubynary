# frozen_string_literal: true

class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
