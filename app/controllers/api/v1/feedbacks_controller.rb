class Api::V1::FeedbacksController < Api::V1::BaseController
  def create
    feedback = save_feedback
    update_contact_info if !feedback_params[:fulfilled]
    respond_with feedback
  end

  private

  def update_contact_info
    receiver.giver.update!(contact_params)
  end

  def save_feedback
    Feedback.create!(
      receiver_id: receiver.id,
      fulfilled: feedback_params[:fulfilled],
      additional_info: feedback_params[:additional_info]
    )
  end

  def feedback_params
    params.require(:feedback).permit(:fulfilled, :additional_info)
  end

  def contact_params
    params.require(:feedback).permit(:email, :phone_number)
  end
end
