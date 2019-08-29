# frozen_string_literal: true

class History < ApplicationRecord
  belongs_to :user
  has_many :project_histories, dependent: :destroy
  has_many :projects, through: :project_histories, dependent: :destroy
end
