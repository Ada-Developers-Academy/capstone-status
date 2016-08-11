class CheckinsController < ApplicationController
  def students
    @students = Student.order(:name)
  end

  def student
    @student = Student.includes(:checkins).find(params[:id])
  end

  def by_date
    @dates = Checkin.distinct_dates
  end

  def date
    @checkins = Checkin.includes(:student).where(collected_at: params[:date])
  end
end
