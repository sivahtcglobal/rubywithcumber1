Given(/^Capture the records from moodle server$/) do
  @baseDir = File.absolute_path "./"
  install_log_file_path = File.join(@baseDir,"lib","intellify","support_files","logstore_intellify_install-2017-12-06.log")
  file = File.open(install_log_file_path, "r")
  $final_user_count = 0
  $final_course_count = 0
  $final_course_category_count = 0

  file.each do |line|
    if line.match /Fetched/
      if line.split('Fetched').last.include? ('users')
        @user_count = line.split('Fetched ').last.split(' users').first
        $final_user_count = $final_user_count+@user_count.to_i

      elsif line.split('Fetched').last.include? ('courses')
        @course_count = line.split('Fetched ').last.split(' courses').first
        $final_course_count = $final_course_count+@course_count.to_i

      elsif line.split('Fetched').last.include? ('course categories')
        @course_category_count = line.split('Fetched ').last.split(' course categories').first
        $final_course_category_count = $final_course_category_count+@course_category_count.to_i
      end
    end
  end
  puts $final_user_count
  puts $final_course_count
  puts $final_course_category_count
  @total_entities = $final_user_count+$final_course_count+$final_course_category_count
  puts @total_entities
end

Then(/^All the historical data sent to our Raw Event Index$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  #Log file to Log the Verification Result
  $stdout.reopen("./lib/intellify/support_files/logstore_validation_#{@currnetTimeStamp}.log", "w")
  $stdout.sync = true
  $stderr.reopen($stdout)

  @baseDir = File.absolute_path "./"
  lib_log_file_path = File.join(@baseDir,"lib","intellify","support_files","logstore_intellify_lib-2017-12-06.log")
  lib_file = File.read(lib_log_file_path)

  #Generating API Token
  @tokenhost = 'moodleautomation.intellifyqa.net' #configatron.moodleWorkbench
  @tokenuser = "AutoDesigner1" #configatron.tokenuser
  @tokenpass = "fooBar1@34" #configatron.tokenpass
  @intellistream = 'data-entitydata-5a28355346c3433b91690c09' #configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)

  #Getting out the Entity Jsons from Lib File
  splitedJson = Array.new
  splitedJson = lib_file.scan(/\"entityData\":(.*?)\]\n}/m)

  @TotalEntiyJson = 0
  @TotalUserEntiy= 0
  @TotalCourseEntiy= 0
  @TotalCourseCatagoryEntiy= 0
  @TotalEnrolmentEntiy = 0
  @TotalAdvancedForumEntiy = 0
  @TotalDatabaseEntiy = 0
  @TotalAssignmentEntiy = 0
  @TotalFileEntiy = 0
  @TotalFolderEntiy = 0
  @TotalChatEntiy = 0
  @TotalFeedbackEntiy = 0
  @TotalForumEntiy = 0
  @TotalGlossaryEntiy = 0
  @TotalLessonEntiy = 0
  @TotalPageEntiy = 0
  @TotalQuizEntiy = 0
  @TotalURLEntiy = 0
  @TotalChoiceEntiy = 0
  @TotalQuestionnaireEntiy = 0
  @TotalWikiEntiy = 0
  @TotalJournalEntiy = 0
  @TotalWorkshopEntiy = 0
  @TotalBigBlueButtonEntiy = 0
  @TotalSurveyEntiy = 0
  @TotalRecordingsBnEntiy = 0
  @TotalLTIEntiy = 0
  @TotalSchedulerEntiy = 0

  splitedJson.each do |entitySet|
    #converting the String Entityes Identified in Lib to a Json Array
    valueAsString = entitySet.to_s
    removeEOL = valueAsString.gsub("\\n",'')
    makeAsArray = removeEOL.gsub("[\"",'')
    makeAsArrayEnd = makeAsArray.gsub("\"]",']')
    removeBackSlach = makeAsArrayEnd.gsub("\\\"",'"')
    convertedasJson = JSON.parse(removeBackSlach)

    ###Verifying the Json is Available in the ES Raw Index.
    convertedasJson.each do |singleJsonEntity|


      case singleJsonEntity['entity']['extensions']['moduleType']

        when 'user'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["
          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.userName\":\"#{singleJsonEntity['entity']['extensions']['userName']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.email\":\"#{singleJsonEntity['entity']['extensions']['email']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.firstName\":\"#{singleJsonEntity['entity']['extensions']['firstName']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.lastName\":\"#{singleJsonEntity['entity']['extensions']['lastName']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.timeZone\":\"#{singleJsonEntity['entity']['extensions']['timeZone']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalUserEntiy= @TotalUserEntiy + 1

        when 'course'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.shortName\":\"#{singleJsonEntity['entity']['extensions']['shortName']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['subOrganizationOf']['@type']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalCourseEntiy= @TotalCourseEntiy + 1

        when 'course_category'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalCourseCatagoryEntiy= @TotalCourseCatagoryEntiy + 1

        when 'enrolment'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.organization.@id\":\"#{singleJsonEntity['entity']['organization']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.organization.@context\":\"#{singleJsonEntity['entity']['organization']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.organization.@type\":\"#{singleJsonEntity['entity']['organization']['@type']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalEnrolmentEntiy= @TotalEnrolmentEntiy + 1

        when 'hsuforum'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.gradeType\":\"#{singleJsonEntity['entity']['extensions']['gradeType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.ratingAggregateType\":\"#{singleJsonEntity['entity']['extensions']['ratingAggregateType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalAdvancedForumEntiy= @TotalAdvancedForumEntiy + 1

        when 'data'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.ratingAggregateType\":\"#{singleJsonEntity['entity']['extensions']['ratingAggregateType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.allowCommentsEntries\":\"#{singleJsonEntity['entity']['extensions']['allowCommentsEntries']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.entriesRequiredForCompletion\":\"#{singleJsonEntity['entity']['extensions']['entriesRequiredForCompletion']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.entriesRequiredBeforeViewing\":\"#{singleJsonEntity['entity']['extensions']['entriesRequiredBeforeViewing']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.maximunNumberOfEntries\":\"#{singleJsonEntity['entity']['extensions']['maximunNumberOfEntries']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalDatabaseEntiy= @TotalDatabaseEntiy + 1

        when 'assign'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.gradeType\":\"#{singleJsonEntity['entity']['extensions']['gradeType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.gradeToPass\":\"#{singleJsonEntity['entity']['extensions']['gradeToPass']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireSubmitButton\":\"#{singleJsonEntity['entity']['extensions']['requireSubmitButton']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireSubmissionStatement\":\"#{singleJsonEntity['entity']['extensions']['requireSubmissionStatement']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.gradingMethod\":\"#{singleJsonEntity['entity']['extensions']['gradingMethod']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalAssignmentEntiy= @TotalAssignmentEntiy + 1

        when 'resource'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalFileEntiy= @TotalFileEntiy + 1

        when 'folder'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalFolderEntiy= @TotalFolderEntiy + 1

        when 'chat'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.chatRepeatTimes\":\"#{singleJsonEntity['entity']['extensions']['chatRepeatTimes']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalChatEntiy= @TotalChatEntiy + 1

        when 'feedback'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.recordUserNames\":\"#{singleJsonEntity['entity']['extensions']['recordUserNames']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.allowMultipleSubmissions\":\"#{singleJsonEntity['entity']['extensions']['allowMultipleSubmissions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.enableNotifications\":\"#{singleJsonEntity['entity']['extensions']['enableNotifications']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.autoNumberQuestions\":\"#{singleJsonEntity['entity']['extensions']['autoNumberQuestions']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalFeedbackEntiy= @TotalFeedbackEntiy + 1

        when 'forum'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.ratingAggregateType\":\"#{singleJsonEntity['entity']['extensions']['ratingAggregateType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalForumEntiy= @TotalForumEntiy + 1

        when 'glossary'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.gradeToPass\":\"#{singleJsonEntity['entity']['extensions']['gradeToPass']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.ratingAggregateType\":\"#{singleJsonEntity['entity']['extensions']['ratingAggregateType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalGlossaryEntiy= @TotalGlossaryEntiy + 1

        when 'lesson'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.gradeType\":\"#{singleJsonEntity['entity']['extensions']['gradeType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.gradeToPass\":\"#{singleJsonEntity['entity']['extensions']['gradeToPass']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalLessonEntiy= @TotalLessonEntiy + 1

        when 'page'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalPageEntiy= @TotalPageEntiy + 1

        when 'quiz'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.gradeToPass\":\"#{singleJsonEntity['entity']['extensions']['gradeToPass']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.gradeMethod\":\"#{singleJsonEntity['entity']['extensions']['gradeMethod']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.timeLimit\":\"#{singleJsonEntity['entity']['extensions']['timeLimit']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.overdueHandling\":\"#{singleJsonEntity['entity']['extensions']['overdueHandling']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.gracePeriod\":\"#{singleJsonEntity['entity']['extensions']['gracePeriod']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalQuizEntiy= @TotalQuizEntiy + 1

        when 'url'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.externalurl\":\"#{singleJsonEntity['entity']['extensions']['externalurl']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalURLEntiy= @TotalURLEntiy + 1

        when 'choice'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.previewOptions\":\"#{singleJsonEntity['entity']['extensions']['previewOptions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.publishResults\":\"#{singleJsonEntity['entity']['extensions']['publishResults']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.resultsPrivacy\":\"#{singleJsonEntity['entity']['extensions']['resultsPrivacy']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalChoiceEntiy= @TotalChoiceEntiy + 1

        when 'questionnaire'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.responseType\":\"#{singleJsonEntity['entity']['extensions']['responseType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.respondentType\":\"#{singleJsonEntity['entity']['extensions']['respondentType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.submissionGrade\":\"#{singleJsonEntity['entity']['extensions']['submissionGrade']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalQuestionnaireEntiy= @TotalQuestionnaireEntiy + 1

        when 'wiki'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.wikiMode\":\"#{singleJsonEntity['entity']['extensions']['wikiMode']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalWikiEntiy= @TotalWikiEntiy + 1

        when 'journal'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.gradeType\":\"#{singleJsonEntity['entity']['extensions']['gradeType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.gradeToPass\":\"#{singleJsonEntity['entity']['extensions']['gradeToPass']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.daysAvailable\":\"#{singleJsonEntity['entity']['extensions']['daysAvailable']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalJournalEntiy= @TotalJournalEntiy + 1

        when 'workshop'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.submissionGradeType\":\"#{singleJsonEntity['entity']['extensions']['submissionGradeType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.submissionGradeToPass\":\"#{singleJsonEntity['entity']['extensions']['submissionGradeToPass']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.assessmentGradeType\":\"#{singleJsonEntity['entity']['extensions']['assessmentGradeType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.assessmentGradeToPass\":\"#{singleJsonEntity['entity']['extensions']['assessmentGradeToPass']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.gradeStrategy\":\"#{singleJsonEntity['entity']['extensions']['gradeStrategy']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.submissionAttachmentLimit\":\"#{singleJsonEntity['entity']['extensions']['submissionAttachmentLimit']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.allowLateSubmissions\":\"#{singleJsonEntity['entity']['extensions']['allowLateSubmissions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.allowSelfAssessment\":\"#{singleJsonEntity['entity']['extensions']['allowSelfAssessment']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.overallFeedbackMode\":\"#{singleJsonEntity['entity']['extensions']['overallFeedbackMode']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalWorkshopEntiy= @TotalWorkshopEntiy + 1

        when 'bigbluebuttonbn'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalBigBlueButtonEntiy= @TotalBigBlueButtonEntiy + 1

        when 'survey'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.surveyType\":\"#{singleJsonEntity['entity']['extensions']['surveyType']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalSurveyEntiy= @TotalSurveyEntiy + 1

        when 'recordingsbn'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalRecordingsBnEntiy= @TotalRecordingsBnEntiy + 1

        when 'lti'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.gradeType\":\"#{singleJsonEntity['entity']['extensions']['gradeType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.preconfiguredTool\":\"#{singleJsonEntity['entity']['extensions']['preconfiguredTool']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.preconfiguredToolUrl\":\"#{singleJsonEntity['entity']['extensions']['preconfiguredToolUrl']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.privacyShareLauncherNameWithTheTool\":\"#{singleJsonEntity['entity']['extensions']['privacyShareLauncherNameWithTheTool']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.privacyShareLauncherEmailWithTheTool\":\"#{singleJsonEntity['entity']['extensions']['privacyShareLauncherEmailWithTheTool']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.acceptGradesFromTheTool\":\"#{singleJsonEntity['entity']['extensions']['acceptGradesFromTheTool']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalLTIEntiy= @TotalLTIEntiy + 1

        when 'scheduler'
          esquery= "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":["

          esquery = esquery + "{\"term\":{\"entity.@id\":\"#{singleJsonEntity['entity']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@context\":\"#{singleJsonEntity['entity']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.@type\":\"#{singleJsonEntity['entity']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.dateModified\":\"#{singleJsonEntity['entity']['dateModified']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.name\":\"#{singleJsonEntity['entity']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@id\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@context\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.courseSection.subOrganizationOf.@type\":\"#{singleJsonEntity['entity']['extensions']['courseSection']['subOrganizationOf']['@type']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.moduleType\":\"#{singleJsonEntity['entity']['extensions']['moduleType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@id\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@id']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@context\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@context']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.@type\":\"#{singleJsonEntity['entity']['extensions']['edApp']['@type']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.edApp.name\":\"#{singleJsonEntity['entity']['extensions']['edApp']['name']}\"}},"

          esquery = esquery + "{\"term\":{\"entity.extensions.gradeType\":\"#{singleJsonEntity['entity']['extensions']['gradeType']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.gradeToPass\":\"#{singleJsonEntity['entity']['extensions']['gradeToPass']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.visible\":\"#{singleJsonEntity['entity']['extensions']['visible']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.grouping\":\"#{singleJsonEntity['entity']['extensions']['grouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.groupMode\":\"#{singleJsonEntity['entity']['extensions']['groupMode']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.restrictions\":\"#{singleJsonEntity['entity']['extensions']['restrictions']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.completionTracking\":\"#{singleJsonEntity['entity']['extensions']['completionTracking']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireView\":\"#{singleJsonEntity['entity']['extensions']['requireView']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.requireGrade\":\"#{singleJsonEntity['entity']['extensions']['requireGrade']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.rolenameOfTeacher\":\"#{singleJsonEntity['entity']['extensions']['rolenameOfTeacher']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.studentsCanRegister\":\"#{singleJsonEntity['entity']['extensions']['studentsCanRegister']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.appointment\":\"#{singleJsonEntity['entity']['extensions']['appointment']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.guardtime\":\"#{singleJsonEntity['entity']['extensions']['guardtime']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.bookinGrouping\":\"#{singleJsonEntity['entity']['extensions']['bookinGrouping']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.defaultSlotDuration\":\"#{singleJsonEntity['entity']['extensions']['defaultSlotDuration']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.notifications\":\"#{singleJsonEntity['entity']['extensions']['notifications']}\"}},"
          esquery = esquery + "{\"term\":{\"entity.extensions.useNotesAppointments\":\"#{singleJsonEntity['entity']['extensions']['useNotesAppointments']}\"}}"

          esquery = esquery + "]}}}}}"
          @query = esquery
          @TotalSchedulerEntiy= @TotalSchedulerEntiy + 1
      end

      @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
      puts @posturl
      puts @query
      @response = post_request(@posturl,@query,@apitoken)
      @hits = @response['hits']['total']

      if @hits == 1 then
        #Skipped PASS case printing in the Result
        #puts "PASS : Hit counts #{@hits}"
      else
        puts "FAIL : Hit counts #{@hits} - #{@query}"
      end

    end

    #Find the Total Number of Entities Available in the Lib File
    @TotalEntiyJson = @TotalEntiyJson + convertedasJson.length
  end

  puts "Completed Validating the Historical Data"
  puts "Total User Entity Json Identified : #{@TotalUserEntiy}"
  puts "Total Course Entity Json Identified : #{@TotalCourseEntiy}"
  puts "Total Category Entity Json Identified : #{@TotalCourseCatagoryEntiy}"
  puts "Total Enrollment Entity Json Identified : #{@TotalEnrolmentEntiy}"
  puts "Total Advanced Forum Entity Json Identified : #{@TotalAdvancedForumEntiy}"
  puts "Total Database Entity Json Identified : #{@TotalDatabaseEntiy}"
  puts "Total Assignment Entity Json Identified : #{@TotalAssignmentEntiy}"
  puts "Total File Entity Json Identified : #{@TotalFileEntiy}"
  puts "Total Folder Entity Json Identified : #{@TotalFolderEntiy}"
  puts "Total Chat Entity Json Identified : #{@TotalChatEntiy}"
  puts "Total Feedback Entity Json Identified : #{@TotalFeedbackEntiy}"
  puts "Total Forum Entity Json Identified : #{@TotalForumEntiy}"
  puts "Total Glossary Entity Json Identified : #{@TotalGlossaryEntiy}"
  puts "Total Lesson Entity Json Identified : #{@TotalLessonEntiy}"
  puts "Total Page Entity Json Identified : #{@TotalPageEntiy}"
  puts "Total Quiz Entity Json Identified : #{@TotalQuizEntiy}"
  puts "Total URL Entity Json Identified : #{@TotalURLEntiy}"
  puts "Total Choice Entity Json Identified : #{@TotalChoiceEntiy}"
  puts "Total Questionnaire Entity Json Identified : #{@TotalQuestionnaireEntiy}"
  puts "Total Wiki Entity Json Identified : #{@TotalWikiEntiy}"
  puts "Total Journal Entity Json Identified : #{@TotalJournalEntiy}"
  puts "Total Workshop Entity Json Identified : #{@TotalWorkshopEntiy}"
  puts "Total BigBlueButton Entity Json Identified : #{@TotalBigBlueButtonEntiy}"
  puts "Total Survey Entity Json Identified : #{@TotalSurveyEntiy}"
  puts "Total RecordingsBN Entity Json Identified : #{@TotalRecordingsBnEntiy}"
  puts "Total LTI External Tool Entity Json Identified : #{@TotalLTIEntiy}"
  puts "Total Scheduler Entity Json Identified : #{@TotalSchedulerEntiy}"
  puts "Total Entity Json Identified in Intellify Lib File is #{@TotalEntiyJson}"
end
