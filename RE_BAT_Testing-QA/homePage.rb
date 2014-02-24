# This call is used to perform all functions on the ReachEdge Home Page 

class HomePage

	def homeTabs(logName,dirName,driver,browser)
		begin
			bin=Utility.new
			# Setting up wait time for driver
			dWait= Selenium::WebDriver::Wait.new(:timeout=>5)
			theTab="none"
			for i in 1..6
				if i==1 # Identifying the tab
					theTab="Contacts"
					theVerify="contact_list"
				elsif i==2
					theTab="Campaigns"
					theVerify="campaign_list"
				elsif i==3
					theTab="Reports"
					theVerify="overview-report"
				elsif i==4
					theTab="Settings"
					theVerify="daily_digest_form"
				elsif i==5
					theTab="Admin"
					theVerify="account_list"
				else
					theTab="Home"
					theVerify="dashboard_container"
				end	
			# Identifing and clicking on the tab
			e=dWait.until{driver.find_element(:link_text,theTab)}
			theBttn=driver.find_element(:link_text,theTab)
			bin.reporting(logName,Time.now.inspect+": Clicking the #{theTab} tab.",false,nil,nil)
			theBttn.click
			# Verifying the correct screen appeared
			e=dWait.until{driver.find_element(:id,theVerify)}
			bin.reporting(logName,Time.now.inspect+": Verifying the #{theTab} screen.",false,nil,nil)
			# Saving image of screen
			driver.save_screenshot(dirName+"\\#{browser}_#{theTab}_screen_"+Time.now.strftime("%Y%m%d%H%M%S")+".png")
			end
		rescue 
			bin.reporting(logName,Time.now.inspect+":  ERROR CLICKING TABS-"+theTab,true,driver,dirName)
		end
	end
end

