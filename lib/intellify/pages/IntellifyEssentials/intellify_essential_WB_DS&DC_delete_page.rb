class EssentialsWBDSDCdelete< PageFactory #< BasePage
  page_url configatron.essentialWBdatastorepageURL
  expected_element :sign_out,30
  element(:login_button) { |b| b.button(value: "Login") }
  element(:sign_out) { |b| b.i(class: "icon icon-signout") }
  element(:image_intellify) { |b| b.image(:src, "img/logo.png")}
  element(:envelop_icon) {|b| b.i(class:"icon icon-envelope")}
  element(:comment_icon) {|b| b.i(class:"icon icon-comment")}
  element(:data_store) {|b| b.h2.small.span(class:"icon icon-archive")}
  element(:streams_tab) {|b| b.li(class:"inactive",index:0).a.h2.small.span(class:"icon icon-exchange")}
  element(:newuser){|b| b.a(text:"New User")}
  element(:mangeuser){|b| b.legend(text:"Manage User")}
  element(:icon_plus) {|b| b.i(class:"icon-plus iType ")}
  element(:icon_refresh) {|b| b.i(class:"icon-refresh")}
  element(:username){|b| b.span(text:"selenium auto")}
  element(:userrole){|b| b.span(text:"(Admin)")}
  element(:orgname){|b| b.span(text:"Essential Org")}
  element(:form_firstname){|b| b.text_field(name:"firstName")}
  element(:form_lastname){|b| b.text_field(name:"lastName")}
  element(:form_username){|b| b.text_field(name:"username")}
  element(:form_password){|b| b.text_field(name:"password")}
  element(:form_city){|b| b.text_field(name:"city")}
  element(:form_country){|b| b.text_field(name:"country")}
  element(:form_email){|b| b.text_field(name:"eMail")}
  element(:form_role){|b| b.option(text:"Organization Analyst/Designer")}
  element(:form_update){|b| b.form(name:"userForm").button(text:"Update")}
  element(:org_expand){|b| b.i(class:"tree-branch-head")}
  element(:user_expand){|b| b.ul(class:"ng-scope").li(class:"ng-scope tree-collapsed").i(class:"tree-branch-head")}
  element(:exist_username){|b| b.li(class:"ng-scope tree-leaf",index:1).span(text:"selenium automation",index:2)}
  #element(:edit_btn){|b| b.div(class:"span9 admin-panel-right",index:8).div(type:"button",text:"Edit")}
  element(:edit_btn){|b| b.div(class:"btn btn-default ng-pristine ng-valid")}
  element(:select_role){|b| b.select(name:"roles")}
  element(:exist_updt_username){|b| b.li(class:"ng-scope tree-leaf",index:1).span(text:"selenium1 auto1",index:2)}
  element(:update_btn){|b| b.form(name:"dcForm").button(text:"Update")}
  element(:datacollection_name){|b| b.li(class:"ng-scope tree-collapsed",index:0).i(class:"iType dataCollection").span(text:"selenium_dataCollection",index:0)}
  element(:uuid){|b| b.form(name:"dcForm").text_field(name:"uuid").value}
  element(:porg_name){|b| b.form(name:"dcForm").text_field(name:"parentOrgLabel").value}
  element(:tree_head){|b| b.i(class:"tree-branch-head")}
  element(:collectionname){|b| b.form(name:"dcForm").text_field(class:"ng-dirty ng-valid ng-valid-required").value}
  element(:collection_name){|idx1,b| b.ul(class:"ng-scope").li(class:"ng-scope tree-collapsed",index:idx1).div(class:"tree-label").i(class:"iType dataCollection").span(class:"dataCollection_fullname")}
  element(:list_expand){|idx1,b| b.ul(class:"ng-scope").li(class:"ng-scope tree-collapsed",index:idx1).i(class:"tree-branch-head")}
  element(:data_source){|b| b.ul(class:"ng-scope").li(class:"ng-scope tree-leaf",index:1).div(class:"tree-label").i.span(class:"noneatall ng-binding",index:1)}
  element (:edit_datasource){|b| b.div(class:"span9 admin-panel-right",index:4).div(class:"row-fluid").div(class:"span4").div(class:"btn btn-default ng-pristine ng-valid")}
  element(:delete_datasource){|b| b.div(class:"span9 admin-panel-right",index:4).div(class:"row-fluid").div(class:"span4").div(text:"Delete")}
  element(:api_key){|b| b.ul(class:"ng-scope").li(class:"ng-scope tree-leaf",index:0).div(class:"tree-label").i.span(class:"noneatall ng-binding",index:1)}
  element (:edit_apikey){|b| b.div(class:"span9 admin-panel-right",index:3).div(class:"row-fluid").div(class:"span4").div(class:"btn btn-default ng-pristine ng-valid")}
  element(:delete_apikey){|b| b.div(class:"span9 admin-panel-right",index:3).div(class:"row-fluid").div(class:"span4").div(text:"Delete")}
  element(:data_collection){|b| b.ul(class:"ng-scope").li(class:"ng-scope tree-leaf",index:0).div(class:"tree-label").i(class:"iType dataCollection")}
  element (:edit_collection){|b| b.div(class:"span9 admin-panel-right",index:2).div(class:"row-fluid").div(class:"span4").div(text:"Edit")}
  element(:delete_collection){|b| b.div(class:"span9 admin-panel-right",index:2).div(class:"row-fluid").div(class:"span4").div(text:"Delete")}

end
