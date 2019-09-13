# frozen_string_literal: true

class Word < ApplicationRecord
  validates :ja, presence: true, length: { maximum: 255 }
  validates :en, presence: true, length: { maximum: 255 }
  validates :vi, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 255 }

  has_many :project_words, dependent: :destroy
  has_many :projects, through: :project_words, dependent: :destroy
  has_many :suggested_words, dependent: :destroy
end
