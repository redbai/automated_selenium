Written By:  Von Bailey
February 21, 2014
Version 1.1
**********************************************
Requirement:  
	System must be running Window 8
	System must have Ruby 1.9.3 or higher installed
	System must have Selenium WebServers installed
	**Interenet Explorer & Chrome have their own exe files that must be installed in path
	System must have Chrome and Firefox browsers installed (IE on Windows Machines)
	Access to the ReachLocal VPN and the relevant QA resources

Files:
	contacts.rb
	homePage.rb
	RE_BAT-Test.rb
	utilitybin.rb
	chromedriver.exe (must be in system path)
	IEDriverServer.exe (must be in system path for Windows Machines)

This version of the application will perform the following:
1) Open the varioius browsers identified above
2) Attempt to verify access to the relevant QA resources
3) Access the ReachEdge application in the QA environment
4) Click on each major tab on the home page and verify access to the pages the tabs access
5) Log the actions in a log file of the test in a directory located on the user's desktop
6) Supply screen shots in the log directory of any instances of errors during the test
7) Create and validate creation of a new contact

To start the application:
1) Open a terminal on the desktop and access the directory in which the .rb files are located.
2) Enter the following command:
	ruby RE_BAT-Test.rb

The terminal should indicate that the test has started and the browsers should start opening and performing the tests.