local name, tbdui = ...;

TheBoringDadsMenuGridviewItemMixin = {}

function TheBoringDadsMenuGridviewItemMixin:OnLoad()
    
end

function TheBoringDadsMenuGridviewItemMixin:SetDataBinding(binding)

    self.label:SetText(binding.label)

    if binding.icon then
        if type(binding.icon) == "string" then
            self.icon:SetAtlas(binding.icon, true)
        else
            self.icon:SetTexture(binding.icon)
        end
    end

    self:SetScript("OnMouseDown", binding.onMouseDown)
end

function TheBoringDadsMenuGridviewItemMixin:ResetDataBinding()
    
end

TheBoringDadsBasicListviewItemMixin = {}

function TheBoringDadsBasicListviewItemMixin:OnLoad()
    
end

function TheBoringDadsBasicListviewItemMixin:SetDataBinding(binding, height)

    self:SetHeight(height)

    self.label:SetText(binding.label)

    if binding.onMouseDown then
        self:SetScript("OnMouseDown", binding.onMouseDown)
    end
end

function TheBoringDadsBasicListviewItemMixin:ResetDataBinding()
    
end