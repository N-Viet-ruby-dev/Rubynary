# frozen_string_literal: true

class WordsController < ApplicationController
  before_action :set_search, only: %i[index]

  def index
    @words_search = @search.result(distinct: true) unless params[:q].nil?
  end

  private

  def set_search
    @search = Word.ransack(params[:q])
  end
end
