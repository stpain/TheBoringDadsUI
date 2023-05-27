

local addonName, addon = ...;

local Database = {}

function Database:Init()

    --TBD_DB = nil

    if not TBD_DB then
        TBD_DB = {
            config = {},
            minimapButton = {},
            layouts = {},
        };
    end

    self.db = TBD_DB;

    addon:TriggerEvent("Database_OnInitialised")
end

function Database:RegisterTable(dbObj)
    if dbObj.name and dbObj.db then
        if not self.db[dbObj.name] then
            self.db[dbObj.name] = dbObj.db
        end
    end
end

function Database:FetchTable(name)
    if self.db and self.db[name] then
        return self.db[name];
    end
    return false;
end

addon.db = Database;