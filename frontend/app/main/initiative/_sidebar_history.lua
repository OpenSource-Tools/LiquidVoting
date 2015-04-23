local initiative = param.get("initiative", "table")


ui.sidebar( function ()
  ui.sidebarHead( function ()
    ui.link { attr = { name = "history", class='history' }, text = "" }
    ui.heading { 
            attr = { class = 'h1' },
            level = 1, content = _"History" }
  end )
  execute.view {
    module = "issue", view = "_list2", params = {
      for_initiative = initiative, for_sidebar = true
    }
  }
end )
