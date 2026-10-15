
-- PHANTOM
-- Pages/Settings.lua

local Settings = {}

Settings.Title = "Ajustes"

Settings.Options = {
    ShowStatus = true,
    CompactMode = false,
}

function Settings:GetOption(name)
    return self.Options[name]
end

function Settings:SetOption(name, value)
    if self.Options[name] == nil then
        return false
    end

    if type(value) ~= "boolean" then
        return false
    end

    self.Options[name] = value
    return true
end

return Settings
