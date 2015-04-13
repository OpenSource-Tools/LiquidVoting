local issue = param.get("issue", "table")
local initiative = param.get("initiative", "table")

local member = param.get ( "member", "table" )

local unit  = param.get("unit", "table")
local area  = param.get("area", "table")
local issue = param.get("issue", "table")

ui.title ( function ()

  ui.tag { tag = 'li', attr = { class = "unit" }, content = function()
      ui.link { content = function()
          ui.tag{ tag = 'span', content = issue.area.unit.name }
        end,
        module = "unit", view = "show",
        id = issue.area.unit.id
      }
    end
  }
  ui.tag { tag = 'li', attr = { class = 'area' }, content = function()
      ui.link { content = function()
          ui.tag{ tag = 'span', content = issue.area.name }
        end,
        module = "area", view = "show",
        id = issue.area.id
      }
    end
  }

  local info        = issue.member_info
  local klass       = 'issue'
  local interested  = info.own_participation
  if interested then klass = klass .. ' interested' end
  ui.tag { tag = 'li', attr = {class =  klass}, content = function()
        ui.link {
            module = "issue", view = "show",
            id = issue.id,
            content = function()
                -- ui.tag { tag = 'span', content = issue.policy.name .. " " .. issue.id }
                ui.tag { tag = 'span', content = issue.name }
            end
            }

      -- if member then
      --   execute.view {
      --     module = "delegation", view = "_info", params = { 
      --       issue = issue, member = member, for_title = true
      --     }
      --   }
      -- end
    end
  }
  
  if initiative then
    info = initiative.member_info
    supported = info.supported
    klass = "initiative last"
    if supported then klass = klass .. " supported" end
    ui.tag{ tag = 'li', attr = { class = klass },
      content = initiative.display_name
    }
  end
  
end ) -- ui.title
