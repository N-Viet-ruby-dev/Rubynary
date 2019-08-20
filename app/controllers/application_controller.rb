# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def check_lead_comtor
    return if current_user.lead_comtor?

    redirect_to :root
  end

  def check_developer
    return if !current_user.developer?

    redirect_to :root
  end
end
