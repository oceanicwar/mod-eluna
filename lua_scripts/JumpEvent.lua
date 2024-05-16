local ZONE_QUEL_THALAS = 2037

local PLAYER_EVENT_ON_UPDATE_ZONE = 27
local PLAYER_EVENT_ON_PACKET_SEND = 5

local PACKET_CMSG_REPOP_REQUEST = 0x15A

local SPELL_SAFE_FALL = 24350

local function OnPlayerUpdateZone(event, player, newZone, newArea)
	if newZone ~= ZONE_QUEL_THALAS then
		if player:HasAura(SPELL_SAFE_FALL) then
			player:RemoveAura(SPELL_SAFE_FALL)
		end
	else
		if not player:HasAura(SPELL_SAFE_FALL) then
			local aura = player:AddAura(SPELL_SAFE_FALL, player)
			aura:SetStackAmount(50)
		end
	end
end

local function OnPacketSendRepop(event, packet, player)
	if player:GetZoneId() ~= ZONE_QUEL_THALAS then
		return
	end
	
	if player:IsDead() then
		player:Teleport(0, 4271.955, -2778.236, 5.555, 3.645)
		player:ResurrectPlayer()
	end
end

RegisterPlayerEvent(PLAYER_EVENT_ON_UPDATE_ZONE, OnPlayerUpdateZone)
RegisterPacketEvent(PACKET_CMSG_REPOP_REQUEST, PLAYER_EVENT_ON_PACKET_SEND, OnPacketSendRepop)