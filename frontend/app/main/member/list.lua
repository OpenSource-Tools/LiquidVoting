ui.title(function()
        ui.tag { tag = 'li', content = _"Member list",
                attr = { class = 'last', }
        }
end)

local members_selector = Member:new_selector()
  :add_where("activated NOTNULL")

ui.section('section-all-members', function()

  ui.sectionHead( function()
    ui.heading { level = 1, content = _"Member list" }
  end )

  ui.sectionRow( function()
    execute.view{
      module = "member",
      view = "_list",
      params = { members_selector = members_selector }
    }
  end )
end    )
