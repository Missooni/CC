    -- Get the terminal width so that we can wrap text in blockquotes.
    local termX, termY = term.getSize()
    -- Make an empty table for all of the lines from the text file to be stored.
    local lines = {}
     
    -- Reads the text file and stores all lines in our table.
    for line in io.lines("text.txt") do
      table.insert(lines, line)
    end
     
    -- Reads each of the lines and performs an action depending on the syntax.
    for i, str in pairs(lines) do
      if str:find(">") and str:sub(1,1) == ">" then
    -- The 'pos' variable is created so that it can parse text that is written >like this and > like this.
      local pos = 2
      if str:find("> ") then pos = 3 end
      str = str:sub(pos)
    -- If the string is longer than the terminal width it will cut it down and re-add entries to the table.
      if #str > termX - 3 then 
      table.insert(lines, i+1, ">"..str:sub(termX - 3))
      str = str:sub(0,(termX - 3))
      end
    -- Adds a unicode symbol and two spaces in front of formatted text.
      str = "\149  "..str
      end
      print(str)
    end
