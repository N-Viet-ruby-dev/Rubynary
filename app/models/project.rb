# frozen_string_literal: true

class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :project_words, dependent: :destroy
  has_many :words, through: :project_words, dependent: :destroy
end
