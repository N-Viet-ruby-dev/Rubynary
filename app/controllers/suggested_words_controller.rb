# frozen_string_literal: true

class SuggestedWordsController < ApplicationController
  before_action :check_developer

  def index
    @suggested_words = SuggestedWord.where(created_by_id: current_user.id).order(status: :desc)
  end

  def new
    @suggested_word = SuggestedWord.new
  end

  def create
    @suggested_word = SuggestedWord.new(suggested_word_params.merge(
                                          created_by_id: current_user.id, word_id: params[:word][:id], status: 0
                                        ))
    respond_to do |format|
      format.js
    end

    if @suggested_word.save
      flash[:info] = "The revision has been added to the update waiting list !"
    else
      flash[:error] = "Edit word falsed !"
    end
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
