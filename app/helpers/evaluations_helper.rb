module EvaluationsHelper
  def format_semaphore(color, reverse = false)
    colors = [['red', '#f63b3b'], ['yellow', '#f7ec5b'], ['green', '#3eb076']]
    colors.reverse! if reverse
    semaphore = '<div class="semaphore">'
    colors.each do |c|
    semaphore += "<svg viewBox='0 0 36 36' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' aria-hidden='false' role='img' width='24px' height='24px'"
      if c[0] != color
        semaphore += "class='fade'"
      end
      semaphore += "><circle fill='#{c[1]}' cx='18' cy='18' r='18'></circle></svg>"
    end
    semaphore += '</div>'
    semaphore.html_safe
  end
end
