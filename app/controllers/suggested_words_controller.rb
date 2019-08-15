# frozen_string_literal: true

class SuggestedWordsController < ApplicationController
  def index
    @suggested_words = SuggestedWord.order(status: :desc)
  end

  def new
    @suggested_word = SuggestedWord.new
  end

  def create
    @suggested_word = SuggestedWord.new(suggested_word_params.merge(
                                          created_by_id: current_user.id, word_id: params[:word][:id], status: 0
                                        ))
    render "new" unless @suggested_word.save
  end

  def destroy
    @suggested_word = SuggestedWord.find params[:id]
    @suggested_word.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def suggested_word_params
    params.require(:word).permit :ja, :en, :vi, :description
  end
end
