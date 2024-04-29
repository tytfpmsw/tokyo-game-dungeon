# frozen_string_literal: true

class Admin::RegistrationsController < Admin::ApplicationController

  before_action :authenticate_administrator!, only: %i[edit update]

  def edit
    @administrator = current_administrator
  end

  def update
    @administrator = current_administrator

    if @administrator.update(administrator_params)
      redirect_to admin_root_path, notice: '管理者情報を更新しました'
    else
      # TODO: フラッシュメッセージを表示する
      flash.alert = '管理者情報を更新できませんでした'
      render :edit
    end
  end

  private

  def administrator_params
    params.permit(:email)
  end
  
  def guard_signup!
    raise ActionController::RoutingError, 'Not Found'
  end
end
