if (compassthrough) then
	if installcheck == 1 then
		table.insert(installedcommands, loadedfilepath)
		print("installed template")
	else
		--put your code here
		--the global array "compassthrough" will hold the last string input by the user, separated at every space
		--make sure to include "return(1)" in your commands!
		--
		--Example code:
			if (chhelp) then
				print("Installable Command Template:")
				print("	test")
			elseif compassthrough[1] == "test" then
				print("the test was a succsess!")
				return(1) --tells ClOS that the command worked
			end
	end
else
	print("Error: run this program from ClOS to use/install")
end
