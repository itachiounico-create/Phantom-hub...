
--[[
    PHANTOM UI
    Modulo responsavel pela interface
]]

local PhantomUI = {}

PhantomUI.State = {
    IsOpen = false,
    IsInitialized = false,
}

function PhantomUI:Init()
    if self.State.IsInitialized then
        return false
    end

    self.State.IsInitialized = true

    print("[PHANTOM UI] Modulo preparado!")

    return true
end

function PhantomUI:Toggle()
    self.State.IsOpen = not self.State.IsOpen

    return self.State.IsOpen
end

function PhantomUI:IsOpen()
    return self.State.IsOpen
end

function PhantomUI:Destroy()
    self.State.IsOpen = false
    self.State.IsInitialized = false
end

return PhantomUI
