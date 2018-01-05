class IntellifyEssentialHelppage < BasePage

  page_url configatron.essentialHelppageURL
  element (:logout){|b| b.span(class:"glyphicon glyphicon-log-out")}
  element(:help){|b| b.a(text:"Help?")}
  element(:data_source){|b| b.a(text:"Data Sources")}
  element(:welcome_header) {|b| b.div(class:"_2wIKvCrEgyD2grdx0KdZh5-helpView-module-section").h2.text}
  element(:welcome_para){|b| b.div(class:"_2wIKvCrEgyD2grdx0KdZh5-helpView-module-section").p.text  }
  element(:sys_orien){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:0).li(index:0).text}
  element(:sys_link1text){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:0).ul.li(index:0).a.text}
  element(:sys_link1){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:0).ul.li(index:0).a}
  element(:sys_link2text){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:0).ul.li(index:1).a.text}
  element(:sys_link2){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:0).ul.li(index:1).a}
  element(:help_page_view){|b| b.div(class:"K9hP8GCkO0sx8CcLjM0ZC-helpViewDetail-module-section")}

  element(:datasource_title){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:2).li.text}
  element(:datasource_link1text){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:2).ul(index:0).li(index:0).a.text}
  element(:datasource_link1){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:2).ul(index:0).li(index:0).a}

  element(:config_moodlelinktext){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:2).ul.li(index:1).a.text}
  element(:config_moodlelink){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:2).ul.li(index:1).a}


  element(:config_canvaslinktext){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:2).ul.li(index:2).a.text}
  element(:config_canvaslink){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:2).ul.li(index:2).a}

  element(:datatools_title){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:4).li(index:0).text}
  element(:tableau_setuplinktext){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:4).ul.li(index:0).a.text}
  element(:tableau_setuplink){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:4).ul.li(index:0).a}
  element(:starter_workbooklinktext){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:4).ul.li(index:1).a.text}
  element(:starter_workbooklink){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:4).ul.li(index:1).a}
  element(:download_csvlinktext){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:4).ul.li(index:2).a.text}
  element(:downlaod_csvlink){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:4).ul.li(index:2).a}


  element(:accsetting_title){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:6).li(index:0).text}
  element(:change_userpasslinktext){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:6).ul.li(index:0).a.text}
  element(:change_userpasslink){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:6).ul.li(index:0).a}
  element(:update_orgacclinktext){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:6).ul.li(index:1).a.text}
  element(:update_orgacclink){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:6).ul.li(index:1).a}
  element(:create_userlinktext){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:6).ul.li(index:2).a.text}
  element(:create_userlink){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(index:6).ul.li(index:2).a}
  element(:data_table_header){|b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(id:"data-tables-section").li.text}
  element(:data_listtxt){|row,b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(id:"data-tables-section").ul.li(index:row).a.text}
  element(:data_table_list){|row,b| b.div(class:"fr2weubvny_eHnmdEnIih-helpView-module-nav").ul(id:"data-tables-section").ul.li(index:row).a}

end
