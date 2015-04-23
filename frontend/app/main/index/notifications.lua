if app.session.member then
  ui.title(function()
          ui.tag{ tag = 'li', attr = {class = 'last'},
          content = _"Notifications"
  }end)
    
  ui.section('section-notifications', function() 

    ui.sectionHead( function()
      ui.heading{ level = 1, content = _"Notifications" }
    end )
  
    ui.sectionRow( function()
      execute.view { module = "index", view = "_sidebar_notifications" }
    end ) 
  end )
end
