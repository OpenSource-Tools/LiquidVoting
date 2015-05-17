local area = param.get("area", "table")
local member = param.get("member", "table")


local subscribed = area.delegation_info.own_participation
local delegated  = area.delegation_info.first_trustee_id
local class = 'area'
if subscribed then class = class .. ' subscribed' end
if delegated then class = class .. ' delegated' end

ui.title ( function ()

  ui.tag { tag = 'li', attr = { class = 'unit' }, content = function()
    ui.link {
      attr = { class = "unit" },
      content = function()
        ui.tag{ content = function() 
                ui.tag{ tag = 'span', content = area.unit.name  }
        end}
      end,
      module = "unit", view = "show",
      id = area.unit.id
    }
  end }

  ui.tag { tag = 'li', attr = { class = class }, content = function()
      ui.link {
        content = function()
          ui.tag{ content = function()
                ui.tag{ tag = 'span', content = area.name  }
        end}
        end,
        module = "area", view = "show",
        id = area.id
      }
      
      execute.view {
        module = "delegation", view = "_info", params = { 
          area = area, member = member, for_title = true
        }
      }
  end }
  ;
end )
