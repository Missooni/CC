function saveOGs()
	local ogTbl = {
	term.getBackgroundColor(),
	term.getTextColor(),
	term.getCursorPos(),
	}
	return ogTbl
end

function restoreOGs(ogTbl)
	term.setBackgroundColor(ogTbl[1])
	term.setTextColor(ogTbl[2])
	term.setCursorPos(ogTbl[3], ogTbl[4])
end

function label(x, y, text, w, c1, c2)
	local ogTbl = saveOGs()
	paintutils.drawLine(x, y, x+w, y, c2)
	local mX, mY = term.getCursorPos()
	term.setCursorPos(mX-(math.floor(w/2+0.5))-(math.floor(#text/2+0.5)), mY)
	term.setTextColor(c1)
	write(text)
	restoreOGs(ogTbl)
end

function safe(x, y, w, c1, c2, def, c3)
	return field(x, y, w, c1, c2, def, c3, true)
end

function field(x, y, w, c1, c2, def, c3, prot)
	regionTbl = {
	["x"] = x,
	["y"] = y,
	["xw"] = x+w,
	["ctbl"] = {
	c1,
	c2,
	c3,
	},
	["input"] = "",
	["def"] = def,
	["prot"] = prot,
    ["label"] = function()
                label(x, y, " ", w, c1, c2) 
	            end,
	}
	return regionTbl
end

function build(formTbl, submitFunc, x, y, w, c1, c2, text)
	if not text then text = " " end
	label(x, y, text, w, c1, c2)
	local ogTbl = saveOGs()
	local form = {
		["sel"] = 1,
		["total"] = 0,
		["x"] = x,
		["y"] = y,
		["xw"] = x+w,
		}
	for key, val in pairs(formTbl) do
		form.total = form.total + 1
		val.label()
		update(formTbl, {["sel"] = key})
	end
	update(formTbl, {["sel"] = 1})
	os.sleep(0.15)
	handle(formTbl, form)
	restoreOGs(ogTbl)
    submitFunc(formTbl)
end

function handle(formTbl, form)
	local pause = false
	local active = true
	local event, button, mX, mY = os.pullEvent()
	for key, val in pairs(formTbl) do
		if event == "mouse_click" and mX >= val.x and mX <= val.xw and mY == val.y and form.sel ~= key then
			form.sel = key 
        elseif event == "char" and key == form.sel then
			val.input = val.input..button
		elseif button == keys.backspace and key == form.sel then
			val.input = string.sub(val.input, 1, #val.input-1)
			os.sleep(0.15)
		elseif not pause and button == keys.tab then
			if form.total ~= form.sel then
			form.sel = form.sel+1
			else
			form.sel = 1
			end
			os.sleep(0.2)
			pause = true
		elseif not pause and button == keys.leftCtrl and form.sel ~= 1 then
			form.sel = form.sel-1
			os.sleep(0.2)
			pause = true
		elseif button == keys.enter and form.total == form.sel then
			active = false
		elseif event == "mouse_click" and mX >= form.x and mX <= form.xw and mY == form.y then
			active = false
		end
	update(formTbl, form)
	end
	if active then
	handle(formTbl, form)
	else
	term.setCursorBlink(false)
	end
end

function update(formTbl, form)
	local val = formTbl[form.sel]
	formTbl[form.sel].label()
	term.setCursorBlink(false)
	term.setCursorPos(val.x, val.y)
	term.setBackgroundColor(val.ctbl[2])
	if val.def and val.input == "" then
	term.setTextColor(val.ctbl[3])
	write(val.def)
	term.setCursorBlink(true)
	elseif val.input then
	term.setTextColor(val.ctbl[1])
	local w = val.xw-val.x
		if #val.input > w then
			if not val.prot then
			write(string.sub(val.input, -w-1))
			else
			write(string.sub(string.rep("*", #val.input), -w-1))
			end
		else
			if not val.prot then
			write(val.input)
			else
			write(string.rep("*", #val.input))
			end
		end
		term.setCursorBlink(true)
	end	
end

return { build = build, label = label, field = field, safe = safe}
