class Admin::ExhibitSubmissionsController < ApplicationController
  def index
    @exhibit_submissions = ExhibitSubmission.submitted.order(created_at: :asc)
  end

  def show
    @exhibit_submission = ExhibitSubmission.find(params[:id])
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
      @exguibit_submission.status = "approved"
    elsif :params[:commit] == "却下"
      @exguibit_submission.status = "rejected"
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
    @exhibit_information = ExhibitInformation.find_by(exhibitor_id: @exhibit_submission.exhibitor_id)
    if @exhibit_information
      @exhibit_information.update(
        title: @exhibit_submission.exhibit_title? ? @exhibit_submission.exhibit_title : @exhibit_information.title,
        description: @exhibit_submission.exhibit_description? ? @exhibit_submission.exhibit_description : @exhibit_information.description,
        movie_link: @exhibit_submission.exhibit_movie_url? ? @exhibit_submission.exhibit_movie_url : @exhibit_information.movie_link
      )
    else
      ExhibitInformation.create(
        exhibitor_id: @exhibit_submission.exhibitor_id,
        title: @exhibit_submission.exhibit_title,
        description: @exhibit_submission.exhibit_description,
        movie_link: @exhibit_submission.exhibit_movie_url
      )
    end
    @exhibit_submission.update(status: "approved")
    redirect_to admin_exhibit_submissions_path
    # フラッシュメッセージを表示する
  end

  def reject
    @exhibit_submission = ExhibitSubmission.find(params[:id])
    @exhibit_submission.update(status: "rejected")
    redirect_to admin_exhibit_submissions_path
    # フラッシュメッセージを表示する
  end
end
