function spam_callback(event, origin, params)
	local parts = str_split_max(params[2], " ", 2)
	if parts[1] == "!spam" then
		spam(parts[2], origin, params[1])
	elseif parts[1] == "!rainbow" then
		rainbow(parts[2], origin, params[1])
	elseif parts[1] == "!bigrainbow" then
		bigrainbow(parts[2], origin, params[1])
	elseif parts[1] == "!biggerrainbow" then
		biggerrainbow(parts[2], origin, params[1])
	end
end
register_callback("CHANNEL", "spam_callback")


function spam(word,user,target)
	local buffer,buffer2 = "",""
	while buffer2:len() < 400 do
		for i,v in pairs(str_split(word," ")) do
			local c1,c2 = math.random(0,15),math.random(0,15)
			while c1==c2 do
				c2 = math.random(0,15)
			end
			buffer2 = buffer2 .. string.char(3) .. c1 .. "," .. c2 .. v .. string.char(15) .. " "
		end
	end
	irc_msg(target,buffer2:gsub("^%s*(.-)%s*$","%1"))
end

bot_addHook("spam",spam)

function rainbow(word,user,target)
	local f = io.popen("toilet -f term -F gay --irc > /tmp/denice_rainbow","w")
	f:write(word)
	f:close()
	local f = io.open("/tmp/denice_rainbow")
	local buffer = f:read("*line")
	f:close()
	irc_msg(target,buffer)
end

function bigrainbow(word,user,target)
	if word:len() > 256 then
		word=user.nick.." is a big gay fag!"
	end
	local f = io.popen("toilet -f future -F gay --irc > /tmp/denice_rainbow","w")
	f:write(word)
	f:close()
	local f = io.open("/tmp/denice_rainbow")
	repeat 
		local buffer = f:read("*line")
		irc_msg(target,buffer)
	until buffer == nil
	f:close()
end

function biggerrainbow(word,user,target)
        if word:len() > 128 then
                word=user.nick.." is a big gay fag!"
        end
        local f = io.popen("toilet -f mono9 -F gay --irc > /tmp/denice_rainbow","w")
        f:write(word)
        f:close()
        local f = io.open("/tmp/denice_rainbow")
        repeat
                local buffer = f:read("*line")
                irc_msg(target,buffer)
        until buffer == nil
        f:close()
end
