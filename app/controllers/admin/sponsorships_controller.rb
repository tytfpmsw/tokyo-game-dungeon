class Admin::SponsorshipsController < Admin::ApplicationController

  before_action :set_event

  def index
    @sponsorships = Sponsorship.includes(:sponsor).where(event_id: @event.id)
  end

  def new
    @sponsorship = Sponsorship.new
    @sponsors = Sponsor.not_sponsorships(@event)
  end

  def create
    @sponsorship = Sponsorship.new(sponsorship_params)
    @sponsor = Sponsor.find(sponsorship_params[:sponsor_id])

    if @sponsorship.save
      flash.now[:notice] = "協賛を登録しました。"
    else
      @sponsors = Sponsor.not_sponsorships(@event)
      render :new, response: :unprocessable_entity
    end
  end

  def edit
    @sponsorship = Sponsorship.find(params[:id])
    @sponsors = Sponsor.not_sponsorships(@event)
  end

  def update
    @sponsorship = Sponsorship.find(params[:id])
    if @sponsorship.update(sponsorship_params)
      flash[:notice] = "協賛を更新しました。"
    else
      @sponsors = Sponsor.not_sponsorships(@event)
      render :edit
    end
  end

  def destroy
    @sponsorship = Sponsorship.find(params[:id])
    if @sponsorship.destroy
      flash[:notice] = "協賛を解除しました。"
    else
      render :index
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def sponsorship_params
    params.require(:sponsorship).permit(:sponsor_id, :event_id)
  end
end
