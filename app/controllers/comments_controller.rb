class CommentsController < ApplicationController
  def create
    comment = Comment.new(content:params[:content], user: current_user, event:Event.find(params[:id]))
    if comment.valid?
      comment.save
    else
      flash[:errors] = comment.errors.full_messages
    end
    redirect_to :back
  end
end
