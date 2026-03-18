--[[
    SAMBUNG KATA AUTO ADVANCED - DELTA PERFECTION EDITION
    Acuan: Script Original User + Engine Delta AI
    Fitur Baru: Fast A-Z Indexing, Trap Word Engine, Premium Rayfield UI.
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local VirtualInputManager = game:GetService("VirtualInputManager")
local LP = game.Players.LocalPlayer

-- ==================== KONFIGURASI ====================
local config = {
    typingDelay = 0.05,     -- Delay ngetik (Biar kayak manusia)
    scanInterval = 0.5,     -- Jangan terlalu cepat agar tidak lag
    useVirtualInput = true,
    useTextBox = false,
    trapMode = true,        -- Prioritaskan akhiran X, V, Z
}

-- ==================== DATABASE KATA ====================
-- (Saya mengambil sebagian dari script Anda, silakan paste sisanya jika kurang)
local kataKBBI = {
    "abadi", "abadiah", "abah", "abai", "abang", "abar", "abdi", "abdikasi", "abece", "aberasi",
    "baba", "babad", "babak", "babal", "baban", "bambang", "bambu", "ban", "bana", "banal",
    "cabai", "cabang", "cabar", "cabik", "cabir", "cabul", "cabut", "cacah", "cacak", "cacar",
    "daba", "dabih", "dabik", "dabit", "dablek", "dabol", "dada", "dadah", "dadak", "dadal",
    "ebi", "ebonit", "ebro", "ebulisi", "ebur", "ecer", "eceng", "edafik", "edafologi", "edan",
    "fabel", "fabrikasi", "fabrikat", "fabula", "fadihat", "fadil", "fagosit", "fagositosis", "faham",
    "gaba", "gabah", "gabai", "gabak", "gabal", "gabang", "gabar", "gabas", "gabir", "gabro",
    "habib", "habis", "habitat", "habituasi", "habitus", "had", "hadanah", "hadap", "hadapan",
    "iakan", "iaket", "ialah", "ian", "ibadah", "ibadat", "ibarat", "iblis", "ibnu", "ibra",
    "jaba", "jabang", "jabangbayi", "jabar", "jabaran", "jabat", "jabatan", "jabing", "jabir",
    "kaba", "kabak", "kabal", "kaban", "kabar", "kabaret", "kabas", "kabat", "kabau", "kabel",
    "laal", "laat", "laba", "labah", "labak", "labal", "labang", "labas", "label", "labi",
    "maaf", "maah", "maal", "maam", "maan", "maarif", "mabes", "mabi", "mabok", "mabuk",
    "naas", "naba", "nabi", "nabiri", "nabla", "nabrak", "nadas", "nadi", "nadir", "nafas",
    "paal", "pabean", "pabrik", "pabrikasi", "pabrikan", "pacak", "pacal", "pacang", "pacar",
    "raab", "raad", "raas", "raba", "rabak", "rabal", "raban", "rabas", "rabat", "rabel",
    "saat", "saba", "sabab", "sabah", "sabak", "sabal", "saban", "sabang", "sabar", "sabas",
    "taat", "tabah", "tabal", "taban", "tabar", "tabarak", "tabas", "tabayun", "tabeh", "tabek",
    "uang", "uap", "uar", "uas", "uayeb", "ubah", "ubahan", "uban", "ubang", "ubek",
    "waad", "waar", "wabah", "wacana", "wad", "wada", "wadah", "wadak", "wadat", "wadi",
    "ya", "yacht", "yah", "yahudi", "yahudiah", "yahwe", "yaitu", "yakin", "yakini", "yakis",
    "zaal", "zabadi", "zabania", "zabib", "zabur", "zadah", "zahid", "zahir", "zahiriah", "zaitun",
    "zakar", "zakat", "zaki", "zakkum", "zalim", "zaman", "zamrud", "zamzam", "zana", "zanan",
    "zebra", "xenon", "xylem", "vokal", "viva" -- Tambahan Trap Words
    -- [PASTE SEMUA ISI TABEL kataKBBI ANDA YANG 3000 KATA DI SINI]
}

-- ==================== SISTEM & STATS ====================
local usedWords = {}
local IndexedDB = {}
local autoEnabled = false
local lastWordDetected = ""
local stats = { total = #kataKBBI, used = 0, lastTyped = "None", currentPrompt = "None" }

-- [OPTIMASI 1]: Fast Indexing (Agar tidak lag saat scan 3000 kata)
local function rebuildIndex()
    IndexedDB = {}
    for _, word in ipairs(kataKBBI) do
        local first = word:sub(1,1):lower()
        if not IndexedDB[first] then IndexedDB[first] = {} end
        table.insert(IndexedDB[first], word:lower())
    end
end
rebuildIndex()

-- ==================== LOGIKA UTAMA ====================

-- [ACUAN]: Mengambil 3, 2, atau 1 huruf terakhir
local function getAkhiran(kata)
    local p = #kata
    local akhiran = {}
    if p >= 3 then table.insert(akhiran, kata:sub(p-2, p)) end
    if p >= 2 then table.insert(akhiran, kata:sub(p-1, p)) end
    table.insert(akhiran, kata:sub(p, p))
    return akhiran
end

-- [OPTIMASI 2]: Smart Trap Logic dengan Fast Search
local function cariKataCerdas(awalan)
    awalan = awalan:lower()
    local firstLetter = awalan:sub(1,1)
    local candidates = IndexedDB[firstLetter] or {}
    
    local normalMatch = {}
    local trapMatch = {}
    local difficultEndings = {x=true, v=true, z=true, j=true, f=true, y=true}

    for _, kata in ipairs(candidates) do
        if kata:find("^"..awalan) and not usedWords[kata] and #kata > #awalan then
            if difficultEndings[kata:sub(-1)] then
                table.insert(trapMatch, kata)
            else
                table.insert(normalMatch, kata)
            end
        end
    end

    if config.trapMode and #trapMatch > 0 then
        return trapMatch[math.random(1, #trapMatch)]
    elseif #normalMatch > 0 then
        return normalMatch[math.random(1, #normalMatch)]
    end
    return nil
end

-- [ACUAN & OPTIMASI]: Typing System
local function executeType(kata, targetTextBox)
    if config.useTextBox and targetTextBox then
        targetTextBox.Text = kata
        task.wait(0.1)
        pcall(function()
            if targetTextBox:FindFirstChild("Submit") then targetTextBox.Submit:Fire() end
            if targetTextBox:FindFirstChild("FocusLost") then targetTextBox.FocusLost:Fire() end
        end)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
    elseif config.useVirtualInput then
        for i = 1, #kata do
            local char = kata:sub(i, i)
            VirtualInputManager:SendKeyEvent(true, char:upper(), false, game)
            task.wait(config.typingDelay)
            VirtualInputManager:SendKeyEvent(false, char:upper(), false, game)
        end
        task.wait(0.1)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
    end
    
    usedWords[kata] = true
    stats.used = stats.used + 1
    stats.lastTyped = kata:upper()
end

-- ==================== GUI RAYFIELD ====================
local Window = Rayfield:CreateWindow({
    Name = "Sambung Kata PRO | Advanced",
    LoadingTitle = "Menginisialisasi Engine...",
    LoadingSubtitle = "Delta Exec Optimized",
    ConfigurationSaving = { Enabled = false }
})

local DashTab = Window:CreateTab("Dashboard", 4483362458)
local AutoTab = Window:CreateTab("Automation", 4483362458)
local SetTab = Window:CreateTab("Settings", 4483362458)

-- Dashboard Elements
local TotalLbl = DashTab:CreateLabel("Database: " .. stats.total .. " Kata")
local UsedLbl = DashTab:CreateLabel("Telah Digunakan: 0")
local DetLbl = DashTab:CreateLabel("Kata Terdeteksi: None")
local LastLbl = DashTab:CreateLabel("Jawaban Terakhir: None")

local function updateUI()
    UsedLbl:Set("Telah Digunakan: " .. stats.used)
    DetLbl:Set("Kata Terdeteksi: " .. stats.currentPrompt)
    LastLbl:Set("Jawaban Terakhir: " .. stats.lastTyped)
end

-- Automation Toggles
AutoTab:CreateToggle({
    Name = "MULAI AUTO SCAN & JAWAB",
    CurrentValue = false,
    Callback = function(v) autoEnabled = v end
})

AutoTab:CreateToggle({
    Name = "Prioritas Kata Jebakan (Trap Mode)",
    CurrentValue = true,
    Callback = function(v) config.trapMode = v end
})

AutoTab:CreateButton({
    Name = "Reset History Kata (Klik Tiap Ronde)",
    Callback = function() 
        usedWords = {} 
        stats.used = 0
        updateUI()
        Rayfield:Notify({Title = "Reset", Content = "Siap menghancurkan lawan di ronde baru!"})
    end
})

-- Settings Toggles
SetTab:CreateToggle({
    Name = "Gunakan Virtual Keyboard (Aman)",
    CurrentValue = true,
    Callback = function(v) config.useVirtualInput = v; config.useTextBox = not v end
})

SetTab:CreateSlider({
    Name = "Kecepatan Ketik (Delay per huruf)",
    Range = {0.01, 0.2},
    Increment = 0.01,
    CurrentValue = 0.05,
    Suffix = "detik",
    Callback = function(v) config.typingDelay = v end
})

-- ==================== ENGINE SCANNER (ACUAN USER) ====================
task.spawn(function()
    while task.wait(config.scanInterval) do
        if autoEnabled then
            local textBox = nil
            local kataDisplay = nil
            local detectText = ""
            
            -- Scan UI seperti script Original
            for _, gui in ipairs(LP.PlayerGui:GetChildren()) do
                if gui:IsA("ScreenGui") then
                    for _, obj in ipairs(gui:GetDescendants()) do
                        -- Cari TextBox
                        if obj:IsA("TextBox") then
                            local name = obj.Name:lower()
                            if name:match("input") or name:match("jawab") or name:match("answer") or name:match("teks") then
                                textBox = obj
                            end
                        end
                        -- Cari Teks Soal
                        if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                            local teks = obj.Text:lower():gsub("%s+", "")
                            if teks:match("%a+") and (#teks >= 2 and #teks <= 20) and not teks:match("http") then
                                local name = obj.Name:lower()
                                if name:match("kata") or name:match("word") or name:match("soal") or obj.Parent.Name:lower():match("game") then
                                    kataDisplay = obj
                                    detectText = teks
                                end
                            end
                        end
                    end
                end
            end
            
            -- Jika kata soal ditemukan dan berbeda dari sebelumnya
            if kataDisplay and detectText ~= "" and detectText ~= lastWordDetected then
                stats.currentPrompt = detectText:upper()
                updateUI()
                
                local akhiranList = getAkhiran(detectText)
                local jawaban = nil
                local akhiranTerpilih = ""
                
                -- Coba cari dari 3 huruf, jika gagal 2 huruf, lalu 1 huruf
                for _, akhiran in ipairs(akhiranList) do
                    jawaban = cariKataCerdas(akhiran)
                    if jawaban then 
                        akhiranTerpilih = akhiran
                        break 
                    end
                end
                
                if jawaban then
                    lastWordDetected = detectText
                    task.wait(0.3) -- Jeda reaksi mikir
                    executeType(jawaban, textBox)
                    
                    -- Masukkan soal dan jawaban ke history agar tidak dipakai lagi
                    usedWords[detectText] = true 
                    updateUI()
                    
                    Rayfield:Notify({Title="Menjawab", Content="Kata: "..detectText.."\nAkhiran: "..akhiranTerpilih.."\nJawab: "..jawaban:upper()})
                    task.wait(1.5) -- Cooldown per soal
                end
            end
        end
    end
end)
