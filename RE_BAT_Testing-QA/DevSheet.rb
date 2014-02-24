require "selenium-webdriver"
#require "win32ole"
require_relative "utilityBin.rb"

class CreateContact
	def makeContact()
		begin
		
		bin=Utility.new
			x="fname"
			@fName="QA"+Time.now.strftime("%H%M%S")
			x="lname"
			@lName="Z"+Time.now.strftime("%Y%m%d")
			x="email"
			@email=@fName+@lName+"@mailinator.com"
			x="address"
			@address=Time.now.strftime("%H%M%S")+" Somewhere Blvd"
			return @fName,@lName,@email,@address
		rescue
			puts "This didn't work\nError happened: "+x
		end
	end
	
	def pickCustomerData(logName,dirName,driver,browser)
		begin
		bin=Utility.new
		bin.verify_environment(logName,dirName,driver,browser)
		driver.get("https://edge.qa.wh.reachlocal.com/marketing/contacts/269495?edit=true&new_contact=true")
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
		end
		rescue
			puts "This didn't work\nError happened: "
		end		
	
	end
end

require 'net/smtp'

message = <<MESSAGE_END
From: Private Person <von.bailey@reachlocal.com>
To: A Test User <QA1148Z022414@mailinator.com>
Subject: SMTP e-mail test

This is a test e-mail message.
MESSAGE_END

Net::SMTP.start('smtp.gmail.com',
				465,
				'gmail.com',
				"von.bailey@gmail.com","ramses02", :login) do |smtp|
  smtp.send_message message, 'connie.durr@gmail.com', 
                             ['QA1148Z022414@mailinator.com']
end
