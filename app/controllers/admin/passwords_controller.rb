class Admin::PasswordsController < Admin::ApplicationController

  def edit
    @administrator = current_administrator
  end

  def update
    @administrator = current_administrator

    if (params[:password].blank? && params[:password_confirmation].blank?)
      @administrator.errors.add(:password, :blank)
      @administrator.errors.add(:password_confirmation, :blank)
      flash.now.alert = 'パスワードを入力してください'
      render :edit, status: :unprocessable_entity and return
    end

    if params[:password] != params[:password_confirmation]
      @administrator.errors.add(:password, :confirmation)
      flash.now.alert = 'パスワードが一致しません'
      render :edit, status: :unprocessable_entity and return
    end

    if @administrator.reset_password(params[:password], params[:password_confirmation])
      # 変更後強制ログアウトによって2回リダイレクトが走り、フラッシュメッセージが消えてしまうため
      # bypass_sign_inによってログイン状態を維持する
      bypass_sign_in(@administrator)
      flash.notice = 'パスワードを変更しました'
      redirect_to admin_root_path
    else
      flash.now.alert = @administrator.errors.full_messages.join("\n")
      render :edit, status: :unprocessable_entity and return
    end
  end
end
