-- ClOS Lua adaptation
-- Developed under Macrosaft WinDOS (Microsoft Windows)
-- Will hopefully run on other OSes

-- Version 0.0.1

-- Created by Clarence Pacelli (clarence112)

-- destrubuted under Attribution-NonCommercial-ShareAlike 3.0(CC-BY-NC-SA 3.0)
--    you CAN modify and re-destribute this code, just give credit
--    you CAN'T use this code for commercial purposes, or change the licence

--If you came here from the scratch based version of ClOS, welcome!
--greetings to future crew (yes this is nessicary)

--also I'm terrible at spelling but everything seems to work so idc


--declare dependencies
io = require("io")
os = require("os")

-- var setup
restart = 1
osver = "vanilla 0.0.1" --OS version
cominput = " " --input to command system
installedcommands = {}

--load installed commands
for line in io.lines("installedprograms.txt") do
    table.insert(installedcommands, line)
end

--main command infastructure
local function command()

	comsucsess = 0 --set command sucsess check var

	for i,line in ipairs(installedcommands) do --run any user-installed commands
      dofile(line)
    end

	if answer == "lala" then --easter egg
		print("'tis a test")
		comsucsess = 1
	end

	if answer == "quit" or answer == "logout" or answer == "halt" or answer == "shutdown" then --exit ClOS
		comsucsess = 1
		print("Goodbye")
		clspgm = 1
		restart = 0
	end

	if answer == "help" then --command help
		comsucsess = 1
		print("choose a catigory (1-3)")
		print(" ")
		print("1: power")
		print("2: easter eggs")
		print("3: utillity")
		io.write("help > ")
		io.flush()
		answer = io.read()
		if answer == "1" then
			print("close ClOS:")
			print("	quit")
			print("	logout")
			print("	halt")
			print("	shutdown")
			print("restart ClOS:")
			print("	restart")
		end
		if answer == "2" then
			print("easter egg commands:")
			print("	lala")
		end
		if answer == "3" then
			print("Utillity commands:")
			print("	clear")
			print("	fileload")
			print("	fileprint")
			print("	filerun")
		end
	end

	if answer == "restart" then --restart ClOS
		clspgm = 1
		comsucsess = 1
		print("Restarting")
	end

	if answer == "clear" then --clear the screen
		comsucsess = 1
		os.execute("CLS")
	end

	if answer == "fileload" then --load a file
		print("Type the path of the file")
		io.write("fileload > ")
		io.flush()
		answer = io.read()
		loadedfile = io.open(answer)
		comsucsess = 1
		if (loadedfile) then
			print("Load sucsessful")
			loadedfilepath = answer
		else
			print("File not found")
		end
	end

	if answer == "fileprint" then --print loaded file (userdata)
		if (loadedfile) then
			print(loadedfile)
		else
			print("No file loaded, load one with fileload")
		end
		comsucsess = 1
	end

	if answer == "filerun" then --run loaded file (lua programs only)
		if (loadedfile) then
			installcheck = 1
			dofile(loadedfilepath)
			installcheck = 0
		else
			print("No file loaded, load one with fileload")
		end
		comsucsess = 1
	end

	if comsucsess == 0 then --check to see of the command was sucsessful
		print("Unknown command:", answer)
	end
end

-- ClOS terminal mode
local function advmode()
print("*** STARTING CLOS IN TERMINAL MODE ***")
print("Begin sys info collection")
print("OS version:", osver)
print("Lua version:", _VERSION, "Built for: Lua 5.1")
print(" ")
print("This is a BETA VERSION, don't expect things to run smoothly.")
while clspgm == 0 do
	answer = " "
	io.write("ClOS > ")
	io.flush()
	answer = io.read()
	command()
end
end

-- save the list of installed commands
local function saveinstalllist()
file = io.open("installedprograms.txt", "w")
file:write("")
file:close()
file = io.open("installedprograms.txt", "a")
for i,line in ipairs(installedcommands) do
	file:write(line, "\n")
end
file:close()
end

-- bootloader screen will go here once I figure out how to render GUIs, for now it's hardcoded to go to advanced mode
while restart == 1 do
	clspgm = 0
	os.execute("CLS")
	advmode()
end

saveinstalllist() -- save installed commands before quitting

