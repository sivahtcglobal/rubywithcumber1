class LTIAutomationPage < BasePage

   page_url "https://automation.intellify.tools/lti/index.html"
   expected_element :pdfauto,30

  element(:pdfauto) { |b| b.link(text:"PDF Automation") }
  action(:pdfautoclick) { |b| b.pdfauto.click }

  # element(:launchUrl) { |b| b.text_field(id:"launchUrl") }
  element(:launchUrl) { |b| b.text_field(id:"launchUrl") }

  element(:key) { |b| b.text_field(id: "key") }
  element(:secret) { |b| b.text_field(id: "secret") }

  #Custom Parameters
  element(:cp1) { |b| b.text_field(id: "cp_1") }
  element(:cpv1) { |b| b.text_field(id: "cpv_1") }

  element(:cp2) { |b| b.text_field(id: "cp_2") }
  element(:cpv2) { |b| b.text_field(id: "cpv_2") }

  element(:cp3) { |b| b.text_field(id: "cp_3") }
  element(:cpv3) { |b| b.text_field(id: "cpv_3") }

  element(:cp4) { |b| b.text_field(id: "cp_4") }
  element(:cpv4) { |b| b.text_field(id: "cpv_4") }

  element(:cp5) { |b| b.text_field(id: "cp_5") }
  element(:cpv5) { |b| b.text_field(id: "cpv_5") }

  element(:cp6) { |b| b.text_field(id: "cp_6") }
  element(:cpv6) { |b| b.text_field(id: "cpv_6") }

  element(:cp7) { |b| b.text_field(id: "cp_7") }
  element(:cpv7) { |b| b.text_field(id: "cpv_7") }

  element(:cp8) { |b| b.text_field(id: "cp_8") }
  element(:cpv8) { |b| b.text_field(id: "cpv_8") }

  element(:cp9) { |b| b.text_field(id: "cp_9") }
  element(:cpv9) { |b| b.text_field(id: "cpv_9") }

  element(:cp10) { |b| b.text_field(id: "cp_10") }
  element(:cpv10) { |b| b.text_field(id: "cpv_10") }

  element(:ltiLaunch) { |b| b.button(text: "Launch") }
  action(:ltiLaunchclick) { |b| b.ltiLaunch.click }

  element(:ltiRefresh) { |b| b.button(text: "Refresh") }
  action(:ltiRefreshclick) { |b| b.ltiRefresh.click }





end
