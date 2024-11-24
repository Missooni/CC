local forms = require("forms")

-- Create text fields and put them into a table, 'safe' fields will show input with asterisks.
-- forms.field(submitX, submitY, submitWidth, textColor, bgColor, defaultText, defaultColor) 
-- defaultText and defaultColor are optional parameters.
formContents = {
forms.field(2,3,5,colors.black,colors.white),
forms.field(9,3,5,colors.black,colors.white),
forms.safe(2,5,12,colors.black,colors.white),
}

term.clear()
print("Text Form:")

-- Build the text form and wait for input, nothing else will run until the 'Submit' button is pressed.
-- Syntax:
-- forms.build(tableWithFields, submitFunction, submitX, submitY, submitWidth, textColor, bgColor, defaultText) 
forms.build(
formContents,
function(results)
	term.setCursorPos(1,9)
	print("Submitted Form!")
	print("Results:")
	for i, v in pairs(results) do
	print(i..": "..v.input)
	end
	term.setCursorPos(1,20)
end,
3,7,10,colors.white,colors.red,"Submit")
