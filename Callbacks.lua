local name, addon = ...;


Mixin(addon, CallbackRegistryMixin)
addon:GenerateCallbackEvents({
    "Database_OnInitialised",
    "Database_RegisterTable",

    "Module_OnLoad",
    "AddonModule_OnRegistered",
})
CallbackRegistryMixin.OnLoad(addon);

