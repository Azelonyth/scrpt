--[[
    Delta Script AI - Sambung Kata REAL ENGINE
    Status: Active & Tested
    Logic: UI Text Monitoring + Virtual Input Injection
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- DATABASE KATA (PASTE LEBIH BANYAK DI SINI)
-- ==========================================
local myWords = {
    "ayam", "anjing", "api", "bakso", "balon", "cacing", "cicak", "dadu", "diam", 
    "emas", "elang", "film", "foto", "gajah", "gitar", "hari", "hujan", "ikan", 
    "itik", "jam", "jeruk", "kucing", "kenapa", "kapan", "dimana", "lampu", "makan", 
    "minum", "nasi", "nenek", "obat", "orang", "padi", "pintu", "rumah", "rusa", 
    "sapi", "satu", "tahu", "telur", "ular", "uang", "viva", "vitamin", "waktu", 
    "wortel", "xilem", "xerox", "yoyo", "yakin", "zebra", "zakat", "kultur", "vokal"
}

-- Internals
local usedWords = {}
local IndexedDB = {}
local targetUIPath = "" -- Diset via UI manual atau auto-scan
local autoTypeEnabled = false
local trapMode = true
local lastDetectedPrompt = ""

-- Pengelompokan kata (A-Z)
local function rebuildIndex()
    IndexedDB = {}
    for _, word in ipairs(myWords) do
        local firstLetter = string.lower(string.sub(word, 1, 1))
        if not IndexedDB[firstLetter] then IndexedDB[firstLetter] = {} end
        table.insert(IndexedDB[firstLetter], string.lower(word))
    end
end
rebuildIndex()

-- UI Setup
local Window = Rayfield:CreateWindow({
    Name = "DELTA | Sambung Kata REAL",
    LoadingTitle = "Menghubungkan Engine...",
    LoadingSubtitle = "Delta Executor Optimized",
})

local MainTab = Window:CreateTab("Utama", 4483362458)
local StatsTab = Window:CreateTab("Statistik", 4483362458)

-- Stat Labels
local StatusLabel = StatsTab:CreateLabel("Status: Menunggu...")
local PromptLabel = StatsTab:CreateLabel("Prefix Terdeteksi: None")
local LastWordLabel = StatsTab:CreateLabel("Kata Terakhir: None")
local dbCountLabel = StatsTab:CreateLabel("Total Database: " .. #myWords .. " Kata")

-- Pencarian Kata Terbaik
local function findWord(prefix)
    prefix = prefix:lower():match("%w+") -- Bersihkan teks dari simbol
    if not prefix then return nil end
    
    local firstLetter = string.sub(prefix, 1, 1)
    local candidates = IndexedDB[firstLetter] or {}
    
    local normalOnes = {}
    local trapOnes = {}

    for _, word in ipairs(candidates) do
        -- Syarat: Harus diawali prefix, belum dipakai, dan panjang > panjang prefix
        if string.find(word, "^" .. prefix) and not usedWords[word] and #word > #prefix then
            local lastChar = string.sub(word, -1)
            if lastChar == "x" or lastChar == "v" or lastChar == "z" or lastChar == "j" then
                table.insert(trapOnes, word)
            else
                table.insert(normalOnes, word)
            end
        end
    end

    if trapMode and #trapOnes > 0 then
        return trapOnes[math.random(1, #trapOnes)]
    elseif #normalOnes > 0 then
        return normalOnes[math.random(1, #normalOnes)]
    end
    return nil
end

-- Simulasi Mengetik REAL (Bukan sekedar ganti teks)
local function realType(word)
    StatusLabel:Set("Status: Mengetik " .. word:upper())
    -- Klik TextBox agar fokus (Opsional, beberapa game butuh ini)
    -- VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0) 

    for i = 1, #word do
        local char = string.sub(word, i, i)
        VirtualInputManager:SendKeyEvent(true, char:upper(), false, game)
        task.wait(0.05) -- Kecepatan ketik (0.05 = Cepat)
        VirtualInputManager:SendKeyEvent(false, char:upper(), false, game)
    end
    
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(true, "Return", false, game) -- Tekan Enter
    VirtualInputManager:SendKeyEvent(false, "Return", false, game)
    
    usedWords[word] = true
    LastWordLabel:Set("Kata Terakhir: " .. word:upper())
    StatusLabel:Set("Status: Selesai Mengetik")
end

-- UI Controls
MainTab:CreateToggle({
    Name = "Aktifkan Auto-Typing",
    CurrentValue = false,
    Callback = function(Value) autoTypeEnabled = Value end,
})

MainTab:CreateToggle({
    Name = "Mode Jebakan (Trap)",
    CurrentValue = true,
    Callback = function(Value) trapMode = Value end,
})

MainTab:CreateInput({
    Name = "Nama UI Label Kata",
    PlaceholderText = "Contoh: WordLabel / PromptText",
    Callback = function(Text)
        targetUIPath = Text
        Rayfield:Notify({Title = "Target Diset", Content = "Mencari UI dengan nama: " .. Text})
    end,
})

MainTab:CreateButton({
    Name = "Reset History (Gunakan Tiap Ronde)",
    Callback = function() 
        usedWords = {} 
        Rayfield:Notify({Title = "Reset", Content = "History kata dikosongkan!"})
    end,
})

-- ENGINE: Loop untuk mendeteksi perubahan teks di game
task.spawn(function()
    while task.wait(0.2) do
        if autoTypeEnabled then
            -- CARA KERJA: Mencari seluruh UI di layar yang punya nama sesuai targetUIPath
            local foundLabel = nil
            for _, v in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                if v:IsA("TextLabel") or v:IsA("TextBox") then
                    -- Jika user mengisi nama UI, cari spesifik. Jika tidak, coba scan teks pendek.
                    if targetUIPath ~= "" and v.Name == targetUIPath then
                        foundLabel = v
                        break
                    elseif targetUIPath == "" and #v.Text > 0 and #v.Text <= 3 and v.Visible then
                        -- Auto-detect: Cari label yang teksnya pendek (1-3 huruf) biasanya itu prefix
                        foundLabel = v
                    end
                end
            end

            if foundLabel and foundLabel.Text ~= lastDetectedPrompt then
                local currentText = foundLabel.Text:gsub("%s+", "") -- Hapus spasi
                if #currentText > 0 then
                    lastDetectedPrompt = currentText
                    PromptLabel:Set("Prefix Terdeteksi: " .. currentText:upper())
                    
                    local wordToPlay = findWord(currentText)
                    if wordToPlay then
                        task.wait(0.5) -- Jeda sebentar sebelum mulai ketik
                        realType(wordToPlay)
                    else
                        StatusLabel:Set("Status: Kata tidak ada di DB!")
                    end
                end
            end
        end
    end
end)
