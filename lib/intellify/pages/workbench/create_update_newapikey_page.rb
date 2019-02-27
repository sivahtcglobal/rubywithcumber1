class WorkbenchApikey < BasePage


  #API Key Elements
  element(:apikey_creation){|b| b.a(text:"New API Key")}
  element(:org_name){|b| b.text_field(class:"ng-pristine ng-invalid ng-invalid-required")}
  element(:update_btn){|b| b.form(name:"apiKeyForm").button(text:"Update")}

  #element(:datacollection_name){|b| b.li(class:"ng-scope tree-expanded",index:0).i(class:"iType dataCollection").span(text:"selenium_dataCollection",index:0)}
  element(:datacollection_name){|collectionname,b| b.span(text:"#{collectionname}",index:0)}
  element(:uuid){|b| b.form(name:"dcForm").text_field(name:"uuid").value}
  element(:porg_name){|b| b.form(name:"dcForm").text_field(name:"parentOrgLabel").value}
  element(:tree_head){|b| b.i(class:"tree-branch-head")}
  element(:apikey_name_check){|b| b.form(name:"apiKeyForm").text_field(name:"name").value}
  element(:apikey_name){|b| b.form(name:"apiKeyForm").text_field(name:"name")}
  element(:apikey_active){|b| b.form(name:"apiKeyForm").input(name:"active")}
  element(:apikey_parentorg){|b| b.form(name:"apiKeyForm").text_field(name:"parentOrgLabel")}
  element(:apikey_parentdatacollection){|b| b.form(name:"apiKeyForm").text_field(name:"parentDataCollectionLabel")}
  element(:apikey_parentorg_check){|b| b.form(name:"apiKeyForm").text_field(name:"parentOrgLabel").value}
  element(:apikey_parentdatacollection_check){|b| b.form(name:"apiKeyForm").text_field(name:"parentDataCollectionLabel").value}
  element(:apikey_uuid_check){|b| b.form(name:"apiKeyForm").text_field(name:"uuid").value}
  element(:apikey_uuid){|b| b.form(name:"apiKeyForm").text_field(name:"uuid")}

  element(:apikey){|apikeyname,b| b.span(text:"#{apikeyname}",index:2)}
  element(:apikey_id){|b| b.form(name:"apiKeyForm").text_field(name:"apiKey").value}

  #Edit
  element(:editbtn){|b| b.div(css:"div:nth-child(5) > div > div:nth-child(2) > div:nth-child(1)")}

  #Delete
  element(:delete_apikey_btn){|b| b.div(css:"div:nth-child(5) > div > div.span4 > div:nth-child(2)")}

  #Cancel
  element(:cancel_apikey_btn){|b| b.div(css:"div:nth-child(5) > div > div.span4 > div:nth-child(3)")}


  #API Key Alert Message
  element(:apikey_alert) { |b| b.div(:id, "alerts") }
end