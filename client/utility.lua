local function line(y)
  term.setCursorPos(1,y)
  term.clearLine()
end
 
 
local function topmenu()
  term.setBackgroundColour(colours.blue)
  term.clear()
  term.setBackgroundColour(colours.white)
  term.setTextColour(colours.blue)
  line(2)
  line(3)
  line(4)
  center(3,"DirectConnect Utility")
end
 
topmenu()
line(7)
line(8)
line(9)
line(10)
line(11)
center(8,"Welcome to the DirectConnect Utility!")
center(9,"Here, we will test your connection and attempt")
center(10,"to connect to the DirectConnect servers.")
sleep(1.75)
  if not peripheral.find("modem") then
  topmenu()
  line(7)
  line(8)
  line(9)
  center(8,"There is no modem attached!")
  center(9,"Please attach a modem, then retry.")
  sleep(2)
  
  elseif peripheral.find("modem") then
  topmenu()
  line(7)
  line(8)
  line(9)
  line(10)
  center(8,"Attempting Connection...")
  sleep(1)
  local modem = peripheral.find("modem")
  modem.open(1916)
  modem.transmit(1916, 1916, {sType = "status"})
  local t = os.startTimer(3)
  while true do
  local e = {os.pullEvent()}
  if e[1] == "modem_message" then
    if e[3] == 1916 then
      if type(e[5]) == "table" then
        if e[5].sType then
          if e[5].sType == "status" then
            if e[5].sContents == "Offline" then
            topmenu()
            line(7)
            line(8)
            line(9)
            line(10)
            center(8,"Connection Failed:")
            center(9,"DirectConnect Servers are currently offline.")
            sleep(3)
            shell.run("/GS/Menu")
            elseif e[5].sContents == "Shutdown" then
              topmenu()
              line(7)
              line(8)
              line(9)
              line(10)
              center(8,"Connection Failed:")
              center(9,"The DirectConnect Service has been terminated.")
              sleep(3)
              shell.run("/GS/Menu")
            elseif e[5].sContents == "Online" then
              topmenu()
              line(7)
              line(8)
              line(9)
              line(10)
              center(8,"Connection Successful!")
              center(9,"All DirectConnect systems online.")
              sleep(3)
              shell.run("/GS1/Menu")
              end
             end
            end
           end
          end
         elseif e[1] == "timer" then topmenu()
         line(7)
         line(8)
         line(9)
         line(10)
         center(8,"Connection Failed:")
         center(9,"The DirectConnect Servers did not respond.")
         sleep(2)
         error("Timed out.")
        end
    end
end
