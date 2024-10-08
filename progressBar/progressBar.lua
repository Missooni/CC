-- Define or alias values using a table. I'm using strings for this example.
local barTable = {"val1","val2","val3","val4","val5"}

local termWidth, termHeight = term.getSize()

-- All customizable values.
local barWidth = math.floor(termWidth*.75)
local fullChar = " "
local emptyChar = "\143"
local bg = "f"
local fg = "0"

-- Draws the empty progress bar.
local mouseX, mouseY = term.getCursorPos()
term.setCursorPos(termWidth/2-barWidth/2, mouseY)
term.blit(emptyChar:rep(barWidth), bg:rep(barWidth), fg:rep(barWidth))

-- Iterates through the table and performs an action.
for key, value in pairs(barTable) do
	os.sleep(1)

-- Draws 'full characters' to the progress bar as the action finishes.
	term.setCursorPos(termWidth/2-barWidth/2, mouseY)
	term.blit(fullChar:rep(math.floor(i / #table * barWidth)), bg:rep(math.floor(i / #table * barWidth)), fg:rep(math.floor(i / #table * barWidth)))
end

print(" Done!")
-- For this example, the program will end once any key is pressed.
os.pullEvent( "key" )
