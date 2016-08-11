Rails.application.routes.draw do
  root 'checkins#students'

  controller 'checkins' do
    get 'students'
    get 'students/:id', action: 'student', as: :student
    get 'by_date'
    get 'by_date/:date', action: 'date', as: :date
  end
end
