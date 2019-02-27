class WorkbenchHomepage < BasePage

  @homePage = configatron.workbenchURL+'/wb/index.html#'
  page_url @homePage

  #Top Right panel Icons
  element(:sign_out) { |b| b.i(class: "icon icon-signout") }
  element(:image_intellify) { |b| b.image(:src, "img/logo.png")}
  element(:envelop_icon) {|b| b.i(class:"icon icon-envelope")}
  element(:comment_icon) {|b| b.i(class:"icon icon-comment")}

  #Left side panel Links
  element(:data_store) {|b| b.h2.small.span(class:"icon icon-archive")}
  element(:streams_tab){|b| b.small(css:"li:nth-child(2) > a > h2 > small")}
  element(:views_tab) {|b| b.small(css:"li:nth-child(3) > a > h2 > small")}

  element(:streams) {|b| b.h2.small.span(class:"icon icon-exchange")}
  element(:views) {|b| b.a.h2.small(text:" Views")}
  element(:intelli_manager) {|b| b.h1.small(text:"IntelliStore Manager")}

  #Organizations elements
  element(:org_data) {|b| b.h4.small(text:"Manage and Organize Data")}
  element(:product_org) {|b| b.h3.small.p(text:"Products/ Organizations")}
  element(:icon_plus) {|b| b.i(class:"icon-plus iType ")}
  element(:icon_refresh) {|b| b.i(class:"icon-refresh")}
  element(:username){|fname,lname,b| b.span(text:"#{fname} #{lname}")}
  element(:userrole){|b| b.span(text:"(Designer)")}
  element(:tooltip_org){|b| b.span(text:"Organizations")}
  element(:tooltip_user){|b| b.span(text:"Users")}
  element(:tooltip_service){|b| b.span(text:"Services")}
  element(:tooltip_collection){|b| b.span(text:"Data Collections")}
  element(:tooltip_source){|b| b.span(text:"DataSources")}
  element(:tooltip_apikey){|b| b.span(text:"API Keys")}
  element(:tooltip_intellistream){|b| b.span(text:"IntelliStreams")}
  element(:tooltip_intelliview){|b| b.span(text:"IntelliViews")}

  element(:orgname) { |orgname,b| b.span(text:"#{orgname}")}

  #Manage elements
  element(:home_manage){|b| b.p(text:"Manage")}
  element(:organization){|b| b.li(text:"Organizations")}
  element(:data_collection){|b| b.li(text:"Data Collections")}
  element(:api_key){|b| b.li(text:"API Keys")}
  element(:data_Sources){|b| b.li(text:"Data Sources")}
  element(:services){|b| b.li(text:"Services")}
  element(:intelliview){|b| b.li(text:"IntelliViews ")}
  element(:users){|b| b.li(text:"Users ")}
  element(:dis){|b| b.small(text:"Please select a link on the left")}
  element(:list) { |b| b.div(class:"span10").li(:text => 'IntelliViews ')}


end
