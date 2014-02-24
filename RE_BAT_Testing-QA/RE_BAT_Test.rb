# Written by Von Bailey for ReachLocal
# Date: 02/24/2014
# This is the starting script of the testing program

require "selenium-webdriver"
# This determines the correct OS and loads the correct utility script for it.
if RbConfig::CONFIG['host_os']=="mingw32"
	require_relative "utilityBin.rb"
else
	require_relative "mac_utilityBin.rb"
end
require_relative "homePage.rb"
require_relative "contacts.rb"

class Main

def RE_AutoTest(logName,dirName)
	begin
	bin=Utility.new
	home=HomePage.new
	cont=Contacts.new
		for i in [1,2,3] #Checking the environment.
			driver,browser=bin.setUpBrowser(i)
			if driver != nil
				#Accessing the WebPage
				bin.verify_environment(logName,dirName,driver,browser)			
				#Clicking through the tabs on Home Page.
				home.homeTabs(logName,dirName,driver,browser)
				#Creating a contact
				fName,lName,email,address=cont.makeContact(logName,driver,dirName)
				cont.createContact(logName,driver,dirName,fName,lName,email,address,browser)
				#Accessing contact form and Entering contact data
			
				#Closing Broswer
				driver.quit
			else
				bin.reporting(logName,Time.now.inspect+":  No Browser Selected",false,nil,nil)
			end
		end
	rescue
		bin.reporting(logName,Time.now.inspect+":  ERROR STARTING TEST",true,driver,dirName)
	end
end
end

# Creating Log
rStart=Main.new
binStart=Utility.new
@dirName=binStart.createDir()
@logName=binStart.createLog()

# Starting Test
puts "Starting the test script"
binStart.reporting(@logName,Time.now.inspect.to_s+": Starting the Browser Test",false,nil,nil)
rStart.RE_AutoTest(@logName,@dirName)


# Ending Test
puts "Ending the test script"
binStart.reporting(@logName,Time.now.inspect.to_s+": Ending the Test",false,nil,nil)
