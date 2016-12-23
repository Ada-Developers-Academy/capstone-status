class CheckinsController < ApplicationController
  before_action :setup_nav_data

  def students; end

  def student
    @student = Student.includes(:checkins).find(params[:id])
  end

  def date
    @checkins = Checkin.includes(:student).where(collected_at: params[:date])
    @missing  = @students - @checkins.map(&:student)
  end

  def cohort
    @students = Student.where(cohort: params[:cohort])
    p @students
    @checkins = @students.map(&:checkins)
    render :students
  end

  private

  def setup_nav_data
    @students = Student.order(:name)
    @dates = Checkin.distinct_dates
    @cohorts = Student.all.map(&:cohort).uniq
  end
end
