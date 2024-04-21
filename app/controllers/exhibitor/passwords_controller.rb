class Exhibitor::PasswordsController < Exhibitor::ApplicationController

  def edit
    @exhibitor = current_exhibitor
  end

  def update
    @exhibitor = current_exhibitor

    if (params[:password].blank? && params[:password_confirmation].blank?)
      @exhibitor.errors.add(:password, :blank)
      @exhibitor.errors.add(:password_confirmation, :blank)
      flash.now.alert = 'パスワードを入力してください'
      render :edit, status: :unprocessable_entity and return
    end

    if params[:password] != params[:password_confirmation]
      @exhibitor.errors.add(:password, :confirmation)
      flash.now.alert = 'パスワードが一致しません'
      render :edit, status: :unprocessable_entity and return
    end

    if @exhibitor.reset_password(params[:password], params[:password_confirmation])
      # 変更後強制ログアウトによって2回リダイレクトが走り、フラッシュメッセージが消えてしまうため
      # bypass_sign_inによってログイン状態を維持する
      bypass_sign_in(@exhibitor)
      flash.notice = 'パスワードを変更しました'
      redirect_to exhibitor_root_path
    else
      flash.now.alert = @exhibitor.errors.full_messages.join("\n")
      render :edit, status: :unprocessable_entity and return
    end
  end
end
