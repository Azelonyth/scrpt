--[[
    SAMBUNG KATA AUTO - FULL UI/UX GOD TIER
    Semua pengaturan bisa diakses 100% melalui Menu GUI.
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local VIM = game:GetService("VirtualInputManager")
local VU = game:GetService("VirtualUser")
local LP = game:GetService("Players").LocalPlayer

-- ==================== 1. DATABASE KATA DASAR ====================
-- PASTE RIBUAN KATA ANDA DI BAWAH INI (Hanya perlu dilakukan 1x)
local kataKBBI = {
    "abadi", "abadiah", "abah", "abai", "abang", "abar", "abdi", "abdikasi",
    "baba", "babad", "babak", "babal", "baban", "bambang", "bambu", "ban",
    "cabai", "cabang", "cabar", "cabik", "cabir", "cabul", "cabut", "cacah",
    -- [PASTE SEMUA KATA LAINNYA DI SINI] --
    "zakat", "zaman", "zamrud", "zebra", "xenon", "xylem", "vokal", "viva",
    "konsekuensi", "kemerdekaan", "kesejahteraan", "uap", "cat", "bom"
}

-- ==================== 2. KONFIGURASI (Diatur via UI) ====================
local Config = {
    AutoActive = false,
    GameMode = "Sambung Akhiran",
    TargetUIName = "",
    TrapMode = true,
    LengthMode = "Normal (Acak)", 
    DelayBeforeType = 0.5,
    TypingSpeed = 0.05,
    Humanizer = true,
    TypoChance = 5, -- Persentase Typo
    AutoEnter = true,
    ESPMode = false,
    AFKFarm = false,
    AntiAFK = true,
    SavedCFrame = nil
}

local State = {
    UsedWords = {},
    IndexedDB = {},
    LastPrompt = "Belum Ada",
    LastAnswer = "Belum Ada",
    TotalDB = #kataKBBI,
    CountUsed = 0,
}

-- [SISTEM INDEXING CEPAT]
local function rebuildIndex()
    State.IndexedDB = {}
    for _, word in ipairs(kataKBBI) do
        local first = word:sub(1,1):lower()
        if not State.IndexedDB[first] then State.IndexedDB[first] = {} end
        table.insert(State.IndexedDB[first], word:lower())
    end
    State.TotalDB = #kataKBBI
end
rebuildIndex()

-- ==================== 3. ESP CONTEKAN ====================
local ESPGui = Instance.new("ScreenGui", game.CoreGui)
ESPGui.Name = "ContekanSambungKata"
ESPGui.Enabled = false

local ESPFrame = Instance.new("Frame", ESPGui)
ESPFrame.Size = UDim2.new(0, 250, 0, 110)
ESPFrame.Position = UDim2.new(0.5, 150, 0.2, 0)
ESPFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ESPFrame.BackgroundTransparency = 0.2
Instance.new("UICorner", ESPFrame).CornerRadius = UDim.new(0, 8)

local ESPTitle = Instance.new("TextLabel", ESPFrame)
ESPTitle.Size = UDim2.new(1, 0, 0, 30)
ESPTitle.BackgroundTransparency = 1
ESPTitle.Text = "📝 CONTEKAN DEWA"
ESPTitle.TextColor3 = Color3.fromRGB(0, 255, 127)
ESPTitle.Font = Enum.Font.GothamBold
ESPTitle.TextSize = 16

local ESPText = Instance.new("TextLabel", ESPFrame)
ESPText.Size = UDim2.new(1, -10, 1, -35)
ESPText.Position = UDim2.new(0, 5, 0, 30)
ESPText.BackgroundTransparency = 1
ESPText.Text = "Menunggu Giliran..."
ESPText.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPText.Font = Enum.Font.Gotham
ESPText.TextSize = 14
ESPText.TextWrapped = true
ESPText.TextYAlignment = Enum.TextYAlignment.Top

-- ==================== 4. ENGINE UTAMA ====================
local function getPrefixList(teks)
    teks = teks:lower():gsub("%s+", ""):match("%w+")
    if not teks then return {} end
    if Config.GameMode == "Sambung Akhiran" then
        local p = #teks
        local list = {}
        if p >= 3 then table.insert(list, teks:sub(p-2, p)) end
        if p >= 2 then table.insert(list, teks:sub(p-1, p)) end
        table.insert(list, teks:sub(p, p))
        return list
    else
        return {teks}
    end
end

local function cariJawaban(awalan, isESP)
    awalan = awalan:lower()
    local firstLetter = awalan:sub(1,1)
    local candidates = State.IndexedDB[firstLetter] or {}
    local validWords = {}
    local traps = {x=true, v=true, z=true, j=true, f=true, y=true}

    for _, kata in ipairs(candidates) do
        if kata:find("^"..awalan) and not State.UsedWords[kata] and #kata > #awalan then
            table.insert(validWords, kata)
        end
    end

    if #validWords == 0 then return nil, {} end

    if Config.LengthMode == "Sombong (Paling Panjang)" then
        table.sort(validWords, function(a, b) return #a > #b end)
    elseif Config.LengthMode == "Cepat (Paling Pendek)" then
        table.sort(validWords, function(a, b) return #a < #b end)
    else
        for i = #validWords, 2, -1 do
            local j = math.random(i)
            validWords[i], validWords[j] = validWords[j], validWords[i]
        end
    end

    local finalMatch = nil
    if Config.TrapMode then
        for _, kata in ipairs(validWords) do
            if traps[kata:sub(-1)] then finalMatch = kata break end
        end
    end
    if not finalMatch then finalMatch = validWords[1] end

    if isESP then
        local espList = {}
        for i=1, math.min(3, #validWords) do table.insert(espList, validWords[i]) end
        return finalMatch, espList
    end
    return finalMatch, {}
end

local function ketik(kata)
    task.wait(Config.DelayBeforeType)
    for i = 1, #kata do
        local char = kata:sub(i, i)
        
        -- Simulasi Typo (Kesalahan Ketik Manusia)
        if Config.Humanizer and math.random(1, 100) <= Config.TypoChance and i < #kata then
            local salahChar = string.char(math.random(97, 122)) 
            VIM:SendKeyEvent(true, salahChar:upper(), false, game)
            task.wait(0.05)
            VIM:SendKeyEvent(false, salahChar:upper(), false, game)
            task.wait(0.15)
            
            -- Backspace
            VIM:SendKeyEvent(true, Enum.KeyCode.Backspace, false, game)
            task.wait(0.05)
            VIM:SendKeyEvent(false, Enum.KeyCode.Backspace, false, game)
            task.wait(0.1)
        end

        VIM:SendKeyEvent(true, char:upper(), false, game)
        task.wait(Config.TypingSpeed + math.random(-5, 5)/1000)
        VIM:SendKeyEvent(false, char:upper(), false, game)
    end
    
    if Config.AutoEnter then
        task.wait(0.2)
        VIM:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        VIM:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
    end
    
    State.UsedWords[kata] = true
    State.CountUsed = State.CountUsed + 1
    State.LastAnswer = kata:upper()
end

-- ==================== 5. FULL UI / UX RAYFIELD ====================
local Window = Rayfield:CreateWindow({
    Name = "Sambung Kata | FULL UI EDITION",
    LoadingTitle = "Delta UI/UX System",
    LoadingSubtitle = "by Delta AI",
    ConfigurationSaving = { Enabled = true, FolderName = "SambungKataPro", FileName = "ConfigSaves" },
    KeySystem = false
})

local DashTab = Window:CreateTab("📊 Dashboard", 4483362458)
local SetupTab = Window:CreateTab("🎯 Target Setup", 4483362458)
local AutoTab = Window:CreateTab("⚙️ Auto-Play", 4483362458)
local HumTab = Window:CreateTab("🤖 Humanizer", 4483362458)
local AFKTab = Window:CreateTab("💤 AFK Farm", 4483362458)
local DBTab = Window:CreateTab("📚 Database", 4483362458)

-- [TAB 1: DASHBOARD]
local LblDB = DashTab:CreateLabel("📚 Total Kata di Database: " .. State.TotalDB)
local LblUsed = DashTab:CreateLabel("🔥 Kata Digunakan Ronde Ini: 0")
local LblQuest = DashTab:CreateLabel("🎯 Pertanyaan Terakhir: -")
local LblAns = DashTab:CreateLabel("✅ Jawaban Terakhir: -")

local function updateDashboard()
    LblDB:Set("📚 Total Kata di Database: " .. State.TotalDB)
    LblUsed:Set("🔥 Kata Digunakan Ronde Ini: " .. State.CountUsed)
    LblQuest:Set("🎯 Pertanyaan Terakhir: " .. State.LastPrompt)
    LblAns:Set("✅ Jawaban Terakhir: " .. State.LastAnswer)
end

-- [TAB 2: TARGET SETUP]
SetupTab:CreateSection("Opsi 1: Scanner Otomatis (Rekomendasi)")
local targetDropdown = SetupTab:CreateDropdown({
    Name = "Pilih Teks Layar", Options = {"Klik Tombol Scan Dulu"}, CurrentOption = {""}, MultipleOptions = false,
    Callback = function(v)
        if v[1]:find(" | ") then 
            Config.TargetUIName = v[1]:split(" | ")[1] 
            Rayfield:Notify({Title="Sukses", Content="Target UI Dikunci ke: " .. Config.TargetUIName})
        end
    end
})
SetupTab:CreateButton({
    Name = "🔍 SCAN SEMUA TEKS DI LAYAR",
    Callback = function()
        local tempList = {}
        for _, ui in pairs(LP.PlayerGui:GetDescendants()) do
            if (ui:IsA("TextLabel") or ui:IsA("TextBox")) and ui.Visible and ui.Text ~= "" then
                local t = ui.Text:gsub("\n", " ")
                if #t <= 20 and not t:match("^%d+$") then table.insert(tempList, ui.Name .. " | " .. t) end
            end
        end
        if #tempList > 0 then targetDropdown:Refresh(tempList, true) end
    end
})

SetupTab:CreateSection("Opsi 2: Manual Input (Jika Pakai Dex)")
SetupTab:CreateInput({
    Name = "Ketik Nama UI Secara Manual", PlaceholderText = "Contoh: SoalLabel", RemoveTextAfterFocusLost = false,
    Callback = function(v) Config.TargetUIName = v end
})

-- [TAB 3: AUTO-PLAY]
AutoTab:CreateToggle({
    Name = "▶️ NYALAKAN BOT SAMBUNG KATA", CurrentValue = false, Flag = "BotToggle",
    Callback = function(v) Config.AutoActive = v end
})
AutoTab:CreateToggle({
    Name = "📝 Tampilkan Papan Contekan (ESP)", CurrentValue = false, Flag = "ESPToggle",
    Callback = function(v) Config.ESPMode = v; ESPGui.Enabled = v end
})
AutoTab:CreateDropdown({
    Name = "Mode Permainan", Options = {"Sambung Akhiran", "Awalan Murni"}, CurrentOption = {"Sambung Akhiran"}, Flag = "GameMode", MultipleOptions = false,
    Callback = function(v) Config.GameMode = v[1] end
})
AutoTab:CreateDropdown({
    Name = "Filter Panjang Kata", Options = {"Normal (Acak)", "Sombong (Paling Panjang)", "Cepat (Paling Pendek)"}, CurrentOption = {"Normal (Acak)"}, Flag = "LengthMode", MultipleOptions = false,
    Callback = function(v) Config.LengthMode = v[1] end
})
AutoTab:CreateToggle({
    Name = "Mode Jebakan (Akhiran X/V/Z)", CurrentValue = true, Flag = "TrapToggle",
    Callback = function(v) Config.TrapMode = v end
})
AutoTab:CreateToggle({
    Name = "Otomatis Tekan Enter", CurrentValue = true, Flag = "EnterToggle",
    Callback = function(v) Config.AutoEnter = v end
})

-- [TAB 4: HUMANIZER (ANTI-BAN)]
HumTab:CreateToggle({
    Name = "Aktifkan Pura-Pura Salah Ketik (Typo)", CurrentValue = true, Flag = "HumToggle",
    Callback = function(v) Config.Humanizer = v end
})
HumTab:CreateSlider({
    Name = "Peluang Typo (%)", Range = {1, 20}, Increment = 1, CurrentValue = 5, Suffix = "%", Flag = "TypoChance",
    Callback = function(v) Config.TypoChance = v end
})
HumTab:CreateSlider({
    Name = "Jeda Waktu Mikir (Sebelum Ngetik)", Range = {0, 3}, Increment = 0.1, CurrentValue = 0.5, Suffix = "Detik", Flag = "DelayMikir",
    Callback = function(v) Config.DelayBeforeType = v end
})
HumTab:CreateSlider({
    Name = "Kecepatan Jari Ngetik", Range = {0.01, 0.2}, Increment = 0.01, CurrentValue = 0.05, Suffix = "Detik/Huruf", Flag = "SpeedKetik",
    Callback = function(v) Config.TypingSpeed = v end
})

-- [TAB 5: AFK FARMING]
AFKTab:CreateButton({
    Name = "📍 KUNCI POSISI SAAT INI (Stand Here)",
    Callback = function()
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            Config.SavedCFrame = LP.Character.HumanoidRootPart.CFrame
            Rayfield:Notify({Title="Terkunci", Content="Karakter Anda akan dijaga di posisi ini."})
        end
    end
})
AFKTab:CreateToggle({
    Name = "Auto-Teleport ke Posisi Terkunci", CurrentValue = false, Flag = "AFKFarm",
    Callback = function(v) Config.AFKFarm = v end
})
AFKTab:CreateToggle({
    Name = "Anti-AFK (Anti Kick dari Server)", CurrentValue = true, Flag = "AntiAFK",
    Callback = function(v) Config.AntiAFK = v end
})

-- [TAB 6: DATABASE MANAGER]
DBTab:CreateButton({
    Name = "♻️ RESET MEMORY (KLIK SAAT RONDE BARU)",
    Callback = function() 
        State.UsedWords = {} 
        State.CountUsed = 0 
        State.LastPrompt = "Belum Ada"
        State.LastAnswer = "Belum Ada"
        updateDashboard()
        Rayfield:Notify({Title="Reset Sukses", Content="Siap tempur di ronde baru!"}) 
    end
})
DBTab:CreateInput({
    Name = "Tambah Kata Baru ke Database", PlaceholderText = "Ketik kata lalu tekan Enter...", RemoveTextAfterFocusLost = true,
    Callback = function(v) 
        local kataBaru = v:lower():gsub("%s+", "")
        if kataBaru ~= "" then
            table.insert(kataKBBI, kataBaru)
            rebuildIndex()
            updateDashboard()
            Rayfield:Notify({Title="Sukses", Content="Kata '"..kataBaru:upper().."' ditambahkan!"})
        end
    end
})

-- ==================== BACKGROUND PROCESS ====================

-- Anti-AFK Roblox
LP.Idled:Connect(function()
    if Config.AntiAFK then
        VU:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VU:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

-- AFK Teleport Loop
task.spawn(function()
    while task.wait(3) do
        if Config.AFKFarm and Config.SavedCFrame and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            LP.Character.HumanoidRootPart.CFrame = Config.SavedCFrame
        end
    end
end)

-- Main Scanner & Typist Loop
task.spawn(function()
    while task.wait(0.3) do
        if Config.AutoActive and Config.TargetUIName ~= "" then
            local currentText = nil
            for _, ui in pairs(LP.PlayerGui:GetDescendants()) do
                if (ui:IsA("TextLabel") or ui:IsA("TextBox")) and ui.Name == Config.TargetUIName then
                    currentText = ui.Text break
                end
            end

            if currentText and currentText ~= "" and currentText ~= State.LastPrompt then
                local prefixes = getPrefixList(currentText)
                local jawaban = nil
                local espList = {}
                
                for _, p in ipairs(prefixes) do
                    jawaban, espList = cariJawaban(p, Config.ESPMode)
                    if jawaban then break end
                end
                
                if jawaban then
                    State.LastPrompt = currentText:upper()
                    State.UsedWords[currentText:lower()] = true 
                    
                    if Config.ESPMode then
                        local listText = ""
                        for i, v in ipairs(espList) do listText = listText .. i .. ". " .. v:upper() .. "\n" end
                        ESPText.Text = "Soal: " .. State.LastPrompt .. "\n\nRekomendasi:\n" .. listText
                        State.LastAnswer = "(Manual via ESP)"
                    else
                        ketik(jawaban)
                    end
                    updateDashboard()
                end
            end
        end
    end
end)
