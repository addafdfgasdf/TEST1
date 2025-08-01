-- Универсальная функция задержки
local function waitSeconds(sec)
    local start = tick()
    repeat game:GetService("RunService").Heartbeat:wait() until tick() - start >= sec
end

-- Основная функция атаки
local function executeAttackSequence()
    -- === Блок 1: Атаки из загруженного файла (все подряд с 0.15 сек) ===
    local attacks = {
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(115.69571685791016, 58.3268928527832, -409.8924560546875),
            D = vector.create(0.019397510215640068, -0.9419409036636353, -0.3352179527282715),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(116.23494720458984, 5.945230484008789, -419.8333740234375),
            HP = vector.create(116.2313232421875, 5.865042686462402, -419.8741760253906),
            RS = vector.create(116.23494720458984, 5.945230484008789, -419.8333740234375)
        },
        {
            ALV = vector.create(0.16295383870601654, -392.1344909667969, -2.661980628967285),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(116.87561798095703, 0.31051912903785706, -430.3683776855469)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(115.62783813476562, 191.25375366210938, -302.9499206542969),
            D = vector.create(0.01035215426236391, -0.9286769032478333, -0.37074556946754456),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(115.6452407836914, 5.849944114685059, -349.2359313964844),
            HP = vector.create(115.63875579833984, 5.770416259765625, -349.1942138671875),
            RS = vector.create(115.6452407836914, 5.849944114685059, -349.2359313964844)
        },
        {
            ALV = vector.create(0.5277670621871948, -392.978515625, -7.489195823669434),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(117.75045776367188, -1.3132237195968628, -379.08624267578125)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(115.60836029052734, 191.24598693847656, -277.78460693359375),
            D = vector.create(0.005865023005753756, -0.9514943361282349, -0.30761048197746277),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(115.09434509277344, 5.95564079284668, -323.92950439453125),
            HP = vector.create(115.09793090820312, 5.8752336502075195, -323.8891296386719),
            RS = vector.create(115.09434509277344, 5.95564079284668, -323.92950439453125)
        },
        {
            ALV = vector.create(0.42253631353378296, -392.9546813964844, -3.8825953006744385),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(116.78780364990234, -1.3528742790222168, -339.3464660644531)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(119.90447235107422, 178.878662109375, -242.3394775390625),
            D = vector.create(-0.010386792942881584, -0.8947662711143494, -0.44641396403312683),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(115.61795043945312, 5.941355228424072, -319.42987060546875),
            HP = vector.create(115.61312103271484, 5.861145973205566, -319.47052001953125),
            RS = vector.create(115.61795043945312, 5.941355228424072, -319.42987060546875)
        },
        {
            ALV = vector.create(0.5532792806625366, -393.8188781738281, -3.004709005355835),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(117.83305358886719, -3.0505478382110596, -331.36578369140625)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(102.8530502319336, 168.5330047607422, -178.84620666503906),
            D = vector.create(0.07678429782390594, -0.8831703662872314, -0.46272480487823486),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(133.63441467285156, 5.955195426940918, -275.3751220703125),
            HP = vector.create(133.59854125976562, 5.874794006347656, -275.35626220703125),
            RS = vector.create(133.63441467285156, 5.955195426940918, -275.3751220703125)
        },
        {
            ALV = vector.create(-4.038083076477051, -391.36981201171875, 2.0929274559020996),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(117.51171112060547, 1.969130039215088, -266.944091796875)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(74.99716186523438, 73.21112823486328, -230.42068481445312),
            D = vector.create(-0.27858445048332214, -0.7889572978019714, -0.547664999961853),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(80.17918395996094, 5.758800506591797, -277.41046142578125),
            HP = vector.create(80.1427993774414, 5.678632736206055, -277.4293212890625),
            RS = vector.create(80.17918395996094, 5.758800506591797, -277.41046142578125)
        },
        {
            ALV = vector.create(-7.745800971984863, -394.6235656738281, -0.9330183863639832),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(49.206268310546875, -4.813029766082764, -281.07781982421875)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(-12.55128002166748, 70.58998107910156, -297.0608825683594),
            D = vector.create(0.12946009635925293, -0.6726154685020447, -0.7285798788070679),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(-8.998330116271973, 5.7679524421691895, -348.9533996582031),
            HP = vector.create(-9.03905963897705, 5.687656402587891, -348.952392578125),
            RS = vector.create(-8.998330116271973, 5.7679524421691895, -348.9533996582031)
        },
        {
            ALV = vector.create(2.5040884017944336, -389.7334899902344, -6.117320537567139),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(0.9564470648765564, 5.05893087387085, -373.2332763671875)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(-57.7851448059082, 68.54579162597656, -298.1429748535156),
            D = vector.create(-0.18583227694034576, -0.6635976433753967, -0.7246409058570862),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(-49.15531921386719, 5.784631252288818, -352.1299743652344),
            HP = vector.create(-49.195613861083984, 5.704111576080322, -352.1304626464844),
            RS = vector.create(-49.15531921386719, 5.784631252288818, -352.1299743652344)
        },
        {
            ALV = vector.create(-6.949793338775635, -391.37091064453125, -5.1904520988464355),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(-76.85317993164062, 1.0969867706298828, -372.7726745605469)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(-5.688653469085693, 105.00970458984375, -120.73387145996094),
            D = vector.create(0.129168301820755, -0.7067979574203491, -0.6955230236053467),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(-2.027320146560669, 5.9927873611450195, -197.9250030517578),
            HP = vector.create(-1.9875215291976929, 5.912022590637207, -197.92442321777344),
            RS = vector.create(-2.027320146560669, 5.9927873611450195, -197.9250030517578)
        },
        {
            ALV = vector.create(3.8697550296783447, -393.832275390625, -6.468611240386963),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(13.435490608215332, -3.0032143592834473, -223.72525024414062)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(-50.88260269165039, 111.44535064697266, -126.59466552734375),
            D = vector.create(0.040209293365478516, -0.8316124677658081, -0.5538988709449768),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(-45.486366271972656, 5.961657524108887, -192.46221923828125),
            HP = vector.create(-45.48588180541992, 5.881308555603027, -192.5028533935547),
            RS = vector.create(-45.486366271972656, 5.961657524108887, -192.46221923828125)
        },
        {
            ALV = vector.create(-0.005270484834909439, -392.18865966796875, -2.0447447299957275),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(-45.51305389404297, 0.15979081392288208, -200.54776000976562)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(-112.53072357177734, 93.3319091796875, -80.11424255371094),
            D = vector.create(0.005410239100456238, -0.5062837600708008, -0.8623499274253845),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(-104.98814392089844, 6.9641523361206055, -169.0333709716797),
            HP = vector.create(-104.97245025634766, 6.883716583251953, -169.07066345214844),
            RS = vector.create(-104.98814392089844, 6.9641523361206055, -169.0333709716797)
        },
        {
            ALV = vector.create(-1.639684796333313, -394.64215087890625, -16.970989227294922),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(-111.5490951538086, -3.5460798740386963, -236.94122314453125)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(-197.76470947265625, 104.82242584228516, -234.55340576171875),
            D = vector.create(0.36147117614746094, -0.7255814671516418, -0.5855509638786316),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(-153.72023010253906, 5.748726844787598, -296.4005432128906),
            HP = vector.create(-153.7236328125, 5.668702125549316, -296.441650390625),
            RS = vector.create(-153.72023010253906, 5.748726844787598, -296.4005432128906)
        },
        {
            ALV = vector.create(2.0322396755218506, -392.1805419921875, -5.667448043823242),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(-145.6455078125, -0.0246426984667778, -318.97607421875)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(-192.40884399414062, 115.95780181884766, -298.7122802734375),
            D = vector.create(0.12428833544254303, -0.8051581978797913, -0.5798901319503784),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(-180.3611297607422, 5.937141418457031, -356.3271484375),
            HP = vector.create(-180.3717041015625, 5.856991767883301, -356.3667907714844),
            RS = vector.create(-180.3611297607422, 5.937141418457031, -356.3271484375)
        },
        {
            ALV = vector.create(1.4137998819351196, -391.9329528808594, -6.245779514312744),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(-174.73300170898438, 1.2981230020523071, -381.1946105957031)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(-98.27493286132812, 105.71121215820312, -361.5629577636719),
            D = vector.create(-0.13883526623249054, -0.7034880518913269, -0.697014570236206),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(-105.44613647460938, 6.9333977699279785, -439.49896240234375),
            HP = vector.create(-105.48722076416016, 6.853301048278809, -439.49688720703125),
            RS = vector.create(-105.44613647460938, 6.9333977699279785, -439.49896240234375)
        },
        {
            ALV = vector.create(-3.399404287338257, -391.56353759765625, -6.583316802978516),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(-118.98374938964844, 1.7599925994873047, -465.689697265625)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(-63.60953903198242, 105.40636444091797, -363.3438415527344),
            D = vector.create(-0.055802371352910995, -0.7107293605804443, -0.7012487053871155),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(-68.07377624511719, 6.945224761962891, -440.3459167480469),
            HP = vector.create(-68.03736877441406, 6.86503791809082, -440.3646545410156),
            RS = vector.create(-68.07377624511719, 6.945224761962891, -440.3459167480469)
        },
        {
            ALV = vector.create(-0.9460899233818054, -394.0506286621094, -6.663477897644043),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(-71.84742736816406, -3.123443126678467, -466.93646240234375)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(-10.771059036254883, 99.70913696289062, -365.68560791015625),
            D = vector.create(-0.03027655929327011, -0.6983663439750671, -0.7150997519493103),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(-11.126043319702148, 5.962711334228516, -448.1564636230469),
            HP = vector.create(-11.091602325439453, 5.882351875305176, -448.177978515625),
            RS = vector.create(-11.126043319702148, 5.962711334228516, -448.1564636230469)
        },
        {
            ALV = vector.create(-0.9866560101509094, -393.7730407714844, -4.785671710968018),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(-15.070676803588867, -3.4876482486724854, -467.2367248535156)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(14.679253578186035, 90.13756561279297, -352.7801818847656),
            D = vector.create(-0.09540807455778122, -0.6128012537956238, -0.7844563126564026),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(6.8887248039245605, 5.935487747192383, -443.7734375),
            HP = vector.create(6.877773761749268, 5.8553619384765625, -443.8130187988281),
            RS = vector.create(6.8887248039245605, 5.935487747192383, -443.7734375)
        },
        {
            ALV = vector.create(-1.5423723459243774, -393.76763916015625, -5.946815013885498),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(0.7257459163665771, -2.6863670349121094, -467.50872802734375)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(98.42890930175781, 112.23294067382812, -361.8180847167969),
            D = vector.create(-0.27174219489097595, -0.7000753283500671, -0.6603413820266724),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(89.42535400390625, 6.935125350952148, -427.6443786621094),
            HP = vector.create(89.41368865966797, 6.855037689208984, -427.683837890625),
            RS = vector.create(89.42535400390625, 6.935125350952148, -427.6443786621094)
        },
        {
            ALV = vector.create(-8.594343185424805, -394.01708984375, -9.897544860839844),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(55.0751953125, -2.765376567840576, -467.1765441894531)
        }
    }

    -- Выполнение всех атак из файла
    for _, attack in ipairs(attacks) do
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("MainAttack"):FireServer(attack)
        waitSeconds(0.15)
    end

    -- === Блок 2: Дополнительные 5 атак (с разной задержкой) ===
    local extraAttacks = {
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(121.37139892578125, 28.510520935058594, -524.857177734375),
            D = vector.create(-0.15366260707378387, -0.6703393459320068, -0.7259702682495117),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(124.01747131347656, 10.565572738647461, -538.3466186523438),
            HP = vector.create(123.98839569091797, 10.485379219055176, -538.3754272460938),
            RS = vector.create(124.01747131347656, 10.565572738647461, -538.3466186523438)
        },
        {
            ALV = vector.create(-2.014939785003662, 380.3544616699219, -3.0219950675964355),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(123.92186737060547, 31.366321563720703, -538.4544067382812)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(35.51401901245117, 33.50678634643555, -535.2089233398438),
            D = vector.create(-0.01049335952848196, -0.7941884994506836, -0.6075809001922607),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(35.23082733154297, 10.568427085876465, -549.3511352539062),
            HP = vector.create(35.22614669799805, 10.488205909729004, -549.3917236328125),
            RS = vector.create(35.23082733154297, 10.568427085876465, -549.3511352539062)
        },
        {
            ALV = vector.create(-0.023903250694274902, 382.8061218261719, -1.9370571374893188),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(35.23153305053711, 26.6186466217041, -549.362060546875)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(-40.840362548828125, 31.243112564086914, -524.8956298828125),
            D = vector.create(-0.10247182846069336, -0.667262852191925, -0.7377396821975708),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(-44.97359848022461, 10.580979347229004, -542.8135986328125),
            HP = vector.create(-44.96529769897461, 10.500635147094727, -542.8533325195312),
            RS = vector.create(-44.97359848022461, 10.580979347229004, -542.8135986328125)
        },
        {
            ALV = vector.create(0.021807657554745674, 377.8979187011719, -2.8038039207458496),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(-44.96815872192383, 36.117671966552734, -542.939208984375)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(-121.85545349121094, 30.640243530273438, -524.8347778320312),
            D = vector.create(-0.007689942605793476, -0.6559895873069763, -0.7547308206558228),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(-120.37486267089844, 10.608715057373047, -543.795654296875),
            HP = vector.create(-120.41353607177734, 10.52808666229248, -543.80615234375),
            RS = vector.create(-120.37486267089844, 10.608715057373047, -543.795654296875)
        },
        {
            ALV = vector.create(-0.4455985724925995, 377.8905944824219, -2.6654648780822754),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(-120.40371704101562, 36.14576721191406, -543.9088134765625)
        },
        {
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The Eggsterminator",
            O = vector.create(-201.33554077148438, 29.20178985595703, -524.8125),
            D = vector.create(-0.053537994623184204, -0.7300962805747986, -0.6812438368797302),
            T = workspace:WaitForChild("#GAME"):WaitForChild("Folders"):WaitForChild("AccessoryFolder"):WaitForChild("The Eggsterminator"),
            SP = vector.create(-200.1133270263672, 10.594629287719727, -543.0511474609375),
            HP = vector.create(-200.1536407470703, 10.514151573181152, -543.0487670898438),
            RS = vector.create(-200.1133270263672, 10.594629287719727, -543.0511474609375)
        },
        {
            ALV = vector.create(-0.7510681748390198, 377.8945007324219, -1.110744833946228),
            A = game:GetService("Players").LocalPlayer.Character,
            AN = "The EggsterminatorExplode",
            EP = vector.create(-200.15382385253906, 36.135902404785156, -543.0604858398438)
        }
    }

    -- Выполнение дополнительных атак с задержкой 0.15 между FireServer и 0.2 после пар
    for i = 1, #extraAttacks, 2 do
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("MainAttack"):FireServer(extraAttacks[i])
        waitSeconds(0.15)
        if i + 1 <= #extraAttacks then
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("MainAttack"):FireServer(extraAttacks[i + 1])
            waitSeconds(0.2)
        end
    end
end

-- === Повторение всей последовательности 5 раз ===
for i = 1, 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 do
    executeAttackSequence()
    if i < 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 then
        waitSeconds(0.01) -- Пауза между полными циклами
    end
end
