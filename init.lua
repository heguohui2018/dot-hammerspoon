-- DO NOT EDIT THIS FILE DIRECTLY
-- This is a file generated from a literate programing source file located at
-- https://github.com/zzamboni/dot-hammerspoon/blob/master/init.org.
-- You should make any changes there and regenerate it from Emacs org-mode using C-c C-v t

hs.logger.defaultLogLevel="info"

hyper = {"cmd","alt","ctrl"}
shift_hyper = {"cmd","alt","ctrl","shift"}

col = hs.drawing.color.x11

swisscom_logo = hs.image.imageFromPath(hs.configdir .. "/files/swisscom_logo_2x.png")

hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall.repos.zzspoons = {
  url = "https://github.com/zzamboni/zzSpoons",
  desc = "zzamboni's spoon repository",
}

spoon.SpoonInstall.use_syncinstall = true

Install=spoon.SpoonInstall

Install:andUse("BetterTouchTool", { loglevel = 'debug' })
BTT = spoon.BetterTouchTool

JiraApp = "org.epichrome.app.SwisscomJ995"
WikiApp = "org.epichrome.app.SwisscomWiki"
Install:andUse("URLDispatcher",
               {
                 config = {
                   url_patterns = {
                     { "https?://issue.swisscom.ch",                       JiraApp },
                     { "https?://issue.swisscom.com",                      JiraApp },
                     { "https?://jira.swisscom.com",                       JiraApp },
                     { "https?://wiki.swisscom.com",                       WikiApp },
                     { "https?://collaboration.swisscom.com",              "org.epichrome.app.SwisscomCollab" },
                     { "https?://smca.swisscom.com",                       "org.epichrome.app.SwisscomTWP" },
                     { "https?://portal.corproot.net",                     "com.apple.Safari" },
                     { "https?://app.opsgenie.com",                        "org.epichrome.app.OpsGenie" },
                     { "https?://app.eu.opsgenie.com",                     "org.epichrome.app.OpsGenie" },
                     { "https?://fiori.swisscom.com",                      "com.apple.Safari" },
                     { "https?://pmpgwd.apps.swisscom.com/fiori",  "com.apple.Safari" },
                     { "https?://.*webex.com",  "com.google.Chrome" },
                   },
                   default_handler = "com.google.Chrome"
                   -- default_handler = "com.electron.brave"
                   -- default_handler = "com.brave.Browser.dev"
                 },
                 start = true
               }
)

Install:andUse("WindowHalfsAndThirds",
               {
                 config = {
                   use_frame_correctness = true
                 },
                 hotkeys = 'default'
               }
)

Install:andUse("WindowScreenLeftAndRight",
               {
                 hotkeys = 'default'
               }
)

Install:andUse("WindowGrid",
               {
                 config = { gridGeometries = { { "6x4" } } },
                 hotkeys = {show_grid = {hyper, "g"}},
                 start = true
               }
)

Install:andUse("ToggleScreenRotation",
               {
                 hotkeys = { first = {hyper, "f15"} }
               }
)

Install:andUse("UniversalArchive",
               {
                 config = {
                   evernote_archive_notebook = ".Archive",
                   outlook_archive_folder = "Archive (diego.zamboni@swisscom.com)",
                   archive_notifications = false
                 },
                 hotkeys = { archive = { { "ctrl", "cmd" }, "a" } }
               }
)

Install:andUse("SendToOmniFocus",
               {
                 config = {
                   quickentrydialog = false,
                   notifications = false
                 },
                 hotkeys = {
                   send_to_omnifocus = { hyper, "t" }
                 },
                 fn = function(s)
                   s:registerApplication("Swisscom Collab", { apptype = "chromeapp", itemname = "tab" })
                   s:registerApplication("Swisscom Wiki", { apptype = "chromeapp", itemname = "wiki page" })
                   s:registerApplication("Swisscom Jira", { apptype = "chromeapp", itemname = "issue" })
                   s:registerApplication("Brave Browser Dev", { apptype = "chromeapp", itemname = "page" })
                 end
               }
)

Install:andUse("EvernoteOpenAndTag",
                 {
                   hotkeys = {
                     open_note = { hyper, "o" },
--                     ["open_and_tag-+work,+swisscom"] = { hyper, "w" },
--                     ["open_and_tag-+personal"] = { hyper, "p" },
--                     ["tag-@zzdone"] = { hyper, "z" }
                   }
                 }
  )

Install:andUse("TextClipboardHistory",
               {
                 disable = true,
                 config = {
                   show_in_menubar = false,
                 },
                 hotkeys = {
                   toggle_clipboard = { { "cmd", "shift" }, "v" } },
                 start = true,
               }
)

Install:andUse("Hammer",
               {
                 repo = 'zzspoons',
                 config = { auto_reload_config = false },
                 hotkeys = {
                   config_reload = {hyper, "r"},
                   toggle_console = {hyper, "y"}
                 },
                 fn = function(s)
                   BTT:bindSpoonActions(s,
                                        { config_reload = {
                                            kind = 'touchbarButton',
                                            uuid = "FF8DA717-737F-4C42-BF91-E8826E586FA1",
                                            name = "Restart",
                                            icon = hs.image.imageFromName(hs.image.systemImageNames.ApplicationIcon),
                                            color = hs.drawing.color.x11.orange,
                                        }
                   })
                 end,
                 start = true
               }
)

Install:andUse("Caffeine", {
                 start = true,
                 hotkeys = {
                   toggle = { hyper, "1" }
                 },
                 fn = function(s)
                   BTT:bindSpoonActions(s, {
                                          toggle = {
                                            kind = 'touchbarWidget',
                                            uuid = '72A96332-E908-4872-A6B4-8A6ED2E3586F',
                                            name = 'Caffeine',
                                            widget_code = [[
do
  title = " "
  icon = hs.image.imageFromPath(spoon.Caffeine.spoonPath.."/caffeine-off.pdf")
  if (hs.caffeinate.get('displayIdle')) then
    icon = hs.image.imageFromPath(spoon.Caffeine.spoonPath.."/caffeine-on.pdf")
  end
  print(hs.json.encode({ text = title, icon_data = BTT:hsimageToBTTIconData(icon) }))
end
  ]],
                                            code = "spoon.Caffeine.clicked()",
                                            widget_interval = 1,
                                            color = hs.drawing.color.x11.black,
                                            icon_only = true,
                                            icon_size = hs.geometry.size(15,15),
                                            BTTTriggerConfig = {
                                              BTTTouchBarFreeSpaceAfterButton = 0,
                                              BTTTouchBarItemPadding = -6,
                                            },
                                          }
                   })
                 end
})

Install:andUse("MenubarFlag",
               {
                 config = {
                   colors = {
                     ["U.S."] = { },
                     Spanish = {col.green, col.white, col.red},
                     German = {col.black, col.red, col.yellow},
                   }
                 },
                 start = true
               }
)

Install:andUse("MouseCircle",
               {
                 disable = true,
                 config = {
                   color = hs.drawing.color.x11.rebeccapurple
                 },
                 hotkeys = {
                   show = { hyper, "m" }
                 }
               }
)

Install:andUse("ColorPicker",
               {
                 hotkeys = {
                   show = { hyper, "z" }
                 },
                 config = {
                   show_in_menubar = false,
                 },
                 start = true,
               }
)

Install:andUse("BrewInfo",
               {
                 config = {
                   brew_info_style = {
                     textFont = "Inconsolata",
                     textSize = 14,
                     radius = 10 }
                 },
                 hotkeys = {
                   -- brew info
                   show_brew_info = {hyper, "b"},
                   open_brew_url = {shift_hyper, "b"},
                   -- brew cask info
                   show_brew_cask_info = {hyper, "c"},
                   open_brew_cask_url = {shift_hyper, "c"},
                 }
               }
)

Install:andUse("TimeMachineProgress",
               {
                 start = true
               }
)

Install:andUse("ToggleSkypeMute",
               {
                 hotkeys = {
                   toggle_skype = { shift_hyper, "v" },
                   toggle_skype_for_business = { shift_hyper, "f" }
                 }
               }
)

Install:andUse("HeadphoneAutoPause",
               {
                 start = true
               }
)

Install:andUse("Seal",
               {
                 hotkeys = { show = { {"cmd"}, "space" } },
                 fn = function(s)
                   s:loadPlugins({"apps", "calc", "safari_bookmarks", "screencapture", "useractions"})
                   s.plugins.safari_bookmarks.always_open_with_safari = false
                   s.plugins.useractions.actions =
                     {
                         ["Hammerspoon docs webpage"] = {
                           url = "https://hammerspoon.org/docs/",
                           icon = hs.image.imageFromName(hs.image.systemImageNames.ApplicationIcon),
                         },
                         ["Leave corpnet"] = {
                           fn = function()
                             spoon.WiFiTransitions:processTransition('foo', 'corpnet01')
                           end,
                           icon = swisscom_logo,
                         },
                         ["Arrive in corpnet"] = {
                           fn = function()
                             spoon.WiFiTransitions:processTransition('corpnet01', 'foo')
                           end,
                           icon = swisscom_logo,
                         },
                         ["Translate using Leo"] = {
                           url = "http://dict.leo.org/englisch-deutsch/${query}",
                           icon = 'favicon',
                           keyword = "leo",
                         }
                     }
                   s:refreshAllCommands()
                 end,
                 start = true,
               }
)

function reconfigSpotifyProxy(proxy)
  local spotify = hs.appfinder.appFromName("Spotify")
  local lastapp = nil
  if spotify then
    lastapp = hs.application.frontmostApplication()
    spotify:kill()
    hs.timer.usleep(40000)
  end
  --   hs.notify.show(string.format("Reconfiguring %sSpotify", ((spotify~=nil) and "and restarting " or "")), string.format("Proxy %s", (proxy and "enabled" or "disabled")), "")
  -- I use CFEngine to reconfigure the Spotify preferences
  cmd = string.format("/usr/local/bin/cf-agent -K -f %s/files/spotify-proxymode.cf%s", hs.configdir, (proxy and " -DPROXY" or " -DNOPROXY"))
  output, status, t, rc = hs.execute(cmd)
  if spotify and lastapp then
    hs.timer.doAfter(3,
                     function()
                       if not hs.application.launchOrFocus("Spotify") then
                         hs.notify.show("Error launching Spotify", "", "")
                       end
                       if lastapp then
                         hs.timer.doAfter(0.5, hs.fnutils.partial(lastapp.activate, lastapp))
                       end
    end)
  end
end

function reconfigAdiumProxy(proxy)
  --   hs.notify.show("Reconfiguring Adium", string.format("Proxy %s", (proxy and "enabled" or "disabled")), "")
  app = hs.application.find("Adium")
  if app and app:isRunning() then
    local script = string.format([[
tell application "Adium"
  repeat with a in accounts
    if (enabled of a) is true then
      set proxy enabled of a to %s
    end if
  end repeat
  go offline
  go online
end tell
]], hs.inspect(proxy))
    hs.osascript.applescript(script)
  end
end

function stopApp(name)
  app = hs.application.get(name)
  if app and app:isRunning() then
    app:kill()
  end
end

function forceKillProcess(name)
  hs.execute("pkill " .. name)
end

function startApp(name)
  hs.application.open(name)
end

Install:andUse("WiFiTransitions",
               {
                 config = {
                   actions = {
                     -- { -- Test action just to see the SSID transitions
                     --    fn = function(_, _, prev_ssid, new_ssid)
                     --       hs.notify.show("SSID change", string.format("From '%s' to '%s'", prev_ssid, new_ssid), "")
                     --    end
                     -- },
                     { -- Enable proxy in Spotify and Adium config when joining corp network
                       to = "corpnet01",
                       fn = {hs.fnutils.partial(reconfigSpotifyProxy, true),
                             hs.fnutils.partial(reconfigAdiumProxy, true),
                             hs.fnutils.partial(forceKillProcess, "Dropbox"),
                             hs.fnutils.partial(stopApp, "Evernote"),
                       }
                     },
                     { -- Disable proxy in Spotify and Adium config when leaving corp network
                       from = "corpnet01",
                       fn = {hs.fnutils.partial(reconfigSpotifyProxy, false),
                             hs.fnutils.partial(reconfigAdiumProxy, false),
                             hs.fnutils.partial(startApp, "Dropbox"),
                       }
                     },
                   }
                 },
                 start = true,
               }
)

local wm=hs.webview.windowMasks
Install:andUse("PopupTranslateSelection",
               {
                 config = {
                   popup_style = wm.utility|wm.HUD|wm.titled|wm.closable|wm.resizable,
                 },
                 hotkeys = {
                   translate_to_en = { hyper, "e" },
                   translate_to_de = { hyper, "d" },
                   translate_to_es = { hyper, "s" },
                   translate_de_en = { shift_hyper, "e" },
                   translate_en_de = { shift_hyper, "d" },
                 }
               }
)

Install:andUse("DeepLTranslate",
               {
                 disable = true,
                 config = {
                   popup_style = wm.utility|wm.HUD|wm.titled|wm.closable|wm.resizable,
                 },
                 hotkeys = {
                   translate = { hyper, "e" },
                 }
               }
)

Install:andUse("Leanpub",
               {
                 config = {
                   watch_books = {
                     -- api_key gets set in init-local.lua like this:
                     -- spoon.Leanpub.api_key = "my-api-key"
                     { slug = "learning-hammerspoon" },
                     { slug = "learning-cfengine" },
                     { slug = "lit-config"  },
                     { slug = "zztestbook" },
                   }
                 },
                 start = true,
})

local localfile = hs.configdir .. "/init-local.lua"
if hs.fs.attributes(localfile) then
  dofile(localfile)
end

Install:andUse("FadeLogo",
               {
                 config = {
                   default_run = 1.0,
                 },
                 start = true
               }
)

-- hs.notify.show("Welcome to Hammerspoon", "Have fun!", "")
