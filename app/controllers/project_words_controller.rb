# frozen_string_literal: true

class ProjectWordsController < ApplicationController
  before_action :authenticate_user!
  before_action :delete_empty, :find_projects, :find_words, only: %i[create]
  before_action :all_projects, only: %i[index]

  def index
    @words = if params[:project].present?
               @project = Project.find params[:project]
               @project.words
             elsif params[:project].nil?
               Word.order(created_at: :desc)
             else
               @project_words = ProjectWord.pluck(:word_id)
               Word.where.not(id: @project_words)
             end
  end

  def create
    @add_word_project = !params[:projects][:name].empty? && params[:word_ids].present?
    return unless @add_word_project

    @projects.each do |project|
      @words.each do |word|
        if ProjectWord.where(word_id: word.id, project_id: project.id).count.zero?
          ProjectWord.create!(project_id: project.id, word_id: word.id)
        end
      end
    end
    @words = Word.order(created_at: :desc)
  end

  private

  def delete_empty
    params[:projects][:name] = params[:projects][:name].reject(&:empty?)
  end

  def all_projects
    @projects = Project.all
  end

  def find_projects
    @projects = Project.where(name: params[:projects][:name])
  end

  def find_words
    @words = Word.where(id: params[:word_ids])
  end
end
