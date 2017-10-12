if installcheck == 1 then
	table.insert(installedcommands, loadedfilepath)
	print("installed template")
else
	--put your code here
	--the global var "answer" will hold the last string input by the user
	--make sure to include "comsucsess = 1" in your commands!
	--
	--Example code:
		if answer == "test"
			comsucsess = 1 --as a good rule of thumb, always do this as the first thing in a command's if statement
			print("the test was a sucsess!")
		end
end
