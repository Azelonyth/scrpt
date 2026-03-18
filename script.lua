--[[
    SAMBUNG KATA AUTO - ULTIMATE (BUILT-IN UI SCANNER)
    Fitur Baru: 
    - Smart Screen Scanner (Tidak butuh Dex Explorer)
    - Auto Lock UI Target
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local VIM = game:GetService("VirtualInputManager")
local LP = game:GetService("Players").LocalPlayer

-- ==================== DATABASE KATA ====================
-- PASTE RIBUAN KATA ANDA DI BAWAH INI (Di dalam kurung kurawal)
local kataKBBI = {
    "abadi", "abadiah", "abah", "abai", "abang", "abar", "abdi", "abdikasi",
    "baba", "babad", "babak", "babal", "baban", "bambang", "bambu", "ban",
    "cabai", "cabang", "cabar", "cabik", "cabir", "cabul", "cabut", "cacah",
    -- [PASTE SEMUA KATA LAINNYA DI SINI] --
    "zakat", "zaman", "zamrud", "zebra", "xenon", "xylem", "vokal", "viva" 
}

-- ==================== KONFIGURASI & STATE ====================
local Config = {
    AutoActive = false,
    GameMode = "Sambung Akhiran",
    TargetUIName = "",            -- Akan diisi otomatis oleh Scanner
    TrapMode = true,
    MinLength = 3,
    DelayBeforeType = 0.5,
    TypingSpeed = 0.05,
}

local State = {
    UsedWords = {},
    IndexedDB = {},
    LastPrompt = "",
    TotalDB = #kataKBBI,
    CountUsed = 0,
    ScannedUIs = {} -- Menyimpan hasil scan layar
}

-- [1] FAST INDEXING (Anti Lag)
local function rebuildIndex()
    State.IndexedDB = {}
    for _, word in ipairs(kataKBBI) do
        local first = word:sub(1,1):lower()
        if not State.IndexedDB[first] then State.IndexedDB[first] = {} end
        table.insert(State.IndexedDB[first], word:lower())
    end
end
rebuildIndex()

-- [2] EKSTRAKSI PREFIX
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

-- [3] PENCARI KATA CERDAS (Trap Engine)
local function cariJawaban(awalan)
    awalan = awalan:lower()
    local firstLetter = awalan:sub(1,1)
    local candidates = State.IndexedDB[firstLetter] or {}
    
    local normalMatch = {}
    local trapMatch = {}
    local traps = {x=true, v=true, z=true, j=true, f=true, y=true}

    for _, kata in ipairs(candidates) do
        if kata:find("^"..awalan) and not State.UsedWords[kata] and #kata >= Config.MinLength and #kata > #awalan then
            if traps[kata:sub(-1)] then
                table.insert(trapMatch, kata)
            else
                table.insert(normalMatch, kata)
            end
        end
    end

    if Config.TrapMode and #trapMatch > 0 then
        return trapMatch[math.random(1, #trapMatch)]
    elseif #normalMatch > 0 then
        return normalMatch[math.random(1, #normalMatch)]
    end
    return nil
end

-- [4] TYPING ENGINE
local function ketik(kata)
    task.wait(Config.DelayBeforeType)
    for i = 1, #kata do
        local char = kata:sub(i, i)
        VIM:SendKeyEvent(true, char:upper(), false, game)
        task.wait(Config.TypingSpeed + math.random(-5, 5)/1000)
        VIM:SendKeyEvent(false, char:upper(), false, game)
    end
    
    task.wait(0.1)
    VIM:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
    VIM:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
    
    State.UsedWords[kata] = true
    State.CountUsed = State.CountUsed + 1
end

-- ==================== GUI RAYFIELD ====================
local Window = Rayfield:CreateWindow({
    Name = "Sambung Kata | ULTIMATE",
    LoadingTitle = "Delta Built-in Scanner",
    ConfigurationSaving = { Enabled = false }
})

local SetupTab = Window:CreateTab("1. Cari UI (Penting)", 4483362458)
local AutoTab = Window:CreateTab("2. Auto-Play", 4483362458)
local DashTab = Window:CreateTab("3. Dashboard", 4483362458)
local SetTab = Window:CreateTab("4. Settings", 4483362458)

-- ==================== TAB 1: SMART UI SCANNER (PENGGANTI DEX) ====================
SetupTab:CreateLabel("PANDUAN: Saat ada soal muncul di layar (Misal: 'MAKAN'),")
SetupTab:CreateLabel("Klik tombol Scan di bawah, lalu pilih teks 'MAKAN' di Dropdown.")

local targetDropdown = SetupTab:CreateDropdown({
    Name = "Pilih Teks Soal di Layar",
    Options = {"Belum ada data... Klik Scan dulu"},
    CurrentOption = {"Belum ada data... Klik Scan dulu"},
    MultipleOptions = false,
    Callback = function(v)
        local selection = v[1]
        -- Mengekstrak nama UI dari pilihan (Format: "NamaUI | Teksnya")
        if selection:find(" | ") then
            local uiName = selection:split(" | ")[1]
            Config.TargetUIName = uiName
            Rayfield:Notify({Title="Target Terkunci!", Content="Script hanya akan membaca UI: " .. uiName, Duration=4})
        end
    end
})

SetupTab:CreateButton({
    Name = "🔍 SCAN LAYAR SEKARANG",
    Callback = function()
        local tempList = {}
        State.ScannedUIs = {}
        
        -- Scan semua teks di layar
        for _, ui in pairs(LP.PlayerGui:GetDescendants()) do
            if (ui:IsA("TextLabel") or ui:IsA("TextBox")) and ui.Visible and ui.Text ~= "" then
                local t = ui.Text:gsub("\n", " ")
                -- Abaikan teks yang terlalu panjang atau cuma angka (Timer)
                if #t <= 20 and not t:match("^%d+$") then
                    local entry = ui.Name .. " | " .. t
                    table.insert(tempList, entry)
                    State.ScannedUIs[ui.Name] = true
                end
            end
        end
        
        if #tempList > 0 then
            targetDropdown:Refresh(tempList, true)
            Rayfield:Notify({Title="Scan Selesai", Content="Pilih teks soal yang sedang tampil di dropdown!", Duration=4})
        else
            Rayfield:Notify({Title="Error", Content="Tidak ada teks valid di layar!"})
        end
    end
})

-- ==================== TAB 2: AUTO PLAY ====================
AutoTab:CreateToggle({
    Name = "▶️ AKTIFKAN BOT SAMBUNG KATA",
    CurrentValue = false,
    Callback = function(v) 
        if v and Config.TargetUIName == "" then
            Rayfield:Notify({Title="Peringatan!", Content="Anda belum memilih UI di Tab 1!", Duration=3})
        end
        Config.AutoActive = v 
    end
})

AutoTab:CreateDropdown({
    Name = "Mode Permainan",
    Options = {"Sambung Akhiran", "Awalan Murni"},
    CurrentOption = {"Sambung Akhiran"},
    MultipleOptions = false,
    Callback = function(v) Config.GameMode = v[1] end
})

AutoTab:CreateToggle({
    Name = "Mode Jebakan (Akhiran X/V/Z)",
    CurrentValue = true,
    Callback = function(v) Config.TrapMode = v end
})

-- ==================== TAB 3: DASHBOARD ====================
local LblUsed = DashTab:CreateLabel("Kata Digunakan: 0")
local LblDetect = DashTab:CreateLabel("Terdeteksi: -")
local LblAns = DashTab:CreateLabel("Jawaban: -")

local function updateDash(det, ans)
    LblUsed:Set("Kata Digunakan: " .. State.CountUsed)
    if det then LblDetect:Set("Terdeteksi: " .. det:upper()) end
    if ans then LblAns:Set("Jawaban: " .. ans:upper()) end
end

DashTab:CreateButton({
    Name = "♻️ RESET HISTORY (Tiap Ronde Baru)",
    Callback = function()
        State.UsedWords = {}
        State.CountUsed = 0
        State.LastPrompt = ""
        updateDash("-", "-")
        Rayfield:Notify({Title="Reset", Content="Memory dibersihkan!"})
    end
})

-- ==================== TAB 4: SETTINGS ====================
SetTab:CreateSlider({
    Name = "Jeda Sebelum Ngetik (Detik)",
    Range = {0, 3}, Increment = 0.1, CurrentValue = 0.5,
    Callback = function(v) Config.DelayBeforeType = v end
})

SetTab:CreateSlider({
    Name = "Kecepatan Ngetik per Huruf",
    Range = {0.01, 0.2}, Increment = 0.01, CurrentValue = 0.05,
    Callback = function(v) Config.TypingSpeed = v end
})

-- ==================== ENGINE DETEKSI UTAMA ====================
task.spawn(function()
    while task.wait(0.3) do
        if Config.AutoActive and Config.TargetUIName ~= "" then
            local currentText = nil
            
            -- HANYA MEMBACA UI YANG SUDAH DIKUNCI OLEH SCANNER
            for _, ui in pairs(LP.PlayerGui:GetDescendants()) do
                if (ui:IsA("TextLabel") or ui:IsA("TextBox")) and ui.Name == Config.TargetUIName then
                    currentText = ui.Text
                    break
                end
            end

            -- PROSES JAWABAN
            if currentText and currentText ~= "" and currentText ~= State.LastPrompt then
                local prefixes = getPrefixList(currentText)
                local jawaban = nil
                local prefixTerpilih = ""
                
                for _, p in ipairs(prefixes) do
                    jawaban = cariJawaban(p)
                    if jawaban then 
                        prefixTerpilih = p
                        break 
                    end
                end
                
                if jawaban then
                    State.LastPrompt = currentText
                    State.UsedWords[currentText:lower()] = true 
                    
                    updateDash(currentText, jawaban .. " ("..prefixTerpilih..")")
                    ketik(jawaban)
                end
            end
        end
    end
end)
