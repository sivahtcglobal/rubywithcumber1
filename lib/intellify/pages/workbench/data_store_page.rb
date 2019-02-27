class WorkbenchDatastore< BasePage

  #DataStore Tree View Elements
  element(:orgname) { |orgname,b| b.span(text:"#{orgname}")}
  element(:org_expand){|b| b.i(class:"tree-branch-head")}

  element(:icon_refresh) {|b| b.i(class:"icon-refresh")}
  element(:icon_plus) {|b| b.i(class:"icon-plus iType ")}
  element(:newuser){|b| b.a(text:"New User")}
  element(:datacollection_creation){|b| b.a(text:"New Data Collection")}
  element(:new_datasource_creation){|b| b.a(text:"New DataSource")}

  #Expand Datacollection
  element(:datacollection_expand){|dcname, b| b.i(css:"treeitem > ul > li > i ~ div > i > span[text="+dcname+"]")}


  #Datacollection tree View Element
  element(:treeview_datacollection_name){|collectionname,b| b.span(text:/#{collectionname}/)} #,index:0

  #Datasource tree View Element
  element(:treeview_datasource_link){|datasource, b| b.span(text:/#{datasource}/)} #,index:2)

  #APIKey tree View Element
  element(:treeview_apikey_link){|apikeyname,b| b.span(text:/#{apikeyname}/)}

  element(:user_expand){|b| b.i(css:"treeitem > ul > li:last-child > i.tree-branch-head")}
  element(:treeview_username_lnk){|firstname,lastname,b| b.ul(class:"ng-scope").ul(class:"ng-scope").li(class:"ng-scope tree-expanded").ul(class:"ng-scope").li(class:"ng-scope tree-leaf",text:/#{firstname}#{lastname}/)} #,index:0

  #Last User Element
  element(:exist_username){|b| b.span(css:"treeitem > ul > li.ng-scope.tree-expanded > treeitem > ul > li:last-child > div > i > span:nth-child(3)")}


end
