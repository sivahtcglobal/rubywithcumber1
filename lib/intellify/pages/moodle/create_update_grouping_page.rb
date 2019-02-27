class CourseGroupingPage < BasePage

  #Moodle Create Grouping Page Elements

element(:participant_link) {|b| b.p.a(text:"Participants")}
  element(:grouping_icon){|b| b.input(value:"Create grouping")}
  element(:group_name){|b| b.text_field(id:"id_name")}
  element(:group_number){|b| b.text_field(id:"id_idnumber")}
  element(:group_save){|b|b.input(id:"id_submitbutton")}
  element(:group_table){|row,b| b.tbody.tr(index:row).td(class:"cell c0").text}
  element(:group_edit){|row,b| b.tbody.tr(index:row).td(class:"cell c3 lastcol").a(title:"Edit")}
  element(:create_group){|b| b.input(id:"showcreateorphangroupform")}
element(:group_people){|row,b| b.tbody.tr(index:row).td(class:"cell c3 lastcol").a(title:"Show groups in grouping")}
 element(:group_select){|opt,b| b.tbody.tr.td(id:"potentialcell").select.option(text:opt)}
element(:group_select1){|opt,b| b.tbody.tr.td(id:"existingcell").select.option(text:opt)}
  element(:add_group){|b| b.input(id:"add")}
element(:remove_group){|b| b.input(id:"remove")}
end
