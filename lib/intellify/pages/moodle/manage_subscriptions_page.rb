class ManageSubscriptionsPage < BasePage

  #Manage Subscriptions Page Elements
  element(:manage_subscriptions_btn) { |b| b.button(text:"Manage subscriptions") }
  action(:manage_subscriptions_btn_clk) { |b| b.manage_subscriptions_btn.click }

  element(:calendar_name_txt) { |b| b.input(id:"id_name")}
  element(:import_from_select) { |b| b.select_list(id:"id_importfrom")}
  element(:calendar_url_txt) { |b| b.input(id:"id_url")}
  element(:update_interval_select) { |b| b.select_list(name:"pollinterval")}
  element(:choose_file_btn) { |b| b.input(value:"Choose a file...")}
  element(:upload_files_link) { |b| b.span(text:"Upload a file")}
  element(:choose_files_link) { |b| b.input(name:"repo_upload_file")}
  element(:upload_files_btn) { |b| b.button(text:"Upload this file")}
  element(:event_type_select) { |b| b.select_list(id:"id_eventtype")}

  element(:add_btn) { |b| b.input(id:"id_add") }
  action(:add_btn_clk) { |b| b.add_btn.click }

  element(:calendar_name_link) { |b| b.a(css:"tr.lastrow a")}

  element(:update_btn) { |b| b.button(text:"Update") }
  action(:update_btn_clk) { |b| b.update_btn.click }

  element(:remove_btn) { |b| b.button(text:"Remove") }
  action(:remove_btn_clk) { |b| b.remove_btn.click }

end
