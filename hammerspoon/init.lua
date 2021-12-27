--- arrow key map
local function pressFn(mods, key)
	if key == nil then
		key = mods
		mods = {}
	end

	return function() hs.eventtap.keyStroke(mods, key, 1000) end
end

local function remap(mods, key, pressFn)
	hs.hotkey.bind(mods, key, pressFn, nil, pressFn)	
end


remap({'ctrl'}, 'h', pressFn('left'))
remap({'ctrl'}, 'j', pressFn('down'))
remap({'ctrl'}, 'k', pressFn('up'))
remap({'ctrl'}, 'l', pressFn('right'))

remap({'ctrl', 'shift'}, 'h', pressFn({'shift'}, 'left'))
remap({'ctrl', 'shift'}, 'j', pressFn({'shift'}, 'down'))
remap({'ctrl', 'shift'}, 'k', pressFn({'shift'}, 'up'))
remap({'ctrl', 'shift'}, 'l', pressFn({'shift'}, 'right'))

remap({'ctrl', 'cmd'}, 'h', pressFn({'cmd'}, 'left'))
remap({'ctrl', 'cmd'}, 'j', pressFn({'cmd'}, 'down'))
remap({'ctrl', 'cmd'}, 'k', pressFn({'cmd'}, 'up'))
remap({'ctrl', 'cmd'}, 'l', pressFn({'cmd'}, 'right'))

remap({'ctrl', 'alt'}, 'h', pressFn({'alt'}, 'left'))
remap({'ctrl', 'alt'}, 'j', pressFn({'alt'}, 'down'))
remap({'ctrl', 'alt'}, 'k', pressFn({'alt'}, 'up'))
remap({'ctrl', 'alt'}, 'l', pressFn({'alt'}, 'right'))

remap({'ctrl', 'shift', 'cmd'}, 'h', pressFn({'shift', 'cmd'}, 'left'))
remap({'ctrl', 'shift', 'cmd'}, 'j', pressFn({'shift', 'cmd'}, 'down'))
remap({'ctrl', 'shift', 'cmd'}, 'k', pressFn({'shift', 'cmd'}, 'up'))
remap({'ctrl', 'shift', 'cmd'}, 'l', pressFn({'shift', 'cmd'}, 'right'))

remap({'ctrl', 'shift', 'alt'}, 'h', pressFn({'shift', 'alt'}, 'left'))
remap({'ctrl', 'shift', 'alt'}, 'j', pressFn({'shift', 'alt'}, 'down'))
remap({'ctrl', 'shift', 'alt'}, 'k', pressFn({'shift', 'alt'}, 'up'))
remap({'ctrl', 'shift', 'alt'}, 'l', pressFn({'shift', 'alt'}, 'right'))

remap({'ctrl', 'cmd', 'alt'}, 'h', pressFn({'cmd', 'alt'}, 'left'))
remap({'ctrl', 'cmd', 'alt'}, 'j', pressFn({'cmd', 'alt'}, 'down'))
remap({'ctrl', 'cmd', 'alt'}, 'k', pressFn({'cmd', 'alt'}, 'up'))
remap({'ctrl', 'cmd', 'alt'}, 'l', pressFn({'cmd', 'alt'}, 'right'))

remap({'ctrl', 'cmd', 'alt', 'shift'}, 'h', pressFn({'cmd', 'alt', 'shift'}, 'left'))
remap({'ctrl', 'cmd', 'alt', 'shift'}, 'j', pressFn({'cmd', 'alt', 'shift'}, 'down'))
remap({'ctrl', 'cmd', 'alt', 'shift'}, 'k', pressFn({'cmd', 'alt', 'shift'}, 'up'))
remap({'ctrl', 'cmd', 'alt', 'shift'}, 'l', pressFn({'cmd', 'alt', 'shift'}, 'right'))



local key2App = {
    i = {'/Applications/iTerm.app', 'English', 2},
    f = {'/System/Library/CoreServices/Finder.app', 'English', 1},
    -- d = {'/Applications/Dash.app', 'English', 1}
    -- "s" = {'/Applications/System Preferences.app', 'English', 1},
    -- "p" = {'/Applications/Preview.app', 'Chinese', 2},
    -- "b" = {'/Applications/MindNode.app', 'Chinese', 1},
    -- "n" = {'/Applications/NeteaseMusic.app', 'Chinese', 1},
    -- "m" = {'/Applications/Sketch.app', 'English', 2},
}

local hyper = {"ctrl", "command"}
local function English()
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end
local function Korean()
	hs.keycodes.currentSourceID("com.apple.inputmethod.Korean.2SetKorean")
end

function toggleApplication(app)
    local appPath = app[1]
    local inputMethod = app[2]

    -- Tag app path use for `applicationWatcher'.
    startAppPath = appPath

    local app = findApplication(appPath)
    local setInputMethod = true

    if not app then
        -- Application not running, launch app
        launchApp(appPath)
    else
        -- Application running, toggle hide/unhide
        local mainwin = app:mainWindow()
        if mainwin then
            if app:isFrontmost() then
				app:hide()
                setInputMethod = false
            else
                -- Focus target application if it not at frontmost.
                mainwin:application():activate(true)
                mainwin:application():unhide()
                mainwin:focus()
            end
        else
            -- Start application if application is hide.
            if app:hide() then
                launchApp(appPath)
            end
        end
    end

    if setInputMethod then
        if inputMethod == 'English' then
            English()
		else
			Korean()
		end
    end
end

function findApplication(appPath)
    local apps = hs.application.runningApplications()
    for i = 1, #apps do
        local app = apps[i]
        if app:path() == appPath then
            return app
        end
    end

    return nil
end

function launchApp(appPath)
    -- We need use Chrome's remote debug protocol that debug JavaScript code in Emacs.
    -- So we need launch chrome with --remote-debugging-port argument instead application.launchOrFocus.
    if appPath == "/Applications/Google Chrome.app" then
        hs.execute("open -a 'Google Chrome' --args '--remote-debugging-port=9222'")
    elseif appPath == "/Applications/Chromium.app" then
        hs.execute("open -a 'Chromium' --args --user-data-dir='/tmp/chrome_dev_test' --disable-web-security")
    else
        hs.application.launchOrFocus(appPath)
    end

    -- Move the application's window to the specified screen.
    for key, app in pairs(key2App) do
        local path = app[1]
        local screenNumber = app[3]

        if appPath == path then
            hs.timer.doAfter(
                1,
                function()
                    local app = findApplication(appPath)
                    local appWindow = app:mainWindow()

                    -- moveToScreen(appWindow, screenNumber, false)
            end)
            break
        end
    end
end


-- Start or focus application.
for key, app in pairs(key2App) do
    hs.hotkey.bind(
        hyper, key,
        function()
            toggleApplication(app)
    end)
end


controlhyper = {"ctrl"}
safari = {'/Applications/Safari.app', 'English', 2}
kakao = {'/Applications/KakaoTalk.app', 'Korean', 2}
xcode = {'/Applications/Xcode.app', 'English', 2}

hs.hotkey.bind(
	controlhyper, "1",
	function()
		toggleApplication(safari)
	end
)

hs.hotkey.bind(
	controlhyper, "2",
	function()
		toggleApplication(kakao)
	end
)

hs.hotkey.bind(
	controlhyper, "3",
	function()
		toggleApplication(xcode)
	end
)