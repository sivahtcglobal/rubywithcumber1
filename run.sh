#!/bin/bash
/home/ubuntu/.rbenv/bin/rbenv global 
/home/ubuntu/.rbenv/bin/rbenv global 2.3.1
cd $2
echo $2
git pull
artifact_url="https://deploy.intellify.tools/deploy-registry/v1/artifacts/intellisense-moodle/"
artifact_download_path="/data/selenium-automation/lib/intellify/support_files/moodle_plugins/"
echo $3
case "$3" in
moodle)
	wget `curl $artifact_url  | jq .uri | sed -e s/\"//g` -O $artifact_download_path`curl $artifact_url  | jq .uri | sed -e s/\"//g | awk 'BEGIN { FS = "?" } { print $1 }' | awk 'BEGIN { FS = "/" } { print $4 }' `
	/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/moodle/`date +"%Y%m%d"`-$1_result.htm
	rm $artifact_download_path`curl $artifact_url  | jq .uri | sed -e s/\"//g | awk 'BEGIN { FS = "?" } { print $1 }' | awk 'BEGIN { FS = "/" } { print $4 }' `

 ;;
essentials)
	/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/intellify-essentials/`date +"%Y%m%d"`-$1_result.htm
 ;;
hmhreport)
	/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/HMHReport/`date +"%Y%m%d"`-$1_result.htm
 ;;
workbench)
	/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/Workbench/`date +"%Y%m%d"`-$1_result.htm
;;
moodleMasterStaging)
	wget `curl $artifact_url  | jq .uri | sed -e s/\"//g` -O $artifact_download_path`curl $artifact_url  | jq .uri | sed -e s/\"//g | awk 'BEGIN { FS = "?" } { print $1 }' | awk 'BEGIN { FS = "/" } { print $4 }' `
        /home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/Moodle-MS/`date +"%Y%m%d"`-$1_result.htm
	rm $artifact_download_path`curl $artifact_url  | jq .uri | sed -e s/\"//g | awk 'BEGIN { FS = "?" } { print $1 }' | awk 'BEGIN { FS = "/" } { print $4 }' `
;;
moodleKirkStaging)
	wget `curl $artifact_url  | jq .uri | sed -e s/\"//g` -O $artifact_download_path`curl $artifact_url  | jq .uri | sed -e s/\"//g | awk 'BEGIN { FS = "?" } { print $1 }' | awk 'BEGIN { FS = "/" } { print $4 }' `
        /home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/Moodle-Kirk-MS/`date +"%Y%m%d"`-$1_result.htm
	rm $artifact_download_path`curl $artifact_url  | jq .uri | sed -e s/\"//g | awk 'BEGIN { FS = "?" } { print $1 }' | awk 'BEGIN { FS = "/" } { print $4 }' `
;;
moodleMasterProd)
				wget `curl $artifact_url  | jq .uri | sed -e s/\"//g` -O $artifact_download_path`curl $artifact_url  | jq .uri | sed -e s/\"//g | awk 'BEGIN { FS = "?" } { print $1 }' | awk 'BEGIN { FS = "/" } { print $4 }' `
				/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/Moodle-MP/`date +"%Y%m%d"`-$1_result.htm
				rm $artifact_download_path`curl $artifact_url  | jq .uri | sed -e s/\"//g | awk 'BEGIN { FS = "?" } { print $1 }' | awk 'BEGIN { FS = "/" } { print $4 }' `
;;
moodleMSIntegration)
	wget `curl $artifact_url  | jq .uri | sed -e s/\"//g` -O $artifact_download_path`curl $artifact_url  | jq .uri | sed -e s/\"//g | awk 'BEGIN { FS = "?" } { print $1 }' | awk 'BEGIN { FS = "/" } { print $4 }' `
    mkdir -p $2/jobs/Executionresult/functional-automation/Moodle-MS-Integration/
	/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/Moodle-MS-Integration/`date +"%Y%m%d"`-$1_result.htm
	rm $artifact_download_path`curl $artifact_url  | jq .uri | sed -e s/\"//g | awk 'BEGIN { FS = "?" } { print $1 }' | awk 'BEGIN { FS = "/" } { print $4 }' `
;;
moodleMDIntegration)
				wget `curl $artifact_url  | jq .uri | sed -e s/\"//g` -O $artifact_download_path`curl $artifact_url  | jq .uri | sed -e s/\"//g | awk 'BEGIN { FS = "?" } { print $1 }' | awk 'BEGIN { FS = "/" } { print $4 }' `
				mkdir -p $2/jobs/Executionresult/functional-automation/Moodle-MD-Integration/
				/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/Moodle-MD-Integration/`date +"%Y%m%d"`-$1_result.htm
				rm $artifact_download_path`curl $artifact_url  | jq .uri | sed -e s/\"//g | awk 'BEGIN { FS = "?" } { print $1 }' | awk 'BEGIN { FS = "/" } { print $4 }' `
;;
moodleMPIntegration)
				wget `curl $artifact_url  | jq .uri | sed -e s/\"//g` -O $artifact_download_path`curl $artifact_url  | jq .uri | sed -e s/\"//g | awk 'BEGIN { FS = "?" } { print $1 }' | awk 'BEGIN { FS = "/" } { print $4 }' `
				mkdir -p $2/jobs/Executionresult/functional-automation/Moodle-MP-Integration/
				/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/Moodle-MP-Integration/`date +"%Y%m%d"`-$1_result.htm
				rm $artifact_download_path`curl $artifact_url  | jq .uri | sed -e s/\"//g | awk 'BEGIN { FS = "?" } { print $1 }' | awk 'BEGIN { FS = "/" } { print $4 }' `
;;
workbenchMasterStaging)
				mkdir -p $2/jobs/Executionresult/functional-automation/Workbench-MS/
				/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/Workbench-MS/`date +"%Y%m%d"`-$1_result.htm
;;
workbenchMasterProd)
				mkdir -p $2/jobs/Executionresult/functional-automation/Workbench-MP/
				/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/Workbench-MP/`date +"%Y%m%d"`-$1_result.htm
;;
APIMasterStaging)
			    mkdir -p $2/jobs/Executionresult/API-Automation/APIMasterStaging/
				/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/API-Automation/APIMasterStaging/`date +"%Y%m%d"`-$1_result.htm
;;
APIMasterDEV)
			    mkdir -p $2/jobs/Executionresult/API-Automation/APIMasterDEV/
				/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/API-Automation/APIMasterDEV/`date +"%Y%m%d"`-$1_result.htm
;;
APIMasterProd)
			    mkdir -p $2/jobs/Executionresult/API-Automation/APIMasterProd/
				/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/API-Automation/APIMasterProd/`date +"%Y%m%d"`-$1_result.htm
;;
APIHMH2)
			    mkdir -p $2/jobs/Executionresult/API-Automation/APIHMH2/
				/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/API-Automation/APIHMH2/`date +"%Y%m%d"`-$1_result.htm
;;
APIHMHPROD2)
			    mkdir -p $2/jobs/Executionresult/API-Automation/APIHMHPROD2/
				/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/API-Automation/APIHMHPROD2/`date +"%Y%m%d"`-$1_result.htm
;;
APIK12QA)
			    mkdir -p $2/jobs/Executionresult/API-Automation/APIK12QA/
				/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/API-Automation/APIK12QA/`date +"%Y%m%d"`-$1_result.htm
;;
APIK12PROD1)
			    mkdir -p $2/jobs/Executionresult/API-Automation/APIK12PROD1/
				/home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/API-Automation/APIK12PROD1/`date +"%Y%m%d"`-$1_result.htm
;;
osrt)
                            mkdir -p $2/jobs/Executionresult/functional-automation/OSRT/
                                /home/ubuntu/.rbenv/shims/cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/OSRT/`date +"%Y%m%d"`-$1_result.htm
;;
*)
 echo "No job found..."
;;
esac
aws s3 sync $2/jobs/Executionresult/ s3://intellifyqa/
aws s3 cp $2/lib/intellify/support_files/temp.json s3://intellifyqa/selenium-execution/
ls -l $2/jobs/Executionresult/
