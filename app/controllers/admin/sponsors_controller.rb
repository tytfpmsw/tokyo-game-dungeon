class Admin::SponsorsController < Admin::ApplicationController

  before_action :set_sponsor, only: %i[show edit update destroy]

  def index
    @sponsors = Sponsor.all

    @search = Sponsor.ransack(params[:q])
    @search.sorts = 'id asc' if @search.sorts.empty?

    @sponsors = @search.result.page(params[:page])
  end

  def show
    
  end

  def new
    @sponsor = Sponsor.new
  end

  def edit

  end

  def create
    @sponsor = Sponsor.new(sponsor_params)

    if @sponsor.save
      flash.now.notice = "協賛団体を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @sponsor.update(sponsor_params)
      flash.now.notice = "協賛団体を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sponsor.destroy!
    flash.now.notice = "協賛団体を削除しました。"
  end

  private
    def set_sponsor
      @sponsor = Sponsor.find(params[:id])
    end

    def sponsor_params
      params.except(
      :authenticity_token,
      :commit,
      :subdomain
      ).require(:sponsor).permit(
        :name, 
        :image, 
        :url)
    end
end
