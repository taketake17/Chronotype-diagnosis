class CalendarController < ApplicationController
  def index
    @user_chronotype = current_user.user_chronotype
    if @user_chronotype
      @default_schedules = DefaultSchedule.where(chronotype_id: @user_chronotype.chronotype_id)
    else
      @default_schedules = []
    end
    @user_schedules = current_user.schedules

    # カレンダーの表示期間を取得（パラメータから取得するか、デフォルト値を設定）
    start_date = params[:start].present? ? Date.parse(params[:start]) : Date.today.beginning_of_week
    end_date = params[:end].present? ? Date.parse(params[:end]) : start_date + 6.days

    @combined_schedules = []

    # ユーザースケジュールを追加
    @combined_schedules += @user_schedules.map do |s|
      {
        id: s.id,
        title: s.title,
        start: s.start_time,
        end: s.end_time,
        is_default: false
      }
    end

    # デフォルトスケジュールを期間内の毎日分生成
    (start_date..end_date).each do |date|
      @default_schedules.each do |s|
        start_time = Time.parse(s.start_time.to_s)
        end_time = Time.parse(s.end_time.to_s)
        start_datetime = combine_date_and_time(date, start_time)
        end_datetime = combine_date_and_time(date, end_time)
        @combined_schedules << {
          id: "default_#{s.id}_#{date}",
          title: s.title,
          start: start_datetime,
          end: end_datetime,
          is_default: true
        }
      end
    end

    Rails.logger.debug "User Chronotype: #{@user_chronotype.inspect}"
    Rails.logger.debug "Default Schedules: #{@default_schedules.inspect}"
    Rails.logger.debug "User Schedules: #{@user_schedules.inspect}"
    Rails.logger.debug "Combined Schedules: #{@combined_schedules.inspect}"

    respond_to do |format|
      format.html
      format.json { render json: @combined_schedules }
    end
  end

  def combine_date_and_time(date, time)
    Time.zone.local(date.year, date.month, date.day, time.hour, time.min, time.sec)
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

  def combine_date_and_time(date, time)
    Time.zone.local(date.year, date.month, date.day, time.hour, time.min, time.sec)
  end

  def schedule_params
    params.require(:schedule).permit(:title, :start_time, :end_time)
  end
end
