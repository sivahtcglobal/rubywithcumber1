class CourseDatabaseEntryPage < BasePage

  #Search
  element(:search_link) { |b| b.a(text:"Search")}
  element(:add_entry_link) { |b| b.a(css:"a[title='Add entry']")}
  element(:new_entry_name_txt) { |b| b.text_field(type:"text")} #StdEntry1
  element(:color_chkbox) { |b| b.input(type:"checkbox")}
  element(:entry_saveandview_btn) { |b| b.input(type:"submit") }
  element(:fullname) { |b| b.td(css:"tr:nth-child(1) td.lastcol")}
end
