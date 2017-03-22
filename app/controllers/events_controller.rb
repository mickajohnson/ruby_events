class EventsController < ApplicationController
  def index
    @states = states
    @state_events = Event.where("state = ?", current_user.state)
    @not_state_events = Event.where("state != ?", current_user.state).limit(5)
  end

  def create
    event = Event.new(event_params)
    if event.valid?
      event.user = User.find(current_user.id)
      event.save
    else
      flash[:errors] = event.errors.full_messages
    end
    redirect_to :back
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @states = states
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id]).update(event_params)
    if event
      redirect_to '/'
    else
      flash[:errors] = ["Must submit valid fields"]
      redirect_to :back
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to :back
  end

  private
  def event_params
    params.require(:event).permit(:name, :date, :city, :state)
  end
end
