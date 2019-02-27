class WorkbenchDatasource < BasePage

  #Data source elements
  element(:datasource_name){|b| b.form(name:"dataSourceForm").text_field(name:"name")}
  element(:datasource_active){|b| b.form(name:"dataSourceForm").input(name:"active")}
  element(:datasource_sensorId){|b|b.form(name:"dataSourceForm").text_field(name:"sensorId")}
  element(:datasource_eventStreamName){|b| b.form(name:"dataSourceForm").text_field(name:"rawEventStreamName")}
  element(:datasource_entityStreamName){|b| b.form(name:"dataSourceForm").text_field(name:"rawDescribeStreamName")}
  element(:datasource_updateBtnDS){|b|b.form(name:"dataSourceForm").button(text:"Update")}
  element(:datasource_uuid){|b|b.form(name:"dataSourceForm").text_field(name:"uuid")}
  element(:datasource_uuid_check){|b|b.form(name:"dataSourceForm").text_field(name:"uuid").value}
  element(:datasource_name_check){|b| b.form(name:"dataSourceForm").text_field(name:"name").value}

  #Edit
  element(:editbtn){|b| b.div(css:"div:nth-child(6) > div > div:nth-child(2) > div:nth-child(1)")}

  #Delete
  element(:delete_ds_btn){|b| b.div(css:"div:nth-child(6) > div > div.span4 > div:nth-child(2)")}

  #Cancel
  element(:cancel_datasource_btn){|b| b.div(css:"div:nth-child(6) > div > div.span4 > div:nth-child(3)")}

  #Datasource Key Alert Message
  element(:datasource_alert) { |b| b.div(:id, "alerts") }

end
