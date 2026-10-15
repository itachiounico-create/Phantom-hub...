
--[[
    PHANTOM
    Main.lua
    Versao: 0.1.0
]]

local Phantom = {}

Phantom.Name = "PHANTOM"
Phantom.Version = "0.1.0"
Phantom.Initialized = false

function Phantom:Init()
    if self.Initialized then
        return
    end

    self.Initialized = true

    print("[PHANTOM] Inicializado!")
    print("[PHANTOM] Versao: " .. self.Version)
end

function Phantom:GetInfo()
    return {
        Name = self.Name,
        Version = self.Version,
        Initialized = self.Initialized,
    }
end

Phantom:Init()

return Phantom
