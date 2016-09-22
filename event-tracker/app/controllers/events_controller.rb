class EventsController < ApplicationController
  
  http_basic_authenticate_with name: "username", password: "password", except: [:index, :show, :add_user]
  
  def index
    if params[:search] != nil
      @events = Event.all.where("title LIKE '%#{params[:search]}%'")
    elsif params[:search_date] != nil
      @from_date = DateTime.new(params[:search_date]["from_date(1i)"].to_i,
                                params[:search_date]["from_date(2i)"].to_i,
                                params[:search_date]["from_date(3i)"].to_i)
      @to_date = DateTime.new(params[:search_date]["to_date(1i)"].to_i,
                              params[:search_date]["to_date(2i)"].to_i,
                              params[:search_date]["to_date(3i)"].to_i).end_of_day
      @events = Event.where(:datetime => @from_date..@to_date)
    else
      @events = Event.all
    end
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def new
    @event = Event.new
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def create
    @event = Event.new(event_params)
   
    if @event.save
      redirect_to @event
    else
      render 'new'
    end
  end
  
  def update
    @event = Event.find(params[:id])
   
    if @event.update(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
   
    redirect_to events_path
  end
  
  def add_user
    if session[:user_id] == nil
      flash[:failure] = "You need to login to RSVP to an event"
      redirect_to login_path
    else
      @user_id = session[:user_id]
      @user = User.find_by_id(@user_id)
      @event = Event.find_by_id(params[:event_id])
      if @event.users.find_by_id(@user_id)
        flash[:failure] = "You already subscribed to the event"
        redirect_to event_path
      else
        @event.users << @user
        flash[:success] = "Successfully added to the event"
        redirect_to event_path
      end
    end
  end
  
  def save_lat_long
    @events = Event.all
    @events.each do |event|
      if event.latitude.nil?
        binding.pry
        new_location = [address, city, province, postalcode, country].compact.join(",")
        result = Geocoder.search(new_location)
        event.latitude = result[0].latitude
        event.longitude = result[0].longitude
        event.save
      end
    end
  end
  
  private
    def event_params
      params.require(:event).permit(:title, :description, :address, :city, :province, :postalcode, :country, :datetime, :event_type, :latitude, :longitude)
    end
end
