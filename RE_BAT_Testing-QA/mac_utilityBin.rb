# This call is used to house all the common functions for the MAC

class Utility
	def isItemAvailable?(type,selector)
		begin
			@driver.find_element(type,selector)
			true
		rescue Exception
			reporting(logName,Time.now.inspect+":  ERROR VERIFYING ELEMENT",true,nil,nil)
			false
		end
	end
	
	def createDir()
		@dirName="log"+Time.now.strftime("%Y%m%d%H%M%S")+"/ReachEdge_BAT_"+Time.now.strftime("%Y%m%d%H%M%S")
		FileUtils.mkdir_p(@dirName)
		return @dirName
	end

	def createLog()
		begin
			tstamp=Time.now.strftime("%Y%m%d%H%M%S")
			@logName=@dirName+"//0_RE_BAT_"+tstamp+".log"
			File.open(@logName,"w")
			return @logName
		rescue 
			reporting(logName,Time.now.inspect+":  ERROR CREATING LOG",true,nil,nil)
		end
	end

	def reporting(logName,logText,ex,driver,dirName)
		File.open(logName,"a") do|logit|
		logit.puts logText
		if ex == true # reporting exception errors
			driver.save_screenshot(dirName+"\\ERROR_"+Time.now.strftime("%Y%m%d%H%M%S")+".png")
			logit.puts $@ # This symbole represents the error message
			logit.puts $! # This symbole represents the backtrace
			puts "***THERE WERE ERRORS IN THIS RUN***"
			puts $@
			puts $!
		end
	end
	end

	def setUpBrowser(x)
		begin
			if x== 1
				#Firefox browser instantiation
				 driver = Selenium::WebDriver.for :firefox
				 browser="Firefox"
			elsif x==2
				#Chrome browser instantiation
				 driver = Selenium::WebDriver.for :chrome
				 browser="Chrome"
			else
				# Safari browser instantiation
				# driver = Selenium::WebDriver.for :safari
				driver = nil
				browser = "Safari"
			end
		return driver,browser
		rescue 
			reporting(logName,Time.now.inspect+":  ERROR ACCESSING BROWSERS\n"+mess,true,driver,browser)
		end
	end

	def verify_environment(logName,dirName,driver,browser)
		begin
			# Set time for driver to wait for page element to appear
			dWait= Selenium::WebDriver::Wait.new(:timeout=>5)
			reporting(logName,Time.now.inspect+": *************************\n"+Time.now.inspect+": Opening the browser #{browser}\n",false,nil,nil)
			for t in [1,2,3]
				theTime=Time.now.inspect
				if t==1 # Verifying access to servers
					mess=theTime+": Setting Up Browser: Verify Access"
					url="https://edge.qa.wh.reachlocal.com/version"
					browpic="verifyAccess"
				elsif t==2 # Verifying no current user logged into server
					mess=theTime+": Setting Up Browser: Verify Logged Out"
					url="https://edge.qa.wh.reachlocal.com/logout"
					browpic="verifyLogout"		
				else # Accessing the website
					mess=theTime+": Setting Up Browser: Accessing site"
					url="https://edge.qa.wh.reachlocal.com/dev_login?email=von.bailey@reachlocal.com"
					browpic="verifyLogin"
				end
				driver.manage.window.maximize
				driver.get(url)
				reporting(logName,mess,false,nil,nil)
				if t==3 
					# Verify that the environment is available by verifying element on home page 
					e=dWait.until{driver.find_element(:id,"dashboard_container")}
					#Creating Signout Object
					reporting(logName,Time.now.inspect+": Successfully tested availability of environment\n",false,nil,nil)
				end
				# Adding an image of the page
				driver.save_screenshot(dirName+"\\"+browpic+"_#{browser}.png")
			end
		rescue 
			reporting(logName,Time.now.inspect+":  ERROR VERIFYING ENVIRONMENT\n"+mess,true,driver,dirName)
		end
	end
end