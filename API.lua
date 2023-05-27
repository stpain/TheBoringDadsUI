local name, addon = ...;

--Public
TheBoringDad = {}

function TheBoringDad:RegisterModule(mod)
    if mod.name and mod.type then
        addon:TriggerEvent("AddonModule_OnRegistered", mod)
    end
end
