local issue = param.get("issue", "table")
local for_history = param.get("for_history", atom.boolean)

ui.sectionHead( "issueInfo", function ()
  ui.container { attr = { class = "title" }, content = function()
    ui.heading { level = 1, content = issue.name }
  end }
  if app.session.member then

    local interested = (not issue.closed) and issue.member_info.own_participation
    klass = "btn-interest"
    if interested then klass = klass .. " interested" end
    ui.container { attr = { class =  klass }, content = function ()
      if issue.fully_frozen then
        if issue.member_info.direct_voted then
          ui.image { attr = { class = "icon48 right" }, static = "icons/48/voted_ok.png" }
          ui.tag { content = _"You have voted" }
          slot.put(" ")
          if not issue.closed then
            slot.put("<br />")
            ui.link {
              module = "vote", view = "list", 
              params = { issue_id = issue.id },
              text = _"change vote"
            }
          else
            ui.link {
              module = "vote", view = "list", 
              params = { issue_id = issue.id },
              text = _"show vote"
            }
          end
          slot.put(" ")
        elseif active_trustee_id then
          ui.tag { content = _"You have voted via delegation" }
          ui.link {
            content = _"Show voting ballot",
            module = "vote", view = "list", params = {
              issue_id = issue.id, member_id = active_trustee_id
            }
          }
        elseif not issue.closed then
          ui.link {
            attr = { class = "btn btn-default" },
            module = "vote", view = "list", 
            params = { issue_id = issue.id },
            text = _"vote now"
          }
        end
      elseif not issue.closed then
        if issue.member_info.own_participation then
          -- ui.image { attr = { class = "icon48 right" }, static = "icons/48/eye.png" }
          slot.put("<br />")
          ui.tag{ content = _"You are interested in this issue" }
          slot.put("<br />")
          ui.i {
          content = function()
            end,
            attr = { class = "fa fa-bell" }
          }
          ui.link {
            module = "interest", action = "update", 
            params = { issue_id = issue.id, delete = true },
            routing = { default = {
              mode = "redirect", module = "issue", view = "show", id = issue.id
            } },
            text = _"remove my interest"
          }
        else
          slot.put("<br />")
          ui.i {
          content = function()
            end,
            attr = { class = "fa fa-bell" }
          }
          ui.link {
            module = "interest", action = "update", 
            params = { issue_id = issue.id },
            routing = { default = {
              mode = "redirect", module = "issue", view = "show", id = issue.id
            } },
            text = _"add my interest"
          }
        end
      end
    end }
  end
end)
  
ui.container {
  attr = { class = "tabs" }, content = function ()
    ui.link{
      attr = { class = not for_history and "active" or nil },
      text = _"Initiatives",
      module = "issue", view = "show", id = issue.id
    }
    slot.put(" ")
    ui.link{
      attr = { class = for_history and "active" or nil },
      text = _"History",
      module = "issue", view = "history", id = issue.id
    }
  end
}
