module CheckinsHelper
  def missing_list(missing_students)
    missing_students.reduce('') do |accum, student|
      accum += content_tag(:li, student.name, class: 'flex-box skinny')
    end
  end
end
