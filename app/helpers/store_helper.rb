module StoreHelper
  def show_session_counter(session_counter)
    if session_counter > 5
      html = "<div id='display_counter'>" + pluralize(session_counter, 'times') + '</div>'
      html.html_safe
    end
  end
end
