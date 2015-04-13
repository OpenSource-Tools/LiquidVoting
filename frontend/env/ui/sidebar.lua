function ui.sidebar ( arg1, arg2 )

  local class = ""
  local content
  
  if arg2 then
    class =  arg1
    content = arg2
  else
    content = arg1
  end

  slot.select ( "sidebar", function ()
    ui.container { attr = { class = class }, content = content }
  end )

end
