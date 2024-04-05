class Admin::SponsorshipsController < Admin::ApplicationController

  before_action :set_event

  def index
    @sponsorships = Sponsorship.where(event_id: @event.id)
    @sponsors = @sponsorships.map(&:sponsor)
  end

  def new
    @sponsorship = Sponsorship.new
    @sponsors = Sponsor.not_sponsorships(@event)
  end

  def create
    @sponsorship = Sponsorship.new(sponsorship_params)
    @sponsor = Sponsor.find(params[:sponsor_id])

    if @sponsorship.save
    else
      render :new
    end
  end

  def destroy
    @sponsorship = Sponsorship.find(params[:id])
    @sponsor = Sponsor.find(@sponsorship.sponsor_id)
    @sponsorship.destroy!
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def sponsorship_params
    params.permit(:sponsor_id, :event_id)
  end
end
