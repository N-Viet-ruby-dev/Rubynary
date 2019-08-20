# frozen_string_literal: true

class ProjectWordsController < ApplicationController
  def index
    @projects = Project.all
    @words = none_project
    @words = Word.all if params[:project].nil?
    @words = Project.find(params[:project]).words if params[:project].present?
  end

  def create
    projects = Project.where(name: params[:projects][:name])
    words = Word.where(id: params[:word_ids])

    @add_word_project = !params[:projects][:name].empty? && params[:word_ids].present?
    return unless @add_word_project

    projects.each do |project|
      words.each do |word|
        ProjectWord.find_or_create_by(project_id: project.id, word_id: word.id)
      end
    end
    @words = Word.order(created_at: :desc)
  end

  def edit
    @word = Word.find params[:id]
    @suggested_word = @word.suggested_words.last
  end

  private

  def none_project
    project_words = ProjectWord.pluck(:word_id)
    Word.where.not(id: project_words)
  end
end
