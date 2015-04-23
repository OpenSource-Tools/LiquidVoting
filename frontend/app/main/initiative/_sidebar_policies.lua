local area = param.get("area", "table")

ui.sidebar ( "tab tab-initiative-policies", function ()
  ui.sidebarHead( function()
    ui.heading { 

            attr = { class = 'h2' },
            level = 2, content = _"Available policies" }
  end )
  execute.view { module = "policy", view = "_list", params = {
    for_area = area
  } }
end )
