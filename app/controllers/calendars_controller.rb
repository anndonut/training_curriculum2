class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    getWeek
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:calendars).permit(:date, :plan)
  end

  def getWeek
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。

    # ↓変更前；@todays_date = Date.today
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    # ↓変更前：@week_days = []
    @week_days = []
    # ↓変更前：plans = Plan.where(date: @todays_date..@todays_date + 6)
    @plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      # plan = plans.map do |plan|
      plan = @plans.map do |plan|
        # ↓変更前：today_plans.push(plan.plan) if plan.date == @todays_date + x
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end
      # ↓変更前：days = { month: (@todays_date + x).month, date: (@todays_date+x).day, plans: today_plans}
      days = { month: (@todays_date + x).month, date: (@todays_date+x).day, plans: today_plans}
      # ↓変更前：@week_days.push(days)
      @week_days.push(days)
    end

  end
end
