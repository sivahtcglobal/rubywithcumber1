class   WorkbenchDatacollection < BasePage

  element(:org_name){|b| b.text_field(class:"ng-pristine ng-invalid ng-invalid-required")}

  #Create Data collection
  element(:collection_name){|b| b.text_field(css:"div:nth-child(4) > div > div.span8 > form > label:nth-child(2) > input")}

  element(:collectionname){|b| b.form(name:"dcForm").text_field(class:"ng-dirty ng-valid ng-valid-required").value}

  element(:datacollection_name){|collectionname,b| b.span(text:"#{collectionname}",index:0)}
  element(:uuid){|b| b.form(name:"dcForm").text_field(name:"uuid").value}
  element(:porg_name){|b| b.form(name:"dcForm").text_field(name:"parentOrgLabel").value}

  element(:update_btn){|b| b.form(name:"dcForm").button(text:"Update")}
  action(:update_btn_click){|b| b.update_btn.click}

  #Edit Data collection
  element(:edit_btn){|b| b.div(css:"div:nth-child(4) > div > div.span4 > div.btn.btn-default.ng-pristine.ng-valid")}

  #Delete
  element(:delete_dc_btn){|b| b.div(css:"div:nth-child(4) > div > div.span4 > div:nth-child(2)")}

  #Cancel
  element(:cancel_datacollection_btn){|b| b.div(css:"div:nth-child(4) > div > div.span4 > div:nth-child(3)")}

  #Datacollection Key Alert Message
  element(:datacollection_alert) { |b| b.div(:id, "alerts") }
end