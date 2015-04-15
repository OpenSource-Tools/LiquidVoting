function ui.titleAdmin(title)
  ui.title(function()
    ui.tag { tag = 'li', content = function()
    if title then
      ui.link { module = "admin", view = "index", content = _"System administration" }
    else
      ui.tag{ content = _"System administration" }
    end
    if title then
      ui.tag { tag = "span", content = title }
    end
    end, attr = { class = 'last' } }
  end)
end
