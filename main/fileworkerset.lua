if (compassthrough) then
	if installcheck == 1 then
		table.insert(installedcommands, loadedfilepath)
		print("installed fileworker set")
	else
			if (chhelp) then
				print("File Worker Set:")
				print("	ilte ... edits text files")
				print("	mkdir .. creates directories")
				print("	mkfile . creates files")
				print("	cd ..... change current working directory")
				print("	rd ..... go back to root directory")
				return(1)
			elseif compassthrough[1] == "cd" then
				if table.getn(compassthrough) > 2 then
					print("Error: Too many arguments. If the file path has spaces, try running cd without any arguments.")
				elseif table.getn(compassthrough) == 2 then
					if not lfs.chdir(compassthrough[2]) then
						print("Error: the directory " .. compassthrough[2] .. " does not exist!")
					end
				else
					io.write("cd > ")
					io.flush()
					compassthrough[2] = io.read()
					if not lfs.chdir(compassthrough[2]) then
						print("Error: the directory " .. compassthrough[2] .. " does not exist!")
					end
				end
				return(1)
			elseif compassthrough[1] == "rd" then
				if not (lfs.chdir(root)) then
					print("Somthing's horrifically broken! I blame you :P")
				end
				return(1)
			elseif compassthrough[1] == "mkdir" then
				if (lfs.mkdir(compassthrough[2])) then
					print("Created directory " .. compassthrough[2])
				else
					print("Cannot create directory: " .. compassthrough[2])
				end
				return(1)
			elseif compassthrough[1] == "ls" then
				if hosttype == "microsoft" then
					os.execute("dir")
				else
					os.execute("ls")
				end
				return(1)
			end
	end
else
	print("Error: run this program from ClOS to use/install")
end
