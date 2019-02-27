# selenium-automation

# Installation Setup

- Install firefox 43.0.1

- Install Ruby 1.9.3

- Install bundler Gem . 
- Run the below commends

   - >gem install bundler -v 1.11.2
   -  selenium-automation>bundle install 

# Executing the Automation Suit using tags.
    Every feature is tagged so it can fall under a group eg:. (@nightly, @hmhreport , @workbench2,@moodle.... )
    
    -@nightly tag is used to run all the features during overnight execution.
    -@hmhreport tag is used to run only the HMH six reports
    -@workbench2 tag is used to run all the features related to workbench2
    -@moodle tag is used to run all the features relate moodle project.
    
 # Below is the example commands to execute the automation suit.
   From the Suit directory execute the below command to run all the features for a specific tag.
   
  - selenium-automation>cucumber --tags @moodle --format html >..\selenium-automation\Result\<filename to store our result>.html
    
---------------------------------------
# Some Supported Actions and Assertions Examples

### To Use a Window
- page.windows[0].use
- page.windows[1].use

### To close a Broswer Windos
- page.windows[1].close
- page.windows[2].close


### Assign a value from the Element to a variable

- @doc_value = page.doc_no_value


### Select a value from select element
- page.accountsCode.select("BL")
- page.vendor_select_invoice_page.select 'YBP Library Services'



### Set a values to an text Box or Input box
- page.doc_id.set @doc_value
- page.doc_id.set 'somevalue'

### Click Action on any element
- page.doc_id_link.click

### Implicit Wait
- sleep(10)

### Explicit Wait
- expected_element :pdfauto,30  # Where pdfauto is an element and 30 is the time in seconds

### Assertion on a element to Present or Not Present
- page.dataField_tag_data.exists?.should be_true
- page.dataField_tag_data.exists?.should be_false

### Assertion on a element Value to match expected 
- @purchase_order_status.should match 'FINAL'
- @purchase_order_status.should match @somevariable

### Windows Send key Operation
- page.send_keys :enter
 