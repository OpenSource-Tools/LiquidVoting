-- ========================================================================
-- DO NOT CHANGE ANYTHING IN THIS FILE
-- (except when you really know what you are doing!)
-- ========================================================================

config.app_version = "3.0.6"

if not config.password_hash_algorithm then
  config.password_hash_algorithm = "crypt_sha512"
end

if not config.password_hash_min_rounds then
 config.password_hash_min_rounds = 10000
end

if not config.password_hash_max_rounds then
  config.password_hash_max_rounds = 20000
end

if config.enabled_languages == nil then
  config.enabled_languages = { 'en', 'de', 'ka' } --, 'eo', 'el', 'hu', 'it', 'nl', 'zh-Hans', 'zh-TW' }
end

if config.default_lang == nil then
  config.default_lang = "en"
end

if config.mail_subject_prefix == nil then
  config.mail_subject_prefix = "[LiquidFeedback] "
end

if config.member_image_content_type == nil then
  config.member_image_content_type = "image/jpeg"
end

if config.member_image_convert_func == nil then
  config.member_image_convert_func = {
    avatar = function(data) return extos.pfilter(data, "convert", "jpeg:-", "-thumbnail",   "48x48", "jpeg:-") end,
    photo =  function(data) return extos.pfilter(data, "convert", "jpeg:-", "-thumbnail", "240x240", "jpeg:-") end
  }
end

if config.locked_profile_fields == nil then
  config.locked_profile_fields = {}
end

if config.check_delegations_default == nil then
  config.check_delegations_default = "confirm"
end

if config.ldap == nil then
  config.ldap = {}
end

if not config.database then
  config.database = { engine='postgresql', dbname='liquid_feedback' }
end

request.set_404_route{ module = 'index', view = '404' }

request.set_absolute_baseurl(config.absolute_base_url)

-- TODO abstraction
-- get record by id
function mondelefant.class_prototype:by_id(id)
  local selector = self:new_selector()
  selector:add_where{ 'id = ?', id }
  selector:optional_object_mode()
  return selector:exec()
end

-- compatibility for WebMCP 1.2.6
if not listen then
  
  WEBMCP_BASE_PATH = request.get_app_basepath()

  -- workaround bug in WebMCP 1.2.6
  if not string.find(WEBMCP_BASE_PATH, "/$") then
    WEBMCP_BASE_PATH = WEBMCP_BASE_PATH .. "/"
  end
  
  -- open and set default database handle
  _G.db = assert(mondelefant.connect(config.database))

  function mondelefant.class_prototype:get_db_conn() return db end

  -- close the database at exit
  at_exit(function() 
    db:close()
  end)
  
  function request.get_cookie(args)
    return cgi.cookies[args.name]
  end
  
  function request.get_param(args)
    if args.meta then
      return { content_type = cgi.post_types[image_type] }
    else
      return request.get_param_strings()[args.name]
    end
    
  end
  
  function request.add_header(key, value)
    print(key .. ": " .. value)
  end
  
  local request_redirect = request.redirect
  function request.redirect(args)
    if args.static then
      print('Location: ' .. encode.url{ static = args.static } .. '\n\n')
      exit()
    else
      request_redirect(args)
    end
  end

  function request.allow_caching()
    request.add_header("Cache-Control", "max-age=3600");
  end

end
