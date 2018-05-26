-- ClOS Lua adaptation
-- Developed under Microsoft Windows and Ubuntu 16.04
-- Will hopefully run on other OSes

-- Version 0.0.5

-- Created by Clarence Pacelli (clarence112)

-- destrubuted under Attribution-NonCommercial-ShareAlike 3.0(CC-BY-NC-SA 3.0)
--    you CAN modify and re-destribute this code, just give credit
--    you CAN'T use this code for commercial purposes, or change the licence

--If you came here from the scratch based version of ClOS, welcome!
--greetings to future crew (yes this is necessary)



--declare dependencies
io = require("io")
os = require("os")
lfs = require("lfs")

-- var setup
restart = 1
osver = "vanilla 0.0.5" --OS version
installedcommands = {}
installeduis = {}
comsuccess = 0
root = lfs.currentdir()
if string.sub(root, 1, 1) == "/" then
	hosttype = "unixlike"
	slashtype = "/"
else
	hosttype = "microsoft"
	slashtype = "\\"
end

--load installed commands
for line in io.lines("installedprograms.txt") do
    table.insert(installedcommands, line)
end

--load installed User-Interfaces
for line in io.lines("UIs.txt") do
    table.insert(installeduis, line)
end

--main command infastructure
function command(cominput)

	comsuccess = 0 --command sucsess check var

	compassthrough = cominput
	for i,line in ipairs(installedcommands) do --run any user-installed commands
		if dofile(line) == 1 then
			comsuccess = 1
		end
    end

	if cominput[1] == "lala" then --OG test command
		print("'tis a test")
		comsuccess = 1
	end

	if cominput[1] == "quit" or cominput[1] == "logout" or cominput[1] == "halt" or cominput[1] == "shutdown" then --exit ClOS
		comsuccess = 1
		print("Goodbye")
		clspgm = 1
		restart = 0
	end

	if cominput[1] == "help" then
		comsuccess = 1
		print("choose a catigory (1-4)")
		print(" ")
		print("1: power")
		print("2: easter eggs")
		print("3: utillity")
		print("4: installed")
		io.write("help > ")
		io.flush()
		cominput[2] = io.read()
		if cominput[2] == "1" then
			print("close ClOS:")
			print("	quit")
			print("	logout")
			print("	halt")
			print("	shutdown")
			print("restart ClOS:")
			print("	restart")
		elseif cominput[2] == "2" then
			print("easter egg commands:")
			print("	lala")
		elseif cominput[2] == "3" then
			print("Utillity commands:")
			print("	clear........clears the screen")
			print("	fileload.....loads a file")
			print("	fileprint....prints the userdata of the loaded file")
			print("	filerun......runs the loaded file")
			print("	fileunload...unloads the loaded file")
			print("	installed....lists installed programs")
		elseif cominput[2] == "4" then
			chhelp = 1
			for i,line in ipairs(installedcommands) do
				dofile(line)
			end
			chhelp = nil
		end
	end

	if cominput[1] == "restart" then --restart ClOS
		clspgm = 1
		comsuccess = 1
		print("Restarting")
	end

	if cominput[1] == "clear" then --clear the screen
		comsuccess = 1
		if hosttype == "microsoft" then
			os.execute("CLS")
		else
			os.execute("clear")
		end
	end

	if cominput[1] == "fileload" then --load a file
		comsuccess = 1
		if table.getn(cominput) == 2 then
			if table.getn(mysplit(cominput[2], "/")) > 1 or table.getn(mysplit(cominput[2], "\\")) > 1 then
				loadedfile = io.open(cominput[2])
			else
				loadedfile = io.open(lfs.currentdir() .. slashtype .. cominput[2])
				cominput[2] = lfs.currentdir() .. slashtype .. cominput[2]
			end
		elseif table.getn(cominput) == 1 then
			io.write("fileload > ")
			io.flush()
			cominput[2] = io.read()
			if table.getn(mysplit(cominput[2], "/")) > 1 or table.getn(mysplit(cominput[2], "\\")) > 1 then
				loadedfile = io.open(cominput[2])
			else
				loadedfile = io.open(lfs.currentdir() .. slashtype .. cominput[2])
				cominput[2] = lfs.currentdir() .. slashtype .. cominput[2]
			end
		end

		if (loadedfile) then
			loadedfilepath = cominput[2]
			print("Load succsessful: " .. loadedfilepath)
		elseif table.getn(cominput) > 2 then
			print("Error: Too many arguments. If the file path has spaces, try running fileload without any arguments.")
		else
			print("File not found: " .. cominput[2])
		end
	end

	if cominput[1] == "fileprint" then --print loaded file (userdata)
		if (loadedfile) then
			print(loadedfile)
		else
			print("No file loaded, load one with fileload")
		end
		comsuccess = 1
	end

	if cominput[1] == "filerun" then --run loaded file (lua programs only)
		if (loadedfile) then
		local fileext = mysplit(loadedfilepath, ".")
			if fileext[#fileext] == "lua" then
				installcheck = 1
				dofile(loadedfilepath)
				installcheck = 0
			elseif fileext[#fileext] == "clsh" then
				print("CLSH files do not work right now")
			elseif fileext[#fileext] == "sft" then
				print("SFT files do not work right now")
			else
				print("Error: loaded file is not a .lua, .clsh, or .sft file and cannot be run.")
			end
		else
			print("No file loaded, load one with fileload")
		end
		comsuccess = 1
	end

	if cominput[1] == "installed" then
		comsuccess = 1
		for i,line in ipairs(installedcommands) do --run any user-installed commands
			print(line)
    	end
	end

	if cominput[1] == "fileunload" then
		loadedfile = nil
		loadedfilepath = nil
		comsuccess = 1
		print("Unloaded file, if any.")
	end

	if comsuccess == 0 then --check to see of the command was sucsessful
		if (cominput[1]) then
			print("Unknown command: " .. cominput[1])
		end
	end

end

--Thanks to user973713 on stack overflow for this string seperator
function mysplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

-- ClOS terminal mode
local function advmode()
print("*** STARTING CLOS IN TERMINAL MODE ***")
print("Begin sys info collection")
print("OS version:", osver)
print("Host OS type:", hosttype)
print("Lua version:", _VERSION, "Built for: Lua 5.1")
print("root dir:" , root)
print(" ")
print("This is a BETA VERSION, don't expect things to run smoothly.")

--if hosttype == "unixlike" then
--	io.popen("cvlc -q --play-and-exit " .. root .. slashtype .. "logon.wav"):close()
--end

vcheck = _VERSION

if not (_VERSION == "Lua 5.1") then
	print(" ")
	print("Error: ClOS is currently incompatible with lua versions other than 5.1")
	print(" ")
	restart = 0
	clspgm = 1
end

while clspgm == 0 do
	io.write("ClOS@" .. lfs.currentdir() .. " >")
	io.flush()
	command(mysplit(io.read(), " "))
end
end

-- save the list of installed commands
function saveinstalllist()
file = io.open("installedprograms.txt", "w")
file:write("")
file:close()
file = io.open("installedprograms.txt", "a")
for i,line in ipairs(installedcommands) do
	file:write(line, "\n")
end
file:close()
end

-- save the list of installed UIs
function saveuilist()
file = io.open("UIs.txt", "w")
file:write("")
file:close()
file = io.open("UIs.txt", "a")
for i,line in ipairs(installeduis) do
	file:write(line, "\n")
end
file:close()
end

-- bootloader screen will go here once I figure out how to render GUIs, for now it's hardcoded to go to advanced mode
while restart == 1 do
	clspgm = 0
	if hosttype == "microsoft" then
		os.execute("CLS")
	else
		os.execute("clear")
	end
	advmode()
	lfs.chdir(root)
end

--if hosttype == "unixlike" then
--	io.popen("cvlc -q --play-and-exit " .. root .. slashtype .. "logoff.wav"):close()
--end

saveinstalllist() -- save installed commands before quitting
