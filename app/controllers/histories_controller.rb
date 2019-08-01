# frozen_string_literal: true

class HistoriesController < ApplicationController
  def index
    @histories = current_user.histories.includes(:projects).order("created_at DESC")
  end
end
