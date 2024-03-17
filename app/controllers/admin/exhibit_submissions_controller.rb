class Admin::ExhibitSubmissionsController < ApplicationController

  before_action :authenticate_administrator!

  def index
    @exhibit_submissions = ExhibitSubmission.submitted.order(created_at: :asc)
  end

  def show
    @exhibit_submission = ExhibitSubmission.find(params[:id])
    @exhibit_information = ExhibitInformation.find_by(id: @exhibit_submission.exhibit_information_id)
    @exhibitor = Exhibitor.find_by(id: @exhibit_information.exhibitor_id)
  end

  def edit
    @exhibit_submission = ExhibitSubmission.find(params[:id])
    if @exhibit_submission.status != "submitted"
      redirect_to admin_exhibit_submissions_path
      # TODO: 更新できるステータスでない場合はフラッシュメッセージを表示する
    end
  end

  def update
    @exhibit_submission = ExhibitSubmission.find(params[:id])

    if :params[:commit] == "承認"
      @exhibit_submission.status = "approved"
    elsif :params[:commit] == "却下"
      @exhibit_submission.status = "rejected"
    end

    if @exhibit_submission.update(exhibit_submission_params)
      redirect_to admin_exhibit_submissions_path
      # フラッシュメッセージを表示する
    else
      render :edit
    end
  end

  def approve
    @exhibit_submission = ExhibitSubmission.find(params[:id])
    @exhibit_information = ExhibitInformation.find_by(id: @exhibit_submission.exhibit_information_id)
    @exhibit_information.copy_image_from_exhibit_submission(@exhibit_submission.image.path)
    if @exhibit_information
      @exhibit_information.title = @exhibit_submission.title? ? @exhibit_submission.title : @exhibit_information.title
      @exhibit_information.description = @exhibit_submission.description? ? @exhibit_submission.description : @exhibit_information.description
      @exhibit_information.movie_url = @exhibit_submission.movie_url? ? @exhibit_submission.movie_url : @exhibit_information.movie_url
      # imageはcopy_image_from_exhibit_submissionでコピー済み
      @exhibit_information.update(@exhibit_information.attributes)
    else
      ExhibitInformation.create(
        exhibitor_id: @exhibit_submission.exhibitor_id,
        title: @exhibit_submission.title,
        description: @exhibit_submission.description,
        movie_url: @exhibit_submission.movie_url
        # imageはcopy_image_from_exhibit_submissionでコピー済み
      )
    end
    @exhibit_submission.update(status: "approved")
    redirect_to admin_event_exhibit_submissions_path
    # TODO: フラッシュメッセージを表示する
  end

  def reject
    @exhibit_submission = ExhibitSubmission.find(params[:id])
    @exhibit_submission.update(status: "rejected")
    redirect_to admin_event_exhibit_submissions_path
    # TODO: フラッシュメッセージを表示する
  end
end
