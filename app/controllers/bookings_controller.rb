class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
  end

  def create
    @activity = Activity.find(params[:activity_id])
    @booking = Booking.new()
    @booking.user = current_user
    @booking.activity = @activity
    if @booking.save
      redirect_to @activity, notice: "The booking has been made correctly"
    else
      flash[:alert] = @booking.errors.full_messages.join("\n")
      render 'activities/show', status: :see_other
    end
  end

  def destroy
    @booking = Booking.find(params[:id])

    @booking.destroy

    redirect_to activity_path(@booking.activity)
  end

  private

  def set_booking
    @activity = Activity.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(%i[activity_id user_id])
  end
end
