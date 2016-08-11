class CheckinsController < ApplicationController
  before_action :setup_nav_data

  def students

  end

  def student
    @student = Student.includes(:checkins).find(params[:id])
  end

  def by_date

  end

  def date
    @checkins = Checkin.includes(:student).where(collected_at: params[:date])
  end

  private

  def setup_nav_data
    @students = Student.order(:name)
    @dates = Checkin.distinct_dates
  end
end
