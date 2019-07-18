# frozen_string_literal: true

class WordsController < ApplicationController
  before_action :word_project, only: %i[create new]
  before_action :word, only: %i[destroy update edit]
  before_action :authenticate_user!

  def index
    unless params[:q].present?
      flash.now[:warning] = t(".input_word")
    else
      @words = Word.ransack(en_or_vi_or_ja_cont:params[:q]).result(distinct: true).page(params[:page]).per(3)
      if @words.count == 0
        flash.now[:warning] = t(".find_result")
      else
        respond_to do |format|
          format.html{}
          format.json{
            @words = @words.limit(3)
          }
        end
      end
    end
  end

  def edit; end

  def update
    if @word.update(word_params.merge(last_update_by_id: current_user.id))
      respond_to do |format|
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    @word.destroy
    respond_to do |format|
      format.js
    end
  end

  def new; end

  def create
    flash.now[:warning] = t(".not_file_selected") unless params[:file].present?
    response = ImportWords.perform params[:file], params[:project_ids], current_user.id
    if response
      flash[:success] = t(".file_imported")
      redirect_to root_path
    else
      flash.now[:error] = t(".error_import")
      render :new
    end
  end

  private

  def word
    @word = Word.find params[:id]
  end

  def word_params
    params.require(:word).permit :ja, :en, :vi, :description
  end

  def word_project
    @word_project ||= Project.pluck :name, :id
  end
end
