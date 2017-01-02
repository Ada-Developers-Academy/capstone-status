Rails.application.routes.draw do
  root 'checkins#students'

  controller 'checkins' do
    get 'students'
    get 'students/:id', action: 'student', as: :student
    get 'by_date/:date', action: 'date', as: :date
    get 'by_cohort/:cohort', action: 'cohort', as: :cohort
  end
end
