# frozen_string_literal: true

class HistoriesController < ApplicationController
  def index
    @histories = current_user.histories.includes(:projects).order("updated_at DESC")
  end
end
