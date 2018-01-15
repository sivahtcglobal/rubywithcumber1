#!/bin/bash
/home/ubuntu/.rbenv/bin/rbenv global 
/home/ubuntu/.rbenv/bin/rbenv global 2.3.1
cd $2

tag=$4

echo "sudo git checkout tags/$tag"
sudo git checkout tags/$tag
#source /etc/profile.d/rvm.sh
which cucumber
echo $3
#create directories if they dont exist

mkdir -p $2/jobs/Executionresult/functional-automation/Intellify-Essentials-E2E-MD/
mkdir -p $2/jobs/Executionresult/functional-automation/Intellify-Essentials-E2E-MS/
mkdir -p $2/jobs/Executionresult/functional-automation/Intellify-Essentials-E2E-MP/

case "$3" in
essentials_MD)
	cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/Intellify-Essentials-E2E-MD/`date +"%Y%m%d"`-$1_result.htm
	;;
essentials_MS)
	cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/Intellify-Essentials-E2E-MS/`date +"%Y%m%d"`-$1_result.htm
	;;
essentials_MP)
  	cucumber -p $3  --format html > $2/jobs/Executionresult/functional-automation/Intellify-Essentials-E2E-MP/`date +"%Y%m%d"`-$1_result.htm
	;;
*)
 echo "No job found..."

esac
aws s3 sync $2/jobs/Executionresult/ s3://intellifyqa/
ls -l $2/jobs/Executionresult/
sudo git checkout master
