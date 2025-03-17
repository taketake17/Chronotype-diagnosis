class CalendarController < ApplicationController
  def index
    @schedules = current_user.schedules
    respond_to do |format|
      format.html # index.html.erbを表示
      format.json { render json: @schedules.map { |s| { id: s.id, title: s.title, start: s.start_time, end: s.end_time } } }
    end
  end


  def create
    schedule = Schedule.new(schedule_params)
    schedule.user_id = current_user.id # ログイン中のユーザーIDを設定

    if schedule.save
      render json: { id: schedule.id, status: "success" }, status: :created
    else
      render json: { errors: schedule.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    schedule = Schedule.find(params[:id])
    if schedule.update(schedule_params)
      render json: { status: "success" }, status: :ok
    else
      render json: { errors: schedule.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    schedule = Schedule.find(params[:id])
    schedule.destroy
    render json: { status: "success" }, status: :ok
  end

  private

  def schedule_params
    params.require(:schedule).permit(:title, :start_time, :end_time)
  end
end
