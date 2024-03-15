# frozen_string_literal: true

class Administrators::RegistrationsController < Devise::RegistrationsController
  before_action :guard_signup!, only: %i[cancel new destroy create]

  def new
    
  end

  private
  
  def guard_signup!
    raise ActionController::RoutingError, 'Not Found'
  end
end
