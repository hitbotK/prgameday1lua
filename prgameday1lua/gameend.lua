-- ตั้งค่า random seed (ใส่ครั้งเดียว) คือการตั้งระบบสุ่มดาเมจ
math.randomseed(os.time())
--กำหนดตัวแปร
local player = {hp = 100,maxHp = 100, atk = 15}
local enemy = {hp = 100,maxHp = 100, atk = 15}
--สร้างค่าสิ่งต่างๆที่จะเช็ค
local function showstats()
    print("Player HP: ",player.hp)
    print("Enemy HP: ",enemy.hp)
end

local function attack(attacker, target)
    local damage = math.random(attacker.atk -3, attacker.atk +3)

    --critical
    if math.random(1,100) <= 20 then
        damage = damage * 2
        print("critical hit")
    end

    target.hp = target.hp - damage
    if target.hp < 0 then target.hp = 0 end

    print("cridamage:",damage)
end

--heal
local function heal(character)
    local healAmount = math.random(8,15)
    character.hp = character.hp + healAmount
    if character.hp > character.maxHp then
        character.hp  = character.maxHp
    end
    print("heal:",healAmount)
end

-- เช็คตาย
local function isDead(character) -- กำหนดพารามิเตอร์ (parameter)คือ ตัวแปรที่ฟังก์ชันใช้รับค่าจากข้างนอก
    return character.hp <= 0  -- ตรวจสอบว่า hp ของตัวละครที่ส่งเข้ามา ถ้า hp <= 0 จะคืนค่า true (ตาย) ถ้า hp > 0 จะคืนค่า false (ยังไม่ตาย)
end

local turn = math.random(1,2) == 1 and "player" or "enemy"
-- ลูปหลักของเกม
while true do
    showstats() -- แสดง HP ของplayer,enemyปัจจุบันทุกครั้งก่อนเริ่มเทิร์น
    if turn == "player" then
        -- p hit or heal(random)
        if math.random(1,100) <= 50 then
            attack(player,enemy)
            print("ผู้เล่นตี")
        else    
            heal(player)
            print("player heal")
        end

        if isDead(enemy) then
            print("enemy dead")
            break
        end

        turn = "enemy"

else
        --e hit or heal(random)
        if math.random(1,100) <= 50 then
        attack(enemy, player)
        print("ศัตรูตี")
        else
        heal(enemy)
        print("enemy heal")
        end

        if isDead(player) then
        print("player dead")
        break
        end

        turn = "player"
    end
end
