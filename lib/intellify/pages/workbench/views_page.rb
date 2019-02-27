class WorkbenchViews < BasePage

  @viewsPage = configatron.workbenchURL+'/wb/#/admin/explore'
  page_url @viewsPage

  #Header and Title Elements
  element(:intelliview_txt) {|b| b.div(class:"lead span3").h1.small}
  element(:createinteractivedashboards_txt) {|b| b.div(class:"lead span3").h4.small}
  element(:templates_count_txt) {|b| b.span(css:"div:nth-child(2) > div.admin-stats-block > span:nth-child(3)")}
  element(:intelliviews_count_txt) {|b| b.span(css:"div:nth-child(1) > div.admin-stats-block > span:nth-child(3)")}
  element(:templates_count) {|b| b.span(class:"badge badge-important ng-binding")}
  element(:intelliviews_count) {|b| b.span(class:"badge badge-warning ng-binding")}

  #Dashboard Templates
  element(:dashboard_template_txt) {|b| b.div(class:"span6").span.h2.small}
  element(:dashboard_template_plus_btn) {|b| b.i(css:"div:nth-child(1) > div > div > div > a.btn.btn-success.btn-mini > small > i")}
  element(:dashboard_template_search_btn) {|b| b.i(css:"div:nth-child(1) > div > div > div > a.btn.btn-info.btn-mini > small > i")}
  element(:dashboard_template_searchbox) {|b| b.div(class:"span6").span.input(class:"animated ng-pristine ng-valid")}
  element(:dashboard_template_previous_btn) {|b| b.span(css:"div:nth-child(1) > div > div > button:nth-child(2) > span")}
  element(:dashboard_template_next_btn) {|b| b.span(css:"div:nth-child(1) > div > div > button:nth-child(3) > span")}

  #IntelliViews
  element(:intelliviews_txt) {|b| b.div(class:"span10").span.h2.small}
  element(:intelliviews_plus_btn) {|b| b.i(css:"div:nth-child(2) > div > div > div > a.btn.btn-success.btn-mini > small > i")}
  element(:intelliviews_search_btn) {|b| b.i(css:"div:nth-child(2) > div > div > div > a.btn.btn-info.btn-mini > small > i")}
  element(:intelliviews_searchbox) {|b| b.div(class:"span10").span.input(class:"animated ng-pristine ng-valid")}
  element(:intelliviews_previous_btn) {|b| b.span(css:"div:nth-child(2) > div > div > button:nth-child(3) > span")}
  element(:intelliviews_next_btn) {|b| b.span(css:"div:nth-child(2) > div > div > button:nth-child(4) > span")}

end
