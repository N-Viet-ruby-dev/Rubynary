# frozen_string_literal: true

class Word < ApplicationRecord
  validates :ja, presence: true
  validates :en, presence: true
  validates :vi, presence: true
  has_many :project_words, dependent: :destroy
  has_many :projects, through: :project_words, dependent: :destroy
end
