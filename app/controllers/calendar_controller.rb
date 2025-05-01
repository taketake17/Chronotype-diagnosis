class CalendarController < ApplicationController
  before_action :authenticate_user!
  before_action :check_chronotype

  def index
    @user_chronotype = current_user.latest_user_chronotype
    @default_schedules = DefaultSchedule.where(chronotype_id: current_user.latest_chronotype_id)

    @user_schedules = current_user.schedules

    start_date = params[:start].present? ? Date.parse(params[:start]) : Date.today.beginning_of_week
    end_date = params[:end].present? ? Date.parse(params[:end]) : start_date + 6.days

    @combined_schedules = DefaultSchedule.create_default_weekly_schedule(start_date, end_date, @default_schedules).map do |s|
      s.merge(isDefault: s.delete(:is_default))
    end
    @combined_schedules += @user_schedules.map do |s|
      {
        id: s.id,
        title: s.title,
        start: s.start_time.in_time_zone("Asia/Tokyo"),
        end: s.end_time.in_time_zone("Asia/Tokyo"),
        isDefault: false,
        content: s.content
      }
    end

    respond_to do |format|
      format.html
      format.json { render json: @combined_schedules }
    end
  end

  def create
    schedule = Schedule.new(schedule_params)
    schedule.user_id = current_user.id

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

  def check_chronotype
    return if current_user.latest_user_chronotype.present?
    return if request.path == tops_path

    flash[:alert] = "クロノタイプの判定を行ってください"
    redirect_to tops_path
  end


  def schedule_params
    params.require(:schedule).permit(:title, :start_time, :end_time, :content)
  end
end
