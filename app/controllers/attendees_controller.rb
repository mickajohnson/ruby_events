class AttendeesController < ApplicationController
  def create
    Attendee.create(user:User.find(params[:u_id]), event:Event.find(params[:e_id]))
    redirect_to :back
  end

  def destroy
    attendee = Attendee.where("user_id = ? AND event_id = ?", params[:u_id], params[:e_id])
    attendee[0].destroy
    redirect_to :back
  end
end
