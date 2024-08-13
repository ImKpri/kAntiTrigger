local protectedTriggers = {
    "esx:giveItem",
    "esx:removeItem",
    "esx:giveMoney", 
}

local authorizedResources = {
    "TEST1",
    "TEST2",
}

local function logPotentialCheater(source, triggerName, resourceName)
    print("^1[kAntiTrigger] Potentiel tricheur détecté: "..GetPlayerName(source).." (ID: "..source..") a tenté d'utiliser le trigger protégé: "..triggerName.." depuis la ressource: "..(resourceName or "inconnu").."^0")
end

local function isResourceAuthorized(resourceName)
    for _, authorizedResource in ipairs(authorizedResources) do
        if resourceName == authorizedResource then
            return true
        end
    end
    return false
end

for _, triggerName in ipairs(protectedTriggers) do
    RegisterServerEvent(triggerName)
    AddEventHandler(triggerName, function(...)
        local source = source
        local resourceName = GetInvokingResource()
        if not isResourceAuthorized(resourceName) then
            logPotentialCheater(source, triggerName, resourceName)
            DropPlayer(source, "Tentative d'utilisation d'un trigger non autorisé depuis une ressource externe.")
            CancelEvent()
            return
        end
    end)
end
