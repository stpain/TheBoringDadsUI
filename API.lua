local name, addon = ...;

--[[
    This section allows other addons to interact with the base UI
]]

--Public
TheBoringDad = {}

---Register a module
---@param mod frame the frame to register
function TheBoringDad:RegisterModule(mod)
    addon:TriggerEvent("AddonModule_OnRegistered", mod)
end
