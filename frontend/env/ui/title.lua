function ui.title ( content )
  
  slot.select ( "title", function ()
    
    -- home link
    ui.tag { tag = 'ul', content = function()
            local klass = 'home'
            local module = request.get_module()
            local view   = request.get_view()
            if module == view and view == 'index' then
                    klass = klass .. " active"
            end
            ui.tag { tag = 'li', attr = { class = klass }, content = function() 
                    ui.link {
                      module = "index", view = "index",
                      content = function() 
                        ui.i { attr = { class = 'fa fa-home' } }
                      end
                    }
            end}

            -- additional lis
            ui.tag{ content = content }
    end }
  
  end )
  
end
