--[[
    SAMBUNG KATA AUTO - V7.0 PERFECT EDITION
    - Interactive ESP (5 Clickable Options)
    - Trap Difficulty Levels (Extreme, Hard, Medium)
    - Typing Profiles (Godspeed, Natural, Clumsy)
    - Smart Used-Word Memory & Auto-Retry
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local VIM = game:GetService("VirtualInputManager")
local VU = game:GetService("VirtualUser")
local LP = game.Players.LocalPlayer

-- ==================== 1. DATABASE KATA ====================
-- PASTE RIBUAN KATA ANDA DI BAWAH INI
local kataKBBI = {
    "absis", "adneks", "adops", "afiks", "ajeks", "akseptif", "akuntatif", "alfabet", "alomorf", "alotrof", "amfibi", "amfiks", "amorf", "amp", "amuba", "anabasis", "anakronistis", "analog", "anarkis", "anasir", "andil", "andragogi", "androgini", "aneks", "ansambel", "antarklub", "antitesis", "antraks", "antropomorf", "apatis", "apeks", "apendiks", "apograf", "apokrif", "apolitis", "aporetis", "asertif", "asfiks", "asketis", "asinkron", "asistens", "asosiati", "asonansi", "astigmatis", "asimtoti", "asimtut", "ataktis", "ateis", "atenuasi", "atomis", "autokarp", "autokton", "autolisis", "autonom", "autoradiograf", "autotipe", "avontur", "awat", "awet", "azimat", "azis", "biseps", "camp", "deks", "dektos", "dolf", "dops", "draf", "drel", "drop", "drumben", "duet", "dups", "edisi", "efek", "efendi", "eka", "ekh", "eks", "eksak", "eksis", "eksit", "eksons", "ekspos", "ekstrem", "ekte", "elips", "empat", "emulsi", "enans", "engkap", "englap", "engsap", "entit", "eps", "esais", "esens", "estetis", "etis", "etos", "eufemis", "eufoniatis", "eufotis", "evakuatif", "evolutif", "faktual", "fakultatif", "fasik", "fisis", "fleks", "fluks", "fokal", "foks", "fokus", "fons", "forsep", "fungsional", "gips", "golf", "hams", "harkat", "hipotesis", "horisontalis", "hov", "humus", "iatris", "identik", "idiopatis", "impuls", "indeks", "indus", "iners", "infiks", "informatif", "inisiatif", "inisif", "inklusif", "insting", "instingtif", "instruktif", "intens", "interupsi", "intrinsik", "introspeksi", "intuitif", "isobarik", "isomorf", "isomorfis", "isotop", "jaz", "jengat", "jengit", "jips", "jipsi", "jukstapos", "kafi", "kaget", "kais", "kals", "kamp", "kampf", "kanti", "kantif", "kap", "karaf", "karak", "karap", "karas", "kars", "karsis", "kart", "kartu", "kas", "kasif", "kaset", "katarsis", "kategorial", "kates", "katut", "kelap", "keles", "kelip", "kelit", "kelot", "kelut", "kemp", "kempot", "kempu", "kempul", "kens", "kep", "keping", "kepit", "kepul", "kepung", "kerah", "kerak", "kerakal", "keramas", "keramat", "keramba", "kerambit", "keramik", "keran", "keranda", "kerang", "keranjang", "kerap", "keras", "keratan", "keraton", "kerbau", "kerdil", "kerdipan", "kerek", "keren", "kereta", "kerik", "kerikil", "kerinduan", "kering", "keris", "keritik", "kerja", "kerling", "kerna", "keroncong", "kertas", "kerubung", "kerumun", "kerupuk", "kerut", "kesah", "kesan", "kesat", "keseleo", "keset", "kesia", "kesit", "kesitu", "kesohor", "ketam", "ketan", "ketat", "ketawa", "ketiak", "ketiban", "ketika", "ketiwak", "ketoprak", "ketujuh", "ketuk", "ketumbar", "ketupat", "khawatir", "khat", "khatulistiwa", "khayal", "khazanah", "khianat", "khidmmat", "khitan", "khotbah", "khusus", "kiamat", "kian", "kiani", "kias", "kibar", "kibas", "kiblat", "kidal", "kidung", "kikir", "kikis", "kilan", "kilas", "kilat", "kilau", "kili", "kilir", "kilo", "kimah", "kimia", "kimlo", "kimo", "kimpul", "kina", "kincir", "kiner", "kinerja", "kini", "kinyis", "kipas", "kira", "kirab", "kirai", "kiranya", "kirim", "kiring", "kirmizi", "kirs", "kisa", "kisah", "kisar", "kisi", "kisruh", "kista", "kisut", "kita", "kitab", "kitar", "klan", "klasifikasi", "klasik", "klausul", "klik", "klien", "klimaks", "klinik", "kliping", "klise", "kloning", "klorin", "klub", "knalpot", "koala", "koalisi", "koboi", "kocak", "kocok", "kode", "kodrat", "koefisien", "kohesi", "koin", "kokoh", "koki", "kolam", "kolera", "koleksi", "kolektif", "kolesterol", "kolong", "kolom", "koloni", "kolosal", "koma", "komandan", "komedi", "komentar", "komersial", "komidi", "komik", "komisi", "komitmen", "komoditas", "komon", "kompak", "kompas", "kompeni", "kompensasi", "kompetisi", "kompi", "komplain", "komplotan", "komponen", "komposisi", "kompres", "kompromi", "komputer", "komunis", "kondisi", "konduktor", "koneksi", "konferensi", "konflik", "kongkong", "kongres", "konjungsi", "konkrit", "konon", "konperensi", "konsep", "konser", "konservasi", "konsisten", "konsol", "konspirasi", "konstan", "konstruksi", "konsultasi", "konsumsi", "kontak", "kontaminasi", "konteks", "kontemporer", "kontes", "kontingen", "kontinu", "kontrak", "kontraksi", "kontras", "kontribusi", "kontrol", "konveksi", "konvensi", "konvoi", "koper", "koperasi", "kopi", "kopiah", "koplak", "kopling", "kopral", "koprok", "koral", "koran", "korban", "korden", "korek", "koreksi", "koreng", "kores", "koresponden", "koridor", "kornea", "kornet", "korosi", "korps", "korsleting", "korupsi", "kosa", "kosakat", "kosambi", "kosan", "kosek", "kosmetik", "kosmik", "kosmonot", "kosong", "kostum", "kota", "kotak", "kotbah", "kotor", "kowad", "kowalk", "koyak", "kran", "krayon", "kreasi", "kreatif", "kredit", "krem", "kremasi", "kresek", "kribo", "kriminil", "kris", "krisis", "kristal", "kriteria", "kritik", "kromo", "kronis", "ksatria", "kuaci", "kuadran", "kuadrat", "kuah", "kuala", "kuali", "kualitas", "kuantitas", "kuas", "kuasa", "kuat", "kuatir", "kubah", "kubang", "kubik", "kubis", "kubu", "kubur", "kucai", "kucel", "kucing", "kucir", "kucur", "kuda", "kudapan", "kudi", "kudis", "kudrat", "kudus", "kue", "kuetiau", "kufu", "kuil", "kuintal", "kuintet", "kuis", "kuitansi", "kuku", "kukuh", "kukus", "kulai", "kulat", "kuli", "kuliah", "kuliner", "kulit", "kulkas", "kulminasi", "kulo", "kulon", "kulot", "kultural", "kultur", "kuman", "kumandang", "kumbang", "kumis", "kumpul", "kumuh", "kumur", "kunang", "kuncen", "kunci", "kuncup", "kunda", "kuning", "kunjung", "kunno", "kuntum", "kunyah", "kunyit", "kuota", "kuper", "kupas", "kupat", "kuping", "kupon", "kupu", "kura", "kurang", "kuras", "kurator", "kurawal", "kurban", "kurcaci", "kuria", "kurikulum", "kurir", "kurma", "kurnia", "kurs", "kursi", "kursus", "kurun", "kurung", "kurus", "kusa", "kusam", "kusta", "kusu", "kusut", "kutang", "kutu", "kutub", "kutukan", "kutut", "kuwera", "kwarcit", "kwartal", "kwartir", "laba", "labah", "labang", "labas", "label", "laberang", "labi", "labil", "labirin", "labrak", "labu", "labuh", "lacak", "laci", "lacur", "lada", "ladang", "laden", "lading", "ladung", "lafal", "laga", "lagam", "lagi", "lagu", "lahad", "lahap", "laar", "lahir", "laik", "lais", "laju", "lajur", "laki", "laknat", "lakon", "laksa", "laksana", "laku", "lala", "lalai", "lalak", "lalat", "lalau", "laler", "lali", "lalu", "lama", "lambang", "lambat", "lambe", "lambung", "lamun", "lamur", "lana", "lanang", "lanau", "lancar", "lancung", "lancur", "landa", "landai", "landak", "landas", "langganan", "langgar", "langgeng", "langi", "langit", "langka", "langkah", "langkan", "langkas", "langkat", "langking", "langkung", "langlang", "langsa", "langsar", "langsat", "langsi", "langsung", "lanjut", "lanjur", "lansia", "lansi", "lantai", "lantas", "lentera", "lentur", "lanyau", "laos", "lapang", "lapar", "lapat", "lapel", "lapis", "lapor", "lapuk", "lara", "larai", "larak", "larang", "laras", "larat", "lari", "larik", "laris", "laron", "larut", "lasuh", "lata", "latah", "latak", "latar", "latih", "latin", "latung", "latur", "lauk", "laun", "laung", "laut", "lawa", "lawak", "lawan", "lawang", "lawar", "lawas", "lawat", "layak", "layam", "layan", "layang", "layap", "layar", "layas", "layat", "layu", "layur", "lazat", "lazim", "lebah", "lebai", "lebak", "lebam", "lebar", "lebas", "lebat", "leber", "lebih", "lebuh", "lebung", "lebur", "leca", "leceh", "lecek", "lecet", "lecit", "lecur", "lecut", "ledak", "ledang", "ledek", "ledeng", "leder", "ledos", "leduk", "lega", "legak", "legal", "legam", "legap", "legar", "legas", "legat", "legenda", "leger", "legit", "lego", "legong", "legu", "legum", "legung", "lehar", "leher", "leka", "lekah", "lekam", "lekan", "lekap", "lekar", "lekas", "lekat", "lekeh", "lelap", "lelar", "lelas", "lelat", "leleh", "lelep", "leler", "leles", "leluasa", "lelucon", "leluhur", "lulur", "lulus", "lumat", "lumba", "lumbung", "lumpuh", "lumpur", "lumrah", "lumu", "lumur", "lumut", "lunak", "lunas", "luncas", "luncur", "lundun", "lunglai", "lungsin", "lunjur", "luntur", "lupa", "luput", "lurah", "lurik", "luruh", "lurus", "lusa", "lusin", "lusu", "lutut", "luwes", "maafi", "maaf", "mabuk", "macan", "macat", "mace", "macet", "madah", "madani", "madat", "madrasah", "madu", "mafhum", "maut", "mawar", "maya", "mayam", "mayang", "mayat", "mayor", "maysa", "maza", "mazhab", "mebel", "medan", "media", "mediator", "medis", "meditasi", "mega", "megah", "megang", "megar", "meja", "mekar", "mekanisme", "melankolis", "melati", "melayu", "melek", "melesit", "melodi", "melongo", "melulu", "memang", "memar", "memento", "memo", "menang", "menangis", "menantu", "mencak", "mending", "meneng", "mengerti", "mentah", "mentari", "mentega", "menteri", "mentok", "mentol", "menu", "manusia", "menyapa", "merah", "merana", "meranti", "merdeka", "merdu", "mereka", "meriah", "miring", "mirip", "miris", "mirtul", "misa", "misal", "miskin", "mistar", "misteri", "mistis", "mitra", "miyang", "mobil", "modis", "moga", "mogok", "mohon", "molek", "momen", "momentum", "monitor", "monolog", "monopoli", "mosi", "motivasi", "mual", "muara", "muat", "muazin", "muda", "mudah", "mudik", "mufa", "mufakat", "mufti", "muhibah", "muhrim", "muis", "muja", "mujarab", "mujur", "muka", "mukim", "mukjizat", "mukmin", "mula", "mulai", "mulia", "mulsa", "mulut", "mumbul", "mumpuni", "muncul", "munding", "mundur", "mungil", "mungkin", "mungkur", "mungkut", "mungsi", "munisi", "munjul", "munajat", "munjunjung", "munsyi", "muntah", "muntil", "munu", "mupakat", "murah", "muram", "murba", "murbai", "murid", "muring", "murni", "murka", "murtad", "murung", "musa", "musabab", "musafir", "musang", "musyawarah", "moseum", "musik", "musim", "muslihat", "musna", "musnah", "mustahil", "musuh", "mutasi", "mutiara", "mutlak", "mutu", "nabi", "nada", "nadi", "nafas", "nafkah", "nafsi", "nafsu", "naga", "nahas", "nahu", "naik", "najis", "nakal", "nakhoda", "nalar", "nama", "nampak", "nampan", "namun", "nanah", "nanap", "nanar", "nenas", "nangka", "nanti", "napas", "napu", "nara", "narasi", "naratif", "narkoba", "nasab", "nasehat", "nasi", "nasib", "nasihat", "nasional", "naskah", "nasrani", "natal", "natrium", "naung", "nurani", "nusa", "nusantara", "nutrisi", "nuansa", "nyala", "nyaman", "nyamuk", "nyanyi", "nyaring", "nyata", "nyawa", "nyenyak", "nyonya", "obal", "obar", "obat", "obeng", "objek", "objektif", "obligasi", "oblong", "obor", "obrak", "obral", "obrol", "obsesi", "observasi", "obsidian", "oknum", "oktaf", "okuler", "oles", "olahraga", "oleh", "olok", "ombak", "omel", "omong", "ompong", "onak", "onar", "onderdil", "ongkos", "onta", "operasi", "opname", "optimis", "opsi", "optik", "orang", "orasi", "orbit", "order", "organisasi", "orisinal", "ornamen", "ospek", "otak", "otentik", "otobiografi", "otot", "oval", "oven", "oyak", "ozon", "pabean", "pabel", "pabrik", "pacar", "pacu", "padam", "padan", "padang", "padas", "padat", "paderi", "padu", "paduan", "pagar", "pagi", "pagu", "pagut", "paha", "pahala", "paham", "pahas", "pahat", "pahit", "pahlawan", "pailit", "pajak", "pajang", "pajar", "pajuh", "pakai", "pakal", "pakan", "pakar", "pakat", "pakis", "paksa", "pakta", "paku", "paladin", "palai", "palang", "palapa", "palas", "palat", "palau", "palem", "palen", "pales", "palet", "paling", "palis", "palit", "palu", "palun", "palung", "paman", "pamah", "pamer", "pamit", "pamong", "pamor", "pampas", "pampat", "pampa", "pamur", "panah", "panas", "panau", "panca", "pancar", "pancing", "pancit", "pancur", "pancut", "pandai", "pandak", "pandan", "pandang", "pandu", "panel", "pangah", "pangan", "pangeran", "pangestu", "panggul", "panggung", "panggil", "pangkai", "pangkas", "pangkat", "pangkal", "pangkon", "pangku", "panglima", "panglong", "pangonan", "pangsa", "pangsi", "pangur", "panitia", "panitera", "panjang", "panjar", "panjat", "panji", "panjul", "pantai", "pantang", "pantas", "pantat", "pantau", "pantek", "panti", "pantik", "pantis", "pantul", "pantun", "panu", "panus", "papa", "papah", "papak", "papan", "papar", "papas", "papat", "parah", "parafe", "parafin", "paragraf", "parak", "param", "parang", "parap", "paras", "parat", "parau", "parit", "parkir", "parlemen", "parodi", "paroki", "paron", "paruh", "parut", "pasah", "pasak", "pasal", "pasang", "pasar", "pasas", "pasat", "paser", "paset", "pasfoto", "pasif", "pasir", "pasit", "pasma", "pasrah", "pasta", "pasti", "pasu", "pasuh", "pasung", "patah", "patam", "patar", "patek", "paten", "patera", "patih", "patik", "patil", "patin", "patir", "patit", "patok", "patroli", "patron", "patuh", "patuk", "patul", "patung", "patut", "pauh", "pauk", "paus", "paut", "paviliun", "pawai", "pawang", "paya", "payah", "payang", "payar", "payat", "payau", "payir", "payu", "payung", "peberi", "pecah", "pecai", "pecak", "pecal", "pecara", "pecat", "pecel", "pecinan", "pecut", "pedagang", "pedah", "pedaka", "pedal", "pedalaman", "pedanda", "pedang", "pedar", "pedas", "pedati", "pedel", "pedewak", "pedih", "pedis", "pedok", "pedu", "peduli", "pegagan", "pegal", "pegan", "pegang", "pegangan", "pegar", "pegas", "pegawai", "pegun", "pehong", "peka", "pekak", "pekan", "pekap", "pekas", "pekat", "peker", "peki", "peking", "pekir", "pekis", "pekur", "pelabi", "pelah", "pelamin", "pelampung", "pelana", "pelancong", "pelangi", "pelanting", "pelapis", "pelapor", "pelat", "pelatuk", "pelaut", "pelayon", "pelbagai", "pelebaya", "pelepah", "pelesir", "pelesit", "pelet", "peletik", "peleting", "pelias", "pelihara", "pelik", "peling", "pelintir", "pelipis", "pelipit", "pelipur", "pelir", "pelit", "pelita", "pelitur", "pelonco", "pelosok", "pelopor", "pelor", "pelos", "peluh", "peluit", "peluk", "peluntur", "peluru", "pemajang", "pemalak", "pemali", "pemantul", "pemar", "pemat", "pembantu", "pembedah", "pemeo", "pemer", "pemicu", "pemidana", "pemidang", "pemikat", "pemilu", "pemirsa", "pemuda", "pemudi", "penat", "pencak", "pencar", "pencet", "pencil", "pencut", "penda", "pendam", "pendek", "pendapa", "pende", "pending", "pendopo", "penembak", "penganten", "pengaruh", "penggal", "penghulu", "pening", "peniti", "penjara", "penjuru", "pensil", "pensiun", "pental", "pentas", "pentil", "penting", "pentol", "pentung", "penuh", "pepah", "pepak", "pepas", "pepatah", "pepaya", "pepedan", "pepek", "pepes", "pepet", "perah", "perahu", "perai", "perajurit", "perak", "peran", "perancah", "perancis", "perang", "peranti", "peras", "perat", "perawan", "perba", "percaya", "percik", "percul", "percuma", "perdana", "perdata", "perdu", "peredam", "perembu", "perempuan", "peres", "peretel", "pergala", "pergam", "pergi", "pergok", "perhal", "perhati", "peria", "peribahasa", "peribadi", "perigi", "periksa", "perinci", "perindu", "peringat", "perintah", "periode", "perisai", "peristiwa", "periuk", "perkakas", "perkara", "perkasa", "perkedel", "perkemahan", "perkutut", "perlahan", "perlambang", "perlente", "perlus", "permai", "permaisuri", "permanen", "permata", "permadi", "permen", "permisi", "permukiman", "pernah", "peroi", "peron", "pelos", "perosok", "perot", "persada", "persahabatan", "persen", "persep", "persepuluh", "persepsi", "persero", "persetujuan", "persis", "person", "pertama", "pertiwi", "perum", "perwara", "perwira", "pesak", "pesaka", "pesanggrahan", "pesat", "pesawat", "pesiar", "pesimis", "pesinis", "pesisir", "pesona", "pesta", "pesut", "petah", "petai", "petak", "petaka", "petal", "petam", "petang", "petar", "petas", "petatas", "petek", "petenteng", "peter", "petera", "petik", "petilan", "petir", "petis", "petisi", "petola", "petuah", "petunjuk", "piagam", "piala", "piama", "piang", "piano", "piara", "piatu", "picah", "picik", "picis", "picit", "picu", "pidana", "pidato", "pihak", "pijak", "pijar", "pijat", "pikat", "pikir", "pikul", "pikun", "pilar", "pilat", "pilek", "pilih", "pilin", "pilis", "pilon", "pilot", "pimpin", "pinak", "pinang", "pinar", "pincang", "pincuk", "pindah", "pindai", "pindang", "pinding", "pindu", "pinis", "pinisi", "pinjam", "pinset", "pinta", "pintal", "pintar", "pintas", "pintil", "pintu", "pion", "pipet", "pipis", "pipit", "pirai", "piramida", "pirang", "piranti", "pirasat", "piring", "pirsa", "pirus", "pisah", "pisang", "pisau", "pisik", "pispot", "pista", "pistol", "pitar", "piting", "piutang", "pleidoi", "pleno", "plester", "plonco", "pocok", "pocong", "podium", "pohon", "pojok", "pokok", "polan", "polang", "polas", "polda", "polemik", "polen", "poler", "poles", "polet", "poliklinik", "polimer", "polis", "polisi", "politik", "polon", "polong", "polos", "polusi", "polutan", "pompa", "pondok", "pondong", "pongah", "ponis", "ponok", "ponsel", "pontang", "ponton", "ponya", "popi", "populer", "popok", "popor", "porak", "poranda", "porno", "poros", "porsi", "portal", "porter", "porselen", "posisi", "positif", "posko", "posmen", "poster", "postur", "potas", "potensi", "potong", "potret", "poyang", "prabakti", "prabot", "prabu", "prada", "pradana", "pradesa", "praduga", "prahara", "prahoto", "prajurit", "prakarsa", "prakarya", "prakata", "prakiraan", "praktek", "praktis", "pramusaji", "pramuwisata", "prangko", "prasarana", "prasasti", "prasejarah", "prasmanan", "prasangka", "prasetya", "prastawa", "prawira", "pribadi", "pribumi", "prihatin", "primadona", "primer", "prinsip", "prioritas", "prisma", "privasi", "privat", "produk", "profesor", "profil", "program", "progresif", "proklamasi", "promosi", "proporsi", "proposal", "prosedur", "proses", "profesi", "proteksi", "protokol", "proyek", "proyeksi", "puasa", "publik", "pucat", "pucuk", "pudak", "pudar", "puding", "pugar", "pugas", "puguh", "puja", "puji", "pujut", "pukat", "pukau", "pukul", "pulang", "pulan", "pulas", "pulau", "pules", "pulih", "pulpen", "pulsa", "puluh", "pulung", "pulut", "punah", "punakawan", "punat", "punca", "puncak", "pundak", "pundi", "pundit", "pundung", "punggah", "punggawa", "punggung", "pungkas", "pungkur", "pungli", "pungut", "punia", "punya", "pupuk", "pupur", "pupus", "puput", "purba", "purbakala", "purit", "purnama", "purut", "pusat", "puser", "pusing", "puspa", "pusaka", "pusara", "pustaka", "pusta", "putis", "putra", "putri", "putus", "puyeng", "puyuh", "qari", "qariah", "qasar", "qasidah", "qiamulail", "qiraah", "quran", "rabaa", "rabak", "raban", "rabat", "rabit", "rabuk", "rabun", "rabung", "racak", "racau", "racik", "racun", "radak", "radam", "radan", "radar", "raden", "radikal", "radio", "radius", "rafaksi", "ragam", "ragas", "raghu", "ragum", "ragung", "ragut", "rahang", "rahap", "rahasia", "rahat", "rahayu", "rahib", "rahim", "rahman", "rahmat", "rahsia", "rajah", "rajam", "rajan", "rajawali", "rajin", "rajok", "rajut", "rakaat", "rakam", "rakan", "rakap", "rakat", "raket", "rakit", "raksa", "raksasa", "rakun", "rakus", "rakyat", "ralat", "ramah", "ramai", "ramal", "ramas", "rambah", "rambai", "rambak", "ramban", "rambat", "rambu", "rambut", "ramin", "rampai", "rampak", "rampas", "rampat", "ramping", "rampok", "rampung", "ramus", "ranah", "ranai", "ranap", "ranca", "rancak", "rancang", "rancap", "rancau", "rancu", "randa", "randai", "randat", "randau", "randek", "randu", "randung", "rangak", "rangga", "ranggah", "ranggak", "ranggam", "ranggas", "ranggi", "ranggung", "rangka", "rangkai", "rangkak", "rangkam", "rangkang", "rangkap", "rangkas", "rangket", "rangkuh", "rangkul", "rangkum", "rangkung", "rangkup", "rangrang", "rangsang", "rangum", "ranjang", "ranjau", "ranji", "ranju", "ransel", "ransum", "rantai", "rantam", "rantau", "rante", "ranti", "ranting", "rantu", "rantus", "ranyah", "ranyah", "ranyau", "ranyun", "ranyut", "rapat", "rapih", "rapik", "rapor", "rapuh", "rapun", "rapus", "rarai", "rarak", "raras", "rasai", "rasam", "rasamala", "rasan", "rasanya", "rasian", "rasional", "rasisme", "rasul", "rasulullah", "rasut", "ratah", "ratap", "ratas", "ratih", "ratna", "ratus", "rauh", "raum", "raung", "raup", "raut", "rawah", "rawan", "rawat", "rawit", "rawon", "rayah", "rayan", "rayang", "rayap", "razia", "reaktif", "realis", "realita", "rebah", "rebak", "reban", "rebana", "rebas", "rebat", "rebeh", "rebehal", "rebek", "rebet", "rebok", "rebon", "rebus", "rebut", "recah", "recak", "recap", "receh", "recik", "recok", "redah", "redam", "redap", "redas", "redih", "redik", "redoks", "reduksi", "redup", "redusir", "referensi", "refleks", "reformasi", "regan", "regang", "regas", "regat", "regel", "reguk", "regung", "regup", "rehabilitasi", "rehat", "rejah", "rejam", "rejan", "rejasa", "rejeki", "rejeng", "rejuk", "rekah", "rekam", "rekan", "rekap", "rekat", "rekayasa", "reklame", "rekor", "rekreasi", "rekrut", "relai", "relaks", "relasi", "relatif", "relung", "remah", "remai", "remaja", "remak", "remang", "remas", "remat", "rembah", "rembak", "rembang", "rembat", "rembet", "rembih", "rembuk", "rembulan", "rembut", "remeh", "remet", "remik", "remis", "rempa", "rempah", "rempak", "rempang", "rempat", "remuk", "remun", "renang", "renca", "rencak", "rencana", "rencang", "renceh", "rencek", "rencet", "rendah", "rendam", "rendang", "rendeng", "renek", "renem", "rengan", "rengat", "renggang", "renggut", "rengit", "rengka", "rengkah", "rengkam", "rengkang", "rengkap", "rengkat", "rengket", "rengkoh", "rengkol", "rengkong", "rengkudah", "rengkuh", "rengkul", "rengkung", "rengkup", "rengreng", "rengus", "rengut", "renik", "renjana", "renjong", "renon", "renovasi", "rentak", "rentan", "rentang", "rentap", "rentas", "renteng", "renten", "renten", "renti", "renung", "renyah", "renyai", "renyak", "renyam", "renyat", "renyau", "renyeh", "renyem", "renyut", "reot", "repah", "repak", "repas", "repat", "repeh", "repek", "repet", "repis", "repot", "repuh", "repui", "reputasi", "rerak", "reres", "resah", "resak", "resam", "resan", "resap", "resat", "resensi", "resep", "resepsi", "reserse", "resesi", "resiko", "resimen", "resital", "resmi", "resolusi", "respons", "restoran", "restu", "resume", "retak", "retal", "retas", "reteh", "retensi", "retet", "retih", "retis", "retok", "retorika", "retret", "retribusi", "retur", "reuni", "rewak", "rewang", "rewel", "rezeki", "rezim", "riah", "riak", "riam", "rian", "riang", "riap", "ribat", "ribu", "ribut", "rican", "ricau", "ricih", "rician", "ricik", "ricis", "ricuh", "ridan", "ridat", "ridip", "rihal", "rihat", "rijal", "rijang", "rijit", "rikuh", "riles", "rilis", "rimah", "rimar", "rimbas", "rimbat", "rimbau", "rimba", "rimbun", "rimis", "rimpang", "rimpas", "rimpi", "rimpis", "rimpuh", "rimpung", "rinai", "rincah", "rincau", "rinci", "rincis", "rindu", "ringan", "ringgit", "ringih", "ringik", "ringis", "ringkai", "ringkas", "ringkik", "ringking", "ringkuk", "ringkus", "rintang", "rintas", "rintih", "rintik", "rintis", "ripak", "ripuh", "ririk", "riris", "risalah", "risalat", "risau", "riset", "risiko", "risit", "riskan", "ritel", "ritme", "ritual", "riuk", "riung", "rival", "riwan", "riwayat", "robak", "robat", "robek", "roboh", "robok", "robot", "ronah", "ronce", "ronda", "rondo", "roneo", "rongga", "ronggang", "ronggeng", "ronggok", "rongkong", "rongsok", "ronta", "rontok", "rontgen", "rupiah", "ruruh", "rurup", "rusuh", "rusuk", "rutin", "ruyung", "sabak", "sabana", "sabang", "sabar", "sabas", "sabda", "sabel", "saben", "sabet", "sabil", "sabit", "sablon", "sabotase", "sabuk", "sabun", "sabur", "sabut", "sadah", "sadai", "sadak", "sadang", "sadap", "sadar", "sadau", "sadel", "sadik", "sadur", "safari", "safinah", "safir", "sagai", "sagang", "sagar", "saguer", "sagun", "sahabat", "sahada", "sahaja", "saham", "sahan", "sahap", "sahara", "sahaya", "sahid", "sahifa", "sahih", "sahir", "sahur", "sahut", "sailo", "saing", "sains", "sajadah", "sajak", "sajang", "sajen", "sakal", "sakar", "sakarat", "sakat", "sakelar", "sakhalat", "sakhawat", "sakhi", "sakit", "saklar", "sakral", "sakramen", "sakratul", "saksi", "sakti", "salaf", "salah", "salai", "salak", "salam", "salang", "salap", "salar", "salat", "saldo", "saleh", "salem", "salep", "salib", "salih", "salim", "salin", "saling", "salip", "salir", "salju", "salon", "salur", "salut", "samad", "samak", "saman", "samar", "samara", "samas", "sambal", "samban", "sambar", "sambat", "sambau", "samben", "sambet", "sambil", "sambit", "sambut", "sampah", "sampai", "sampak", "sampan", "sampar", "sampas", "sampat", "samper", "sampir", "sampit", "sampo", "sampul", "samudra", "samum", "samun", "sanak", "sanat", "sanatorium", "sandang", "sandar", "sandat", "sandera", "sandikala", "sandiwara", "sandung", "sanga", "sangar", "sangat", "sangga", "sanggah", "sanggam", "sanggan", "sanggat", "sangger", "sanggi", "sanggit", "sanggul", "sanggum", "sanggung", "sangkah", "sangkak", "sangkal", "sangkan", "sangkar", "sangkat", "sangkut", "sangkur", "sangli", "sanglu", "sangon", "sangsang", "sangsi", "saniter", "sanjung", "sanksi", "santai", "santak", "santan", "santap", "santase", "santer", "santir", "santri", "santun", "sapah", "sapai", "sapak", "sapan", "sapar", "sapat", "sapau", "sapeh", "sapek", "saper", "sapir", "sapit", "saput", "saraf", "sarak", "saran", "sarang", "sarap", "sarat", "sarau", "sareh", "saren", "saret", "sargut", "sarikan", "sarip", "sarira", "sarit", "sarjana", "sarju", "sarka", "sarkasme", "sarkofagus", "saron", "sars", "sartan", "sarti", "sartu", "saruk", "sarung", "sarut", "sarwa", "sasak", "sasal", "sasan", "sasana", "sasap", "sasar", "sasat", "sasi", "sastra", "sasul", "satai", "satak", "satar", "satelit", "satin", "satir", "satru", "satuan", "satwa", "saudagar", "saudara", "saudari", "sauk", "saum", "saun", "saung", "saur", "sawah", "sawal", "sawan", "sawang", "sawat", "sawer", "sawit", "sawut", "sayab", "sayad", "sayak", "sayang", "sayap", "sayat", "sayet", "sayid", "sayur", "sebab", "sebah", "sebai", "sebak", "sebal", "seban", "sebar", "sebat", "sebau", "sebayang", "sebek", "sebeng", "seberang", "sebet", "sebih", "sebit", "sebuk", "sebung", "sebut", "sebuya", "sedah", "sedak", "sedam", "sedan", "sedang", "sedap", "sedar", "sedari", "sedat", "sedekah", "sedelinggam", "sedeng", "sederhana", "sedia", "sedikit", "sedimen", "sedot", "seduh", "segah", "segak", "segal", "segan", "segar", "segara", "segat", "segel", "segenap", "segera", "segmen", "segol", "sehat", "sejahtera", "sejarah", "sejuk", "sekali", "sekarang", "sekolah", "sekretaris", "sektor", "selalu", "selam", "selamat", "selang", "selaras", "selat", "selatan", "selebriti", "seleksi", "selesai", "selisih", "selokan", "seluas", "seluh", "seluk", "selum", "selup", "selur", "selut", "semangat", "semangka", "sembah", "sembahyang", "sembarangan", "sembilan", "sembuh", "sembunyi", "semen", "sementar", "semesta", "seminar", "sempat", "sempit", "semproti", "semua", "semut", "senang", "senapan", "senar", "senda", "sendawa", "sendiri", "sendok", "sengaja", "sengat", "sengit", "seniman", "senjata", "sentak", "senter", "sentimen", "sentuh", "senyum", "sepak", "sepatu", "sepeda", "sepele", "sepiring", "sepuluh", "sepur", "seragam", "serai", "serak", "seram", "serambi", "serang", "serap", "serat", "serayu", "serba", "serbet", "serbu", "serbuk", "serdadu", "sereal", "seret", "serikat", "sering", "serius", "seronok", "serta", "sertifikat", "seruling", "serum", "sesah", "sesak", "sesal", "sesama", "sesar", "sesat", "sesudah", "sesumbar", "setang", "setara", "stasiun", "status", "stempel", "setia", "setuju", "siamang", "siang", "siapa", "siasat", "sibuk", "sidak", "sidang", "sidik", "sifat", "sigap", "sihir", "sikap", "sikat", "siklus", "siksa", "silakan", "silang", "silap", "silat", "silau", "silih", "siluet", "siluman", "simak", "simbah", "simbol", "simetri", "simpang", "simpati", "simpan", "simpel", "simpuh", "simpul", "sinar", "sindikat", "sindir", "sinergi", "singgah", "singkap", "singkat", "singkir", "singkur", "sinis", "sinkron", "sintesis", "sipil", "sipir", "siput", "siram", "sirat", "sirine", "sirip", "sirkuit", "sirkulasi", "sirna", "sirsak", "sisik", "sisip", "sisir", "sistem", "siswa", "situasi", "siung", "siur", "skala", "skandal", "skenario", "sketsa", "skripsi", "sogok", "soket", "solat", "solek", "solidaritas", "solusi", "sombong", "sopan", "sopir", "sorak", "sorot", "sosial", "sosis", "sosok", "spanduk", "spesial", "spesifik", "spion", "sponsor", "sprint", "stadion", "standar", "statistik", "status", "stasiun", "steril", "stiker", "struktur", "studi", "studio", "suaka", "suami", "suara", "suasana", "suatu", "subjek", "subsidi", "substansi", "subuh", "subur", "sudah", "sudut", "sugih", "suguh", "sujud", "sukar", "sukarela", "sukses", "sukur", "sulam", "sulap", "suling", "sulit", "sultan", "suluh", "sulung", "sulur", "sumatera", "sumbang", "sumbat", "sumber", "sumbing", "sumbu", "sumpah", "sumpek", "sumpit", "sumsum", "sumur", "sunat", "sungai", "sungging", "sungguh", "sungkem", "sungkur", "sungut", "sunting", "suntuk", "suntuk", "sunyi", "supaya", "super", "supir", "surah", "surai", "suram", "surat", "surau", "sutan", "suuzon", "swafoto", "swalayan", "swasta", "syafaat", "syahadat", "syair", "syaman", "syamsi", "syamsir", "syara", "syaraf", "syarat", "syari", "syariat", "syarif", "syarifah", "syarik", "syarikat", "syatar", "syatibi", "syawal", "syekh", "syirik", "syiwa", "syukur", "taat", "tabah", "tabak", "tabal", "taban", "tabar", "tabet", "tabiat", "tabib", "tabik", "tabir", "tabloid", "tabrak", "tabuh", "tabun", "tabung", "tabur", "tabut", "tadah", "tadar", "tadarus", "tadung", "tafakur", "tafsir", "tagak", "tagal", "tagan", "tagar", "tageh", "tagih", "tagut", "tahadi", "tahak", "tahan", "tahang", "tahap", "tahar", "tahat", "tahayul", "tahiat", "tahil", "tahir", "tahis", "tahit", "tahun", "taici", "taifun", "taiko", "takabur", "takad", "takah", "takak", "takal", "takan", "takar", "takat", "takbir", "takdir", "takel", "takhta", "takik", "takir", "takis", "takjub", "takkan", "taklim", "takluk", "takma", "takraw", "takrif", "takrim", "taksa", "taksir", "taksis", "taktik", "taktis", "takuh", "takuk", "takun", "takut", "takwa", "takwil", "takzim", "talah", "talai", "talak", "talam", "talan", "talang", "talar", "talas", "talat", "talau", "talen", "talent", "talenta", "talib", "talis", "talkun", "talun", "talur", "tamadun", "tamah", "tamak", "tamam", "tamar", "tamasya", "tamat", "tambah", "tambak", "tambal", "tamban", "tambang", "tambar", "tambat", "tambat", "tambi", "tambo", "tambul", "tambun", "tambung", "tambur", "tamat", "tameng", "tamis", "tampah", "tampak", "tampan", "tampar", "tampas", "tampeh", "tampel", "tampi", "tampik", "tampil", "tampin", "tampir", "tampis", "tampok", "tampung", "tamsil", "tamuk", "tamun", "tanai", "tanak", "tanam", "tanat", "tanau", "tandak", "tandan", "tandang", "tandas", "tandat", "tandem", "tandes", "tanduk", "tandun", "tandung", "tandur", "tangah", "tangal", "tangap", "tangar", "tangas", "tangat", "tangga", "tanggah", "tanggal", "tanggap", "tanggar", "tanggas", "tanggi", "tanggul", "tanggum", "tanggung", "tangis", "tangkah", "tangkai", "tangkal", "tangkan", "tangkap", "tangkar", "tangkas", "tangkat", "tangke", "tangkil", "tangkis", "tangkit", "tangku", "tangkue", "tangkul", "tangkup", "tangkur", "tangkut", "tangon", "tangsa", "tangsi", "tania", "tanis", "tanjak", "tanjal", "tanjan", "tanjar", "tanju", "tanjung", "tanjur", "tansi", "tantang", "tanti", "tantu", "tanur", "tapa", "tapah", "tapai", "tapak", "tapan", "tapar", "tapas", "tapau", "tapel", "tapek", "taper", "tapih", "tapik", "tapir", "tapis", "tapit", "tapuk", "tapung", "tapur", "tapus", "taraf", "tarah", "tarai", "tarak", "taram", "taran", "tarang", "tarap", "taras", "tarat", "tarau", "tarekat", "tarek", "tarid", "tarikh", "taring", "taris", "target", "tariu", "tarka", "tarkas", "taruh", "taruk", "tarum", "taruna", "tarung", "tarup", "tarus", "tasah", "tasak", "tasamuh", "tasan", "tasbih", "tasdik", "tasik", "taslim", "tasmak", "tasmik", "tasrif", "tastas", "tatah", "tatai", "tatak", "tatal", "tatam", "tatami", "tatan", "tatang", "tatap", "tatar", "tatih", "tatit", "tatkala", "taufan", "taufik", "tauge", "tauhid", "tauke", "tauladan", "taulan", "taulany", "taum", "taurat", "tawaduk", "tawah", "tawai", "tawak", "tawakal", "tawan", "tawang", "tawas", "tawat", "tayang", "tayar", "tayum", "tayun", "teater", "tebah", "tebak", "tebal", "teban", "tebang", "tebar", "tebas", "tebat", "tebeh", "tebel", "teber", "tebet", "tebih", "tebis", "tebit", "tebok", "tebon", "tebus", "teces", "tedas", "tedeng", "teduh", "tegak", "tegal", "tegang", "tegap", "tegar", "teguh", "teguk", "tegur", "tekad", "tekah", "tekak", "tekap", "tekar", "tekat", "tekek", "tekel", "teken", "teker", "tekis", "teklek", "teknik", "teknis", "teknologi", "tekoh", "tekor", "tekos", "tekte", "tektite", "tekua", "tekuk", "tekul", "tekun", "tekup", "tekur", "telah", "teladan", "telaga", "telah", "telai", "telak", "telan", "telang", "telanjang", "telanjur", "telantar", "telap", "telapak", "telat", "telaten", "telau", "teledek", "telegram", "telepon", "teleskop", "telinga", "teliti", "telor", "teluk", "telungkup", "telus", "telusur", "temah", "temali", "temarang", "temaram", "temasa", "tematik", "tembak", "tembakau", "tembakul", "tembam", "tembang", "tembar", "tembas", "tembeh", "tembel", "temberang", "tembikai", "tembilang", "tembolok", "tembung", "tembuni", "tembus", "temeh", "temen", "temet", "temon", "tempah", "tempai", "tempak", "tempala", "tempan", "tempang", "tempar", "tempas", "tempat", "tempayan", "tempel", "tempeleng", "temperamen", "temperatur", "tempik", "tempil", "tempinis", "tempoyak", "tempua", "tempuh", "tempun", "tempur", "tempurung", "temui", "temuku", "temun", "temut", "tenaga", "tenang", "tendang", "tendas", "tender", "tengak", "tengal", "tengar", "tengat", "tenggak", "tenggang", "tenggara", "tenggek", "tenggelam", "tengger", "tenggiling", "tenggorok", "tengkar", "tengking", "tengku", "tengkuk", "tengkurap", "tengkurup", "tengu", "tenjet", "tensi", "tenun", "tenung", "teologi", "tepah", "tepak", "tepan", "tepas", "tepeh", "tepek", "teper", "tepis", "tepok", "tepuk", "tepung", "tepus", "terah", "terai", "terajang", "terak", "teran", "terang", "terap", "terasi", "terat", "teratai", "terau", "terawang", "terberak", "terbit", "terbus", "tercecer", "terdedah", "terdepan", "terdidik", "terendam", "terentang", "teriak", "teriga", "terima", "terjang", "terjun", "terkam", "terkap", "terkait", "terlanjur", "terlantar", "terminal", "ternak", "terobos", "terompah", "terompet", "teropong", "terowongan", "terperanjat", "tertawa", "tertentu", "teruna", "tetapi", "tetas", "teter", "tetes", "tetua", "tewas", "tiada", "tiarap", "tidak", "tikam", "tikar", "tiket", "tikis", "tikit", "tikus", "tilam", "tilan", "tilap", "tilas", "tilawat", "tilik", "timah", "timang", "timbal", "timbang", "timbau", "timbi", "timbil", "timbun", "timbul", "timbur", "timit", "timpa", "timpal", "timpang", "timpas", "timpi", "timpus", "timun", "timus", "tindak", "tindas", "tindih", "tindis", "tinggal", "tinggung", "tingkah", "tingkal", "tingkap", "tingkat", "tingkepi", "tingkil", "tingkir", "tingkis", "tingkuh", "tinjau", "tinju", "tionghoa", "tipak", "tipar", "tipas", "tipes", "tipis", "tipus", "tirah", "tiram", "tiran", "tiras", "tirat", "tiris", "tirus", "tisak", "tisik", "tisin", "tistis", "titah", "titik", "titip", "titir", "titis", "titit", "titrat", "tituler", "tiung", "tiwul", "tobak", "tobat", "tobel", "toblos", "todong", "togog", "tohor", "tojok", "tokak", "tokek", "tokok", "tokong", "tokop", "tolak", "tolan", "tolap", "toleh", "toleransi", "tolok", "tolol", "tolong", "tomat", "tombak", "tombol", "tombong", "tomong", "tompel", "tonggak", "tongkang", "tongkat", "tongkol", "tongkrong", "tongon", "tongos", "tonton", "topan", "topang", "topdal", "topek", "topeng", "topik", "topografi", "toponimi", "toples", "topong", "toraks", "toreh", "torek", "torkhas", "tornado", "torpedo", "totalitas", "totok", "totol", "towak", "tualang", "tuang", "tuanku", "tuban", "tuberkulosis", "tubruk", "tubuh", "tuding", "tuduh", "tudung", "tugas", "Tuhan", "tuhur", "tujuan", "tujuh", "tukak", "tukal", "tukam", "tukang", "tukar", "tukas", "tukat", "tukik", "tukil", "tukul", "tukung", "tukup", "tulah", "tualang", "tualas", "tualat", "tulen", "tulis", "tulus", "tuman", "tumang", "tumbak", "tumbal", "tumbang", "tumbas", "tumbuh", "tumbuk", "tumis", "tumit", "tumor", "tumpah", "tumpak", "tumpang", "tumpas", "tumpat", "tumpeng", "tumpes", "tumpil", "tumpu", "tumpuk", "tumpul", "tumpur", "tunai", "tunak", "tunam", "tunas", "tunda", "tundang", "tunduk", "tundun", "tungau", "tunggal", "tunggang", "tungging", "tunggit", "tunggul", "tungkai", "tungkak", "tungkap", "tungku", "tungkul", "tungkup", "tungkus", "tunjang", "tunjuk", "tunjung", "tuntas", "tuntun", "tuntut", "tupai", "turap", "turas", "turis", "turisme", "turnamen", "turne", "turun", "turus", "turut", "tustel", "tusuk", "tustel", "tuton", "tutuh", "tutuk", "tutul", "tutup", "tutur", "uang", "ubah", "uban", "ubat", "ubel", "ubet", "ubin", "ubit", "ubrak", "ubun", "ubur", "ucap", "ucek", "ucer", "ucil", "ucung", "udang", "udara", "udat", "udek", "udel", "udet", "udik", "uduk", "udur", "udut", "ugahari", "uget", "ugut", "ujana", "ujud", "ujian", "ujung", "ukas", "ukik", "ukir", "ukrit", "ukur", "ulah", "ulai", "ulak", "ulam", "ulan", "ulang", "ulap", "ular", "ulas", "ulat", "ulekan", "ulem", "uler", "ulet", "ulit", "ulung", "ulup", "ulur", "umat", "umbai", "umbak", "umban", "umbar", "umbat", "umbi", "umbuk", "umbul", "umbun", "umbut", "umpan", "umpat", "umpet", "umpil", "umpuk", "umpun", "umum", "umur", "umut", "unak", " unam", "unan", "unar", "uncang", "uncat", "unce", "uncui", "undak", "undan", "undang", "undas", "undat", "undel", "unduh", "unduk", "undul", "undur", "unggak", "unggal", "unggang", "unggat", "unggul", "unggun", "unggut", "ungkah", "ungkap", "ungkil", "ungkir", "ungkit", "unglai", "ungum", "ungut", "unifurm", "unik", "universitas", "universal", "unjuk", "unjung", "unjun", "unjut", "unok", "unsang", "unsur", "untai", "untal", "untang", "untar", "untas", "untel", "untit", "untung", "untuk", "untun", "untut", "upacara", "upah", "upak", "upam", "upan", "upar", "upas", "upat", "upaya", "upet", "upeti", "upih", "upik", "upir", "upis", "upit", "upok", "urai", "urak", "uram", "uran", "urang", "urap", "uras", "urat", "urau", "uray", "urdu", "ureum", "urgen", "urian", "urik", "uril", "urim", "urin", "uris", "urit", "urung", "urup", "urus", "urut", "uruy", "usah", "usaha", "usak", "usam", "usang", "usap", "usat", "usia", "usik", "usil", "usir", "uskup", "usul", "usung", "usus", "usut", "utama", "utara", "utas", "utih", "utik", "utuh", "utus", "uvula", "uzlah", "uzur", "vaksin", "vakum", "valensi", "valid", "valuta", "vampir", "vanili", "variasi", "varietas", "vaskular", "velbet", "velg", "vena", "ventilasi", "venus", "verbal", "verifikasi", "vermak", "versi", "vertek", "vertikal", "veta", "veteran", "veto", "vetsin", "video", "vinil", "viola", "virus", "virtual", "visual", "vitamin", "vokal", "vokasi", "volume", "vonis", "votum", "vulgar", "vulkanis", "waadat", "wabah", "wacana", "wadah", "wadak", "wadal", "wadam", "wadang", "wadas", "wadat", "waduk", "wadung", "wafat", "wahah", "wahai", "waham", "wahana", "wahyu", "waisya", "wait", "wajah", "wajan", "wajar", "wajib", "wajik", "wakaf", "wakil", "waktu", "wakun", "walad", "walafiat", "walaka", "walang", "walau", "walawafiat", "walet", "walimahan", "walimatul", "walisongo", "walkie", "wallahu", "waluh", "wanda", "wangi", "wangun", "wanita", "wanodya", "wanter", "waqaf", "wara", "warak", "warangan", "waras", "warga", "waria", "warid", "waris", "warisan", "warkat", "warna", "warnasari", "warok", "warsa", "warta", "wartawan", "wartel", "warung", "wasak", "wasalam", "wasangka", "wasiat", "wasil", "wasilah", "wasit", "waslap", "waspada", "waswas", "watak", "watan", "watas", "wates", "watun", "wawancara", "wawas", "wawasan", "wayang", "wayuh", "wedana", "wedang", "wedar", "wedel", "weduk", "weher", "wejang", "wekas", "wekel", "weker", "welang", "welas", "welat", "welit", "wenang", "wenas", "wendi", "wengku", "wenter", "werda", "werdi", "werit", "werkudara", "werst", "wortel", "wreda", "wredatama", "wudu", "wujud", "wukuf", "wulang", "wulung", "wungu", "wutuh", "xenia", "xenofobia", "xilofon", "yaani", "yabai", "yabani", "yadi", "yahud", "yahudi", "yahum", "yaitu", "yakin", "yakit", "yakni", "yaksa", "yakub", "yakun", "yakut", "yakuza", "yaman", "yamani", "yantra", "yapa", "yapi", "yarad", "yara", "yasan", "yasin", "yasti", "yatim", "yaumul", "yayasan", "yayi", "yayu", "yoga", "yogi", "yogya", "yohimbine", "yojana", "yoker", "yolat", "yoyo", "yuda", "yudikatif", "yudo", "yudisial", "yudisium", "yuget", "yugo", "yunda", "yunani", "yunior", "yunta", "yuran", "yure", "yuridis", "yuris", "yurisprudensi", "yuta", "zabad", "zabah", "zabaniah", "zabarjad", "zabib", "zabit", "zabur", "zadah", "zahid", "zahir", "zaitun", "zakat", "zakar", "zakir", "zakum", "zalim", "zalir", "zaman", "zambak", "zamrud", "zamzam", "zanda", "zanggi", "zani", "zapin", "zarah", "zauj", "zaujah", "zayun", "zebra", "zebu", "zenith", "ziarah", "zig-zag", "zikir", "zillullah", "zina", "zindik", "zink", "zionisme", "zirah", "zirkon", "zodiak", "zonasi", "zonk", "zoologi", "zorbing", "zuama", "zuhad", "zuhud", "zuhur", "zulham", "zulhijah", "zulkaidah", "zulmat", "zulu", "zurat", "zuriah", "saat", "sabak", "saban", "sabang", "sabar", "sabat", "sabda", "sabel", "saben", "sabet", "sabil", "sabit", "sablon", "sabot", "sabtu", "sabuk", "sabun", "sabur", "sabut", "sadah", "sadai", "sadak", "sadang", "sadap", "sadar", "sadau", "sadel", "sadik", "sadin", "sadir", "sadis", "sadur", "safari", "safi", "safir", "safra", "safran", "saga", "sagai", "sagam", "sagan", "sagar", "sagas", "sago", "sagon", "sagu", "saguer", "sahabat", "sahadat", "sahaja", "sahala", "saham", "sahan", "sahap", "sahara", "sahaya", "sahdu", "sahid", "sahifa", "sahih", "sahira", "sahitya", "sahul", "sahur", "sahut", "saidi", "saing", "sains", "sais", "sait", "saja", "sajadah", "sajak", "sajan", "sajang", "sajat", "sajen", "saji", "saka", "sakal", "sakang", "sakar", "sakat", "sakau", "sakelar", "sakhi", "sakhawat", "sakit", "saklar", "sakral", "sakramen", "sakrat", "saksi", "sakti", "saku", "sakura", "salaf", "salah", "salai", "salak", "salam", "salang", "salap", "salar", "salat", "salatin", "saldo", "saleh", "salem", "salep", "salib", "salih", "salim", "salin", "saling", "salip", "salir", "salju", "salome", "salon", "salp", "salping", "salur", "salut", "sama", "samad", "samak", "saman", "samar", "sambar", "sambat", "sambau", "sambel", "samber", "sambil", "sambit", "sambo", "sambit", "sambung", "sambut", "samir", "sampah", "sampai", "sampak", "sampan", "sampar", "sampas", "sampat", "sampean", "samper", "sampir", "sampit", "sampo", "sampul", "samudra", "samun", "sana", "sanak", "sanat", "sandang", "sandar", "sandat", "sandera", "sandi", "sandung", "sang", "sanga", "sangam", "sangar", "sangat", "sangga", "sanggah", "sanggam", "sanggan", "sanggar", "sanggat", "sangger", "sanggi", "sanggit", "sanggul", "sanggum", "sanggung", "sangkah", "sangkak", "sangkal", "sangkan", "sangkar", "sangkat", "sangking", "sangku", "sangkur", "sangkut", "sangsang", "sangsi", "sangu", "sani", "saniter", "sanjung", "sanksi", "sano", "santai", "santak", "santan", "santap", "santau", "santer", "santir", "santri", "santun", "sapa", "sapah", "sapai", "sapak", "sapan", "sapar", "sapat", "sapau", "sapeh", "sapek", "saper", "sapi", "sapir", "sapit", "sapu", "saput", "sara", "saraf", "sarak", "saran", "sarana", "sarang", "sarap", "sarat", "sarau", "sare", "sareh", "saren", "saret", "sari", "sarikan", "sarip", "sarira", "sarit", "sarjana", "sarju", "sarkas", "saron", "sars", "sartan", "saru", "saruk", "sarung", "sarut", "sarwa", "sasa", "sasak", "sasal", "sasan", "sasana", "sasap", "sasar", "sasat", "sasi", "sastra", "sasul", "satai", "satak", "satar", "satelit", "satih", "satin", "satir", "satru", "satu", "satuan", "satwa", "saudagar", "saudara", "sauk", "saum", "saun", "saung", "saur", "sawah", "sawai", "sawal", "sawan", "sawang", "sawat", "sawer", "sawi", "sawit", "sawut", "saya", "sayab", "sayad", "sayak", "sayang", "sayap", "sayat", "sayet", "sayid", "sayu", "sayur", "sebab", "sebah", "sebai", "sebak", "sebal", "seban", "sebar", "sebat", "sebau", "sebayang", "sebek", "sebeng", "seberang", "sebet", "sebih", "sebit", "sebuk", "sebung", "sebut", "sedah", "sedak", "sedam", "sedan", "sedang", "sedap", "sedar", "sedat", "sedekah", "sedeng", "sederhana", "sedia", "sedih", "sedikit", "sedimen", "sedot", "seduh", "segah", "segak", "segal", "segan", "segar", "segara", "segat", "segel", "segenap", "segera", "segi", "segmen", "segol", "sehat", "sejahtera", "sejarah", "sejati", "sejuk", "sekali", "sekarang", "sekap", "sekat", "sekedar", "seken", "seker", "sekin", "sekip", "sekolah", "sekongkol", "sekop", "sekoteng", "sekresi", "sekret", "sekretaris", "seks", "seksi", "seksual", "sekte", "sektor", "sekul", "sekuler", "sekutu", "sel", "sela", "selada", "selagi", "selaju", "selak", "selalu", "selam", "selama", "selamat", "selamba", "selan", "selang", "selangkang", "selap", "selar", "selaras", "selat", "selatan", "selawat", "sele", "seleksi", "selektif", "selebras", "selebriti", "seledri", "seleguri", "seleh", "selek", "selempang", "selendang", "selenggara", "selentang", "selepa", "selepe", "selera", "selesai", "selisih", "selit", "selokan", "selon", "selonong", "selop", "selot", "seluar", "selubung", "seludang", "seluduk", "seluk", "seluler", "seluloid", "selulose", "selulu", "selum", "selup", "seluruh", "selusup", "selusur", "selut", "semadi", "semak", "semalam", "semangat", "semangka", "semantik", "semat", "sembah", "sembahyang", "sembarang", "sembat", "sembelih", "sembelit", "sember", "semberani", "semberip", "sembilan", "sembilu", "sembir", "semboyan", "sembrono", "sembuh", "sembul", "sembunyi", "sembur", "semen", "semena", "semenanjung", "semenda", "semengkek", "sementara", "semerbak", "semesta", "semi", "seminar", "seminari", "semir", "semoga", "semok", "semper", "sempit", "sempoa", "semprot", "sempurna", "semu", "semua", "semur", "semut", "sen", "sena", "senada", "senandika", "senandung", "senang", "senap", "senapan", "senar", "senat", "senawat", "senda", "sendal", "sendang", "sendat", "sendawa", "sendel", "sendeng", "sender", "sendi", "sendiri", "sendok", "sendu", "senduduk", "sendung", "seng", "sengaja", "sengal", "sengam", "sengap", "sengat", "sengau", "sengon", "senguk", "sengut", "seni", "seniman", "senin", "senior", "senjata", "senjung", "senka", "senonoh", "senta", "sentak", "sentana", "sentap", "sentara", "sentaus", "sentausa", "senter", "senteri", "senti", "sentimen", "senting", "sentong", "sentosa", "sentra", "sentral", "sentuh", "sentul", "sentung", "senuk", "senur", "senyap", "senyap", "senyum", "senyun", "sepak", "sepakat", "sepan", "sepanjang", "sepanduk", "sepang", "sepasang", "sepat", "sepatu", "sepeda", "sepeleh", "sepenggal", "seper", "seperangkat", "sepersepuluh", "seperti", "sepi", "sepih", "sepuh", "sepul", "sepuluh", "sepura", "sepur", "seput", "sera", "serabut", "serada", "seragam", "serah", "serai", "serak", "seram", "serambi", "serampang", "seran", "serana", "serandang", "serang", "serangga", "serangkai", "serani", "seranta", "serap", "serapah", "serat", "serau", "serawak", "serawan", "seraya", "serba", "serbak", "serban", "serbat", "serbet", "serbu", "serbuk", "serdadu", "serdah", "serdak", "serdam", "serdang", "serdawa", "serdi", "serdih", "sereal", "serebral", "seremoni", "serenade", "serendah", "seret", "sergap", "seri", "serikat", "sering", "seringai", "serit", "serius", "serkah", "serkai", "serkap", "serkup", "serlah", "serloin", "sero", "serobot", "seroja", "serok", "serokan", "seronok", "serot", "serpih", "sersan", "serta", "sertifikat", "sertu", "seru", "seruak", "serual", "serudi", "seruduk", "seruit", "seruling", "serum", "serunai", "serunda", "serundeng", "serung", "serut", "sesah", "sesajen", "sesak", "sesal", "sesama", "sesap", "sesar", "sesat", "sesawi", "sesepuh", "sesi", "sesuai", "sesudah", "sesumbar", "set", "seta", "setabel", "setabil", "setadion", "setahun", "setai", "setaka", "setakar", "setal", "setala", "setali", "setaman", "setan", "setang", "setanggi", "setara", "setasiun", "setat", "setawar", "setebal", "seteguk", "setel", "setela", "setelah", "setem", "setempat", "setengah", "seter", "seterap", "seteru", "setia", "setiap", "setiawan", "setik", "setila", "setinggi", "setip", "setir", "setop", "setor", "setra", "setrap", "setu", "setuju", "setul", "setum", "setung", "setup", "sewa", "sewah", "sewal", "sewar", "sewat", "si", "sia", "siaga", "siang", "siangit", "siap", "siapa", "siar", "siasat", "siat", "sibak", "sibar", "sibat", "sibuk", "sibur", "sibuta", "sida", "sidak", "sidang", "sidat", "sidik", "sifat", "sigai", "sigak", "sigap", "sigar", "sigasir", "sigat", "sigi", "sigung", "sihir", "sijil", "sikap", "sikari", "sikat", "siksa", "siku", "sila", "silah", "silam", "silang", "silap", "silat", "silaturahmi", "silau", "silet", "silih", "silik", "silikon", "silir", "silu", "siluet", "siluk", "siluman", "silung", "silut", "simak", "simbah", "simbak", "simbar", "simbat", "simbol", "simbur", "simetri", "simfoni", "simpai", "simpan", "simpang", "simpati", "simpel", "simplisit", "simpu", "simpuh", "simpul", "simpur", "simut", "sinar", "sinau", "sindikat", "sindir", "sindrom", "sinergi", "singgah", "singgasana", "singit", "singka", "singkak", "singkang", "singkap", "singkat", "singkeh", "singkil", "singkir", "singkur", "singlet", "singsat", "singsing", "sini", "sinis", "sinjal", "sinkron", "sinode", "sinonim", "sinopsis", "sintaks", "sintal", "sintesis", "sinting", "sintir", "sintua", "sintuk", "sintum", "sintung", "sinu", "sinus", "sinyal", "sinyo", "siomai", "sipai", "sipasan", "sipat", "sipil", "sipir", "sipit", "sipoa", "sipoa", "sipu", "sipuh", "sipul", "siput", "sir", "sira", "sirah", "siram", "sirap", "sirat", "siraut", "sirene", "sirih", "sirik", "sirip", "sirkam", "sirkol", "sirkuit", "sirkulasi", "sirkus", "sirna", "sirop", "sirsa", "sirsak", "siru", "sirup", "sirut", "sisa", "sisal", "sisi", "sisih", "sisik", "sisip", "sisir", "sistaltik", "sistem", "siswa", "siswi", "sit", "sita", "sitak", "sitat", "siter", "siti", "sitir", "sitrat", "situn", "situ", "situasi", "siuk", "siul", "siuman", "siung", "siur", "siut", "siwak", "siwal", "siwer", "siwalan", "skala", "skandal", "skenario", "sketsa", "skors", "skripsi", "soal", "sobat", "sobek", "sobok", "soda", "sodok", "sodor", "sofa", "sogo", "sogok", "sohor", "sohwat", "sohib", "sohor", "sohun", "soja", "sok", "soka", "soker", "soket", "soko", "sokong", "sol", "sola", "solat", "solek", "solenoid", "solid", "solider", "solo", "solokan", "solum", "solusi", "somasi", "sombol", "sombol", "sombong", "somengkek", "sompilan", "somplak", "sompok", "sompret", "sonar", "sonata", "sondak", "sondek", "sondel", "sonder", "sondok", "sondol", "sondong", "soneta", "songar", "songel", "songket", "songkok", "songong", "sonik", "sono", "sonsong", "sontak", "sontok", "sontoloyo", "sop", "sopan", "sopi", "sopir", "sopran", "sorak", "sorang", "sorat", "sore", "sorek", "soren", "sorot", "sorp", "sortir", "sosial", "sosialis", "sosok", "sosor", "soto", "sotor", "soyak", "spanduk", "spasi", "spatula", "spesial", "spesifik", "spion", "spirit", "spons", "sponsor", "spora", "sport", "sportif", "spot", "sprint", "stadium", "staf", "staka", "stala", "stal", "stamin", "stamina", "standar", "stanza", "start", "stasiun", "statis", "statistik", "statistika", "status", "steker", "stempel", "stenografi", "stensil", "stepa", "stereo", "steril", "stiker", "stimulan", "stimulus", "stok", "stoker", "stola", "stop", "stoples", "strata", "strategi", "stres", "strip", "struktur", "studi", "studio", "sua", "suai", "suaka", "suami", "suamp", "suar", "suara", "suasana", "suatu", "subak", "subal", "subam", "suban", "subang", "subbab", "subhat", "subjek", "sublim", "subsidi", "substansi", "subuh", "subur", "subversif", "suci", "suda", "sudah", "sudara", "sudari", "sudet", "sudi", "sudip", "sudra", "sudu", "suduk", "sudung", "sudur", "sudut", "sufal", "sufi", "sufiks", "sugesti", "sugi", "sugih", "suguh", "sugul", "sugun", "suh", "suhad", "suhian", "suhu", "suhuf", "suhun", "suir", "sujadah", "sujana", "sujen", "suji", "sujud", "suka", "sukar", "sukarela", "sukaria", "sukat", "suket", "suki", "sukma", "sukses", "suksesi", "suku", "sukun", "sukur", "sula", "sulah", "sulai", "sulalat", "sulam", "sulang", "sulap", "sular", "sulawesi", "sule", "suler", "sulit", "suluh", "suluk", "sulung", "sulup", "sulur", "sulut", "sumarah", "sumarak", "sumatera", "sumatra", "sumba", "sumbah", "sumbak", "sumbang", "sumbar", "sumbat", "sumbel", "sumber", "sumbi", "sumbing", "sumbu", "sumbul", "sumbung", "sumbur", "sumedang", "sumeh", "sumeng", "suming", "sumir", "sumit", "sumpah", "sumpal", "sumpan", "sumpek", "sumper", "sumpil", "sumpit", "sumsum", "sumsum", "sumur", "sumur", "sunah", "sunan", "sunat", "sunatullah", "sunda", "sundal", "sundang", "sundel", "sundul", "sundung", "sungai", "sungga", "sunggi", "sungging", "sungguh", "sungkan", "sungkap", "sungkem", "sungkit", "sungku", "sungkur", "sungkup", "sungkur", "sungsum", "sungu", "sungut", "sunu", "sunut", "sunyi", "sup", "supa", "supaya", "super", "superior", "supit", "suplemen", "suplir", "suport", "supra", "supremasi", "surah", "surai", "suram", "surat", "surau", "surel", "surga", "surh", "suria", "surian", "surih", "surili", "suris", "surit", "suru", "suruh", "suruk", "surung", "surup", "surut", "survai", "survei", "susah", "susila", "suspensi", "susu", "susuh", "susuk", "susul", "susun", "susup", "susur", "susut", "sutan", "sutera", "sutil", "sutra", "suun", "suuzon", "swafoto", "swalayan", "swara", "swasta", "swatantra", "syabas", "syafaat", "syafiq", "syah", "syahadat", "syahdu", "syair", "syaitan", "syal", "syaman", "syamsi", "syara", "syaraf", "syarat", "syareat", "syari", "syariat", "syarif", "syarifah", "syauq", "syawal", "syekh", "syukur", "syur", "taala", "taat", "tabah", "tabak", "tabal", "taban", "tabar", "tabat", "tabel", "tabet", "tabi", "tabia", "tabiat", "tabib", "tabik", "tabir", "tabligh", "tablo", "tabloid", "tabok", "tabrak", "tabu", "tabuh", "tabun", "tabung", "tabur", "tabut", "tadah", "tadi", "tadir", "tadarus", "tadung", "tafakur", "tafsir", "tagak", "tagal", "tagan", "tagar", "tageh", "tagih", "tagut", "tahadi", "tahak", "tahan", "tahang", "tahap", "tahar", "tahat", "tahayul", "tahi", "tahiat", "tahil", "tahir", "tahis", "tahit", "tahu", "tahun", "taici", "taifun", "taiko", "taikun", "tail", "tailing", "tais", "tajak", "tajam", "tajap", "tajar", "tajau", "taji", "tajin", "tajuk", "tajul", "tajur", "tak", "taka", "takabur", "takad", "takah", "takak", "takal", "takan", "takap", "takar", "takat", "takbir", "takdir", "takel", "takhta", "taki", "takik", "takir", "takis", "takjub", "takkan", "taklim", "takluk", "takma", "takraw", "takrif", "takrim", "taksa", "taksir", "taksis", "taksi", "taktik", "taktis", "takuh", "takuk", "takun", "takut", "takwa", "takwil", "takzim", "talah", "talai", "talak", "talam", "talan", "talang", "talar", "talas", "talat", "talau", "talen", "talenta", "talib", "talik", "talim", "talis", "talkun", "talun", "talur", "tam", "tamadun", "tamah", "tamak", "tamam", "taman", "tamar", "tamasya", "tamat", "tambah", "tambak", "tambal", "tamban", "tambang", "tambar", "tambat", "tambi", "tambo", "tambul", "tambun", "tambung", "tambur", "tameng", "tamis", "tampah", "tampak", "tampan", "tampar", "tampas", "tampeh", "tampel", "tampi", "tampik", "tampil", "tampin", "tampir", "tampis", "tampok", "tampung", "tamsil", "tamtam", "tamuk", "tamun", "tanah", "tanai", "tanak", "tanam", "tanat", "tanau", "tanda", "tandak", "tandan", "tandang", "tandas", "tandat", "tandem", "tandes", "tandik", "tanding", "tandu", "tanduk", "tandun", "tandung", "tandur", "tang", "tangah", "tangal", "tangap", "tangar", "tangas", "tangat", "tangga", "tanggah", "tanggal", "tanggap", "tanggar", "tanggas", "tanggi", "tangguh", "tangguk", "tanggul", "tanggum", "tanggung", "tangis", "tangkah", "tangkai", "tangkal", "tangkan", "tangkap", "tangkar", "tangkas", "tangkat", "tangke", "tangkel", "tangki", "tangkil", "tangkis", "tangkit", "tangko", "tangku", "tangkue", "tangkul", "tangkup", "tangkur", "tangkut", "tangon", "tangsa", "tangsi", "tani", "tania", "tanis", "tanjak", "tanjal", "tanjan", "tanjar", "tanju", "tanjung", "tanjur", "tansi", "tantang", "tante", "tanti", "tantu", "tanur", "tanya", "tapa", "tapah", "tapai", "tapak", "tapan", "tapar", "tapas", "tapau", "tapel", "tapek", "taper", "tapi", "tapih", "tapik", "tapir", "tapis", "tapit", "taptu", "tapuk", "tapung", "tapur", "tapus", "taraf", "tarah", "tarai", "tarak", "taram", "taran", "tarang", "tarap", "taras", "tarat", "tarau", "tarekat", "tarek", "tari", "tarid", "tarikh", "taring", "taris", "target", "tariu", "tarka", "tarkas", "taruh", "taruk", "tarum", "taruna", "tarung", "tarup", "tarus", "tas", "tasah", "tasak", "tasan", "tasbih", "tasdik", "tasik", "taslim", "tasmak", "tasmik", "tasrif", "tastas", "tata", "tatah", "tatai", "tatak", "tatal", "tatam", "tatan", "tatang", "tatap", "tatar", "tatih", "tatik", "tatit", "tau", "taufan", "taufik", "tauge", "tauhid", "tauke", "taulan", "taum", "taurat", "taut", "tawaduk", "tawah", "tawai", "tawak", "tawakal", "tawan", "tawang", "tawas", "tawat", "tawe", "tawes", "tawur", "tayang", "tayar", "tayub", "tayum", "tayun", "teater", "tebah", "tebak", "tebal", "teban", "tebang", "tebar", "tebas", "tebat", "tebeh", "tebel", "teber", "tebet", "tebih", "tebis", "tebit", "tebok", "tebon", "tebus", "teces", "tedas", "tedeng", "teduh", "tegah", "tegak", "tegal", "tegang", "tegap", "tegar", "tegas", "teguh", "teguk", "tegur", "teh", "tekad", "tekah", "tekak", "tekap", "tekar", "tekat", "tekek", "tekel", "teken", "teker", "tekis", "teklok", "teknik", "teknis", "teko", "tekoh", "tekor", "tekos", "tekte", "tekua", "tekuk", "tekul", "tekun", "tekup", "tekur", "tela", "telah", "telaga", "telai", "telak", "telan", "telang", "telap", "telat", "telau", "telentang", "telepon", "teler", "teleskop", "televisi", "teliti", "telor", "teluh", "teluk", "telur", "telus", "telut", "temah", "temali", "temam", "teman", "temara", "temaram", "temas", "temat", "temau", "tembak", "tembakau", "tembam", "tembang", "tembar", "tembas", "tembeh", "tembel", "tember", "tembi", "tembuk", "tembung", "tembuni", "tembus", "temeh", "temen", "temet", "temon", "tempa", "tempah", "tempai", "tempak", "tempan", "tempang", "tempar", "tempas", "tempat", "tempel", "tempe", "tempel", "tempiar", "tempik", "tempil", "tempo", "tempua", "tempuh", "tempun", "tempur", "temu", "temuku", "temun", "temut", "tenaga", "tenang", "tenar", "tenda", "tendang", "tendas", "tender", "tengak", "tengal", "tengar", "tengat", "tenggak", "tenggan", "tenggar", "tenggek", "tengger", "tengging", "tenggorok", "tengik", "tengil", "tengkar", "tengking", "tengko", "tengku", "tengkuk", "tengkur", "tengu", "tenis", "tenjet", "tenong", "tensi", "tentu", "tenun", "tenung", "teori", "tep", "tepah", "tepak", "tepan", "tepas", "tepeh", "tepek", "teper", "tepi", "tepis", "tepok", "tepuk", "tepung", "tepus", "tera", "terah", "terai", "terajang", "terak", "teran", "terang", "terap", "teras", "terat", "teratai", "terau", "terawang", "terbang", "terbit", "terbus", "teri", "teriak", "terig", "terik", "terima", "terjang", "terjun", "terka", "terkam", "terkap", "terlalu", "terminal", "ternak", "terobos", "terong", "teropong", "tertawa", "tertib", "terubuk", "terum", "teruna", "terung", "terup", "terus", "tes", "tesis", "tetak", "tetal", "tetamp", "tetap", "tetapi", "tetas", "teter", "tetes", "tetua", "tewas", "tiada", "tiang", "tiap", "tiarap", "tiba", "tiban", "tidak", "tidor", "tiga", "tigel", "tihul", "tijak", "tik", "tika", "tikam", "tikar", "tiket", "tikis", "tikit", "tiku", "tikus", "tilam", "tilan", "tilap", "tilas", "tilik", "tilur", "tim", "timah", "timang", "timba", "timbal", "timbang", "timbau", "timbi", "timbil", "timbul", "timbun", "timbur", "timit", "timpa", "timpal", "timpang", "timpas", "timpi", "timpus", "timu", "timun", "timus", "tin", "tindak", "tindas", "tindih", "tindis", "tinggal", "tinggi", "tinggung", "tingkah", "tingkal", "tingkap", "tingkat", "tingkepi", "tingkil", "tingkir", "tingkis", "tingkuh", "tinja", "tinjau", "tinju", "tinta", "tipak", "tipar", "tipas", "tipes", "tipis", "tipu", "tipus", "tirah", "tirai", "tiram", "tiran", "tiras", "tirat", "tiri", "tiris", "tiru", "tirus", "tisak", "tisik", "tisin", "tistis", "titah", "titar", "titay", "titi", "titik", "titip", "titir", "titis", "titit", "tiung", "tiup", "tiwul", "tobak", "tobat", "tobel", "toblos", "todong", "toga", "togok", "tohor", "tojok", "tok", "tokak", "tokek", "toko", "tokok", "tokong", "tokop", "tolak", "tolan", "tolap", "toleh", "tolok", "tolol", "tolong", "toma", "tomat", "tombak", "tombol", "tombong", "tomong", "tompel", "tong", "tonggak", "tongkang", "tongkat", "tongkol", "tongon", "tongos", "tonton", "top", "topan", "topang", "topdal", "topek", "topeng", "topi", "topik", "topong", "torak", "toreh", "torek", "torkhas", "torne", "torpedo", "torsi", "tortor", "total", "totok", "totol", "towak", "tua", "tuah", "tuai", "tuak", "tual", "tualang", "tuan", "tuang", "tuanku", "tuat", "tuba", "tuban", "tubes", "tubin", "tubir", "tubuh", "tubuh", "tubun", "tuding", "tuduh", "tudung", "tugal", "tugas", "tugu", "tuh", "tuhan", "tuhur", "tui", "tuju", "tujuh", "tujul", "tukak", "tukal", "tukam", "tukang", "tukar", "tukas", "tukat", "tukik", "tukil", "tukul", "tukung", "tukup", "tulah", "tulang", "tular", "tulat", "tule", "tulen", "tuli", "tulis", "tulus", "tuma", "tuman", "tumang", "tumbak", "tumbal", "tumbang", "tumbas", "tumbuh", "tumbuk", "tumis", "tumit", "tumor", "tumpah", "tumpak", "tumpang", "tumpas", "tumpat", "tumpeng", "tumpes", "tumpil", "tumpu", "tumpuk", "tumpul", "tumpur", "tuna", "tunai", "tunak", "tunam", "tunas", "tunda", "tundang", "tunduk", "tundun", "tunggu", "tungka", "tungkah", "tungkai", "tungkak", "tungkap", "tungku", "tungkul", "tungkup", "tungkus", "tunjang", "tunjuk", "tunjung", "tuntas", "tuntun", "tuntut", "tunu", "tupai", "tur", "tural", "turan", "turap", "turas", "turba", "ture", "turi", "turis", "turun", "turus", "turut", "tus", "tustel", "tusuk", "tutup", "tutur", "uai", "uak", "uan", "uang", "uap", "uar", "ubah", "uban", "ubar", "ubat", "ubek", "ubel", "ubet", "ubik", "ubin", "ubit", "ubrak", "ubur", "ucap", "ucek", "ucer", "ucil", "ucu", "udang", "udara", "udat", "udek", "udel", "udet", "udik", "udu", "uduk", "udur", "udut", "uga", "ugahari", "ugama", "uget", "ugut", "uik", "uir", "uja", "ujana", "ujar", "uji", "ujub", "ujud", "ujul", "ujung", "ukik", "ukir", "ukrit", "ukup", "ukur", "ulah", "ulai", "ulak", "ulam", "ulan", "ulang", "ulap", "ular", "ulas", "ulat", "ule", "ulek", "uler", "ulet", "uli", "ulir", "ulun", "ulung", "ulup", "ulur", "umah", "umara", "umat", "umbai", "umbak", "umban", "umbar", "umbat", "umbi", "umbuk", "umbul", "umbun", "umbur", "umbut", "umpama", "umpan", "umpat", "umpet", "umpil", "umpuk", "umpun", "umum", "umur", "umut", "unak", "unam", "unan", "unar", "uncang", "uncat", "unce", "uncui", "unda", "undak", "undan", "undang", "undas", "undat", "undel", "unduh", "unduk", "undul", "undur", "ungap", "ungar", "ungat", "unggak", "unggal", "unggang", "unggat", "unggel", "unggi", "unggit", "unggu", "unggul", "unggun", "unggut", "ungkah", "ungkap", "ungkil", "ungkir", "ungkit", "ungkur", "ungti", "ungu", "ungum", "ungun", "ungut", "uni", "unik", "unit", "unja", "unjak", "unjal", "unjat", "unjuk", "unjun", "unjut", "unok", "unsang", "unsur", "unta", "untai", "untal", "untang", "untar", "untas", "untel", "untit", "untuk", "untun", "untung", "untut", "unyai", "upacara", "upadana", "upah", "upak", "upam", "upan", "upar", "upas", "upat", "upaya", "upet", "upeti", "upih", "upik", "upir", "upis", "upit", "upok", "ura", "urai", "urak", "uram", "uran", "urang", "urap", "uras", "urat", "urau", "uray", "urdo", "urdu", "urek", "urem", "uret", "urgen", "uri", "urian", "urik", "uril", "urim", "urin", "uris", "urit", "uruk", "urung", "urup", "urus", "urut", "uruy", "usah", "usaha", "usak", "usam", "usang", "usap", "usar", "usat", "usia", "usai", "usik", "usil", "usir", "uskup", "usrek", "ustad", "ustadz", "usul", "usung", "usur", "usus", "usut", "utah", "utai", "utama", "utan", "utara", "utas", "utih", "utik", "utuh", "utus", "uud", "uvula", "uyup", "uzlah", "uzur", "vak", "vakansi", "vaksi", "vaksin", "vakum", "valas", "valen", "valensi", "valid", "valis", "valor", "valuta", "vampir", "vana", "vanili", "vari", "variabel", "varian", "variasi", "variasi", "varietas", "varises", "varna", "vas", "vaskular", "vater", "vatikan", "vau", "vege", "vegetar", "vektor", "velbet", "velg", "vena", "vendor", "ventil", "ventilasi", "venus", "verba", "verbal", "verifikasi", "verlak", "vermak", "vermes", "vermut", "vernik", "versi", "verset", "verstek", "versteng", "versu", "vertebra", "vertex", "vertikal", "vespa", "veta", "veter", "veteran", "veto", "vetsin", "via", "viaduk", "vial", "vibrasi", "video", "vidio", "vignette", "vihara", "viking", "vila", "vimpler", "vinal", "vinet", "vinil", "vinyet", "viola", "biola", "biol", "biopsi", "bir", "bira", "birah", "birai", "biram", "birama", "birang", "biras", "birat", "bird", "vireo", "virgin", "virgo", "virid", "viril", "virologi", "virtu", "virtual", "virtuosi", "virulen", "virus", "visa", "visi", "visibel", "visiku", "visioner", "visit", "visitem", "visiting", "visitor", "vista", "visual", "vital", "vitalitas", "vitamin", "viva", "vivi", "vivipar", "vlak", "vlog", "vobla", "voda", "vodka", "vokal", "vokalis", "vokasi", "vokat", "vokatif", "volatil", "voli", "volt", "volta", "voltase", "volum", "volume", "vonis", "vorteks", "votum", "vover", "vroom", "vulgar", "vulkan", "vulkanis", "vulkanisir", "vulva", "waadat", "wabah", "wabak", "wacana", "wadah", "wadak", "wadal", "wadam", "wadang", "wadas", "wadat", "wadau", "waduk", "wadung", "wafat", "wagon", "wah", "wahah", "wahai", "waham", "wahana", "wahar", "wahid", "wahon", "wahyu", "wai", "waisya", "wait", "wajah", "wajan", "wajar", "wajib", "wajik", "wajit", "waka", "wakaf", "wakil", "waktu", "wakun", "walad", "walafiat", "walah", "walaka", "walang", "walat", "walau", "wale", "walet", "wali", "walimah", "walimatul", "walisongo", "walker", "walkie", "wallah", "wallahu", "walpa", "walter", "waluh", "waluku", "wan", "wanda", "wang", "wangi", "wangkang", "wangsa", "wangun", "wanita", "wanodya", "wanra", "wanta", "wanter", "waqaf", "wara", "warak", "warangan", "waras", "warat", "warda", "wardi", "warga", "waria", "warid", "waris", "warisan", "warkat", "warna", "warnasari", "warok", "warsa", "warta", "wartawan", "wartel", "warung", "wasak", "wasalam", "wasangka", "wasbak", "wase", "wasek", "wasi", "wasiat", "wasil", "wasilah", "wasir", "wasit", "waslah", "waslap", "waspada", "waswas", "wat", "watak", "watan", "watas", "wates", "watt", "watun", "wawancara", "wawas", "wawasan", "way", "wayang", "wayuh", "we", "wedana", "wedang", "wedar", "wedatama", "wedel", "wedi", "weduk", "weher", "wejang", "weka", "wekas", "wekel", "weker", "welang", "welas", "welat", "welit", "welut", "wenang", "wenas", "wendi", "wengku", "wenter", "wera", "werda", "werdi", "werit", "werkudara", "werst", "wert", "wes", "wesel", "wesket", "wester", "wet", "wetan", "wewe", "wiaya", "wibawa", "wicara", "wicu", "wida", "widada", "widak", "widang", "widara", "widuri", "widyaiswara", "wihara", "wijaya", "wijayakusuma", "wijen", "wika", "wiladah", "wilayah", "wilayat", "wilis", "wimana", "winaya", "windu", "wingit", "winglet", "wira", "wirama", "wirang", "wirasa", "wirasta", "wiratama", "wirawan", "wiri", "wirid", "wiron", "wiru", "wisata", "wisatawan", "wisaya", "wisik", "wisuda", "wisudawan", "wita", "witir", "wiwaha", "wiweka", "wiwit", "wizurai", "wol", "wolanda", "wolfram", "wonder", "wong", "wortel", "wreda", "wredatama", "wudu", "wujud", "wukuf", "wulang", "wulung", "wungu", "wutuh", "xenia", "xenofobia", "xenon", "xerografi", "xeroks", "xilem", "xilofon", "ya", "yaani", "yabai", "yabani", "yadi", "yahad", "yahud", "yahudi", "yahum", "yaitu", "yakin", "yakit", "yakni", "yaksa", "yakub", "yakun", "yakut", "yakuza", "yam", "yaman", "yamani", "yamin", "yang", "yantra", "yapa", "yapi", "yarad", "yara", "yasan", "yasin", "yasti", "yatim", "yaum", "yaumul", "yayasan", "yayi", "yayu", "yoga", "yogi", "yogya", "yohimbine", "yojana", "yoker", "yolat", "yoyo", "yuda", "yudikatif", "yudisial", "yudisium", "yuget", "yugo", "yunda", "yunani", "yunior", "yunta", "yuran", "yure", "yuridis", "yuris", "yurisdiksi", "yurisprudensi", "yuta", "yuwana", "yuyu", "zabad", "zabah", "zabaniah", "zabarjad", "zabib", "zabit", "zabur", "zadah", "zahid", "zahir", "zaitun", "zakat", "zakar", "zakir", "zakum", "zalim", "zalir", "zaman", "zambak", "zamrud", "zamzam", "zanda", "zanggi", "zani", "zapin", "zarah", "zauj", "zaujah", "zayun", "zebra", "zebu", "zen", "zenith", "ziarah", "zig-zag", "zikir", "zillullah", "zina", "zindik", "zink", "zionisme", "zirah", "zirkon", "zodiak", "zonasi", "zonk", "zoologi", "zorbing", "zuama", "zuhad", "zuhud", "zuhur", "zulham", "zulhijah", "zulkaidah", "zulmat", "zulu", "zurat", "zuriah"
}

-- ==================== 2. CONFIG & STATE ====================
local Config = {
    -- Auto Play Settings
    AutoActive = false,
    GameMode = "Sambung Akhiran",
    ContinuationOnly = true,
    RetryDelay = 2.5,
    
    -- Trap Settings
    TrapEnabled = true,
    TrapDifficulty = "Extreme (X, V, Z, Q)",
    
    -- Typing Profile
    TypingProfile = "Natural Human",
    DelayBeforeType = 0.4,
    TypingSpeed = 0.05,
    TypoChance = 3,
    
    -- System
    ESPEnabled = false,
    AntiAFK = true,
    Blacklist = {"ZAT", "SKOR", "MENU", "WAKTU", "MENANG", "KALAH", "LEVEL", "RANK", "WAIT"}
}

local State = {
    UsedWords = {},
    IndexedDB = {},
    LastPrompt = "",
    CurrentMatches = {},
    MatchIndex = 1,
    IsBusy = false,
    TotalDB = #kataKBBI,
    CountUsed = 0,
}

-- Trap Difficulty Dictionary
local TrapDict = {
    ["Extreme (X, V, Z, Q)"] = {X=true, V=true, Z=true, Q=true},
    ["Hard (F, W, Y)"] = {F=true, W=true, Y=true},
    ["Medium (J, P, G)"] = {J=true, P=true, G=true}
}

-- Fast Indexing A-Z
local function rebuildIndex()
    State.IndexedDB = {}
    for _, word in ipairs(kataKBBI) do
        local upper = word:upper()
        local first = upper:sub(1,1)
        if not State.IndexedDB[first] then State.IndexedDB[first] = {} end
        table.insert(State.IndexedDB[first], upper)
    end
end
rebuildIndex()

-- ==================== 3. INTERACTIVE ESP (CLICKABLE) ====================
local ESPGui = Instance.new("ScreenGui", game.CoreGui)
ESPGui.Name = "InteractiveESP"
ESPGui.Enabled = false

local ESPFrame = Instance.new("Frame", ESPGui)
ESPFrame.Size = UDim2.new(0, 220, 0, 220)
ESPFrame.Position = UDim2.new(0.65, 0, 0.3, 0)
ESPFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ESPFrame.BackgroundTransparency = 0.15
ESPFrame.Active = true
ESPFrame.Draggable = true -- Bisa digeser di layar
Instance.new("UICorner", ESPFrame).CornerRadius = UDim.new(0, 10)

local ESPTitle = Instance.new("TextLabel", ESPFrame)
ESPTitle.Size = UDim2.new(1, 0, 0, 30)
ESPTitle.BackgroundTransparency = 1
ESPTitle.Text = "💡 KLIK UNTUK JAWAB"
ESPTitle.TextColor3 = Color3.fromRGB(0, 255, 150)
ESPTitle.Font = Enum.Font.GothamBold
ESPTitle.TextSize = 14

local ESPSoal = Instance.new("TextLabel", ESPFrame)
ESPSoal.Size = UDim2.new(1, 0, 0, 25)
ESPSoal.Position = UDim2.new(0, 0, 0, 25)
ESPSoal.BackgroundTransparency = 1
ESPSoal.Text = "Soal: -"
ESPSoal.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPSoal.Font = Enum.Font.Gotham
ESPSoal.TextSize = 13

-- Buat 5 Tombol Opsi
local ESPBtns = {}
for i = 1, 5 do
    local btn = Instance.new("TextButton", ESPFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 28)
    btn.Position = UDim2.new(0.05, 0, 0, 20 + (i * 32))
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.Text = "Menunggu..."
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.Visible = false
    ESPBtns[i] = btn
end

-- ==================== 4. ENGINE LOGIC ====================
local function forceClear()
    for i = 1, 25 do
        VIM:SendKeyEvent(true, Enum.KeyCode.Backspace, false, game)
        task.wait(0.005)
        VIM:SendKeyEvent(false, Enum.KeyCode.Backspace, false, game)
    end
    task.wait(0.05)
end

local function applyTypingProfile()
    if Config.TypingProfile == "Godspeed (Instan)" then
        Config.DelayBeforeType = 0.05
        Config.TypingSpeed = 0.01
        Config.TypoChance = 0
    elseif Config.TypingProfile == "Natural Human" then
        Config.DelayBeforeType = 0.4
        Config.TypingSpeed = 0.05
        Config.TypoChance = 3
    elseif Config.TypingProfile == "Clumsy (Banyak Typo)" then
        Config.DelayBeforeType = 0.7
        Config.TypingSpeed = 0.09
        Config.TypoChance = 12
    end
end

local function getPrefixList(teks)
    teks = teks:upper():gsub("%s+", ""):match("%a+")
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

local function get5Options(awalan)
    awalan = awalan:upper()
    local firstLetter = awalan:sub(1,1)
    local candidates = State.IndexedDB[firstLetter] or {}
    local validWords = {}

    -- Cek kata yang valid dan BELUM PERNAH DIPAKAI
    for _, kata in ipairs(candidates) do
        if kata:sub(1, #awalan) == awalan and not State.UsedWords[kata] and #kata > #awalan then
            table.insert(validWords, kata)
        end
    end

    -- Acak Urutan Biar Natural
    for i = #validWords, 2, -1 do
        local j = math.random(i)
        validWords[i], validWords[j] = validWords[j], validWords[i]
    end

    local finalResults = {}
    local activeTraps = TrapDict[Config.TrapDifficulty] or {}

    -- Filter 1: Masukkan kata jebakan sesuai Difficulty
    if Config.TrapEnabled then
        for i = #validWords, 1, -1 do
            local kata = validWords[i]
            if activeTraps[kata:sub(-1)] then 
                table.insert(finalResults, {word = kata, pref = awalan})
                table.remove(validWords, i)
            end
        end
    end
    
    -- Filter 2: Masukkan sisa kata biasa sampai 5 opsi
    for i=1, math.min(5 - #finalResults, #validWords) do
        table.insert(finalResults, {word = validWords[i], pref = awalan})
    end
    
    return finalResults
end

local function ketikOpsi(data)
    if State.IsBusy then return end
    State.IsBusy = true
    applyTypingProfile()
    
    local word = data.word
    local prefix = data.pref
    
    forceClear() -- Bersihkan input
    
    local text = word
    if Config.ContinuationOnly and word:sub(1, #prefix) == prefix then
        text = word:sub(#prefix + 1)
    end

    for i = 1, #text do
        local char = text:sub(i, i)
        
        -- Simulasi Typo
        if math.random(1, 100) <= Config.TypoChance then
            local salah = string.char(math.random(65, 90))
            VIM:SendKeyEvent(true, salah, false, game)
            task.wait(0.05)
            VIM:SendKeyEvent(false, salah, false, game)
            task.wait(0.1)
            VIM:SendKeyEvent(true, Enum.KeyCode.Backspace, false, game)
            task.wait(0.05)
            VIM:SendKeyEvent(false, Enum.KeyCode.Backspace, false, game)
        end

        local key = Enum.KeyCode[char]
        if key then
            VIM:SendKeyEvent(true, key, false, game)
            task.wait(0.02)
            VIM:SendKeyEvent(false, key, false, game)
            task.wait(Config.TypingSpeed)
        end
    end
    
    task.wait(0.1)
    VIM:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
    VIM:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
    
    -- TANDAI KATA SUDAH DIPAKAI
    State.UsedWords[word] = true
    State.CountUsed = State.CountUsed + 1
    State.IsBusy = false
end

-- HUBUNGKAN TOMBOL ESP DENGAN FUNGSI KETIK
for i, btn in ipairs(ESPBtns) do
    btn.MouseButton1Click:Connect(function()
        if State.CurrentMatches[i] then
            ketikOpsi(State.CurrentMatches[i])
            -- Sembunyikan tombol setelah diklik agar tidak spam
            for _, b in ipairs(ESPBtns) do b.Visible = false end
            ESPSoal.Text = "Mengetik: " .. State.CurrentMatches[i].word
        end
    end)
end

-- ==================== 5. RAYFIELD UI ====================
local Window = Rayfield:CreateWindow({
    Name = "Sambung Kata | PERFECT V7",
    LoadingTitle = "Interactive ESP & Smart Retry",
    ConfigurationSaving = { Enabled = false }
})

local DashTab = Window:CreateTab("🏠 Dashboard", 4483362458)
local AutoTab = Window:CreateTab("🎮 Main System", 4483362458)
local TypeTab = Window:CreateTab("⌨️ Typing Style", 4483362458)
local TrapTab = Window:CreateTab("🪤 Trap Engine", 4483362458)

-- DASHBOARD
local LblDB = DashTab:CreateLabel("📚 Total Database: " .. State.TotalDB)
local LblUsed = DashTab:CreateLabel("🔥 Kata Dipakai Ronde Ini: 0")
DashTab:CreateButton({
    Name = "♻️ RESET RONDE (HAPUS HISTORY KATA)",
    Callback = function() 
        State.UsedWords = {} 
        State.CountUsed = 0
        State.LastPrompt = ""
        LblUsed:Set("🔥 Kata Dipakai Ronde Ini: 0")
        Rayfield:Notify({Title="Reset", Content="Kata yang terpakai telah dibersihkan!"}) 
    end
})

-- MAIN SYSTEM
AutoTab:CreateSection("Mode Bermain")
AutoTab:CreateToggle({
    Name = "🤖 Full Auto-Bot (Otomatis Jawab & Retry)", CurrentValue = false,
    Callback = function(v) Config.AutoActive = v end
})
AutoTab:CreateToggle({
    Name = "🖱️ Tampilkan Interactive ESP (Klik Jawab)", CurrentValue = false,
    Callback = function(v) Config.ESPMode = v; ESPGui.Enabled = v end
})
AutoTab:CreateToggle({
    Name = "Anti-Double (Ketik Sambungan Saja)", CurrentValue = true,
    Callback = function(v) Config.ContinuationOnly = v end
})

-- TYPING STYLE
TypeTab:CreateSection("Pilih Gaya Mengetik Bot")
TypeTab:CreateDropdown({
    Name = "Profile Kecepatan & Typo",
    Options = {"Godspeed (Instan)", "Natural Human", "Clumsy (Banyak Typo)"},
    CurrentOption = {"Natural Human"}, MultipleOptions = false,
    Callback = function(v) Config.TypingProfile = v[1]; applyTypingProfile() end
})

-- TRAP ENGINE
TrapTab:CreateSection("Setting Akhiran Jebakan")
TrapTab:CreateToggle({
    Name = "Aktifkan Prioritas Kata Jebakan", CurrentValue = true,
    Callback = function(v) Config.TrapEnabled = v end
})
TrapTab:CreateDropdown({
    Name = "Tingkat Kesulitan Jebakan",
    Options = {"Extreme (X, V, Z, Q)", "Hard (F, W, Y)", "Medium (J, P, G)"},
    CurrentOption = {"Extreme (X, V, Z, Q)"}, MultipleOptions = false,
    Callback = function(v) Config.TrapDifficulty = v[1] end
})

-- ==================== 6. SMART DETECTOR LOOP ====================

-- Anti AFK
LP.Idled:Connect(function()
    if Config.AntiAFK then
        VU:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VU:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

task.spawn(function()
    while task.wait(0.4) do
        -- Hanya scan jika AutoBot ATAU ESP aktif
        if (Config.AutoActive or Config.ESPMode) and not State.IsBusy then
            local detectText = ""
            local foundUI = nil

            -- AUTO-SCANNER (Anti ZAT / Anti Menu)
            for _, ui in pairs(LP.PlayerGui:GetDescendants()) do
                if (ui:IsA("TextLabel") or ui:IsA("TextBox")) and ui.Visible and ui.Text ~= "" then
                    local t = ui.Text:upper():gsub("%s+", "")
                    
                    local isTrash = false
                    for _, b in ipairs(Config.Blacklist) do
                        if t:find(b) then isTrash = true break end
                    end

                    if not isTrash and t:match("%a+") and #t >= 1 and #t <= 20 and not t:match("^%d+$") then
                        local n = ui.Name:upper()
                        if n:find("WORD") or n:find("KATA") or n:find("SOAL") or n:find("LABEL") then
                            foundUI = ui
                            detectText = t
                            break
                        end
                    end
                end
            end

            -- JIKA DITEMUKAN SOAL
            if foundUI then
                local cleanText = detectText:match(":(%a+)") or detectText:match("%a+$") or detectText
                
                if cleanText ~= State.LastPrompt then
                    State.LastPrompt = cleanText
                    
                    -- Dapatkan Prefix yang mungkin (3, 2, atau 1 huruf)
                    local prefixes = getPrefixList(cleanText)
                    State.CurrentMatches = {}
                    local chosenPref = ""
                    
                    for _, pre in ipairs(prefixes) do
                        State.CurrentMatches = get5Options(pre)
                        if #State.CurrentMatches > 0 then chosenPref = pre break end
                    end
                    
                    if #State.CurrentMatches > 0 then
                        -- UPDATE INTERACTIVE ESP
                        if Config.ESPMode then
                            ESPSoal.Text = "Soal: " .. cleanText
                            for i=1, 5 do
                                if State.CurrentMatches[i] then
                                    ESPBtns[i].Text = i .. ". " .. State.CurrentMatches[i].word
                                    ESPBtns[i].Visible = true
                                else
                                    ESPBtns[i].Visible = false
                                end
                            end
                        end

                        -- AUTO KETIK (Jika Auto-Bot ON)
                        if Config.AutoActive then
                            task.wait(Config.DelayBeforeType)
                            ketikOpsi(State.CurrentMatches[1])
                            
                            -- Cek 2.5 detik kemudian, jika soal masih sama berarti gagal, hapus dan coba kata kedua
                            task.wait(Config.RetryDelay)
                            if foundUI.Text:upper():gsub("%s+", "") == detectText and State.CurrentMatches[2] then
                                ketikOpsi(State.CurrentMatches[2])
                            end
                        end
                        
                        -- Update Dashboard Stat
                        LblUsed:Set("🔥 Kata Dipakai Ronde Ini: " .. State.CountUsed)
                    end
                end
            end
        end
    end
end)
