# This call is used to perform all functions on the ReachEdge Contacts Page

class Contacts
	def makeContact(logName,driver,dirName)
		begin
			bin=Utility.new
			x="fname"
			fName="QA"+Time.now.strftime("%H%M%S")
			x="lname"
			lName="Z"+Time.now.strftime("%Y%m%d")
			x="email"
			email=fName+lName+"@mailinator.com"
			x="address"
			address=Time.now.strftime("%H%M%S")+" Somewhere Blvd"
			bin.reporting(logName,Time.now.inspect+": **CONTACT DATA**\n"+Time.now.inspect+": First Name: #{fName}\n"+Time.now.inspect+": Last Name:#{lName}\n"+Time.now.inspect+": Email Address: #{email}\n"+Time.now.inspect+": Address: #{address}",false,nil,nil)
			return fName,lName,email,address
		rescue
			bin.reporting(logName,Time.now.inspect+":  ERROR CREATING CONTACT DATA-"+x,true,driver,dirName)
		end
	end
	
	def createContact(logName,driver,dirName,fName,lName,email,address,browser)
		begin
			bin=Utility.new
			dWait= Selenium::WebDriver::Wait.new(:timeout=>5)
			# Access the Contact page
			x="Accessing Contact Page"
			e=dWait.until{driver.find_element(:link_text,"Contacts")}
			driver.find_element(:link_text,"Contacts").click
			e=dWait.until{driver.find_element(:id,"contact_list")}
			bin.reporting(logName,Time.now.inspect+": Accessed Contact Page Verified\n",false,nil,nil)
			# Accessing the new contact form
			x="Accessing contact form"
			e=dWait.until{driver.find_element(:id,"new_contact")}
			driver.find_element(:id,"new_contact").click
			e=dWait.until{driver.find_element(:id,"save_contact")}
			bin.reporting(logName,Time.now.inspect+": Accessed New Contact Form Verified\n",false,nil,nil)
			enterData(logName,driver,dirName,fName,lName,email,address,browser)
			# Access the main contact and verify the name of the contact is there
			x="Verifying Entry"
			
		rescue
			bin.reporting(logName,Time.now.inspect+":  ERROR CREATING CONTACT-"+x,true,driver,dirName)
		end	
	end
		
	def verifyContactPageFeatures()
		begin
			bin=Utility.new
			dWait= Selenium::WebDriver::Wait.new(:timeout=>5)
			# Click on contacts tab
			x="Contacts Tab"
			
			# Create Contact
			x="Creating Contact"
			
			# Click on Send Email Button
			x="Opening Email Dialog"
			
			# Verify email address of contact in "Send To" field
			x="Verifying email address"
			
			# Change status of contact
			x="Status Change"
			
			# Add new task
			x="New task"			
			
			# Edit contact personal information
			x="Edit Contact Data"
			
			# Close contact
			x="Return to Contact List"
			
			# Delete contact
			x="Deleting contact"
			
		rescue
			bin.reporting(logName,Time.now.inspect+":  ERROR CONTACT FEATURES-"+x,true,driver,dirName)
		end		
	end

	def enterData(logName,driver,dirName,fName,lName,email,address,browser)
		begin
			bin=Utility.new
			dWait= Selenium::WebDriver::Wait.new(:timeout=>5)
			e=dWait.until{driver.find_element(:id,"save_contact")}
			for aId in 1..16
				if aId==1
					theId="cm_contact_first_name"
					theValue=fName
				elsif aId==2
					theId="cm_contact_last_name"
					theValue=lName
				elsif aId==3
					theId="cm_contact_title"
					theValue="QA Test Contact"
				elsif aId==4
					theId="cm_contact_company"
					theValue="QA "+fName+" Company"
				elsif aId==5
					theId="cm_contact_email"
					theValue=email
				elsif aId==6
					theId="cm_contact_phone_mobile"
					theValue="9999999999"
				elsif aId==7
					theId="cm_contact_phone_work"
					theValue="8888888888"
				elsif aId==8
					theId="cm_contact_phone_home"
					theValue="7777777777"
				elsif aId==9
					theId="cm_contact_phone_fax"
					theValue="6666666666"
				elsif aId==10
					theId="cm_contact_address1"
					theValue=address
				elsif aId==11
					theId="cm_contact_address2"
					theValue="Suite 71"
				elsif aId==12
					theId="cm_contact_city"
					theValue="Long Beach"
				elsif aId==13
					theId="cm_contact_state"
					theValue="CA"
				elsif aId==14
					theId="cm_contact_postal"
					theValue="90801"
				elsif aId==15
					theId="cm_contact_country"
					theValue="USA"
				elsif aId==16
					theId="cm_contact_notes"
					theValue="This is a QA Test"
				end
			# Entering data
			driver.find_element(:id,theId).send_keys theValue
			bin.reporting(logName,Time.now.inspect+": Successfully added contact: #{theId}\n",false,nil,nil)
			end
			# Selecting data from Dropdown optoins
			pickCustomerData(logName,dirName,driver,browser)
			# Saving Contact
			driver.find_element(:id,"save_contact").click
			# Validating contact saved
			driver.find_element(:id,"tasks_container")
			bin.reporting(logName,Time.now.inspect+": Successfully added contact: "+driver.title+"\n",false,nil,nil)
			driver.save_screenshot(dirName+"\\"+driver.title+"_#{browser}.png")
		rescue
			bin.reporting(logName,Time.now.inspect+":  ERROR ENTERING CONTACT DATA-"+theId,true,driver,dirName)
		end			
	end
	
	def pickCustomerData(logName,dirName,driver,browser)
		begin
		bin=Utility.new
		for opt in 1..5
			if opt==1
				selection="cm_contact_cm_contact_state_code"
				optPick="pending_contact"
			elsif opt==2
				selection="cm_contact_mm_campaign_id"
				optPick="26872"
			elsif opt==3
				selection="cm_contact_birth_month"
				optPick="9"
			elsif opt==4
				selection="cm_contact_birth_day"
				optPick="23"
			elsif opt==5
				selection="cm_contact_birth_year"
				optPick="1989"
			end
			select=driver.find_element(:id,selection)
			custOptions=select.find_elements(:tag_name,"option")
			custOptions.each do|option|
				if option.attribute("value")==optPick
					option.click
				end
			end
			bin.reporting(logName,Time.now.inspect+": Successfully added contact: #{selection}\n",false,nil,nil)
		end
		rescue
			bin.reporting(logName,Time.now.inspect+":  ERROR SELECTING DROPDOWN CUSTOMER DATA-"+selection,true,driver,dirName)
		end		
	
	end	
	
end

