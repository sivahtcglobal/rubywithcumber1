class MoodleDataSourcePage < BasePage

  #Moodle Data Source Page Elements
  element(:add_data_source_btn) { |b| b.button(text:"+ Data Source")}
  action(:add_data_source_btn_clk) { |b| b.add_data_source_btn.click }

  element(:moodle_label) { |b| b.div(text:"Moodle")}
  element(:moodle_add_datasource_btn) { |b| b.button(id:"add-datasource-Moodle")}
  element(:configure_btn) { |b| b.button(text:"Configure")}
  action(:configure_btn_clk) { |b| b.configure_btn.click }

  element(:api_key_txt) { |b| b.div(css:"section[class*='module-additional-help'] div div:nth-child(1) div")}
  element(:sensor_id_txt) { |b| b.div(css:"section[class*='module-additional-help'] div div:nth-child(2) div")}
  element(:host_name_txt) { |b| b.div(css:"section[class*='module-additional-help'] div div:nth-child(3) div")}

  element(:delete_data_source_btn) { |b| b.span(css:"span.glyphicon-trash")}
  element(:delete_btn) { |b| b.button(text:"Delete")}

  element(:workbench_org_arrow_icon) { |b| b.i(css:"i.tree-branch-head")}
  element(:workbench_data_collection_arrow_icon) { |b| b.i(css:"treeitem li:nth-child(1) i.tree-branch-head")}
  element(:workbench_data_source_name) { |b| b.i(css:"li i.dataSource")}
  element(:data_source_uuid) { |b| b.input(css:"form[name='dataSourceForm'] input[name='uuid']")}

  element(:logout_lnk) { |b| b.span(css:"span.glyphicon-log-out")}
  action(:logout_lnk_clk) { |b| b.logout_lnk.click }

end
