function ui.title ( content )
  
  slot.select ( "title", function ()
    
    -- home link
    ui.tag { tag = 'ul', content = function()
            ui.tag { tag = 'li', attr = { class = 'home' }, content = function() 
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
