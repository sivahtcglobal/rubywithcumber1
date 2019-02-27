
Then(/^Create a Dynamic CSS Style for Data Collection$/) do
										@currnetTimeStamp = Time.new.to_i * 1000
										configatron.currnetTimeStamp = @currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
										@apitoken =  get_apitoken(@hostname,@username,@password)
										configatron.apitoken = @apitoken
	@query = "{   
  \"active\": true,
  \"appliedTo\": \"datacollection\",
  \"appliedToUUID\": \"#{configatron.dataCollectionUUID}\",
   \"name\":\"Runscope Dynamic Styler\",
  \"css\": \"div.intelliview-container{background-color:#ffffcc;color:#555;display:block;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:14px;font-weight:300;height:1733px;line-height:20px;margin-left:0;margin-right:0;padding:5px 10px}div.panel-container{padding:0;background:#fff;border:0 solid rgba(100,100,100,0.5);margin:5px}span.panel-title{color:#636363;display:block;float:left;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700;height:20px;line-height:20px;padding-left:10px;text-transform:uppercase}div.dataCardTitle{color:#060;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:x-large;font-style:normal;font-variant:normal;font-weight:700}div.calcCell{border:1px solid #000;border-radius:15px;padding:5px;margin:10px;float:left;border-color:#000;border-style:solid;border-width:1px}span.calc-cell-value{color:#002db3;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large;font-style:normal;font-variant:normal;font-weight:700}span.calc-cell-label{color:#903;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700}div.hmh-report-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large}span.hmh-report-sub-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:large}\"
}"
	@posturl = File.join('https://',@hostname,'/dynamicstyler/')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

  configatron.dynamiccssUUID_DC = @responce['uuid']

	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
	@responce['uuid'].should_not  == nil
	@responce['active'].should  == true

end

Then(/^Verify the Created Dynamic CSS Style for Data Collection$/) do

	@currnetTimeStamp = configatron.currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken = configatron.apitoken
                   
	@posturl = File.join('https://',@hostname,"/dynamicstyler/#{configatron.dynamiccssUUID_DC}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to "
	@responce['uuid'].should_not  == nil
	@responce['active'].should  == true
	@responce['css'].should  == "div.intelliview-container{background-color:#ffffcc;color:#555;display:block;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:14px;font-weight:300;height:1733px;line-height:20px;margin-left:0;margin-right:0;padding:5px 10px}div.panel-container{padding:0;background:#fff;border:0 solid rgba(100,100,100,0.5);margin:5px}span.panel-title{color:#636363;display:block;float:left;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700;height:20px;line-height:20px;padding-left:10px;text-transform:uppercase}div.dataCardTitle{color:#060;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:x-large;font-style:normal;font-variant:normal;font-weight:700}div.calcCell{border:1px solid #000;border-radius:15px;padding:5px;margin:10px;float:left;border-color:#000;border-style:solid;border-width:1px}span.calc-cell-value{color:#002db3;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large;font-style:normal;font-variant:normal;font-weight:700}span.calc-cell-label{color:#903;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700}div.hmh-report-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large}span.hmh-report-sub-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:large}"
end

Then(/^Create a Dynamic CSS Style for Intelliview$/) do

                    @currnetTimeStamp = configatron.currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken = configatron.apitoken
                   
	@query = "{ 
 \"name\":\"Runscope Dynamic Styler intelliview\",
  \"active\": true,
  \"appliedTo\": \"intelliview \",
  \"appliedToUUID\": \"#{configatron.dataCollectionUUID}111\",
  \"css\": \"div.intelliview-container{background-color:#ffffcc;color:#555;display:block;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:14px;font-weight:300;height:1733px;line-height:20px;margin-left:0;margin-right:0;padding:5px 10px}div.panel-container{padding:0;background:#fff;border:0 solid rgba(100,100,100,0.5);margin:5px}span.panel-title{color:#636363;display:block;float:left;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700;height:20px;line-height:20px;padding-left:10px;text-transform:uppercase}div.dataCardTitle{color:#060;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:x-large;font-style:normal;font-variant:normal;font-weight:700}div.calcCell{border:1px solid #000;border-radius:15px;padding:5px;margin:10px;float:left;border-color:#000;border-style:solid;border-width:1px}span.calc-cell-value{color:#002db3;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large;font-style:normal;font-variant:normal;font-weight:700}span.calc-cell-label{color:#903;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700}div.hmh-report-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large}span.hmh-report-sub-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:large}\"
}"
	@posturl = File.join('https://',@hostname,'/dynamicstyler/')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

   configatron.dynamiccssUUID_IN = @responce['uuid']

	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
	@responce['uuid'].should_not  == nil
	@responce['active'].should  == true

end

Then(/^Verify the Created Dynamic CSS Style for Intelliview$/) do

                    @currnetTimeStamp = configatron.currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken = configatron.apitoken
                   
	@posturl = File.join('https://',@hostname,"/dynamicstyler/#{configatron.dynamiccssUUID_IN}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 202"
	@responce['uuid'].should_not  == nil
	@responce['active'].should  == true
	@responce['css'].should  == "div.intelliview-container{background-color:#ffffcc;color:#555;display:block;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:14px;font-weight:300;height:1733px;line-height:20px;margin-left:0;margin-right:0;padding:5px 10px}div.panel-container{padding:0;background:#fff;border:0 solid rgba(100,100,100,0.5);margin:5px}span.panel-title{color:#636363;display:block;float:left;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700;height:20px;line-height:20px;padding-left:10px;text-transform:uppercase}div.dataCardTitle{color:#060;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:x-large;font-style:normal;font-variant:normal;font-weight:700}div.calcCell{border:1px solid #000;border-radius:15px;padding:5px;margin:10px;float:left;border-color:#000;border-style:solid;border-width:1px}span.calc-cell-value{color:#002db3;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large;font-style:normal;font-variant:normal;font-weight:700}span.calc-cell-label{color:#903;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700}div.hmh-report-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large}span.hmh-report-sub-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:large}"
end

Then(/^Modify the Dynamic CSS Style for Data Collection$/) do

                    @currnetTimeStamp = configatron.currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken = configatron.apitoken
                   
	@query = "{ \"uuid\":\"#{configatron.dynamiccssUUID_DC}\",
 \"name\":\"Runscope Dynamic Styler\",
  \"active\": true,
  \"appliedTo\": \"datacollection\",
  \"appliedToUUID\": \"#{configatron.dataCollectionUUID}\",
  \"css\": \"div.intelliview-container{background-color:#636363;color:#555;display:block;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:14px;font-weight:300;height:1733px;line-height:20px;margin-left:0;margin-right:0;padding:5px 10px}div.panel-container{padding:0;background:#fff;border:0 solid rgba(100,100,100,0.5);margin:5px}span.panel-title{color:#636363;display:block;float:left;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700;height:20px;line-height:20px;padding-left:10px;text-transform:uppercase}div.dataCardTitle{color:#060;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:x-large;font-style:normal;font-variant:normal;font-weight:700}div.calcCell{border:1px solid #000;border-radius:15px;padding:5px;margin:10px;float:left;border-color:#000;border-style:solid;border-width:1px}span.calc-cell-value{color:#002db3;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large;font-style:normal;font-variant:normal;font-weight:700}span.calc-cell-label{color:#903;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700}div.hmh-report-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large}span.hmh-report-sub-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:large}\"
}"
	@posturl = File.join('https://',@hostname,"/dynamicstyler/#{configatron.dynamiccssUUID_DC}")
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)


	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
	@responce['uuid'].should_not  == nil
	@responce['active'].should  == true
	@responce['appliedToUUID'].should  == "#{configatron.dataCollectionUUID}"
end

Then(/^Verify the Modified Dynamic CSS Style for Data Collection$/) do

                    @currnetTimeStamp = configatron.currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken = configatron.apitoken
                   
	@posturl = File.join('https://',@hostname,"/dynamicstyler/#{configatron.dynamiccssUUID_DC}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['uuid'].should_not  == nil
	@responce['active'].should  == true
	@responce['appliedToUUID'].should  == "#{configatron.dataCollectionUUID}"
	@responce['css'].should  == "div.intelliview-container{background-color:#636363;color:#555;display:block;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:14px;font-weight:300;height:1733px;line-height:20px;margin-left:0;margin-right:0;padding:5px 10px}div.panel-container{padding:0;background:#fff;border:0 solid rgba(100,100,100,0.5);margin:5px}span.panel-title{color:#636363;display:block;float:left;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700;height:20px;line-height:20px;padding-left:10px;text-transform:uppercase}div.dataCardTitle{color:#060;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:x-large;font-style:normal;font-variant:normal;font-weight:700}div.calcCell{border:1px solid #000;border-radius:15px;padding:5px;margin:10px;float:left;border-color:#000;border-style:solid;border-width:1px}span.calc-cell-value{color:#002db3;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large;font-style:normal;font-variant:normal;font-weight:700}span.calc-cell-label{color:#903;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700}div.hmh-report-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large}span.hmh-report-sub-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:large}"
end

Then(/^Modify the Dynamic CSS Style for Intelliview$/) do

                    @currnetTimeStamp = configatron.currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken = configatron.apitoken
                   
	@query = "{ \"uuid\":\"#{configatron.dynamiccssUUID_IN}\",
  \"name\":\"Runscope Dynamic Styler intelliview\",
  \"active\": true,
  \"appliedTo\": \"intelliview\",
  \"appliedToUUID\": \"#{configatron.dataCollectionUUID}111\",
  \"css\": \"div.intelliview-container{background-color:#636363;color:#555;display:block;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:14px;font-weight:300;height:1733px;line-height:20px;margin-left:0;margin-right:0;padding:5px 10px}div.panel-container{padding:0;background:#fff;border:0 solid rgba(100,100,100,0.5);margin:5px}span.panel-title{color:#636363;display:block;float:left;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700;height:20px;line-height:20px;padding-left:10px;text-transform:uppercase}div.dataCardTitle{color:#060;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:x-large;font-style:normal;font-variant:normal;font-weight:700}div.calcCell{border:1px solid #000;border-radius:15px;padding:5px;margin:10px;float:left;border-color:#000;border-style:solid;border-width:1px}span.calc-cell-value{color:#002db3;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large;font-style:normal;font-variant:normal;font-weight:700}span.calc-cell-label{color:#903;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700}div.hmh-report-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large}span.hmh-report-sub-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:large}\"
}"
	@posturl = File.join('https://',@hostname,"/dynamicstyler/#{configatron.dynamiccssUUID_IN}")
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
	@responce['uuid'].should_not  == nil
	@responce['active'].should  == true
	@responce['appliedToUUID'].should  == "#{configatron.dataCollectionUUID}111"
end

Then(/^Verify the Modified Dynamic CSS Style for Intelliview$/) do

                    @currnetTimeStamp = configatron.currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken = configatron.apitoken
                   
	
	@posturl = File.join('https://',@hostname,"/dynamicstyler/#{configatron.dynamiccssUUID_IN}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to "
	@responce['uuid'].should_not  == nil
	@responce['active'].should  == true
	@responce['appliedToUUID'].should  == "#{configatron.dataCollectionUUID}111"
	@responce['css'].should  == "div.intelliview-container{background-color:#636363;color:#555;display:block;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:14px;font-weight:300;height:1733px;line-height:20px;margin-left:0;margin-right:0;padding:5px 10px}div.panel-container{padding:0;background:#fff;border:0 solid rgba(100,100,100,0.5);margin:5px}span.panel-title{color:#636363;display:block;float:left;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700;height:20px;line-height:20px;padding-left:10px;text-transform:uppercase}div.dataCardTitle{color:#060;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:x-large;font-style:normal;font-variant:normal;font-weight:700}div.calcCell{border:1px solid #000;border-radius:15px;padding:5px;margin:10px;float:left;border-color:#000;border-style:solid;border-width:1px}span.calc-cell-value{color:#002db3;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large;font-style:normal;font-variant:normal;font-weight:700}span.calc-cell-label{color:#903;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:14px;font-style:normal;font-variant:normal;font-weight:700}div.hmh-report-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:xx-large}span.hmh-report-sub-title{color:#009;font-family:'Arial, Helvetica, sans-serif',Arial,Helvetica,sans-serif;font-size:large}"
end

Then(/^Delete the Dynamic CSS Style for Data Collection$/) do

                    @currnetTimeStamp = configatron.currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken = configatron.apitoken
                   
	
	@posturl = File.join('https://',@hostname,"/dynamicstyler/#{configatron.dynamiccssUUID_DC}")
	@status,@responce, @header = delete_request_api(@posturl,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 204
	puts "&#10004;Status -- 204 was a number equal to 204"
end

Then(/^Delete the Dynamic CSS Style for Intelliview$/) do

                    @currnetTimeStamp = configatron.currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken = configatron.apitoken
                   
	
	@posturl = File.join('https://',@hostname,"/dynamicstyler/#{configatron.dynamiccssUUID_IN}")
	@status,@responce, @header = delete_request_api(@posturl,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 204
	puts "&#10004;Status -- 204 was a number equal to 204"
end

Then(/^Verify the Dynamic CSS Style for Data Collection got deleted$/) do

                    @currnetTimeStamp = configatron.currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken = configatron.apitoken
                   
	
	@posturl = File.join('https://',@hostname,"/dynamicstyler/#{configatron.dynamiccssUUID_DC}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 404
	puts "&#10004;Status -- 404 was a number equal to 404"
end

Then(/^Verify the Dynamic CSS Style for Intelliview got deleted$/) do

                    @currnetTimeStamp = configatron.currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken = configatron.apitoken
                   
	
	@posturl = File.join('https://',@hostname,"/dynamicstyler/#{configatron.dynamiccssUUID_IN}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 404
	puts "&#10004;Status -- 404 was a number equal to 404	"
end
