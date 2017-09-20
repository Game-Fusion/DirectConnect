-- By Mr_Iron2 and Gonow32
-- DirectConnect is a Game Fusion entity
-- Master server that dictates the DConnect status

--rs.setOutput("back",true)
term.clear()
term.setCursorPos(1,1)
print("DirectConnect Server")
local online = true
 
if online == true then
  print("Current Status: Online")
else
  print("Current Status: Shut Down")
end
 
local modem = peripheral.find("modem")
modem.open(1916)
 
while true do
  local e = {os.pullEvent()}
  if e[1] == "modem_message" then
    if e[3] == 1916 then
      if type(e[5]) == "table" then
        if e[5].sType then
          if e[5].sType == "status" then
            if online == true then
              modem.transmit(1916, 1916, {sType = "status", sContents = "Online"})
            elseif online == false then
              modem.transmit(1916, 1916, {sType = "status", sContents = "Shutdown"})
            else
              modem.transmit(1916, 1916, {sType = "status", sContents = "Offline"})
            end
            elseif e[5].sType == "disconnect" then
              modem.transmit(1916, 1916, {sType = "disconnect", sContents = "A player has disconnected"})
         -- elseif type(e[5].sType) == "table" then
           -- if e[5].sType.func == "chat_msg" then
        --      plr = e[5].sType.player
            --  msg = e[5].sType.message
          --    send = e[5].sType.sender
             -- modem.transmit(30000, 30000, {sType = {func="recievemsg",sender=sender,player=plr,message=msg}}
          end
        end
      end
    end
  end
end
