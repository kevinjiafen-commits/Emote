-- Delta Compatibility Diagnostic (safe)
-- 只检测运行环境，不修改游戏状态、不绕过反作弊、不执行自动瞄准/攻击。
local function safeCall(fn, ...)
    if type(fn) ~= "function" then
        return false, "missing"
    end
    local ok, a, b = pcall(fn, ...)
    if ok then return true, a, b end
    return false, tostring(a)
end

local function hasGlobal(name)
    local ok, value = pcall(function() return getfenv and getfenv(0)[name] end)
    return ok and value ~= nil
end

local checks = {
    "loadstring", "readfile", "writefile", "isfile", "makefolder",
    "getgenv", "cloneref", "clonefunction", "copyfunction",
    "sethiddenproperty", "gethiddenproperty",
    "getthreadidentity", "setthreadidentity",
    "hookfunction", "newcclosure", "hookmetamethod",
    "getnamecallmethod", "getgc", "getrenv"
}

print("=== Delta compatibility diagnostic ===")
print("Executor-safe checks only; no exploit functionality is executed.")

for _, name in ipairs(checks) do
    local ok = hasGlobal(name)
    print(string.format("%-22s : %s", name, ok and "AVAILABLE" or "MISSING"))
end

local services = {
    "Players", "RunService", "UserInputService",
    "ReplicatedStorage", "Workspace", "HttpService"
}

for _, name in ipairs(services) do
    local ok, service = pcall(function() return game:GetService(name) end)
    print(string.format("Service %-15s : %s", name, (ok and service) and "OK" or "MISSING"))
end

local lpOk, lp = pcall(function()
    return game:GetService("Players").LocalPlayer
end)
print("LocalPlayer             : " .. ((lpOk and lp) and "OK" or "NOT READY"))

print("=== End ===")
