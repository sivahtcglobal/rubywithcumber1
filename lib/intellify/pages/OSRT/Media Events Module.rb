class MediaEventsModulePage < BasePage

  page_url "https://intellify.instructure.com"
  element(:dashboard_container) { |b| b.div(id:"DashboardCard_Container") }
  element(:account_tab){|b| b.a(id:"global_nav_profile_link")}
  element(:user_name){|b| b.h1(id:"global_nav_profile_display_name").text}
  element(:course_tab){|b| b.a(id:"global_nav_courses_link")}
  element(:ccc_test){|b| b.a(href:"/courses/21",class:"ic-NavMenu-list-item__link")}
  element(:ccc_title){|b| b.h2(title:"CCC test").text}
  element(:module_clk){|b| b.a(title:"Modules",class:"modules")}
  element(:module_1){|b| b.a(href:"/courses/21/modules/items/265",title:"LTI - Introduction to Online Learning (12min)")}
  element(:logout){|b| b.form(class:"ic-NavMenu-profile-header-logout-form").button(class:"Button Button--small")}

  # element(:header){|b| b.iframe(id:"tool_content").div(id:"wrapper").main(class:"content").h1(text:"Introduction to Online Learning - about 12 minutes")}
  element(:header){|header,b| b.iframe(id:"tool_content").div(id:"wrapper").main(class:"content").h1(text:header)}
  element(:header1){|header,b| b.iframe(id:"file_content").div(id:"wrapper").main(class:"content").h1(text:header)}
  element(:launch_video) {|b| b.iframe(id:"tool_content").div(id:"wrapper").ul.li(index:0).a.span}
  element(:launch_video1) {|b| b.iframe(id:"file_content").div(id:"wrapper").ul.li(index:0).a.span}
  element(:myth1){|b| b.div(id:"panel-menu").ul.li(index:5)}
  element(:sectionElement){|section,b| b.div(id:"panel-menu").button(text:section)}
  # element(:sectionElement){|value,b| b.div(id:"tabs").div(id:"panel-menu").button(value:value).value}
  # element(:sectionElement1){|value,b| b.div(id:"tabs").div(id:"panel-menu").button(value:value)}
  element(:play){|b| b.button(class:"able-button-handler-play").span(class:"icon-play")}
  element(:pause){|b| b.button(class:"able-button-handler-play").span(class:"icon-pause")}
  element(:restart){|b| b.button(class:"able-button-handler-restart").span(class:"icon-restart")}
  element(:forward){|b| b.button(class:"able-button-handler-forward").span(class:"icon-forward")}
  element(:rewind){|b| b.button(class:"able-button-handler-rewind").span(class:"icon-rewind")}
  element(:slower){|b| b.button(class:"able-button-handler-slower").span(class:"icon-turtle")}
  element(:faster){|b| b.button(class:"able-button-handler-faster").span(class:"icon-rabbit")}
  element(:hide_caption){|b| b.button(class:"able-button-handler-captions").span(class:"icon-captions")}
  element(:settings){|b| b.button(class:"able-button-handler-preferences").span(class:"icon-preferences")}
  element(:settings_config){|b,list| b.div(id:"video1-prefs-menu").ul.li.label(text:list)}
  element(:save) {|b| b.button(text:"Save")}
  element(:transcript_tab) {|b| b.div(id:"tabs").ul(id:"tablist").li(id:"tab-transcript")}
  element(:resource_tab){|b| b.div(id:"tabs").ul(id:"tablist").li(id:"tab-resources")}
  element(:help_tab){|b| b.div(id:"tabs").ul(id:"tablist").li(id:"tab-help")}
  element(:menu_tab){|b| b.div(id:"tabs").ul(id:"tablist").li(id:"tab-menu")}
end

