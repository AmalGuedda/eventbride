class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]

  
    def index
      @events = Event.all
     
    end
  
   
    def show
      @event = Event.find(params[:id])
      @admin = User.find(@event.admin_id)
      @nb_guests = Attendance.where(event_id: @event.id).count
    end
  
    def new
      @event = Event.new
    end
  

    def edit
      @event = Event.find(params[:id])
    end
  
   
    def create
      @event = Event.new(title: params[:title], 
        description: params[:description],
        location: params[:location],
        price: params[:price],
        start_date: params[:start_date],
        duration: params[:duration],
        admin_id: current_user.id)
  
      if @event.save 
          flash[:success] = "You successfuly created an event"
          redirect_to :controller => 'events', :action => 'show', id: @event.id
      else
       
        flash.now[:danger] = "Error with the account creation"
        render :action => 'new'
      end
    end
  
 
    def update
      respond_to do |format|
        if @event.update(event_params)
          format.html { redirect_to @event, notice: 'Event was successfully updated.' }
          format.json { render :show, status: :ok, location: @event }
        else
          format.html { render :edit }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  

    def destroy
      @event.destroy
      respond_to do |format|
        format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
  
      def set_event
        @event = Event.find(params[:id])
      end
  
     
      def event_params
        params.fetch(:event, {})
      end
end
