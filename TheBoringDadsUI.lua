
-- Files created on: 2023-05-20 17:52:08.729624

local addonName, addon = ...;

TheBoringDadsMixin = {
    modules = {},
}

function TheBoringDadsMixin:OnLoad()

    self.home:SetScript("OnClick", function()
        for name, frame in pairs(self.modules) do
            frame:Hide()
        end
        self.content.gridview:Show()
    end)

    self.reloadui:SetScript("OnClick", ReloadUI)
    
    self:RegisterForDrag("LeftButton")
    self.resize:Init(self, 710, 500)

    self.resize:HookScript("OnMouseDown", function()
        self.isRefreshEnabled = true;
    end)
    self.resize:HookScript("OnMouseUp", function()
        self.isRefreshEnabled = false;
    end)

    self.content.gridview:SetMinMaxSize(120, 210)
    self.content.gridview:InitFramePool("FRAME", "TheBoringDadsMenuGridviewItemTemplate")

    self:RegisterEvent("ADDON_LOADED");
    self:RegisterEvent("PLAYER_ENTERING_WORLD");

    addon:RegisterCallback("AddonModule_OnRegistered", self.AddonModule_OnRegistered, self)
    addon:RegisterCallback("Database_OnInitialised", self.Database_OnInitialised, self)

end

function TheBoringDadsMixin:OnUpdate()
    if not self:IsVisible() then
        return
    end
    if self.isRefreshEnabled then
        self:UpdateUI()
    end
end

function TheBoringDadsMixin:UpdateUI()
    self.content.gridview:UpdateLayout()

    for k, module in pairs(self.modules) do
        if module.UpdateLayout then
            module:UpdateLayout()
        end
    end
end


function TheBoringDadsMixin:OnEvent(event, ...)

    --DevTools_Dump({event, ...})
    
    if event == "PLAYER_ENTERING_WORLD" then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD");
        addon.db:Init();
    end
end

function TheBoringDadsMixin:AddonModule_OnRegistered(module)

    --DevTools_Dump(module.launcher)

    if self.modules[module.launcher.name] then
        
        return
    end
    
    if type(module.launcher) == "table" then
        self.modules[module.launcher.name] = module;
        module:SetParent(self.content)
        module:SetAllPoints()
        module:Hide()

        self.content.gridview:Insert({
            launcher = module.launcher,
            onMouseDown = function()
                self:SelectModule(module.launcher.name)
            end,
        })
    end
end

function TheBoringDadsMixin:SelectModule(module)
    self.content.gridview:Hide()
    for name, frame in pairs(self.modules) do
        frame:Hide()
    end
    self.modules[module]:Show()
end

function TheBoringDadsMixin:Database_OnInitialised()
    self:CreateMinimapButton()
end

function TheBoringDadsMixin:CreateMinimapButton()
    local ldb = LibStub("LibDataBroker-1.1")
    local launcher = ldb:NewDataObject(addonName, {
        type = "launcher",
        icon = 134939,
        OnClick = function(_, button)
            self:SetShown(not self:IsVisible())
        end,
        OnEnter = function(self)
            GameTooltip:SetOwner(self, "ANCHOR_LEFT")
            GameTooltip:AddLine(addonName)
            GameTooltip:Show()
        end,
        OnLeave = function()
            GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
        end
    })
    self.minimapButton = LibStub("LibDBIcon-1.0")
    self.minimapButton:Register(addonName, launcher, TBD_DB.minimapButton)
end

