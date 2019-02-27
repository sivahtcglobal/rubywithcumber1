class CourseCalendarPage < BasePage

  #Moodle Create Calendar Page Elements
  element(:event_type_select) { |b| b.select_list(id:"id_eventtype")}
  element(:event_title_txt) { |b| b.text_field(id:"id_name")}
  element(:event_description_txt) { |b| b.div(id:"id_descriptioneditable")}
  element(:event_time_day_select) { |b| b.select_list(id:"id_timestart_day")}
  element(:event_time_month_select) { |b| b.select_list(id:"id_timestart_month")}
  element(:event_time_year_select) { |b| b.select_list(id:"id_timestart_year")}
  element(:event_time_hour_select) { |b| b.select_list(id:"id_timestart_hour")}
  element(:event_time_minute_select) { |b| b.select_list(id:"id_timestart_minute")}

  #Duration
  element(:duration_link) { |b| b.a(text:"Duration")}
  element(:without_duration_radio) { |b| b.input(id:"id_duration_0")}
  element(:until_radio) { |b| b.input(id:"id_duration_1")}
  element(:duration_until_day_select) { |b| b.select_list(id:"id_timedurationuntil_day")}
  element(:duration_until_month_select) { |b| b.select_list(id:"id_timedurationuntil_month")}
  element(:duration_until_year_select) { |b| b.select_list(id:"id_timedurationuntil_year")}
  element(:duration_until_hour_select) { |b| b.select_list(id:"id_timedurationuntil_hour")}
  element(:duration_until_minute_select) { |b| b.select_list(id:"id_timedurationuntil_minute")}
  element(:duration_in_minutes_radio) { |b| b.input(id:"id_duration_2")}
  element(:time_duration_minutes_txt) { |b| b.input(id:"id_timedurationminutes")}

  #Repeated events
  element(:repeated_events_link) { |b| b.a(text:"Repeated events")}
  element(:repeat_this_event_chkbx) { |b| b.input(id:"id_repeat")}
  element(:repeat_weekly_txt) { |b| b.input(id:"id_repeats")}

  #Buttons
  element(:new_event_btn) { |b| b.input(css:"input[value='New event']")}
  action(:new_event_btn_clk) { |b| b.new_event_btn.click }
  element(:save_changes_btn) { |b| b.input(id:"id_submitbutton")}
  action(:save_changes_btn_clk) { |b| b.save_changes_btn.click }

  element(:calendar_event) { |b| b.div(class:"calendar_event_user")}

end
