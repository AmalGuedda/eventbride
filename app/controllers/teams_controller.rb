class TeamsController < ApplicationController
    before_action :authenticate_user, only: [:show, :edit, :update, :destroy]
    before_action :is_owner, only: [:show, :edit, :update, :destroy]
    before_action :set_user, only: [:show, :edit, :update, :destroy]
  

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
      @admin_events = Event.where(admin_id: @user.id)
      (@admin_events.size > 0)? (@admin = true) : (@admin = false)
      @guest_events = Event.joins(:attendances).where('attendances.user_id = ?', @user.id)
      (@guest_events.size > 0)? (@guest = true) : (@guest = false)
    end
  

    def new
      @user = User.new
    end
  

    def edit
    end

    def create
  
      @user = User.new(first_name: params[:first_name], 
                      last_name: params[:last_name],
                      description: params[:description],
                      email: params[:mail])
      if params[:password] != params[:confirmpassword]
        flash.now[:danger] = "Passwords must match !"
        render :action => 'new' 
      end
      if @user.save # essaie de sauvegarder en base 
          flash[:success] = "You successfuly created your account"
          redirect_to :controller => 'users', :action => 'index'
      else
        flash.now[:danger] = "Error with the account creation"
        render :action => 'new'
      end
    end
  
   
    def update
      respond_to do |format|
        if @user.update(first_name: params[:first_name], 
                      last_name: params[:last_name],
                      description: params[:description],
                      email: params[:mail])
          flash[:success] = "You successfuly updated your account"
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  

    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
      
      def set_user
        @user = User.find(params[:id])
      end
  
    
      def user_params
        params.fetch(:user, {})
      end
  
      def authenticate_user
        unless current_user 
          flash[:danger] = "This section requires to be logged-in. Please log in."
          redirect_to new_user_session_url
        end
      end
  
      def is_owner
        if current_user.id.to_i != params[:id].to_i
          flash[:danger] = "You can't acces this page"
          redirect_to "/"
        end
      end
end
