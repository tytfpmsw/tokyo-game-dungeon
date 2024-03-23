# frozen_string_literal: true

class Exhibitor::RegistrationsController < Devise::RegistrationsController
  # cancel, new, destroy, createの時はguard_signup!でエラーを発生させ、変更以外のアクションを実行できないようにする
  # %iはrubyのリテラル構文で、スペース区切りのシンボルの配列を作成する
  before_action :guard_signup!, only: %i[cancel new destroy create]

  private

  def guard_signup!
    raise ActionController::RoutingError, 'Not Found'
  end
end
