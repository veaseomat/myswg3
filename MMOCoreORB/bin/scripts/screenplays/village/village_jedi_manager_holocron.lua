local ObjectManager = require("managers.object.object_manager")

USEDHOLOCRON = "used_holocron"
HOLOCRONCOOLDOWNTIME =  3600000 -- 1 hr

VillageJediManagerHolocron = ScreenPlay:new {}

-- Check if the player can use the holocron.
-- @param pPlayer pointer to the creature object of the player who tries to use the holocron.
-- @return true if the player can use the holocron.
function VillageJediManagerHolocron.canUseHolocron(pPlayer)
	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	if (pGhost == nil) then
		return false
	end

	return CreatureObject(pPlayer):checkCooldownRecovery(USEDHOLOCRON)
end

-- Checks if the player can replenish the force or not.
-- @param pPlayer pointer to the creature object of the player who should be checked.
-- @return true if the player can replenish the force.
function VillageJediManagerHolocron.canReplenishForce(pPlayer)
	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	if (pGhost == nil) then
		return false
	end

	return PlayerObject(pGhost):getForcePower() < PlayerObject(pGhost):getForcePowerMax()
end

-- Use the holocron on the player.
-- @param pSceneObject pointer to the scene object of the holocron.
-- @param pPlayer pointer to the creature object of the player who is using the holocron.
function VillageJediManagerHolocron.useTheHolocron(pSceneObject, pPlayer)
	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	if (pGhost == nil) then
		return
	end
	
	if CreatureObject(pPlayer):hasSkill("force_rank_dark_master") then
		local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
		sui.setTitle("Prestige")
		sui.setPrompt("Great power requires great sacrifice. The hardest choices require the strongest wills. Death is only the beginning...")
		sui.sendTo(pPlayer)
		
		return
--		PlayerObject(pGhost):addSkillPoints(2)
	end
	
	if  CreatureObject(pPlayer):hasSkill("force_rank_light_master") then
		local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
		sui.setTitle("Prestige")
		sui.setPrompt("Death is a natural part of life. Rejoice for those around you who transform into the Force. Train yourself to let go of everything you fear to lose...")
		sui.sendTo(pPlayer)
		
		return
--		PlayerObject(pGhost):addSkillPoints(2)
	end
	
--	if CreatureObject(pPlayer):hasSkill("force_title_jedi_rank_02") and not CreatureObject(pPlayer):hasSkill("force_title_jedi_rank_03") and not CreatureObject(pPlayer):villageKnightPrereqsMet("") then	
--		local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
--		sui.setTitle("Young Jedi")
--		sui.setPrompt("You are not yet ready to continue your path padawan, keep training...")
--		sui.sendTo(pPlayer)
--	end
		
	if not CreatureObject(pPlayer):hasSkill("force_title_jedi_rank_02") then
	
		PlayerObject(pGhost):setJediState(2)
		
		awardSkill(pPlayer, "force_title_jedi_rank_02")
	
		CreatureObject(pPlayer):sendSystemMessage("You begin to feel attuned with the power of the Force, your Jedi skills have been unlocked.")
		
		local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
		sui.setTitle("Jedi Unlock")
		sui.setPrompt("You begin to feel attuned with the power of the Force, your Jedi skills have been unlocked. Use /findmytrainer to locate your jedi skill trainer. you will also lose ALL non jedi skills once you train your first novice box. May the Force be with you... Jedi")
		sui.sendTo(pPlayer)
		
			local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")

			if (pInventory == nil or SceneObject(pInventory):isContainerFullRecursive()) then
				CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:inventory_full_jedi_robe")
			else
				giveItem(pInventory, "object/tangible/wearables/robe/robe_jedi_padawan.iff", -1)
			end	
			
--		CreatureObject(pPlayer):playEffect("clienteffect/trap_electric_01.cef", "")
--		CreatureObject(pPlayer):playMusicMessage("sound/music_become_jedi.snd")
--		
--		SceneObject(pSceneObject):destroyObjectFromWorld()
--		SceneObject(pSceneObject):destroyObjectFromDatabase()
--		return --was used to prevent 1mil xp to unlock
		

	end
	
	if not CreatureObject(pPlayer):hasSkill("force_title_jedi_rank_03") and CreatureObject(pPlayer):villageKnightPrereqsMet("") then
		
		KnightTrials:sendCouncilChoiceSui(pPlayer)
		
	end
	
	if CreatureObject(pPlayer):hasSkill("force_title_jedi_rank_03") and not (CreatureObject(pPlayer):hasSkill("force_rank_light_novice") or CreatureObject(pPlayer):hasSkill("force_rank_dark_novice"))then
		local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
		sui.setTitle("Knight Box")
		sui.setPrompt("You already have the Jedi Knight Force progression box, you must surrender it before you can choose a side.")
		sui.sendTo(pPlayer)
		return
	end	
	
	if CreatureObject(pPlayer):hasSkill("force_title_jedi_rank_03") then

		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_10") and not CreatureObject(pPlayer):hasSkill("force_rank_light_master") then
		awardSkill(pPlayer, "force_rank_light_master")
									local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You are now a Force Ranking System LEADER, if you clone for any reason you will lose all of your skills, good luck.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_09") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_10") then
		awardSkill(pPlayer, "force_rank_light_rank_10")
			local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")

			if (pInventory == nil or SceneObject(pInventory):isContainerFullRecursive()) then
				CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:inventory_full_jedi_robe")
			else
				giveItem(pInventory, "object/tangible/wearables/robe/robe_jedi_light_s05.iff", -1)
					local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have been given a new robe befitting your rank.")
					sui.sendTo(pPlayer)
			end	
								local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_08") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_09") then
		awardSkill(pPlayer, "force_rank_light_rank_09")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_07") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_08") then
		awardSkill(pPlayer, "force_rank_light_rank_08")
			local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")

			if (pInventory == nil or SceneObject(pInventory):isContainerFullRecursive()) then
				CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:inventory_full_jedi_robe")
			else
				giveItem(pInventory, "object/tangible/wearables/robe/robe_jedi_light_s04.iff", -1)
					local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have been given a new robe befitting your rank.")
					sui.sendTo(pPlayer)
			end	
								local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_06") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_07") then
		awardSkill(pPlayer, "force_rank_light_rank_07")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end		
		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_05") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_06") then
		awardSkill(pPlayer, "force_rank_light_rank_06")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_04") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_05") then
		awardSkill(pPlayer, "force_rank_light_rank_05")
			local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")

			if (pInventory == nil or SceneObject(pInventory):isContainerFullRecursive()) then
				CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:inventory_full_jedi_robe")
			else
				giveItem(pInventory, "object/tangible/wearables/robe/robe_jedi_light_s03.iff", -1)
					local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have been given a new robe befitting your rank.")
					sui.sendTo(pPlayer)
			end	
								local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_03") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_04") then
		awardSkill(pPlayer, "force_rank_light_rank_04")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_02") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_03") then
		awardSkill(pPlayer, "force_rank_light_rank_03")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_01") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_02") then
		awardSkill(pPlayer, "force_rank_light_rank_02")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_light_novice") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_01") then
		awardSkill(pPlayer, "force_rank_light_rank_01")
			local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")

			if (pInventory == nil or SceneObject(pInventory):isContainerFullRecursive()) then
				CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:inventory_full_jedi_robe")
			else
				giveItem(pInventory, "object/tangible/wearables/robe/robe_jedi_light_s02.iff", -1)
					local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have been given a new robe befitting your rank.")
					sui.sendTo(pPlayer)
			end	
								local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_10") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_master") then
		awardSkill(pPlayer, "force_rank_dark_master")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You are now a Force Ranking System LEADER, if you clone for any reason you will lose all of your skills, good luck.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_09") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_10") then
		awardSkill(pPlayer, "force_rank_dark_rank_10")
			local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")

			if (pInventory == nil or SceneObject(pInventory):isContainerFullRecursive()) then
				CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:inventory_full_jedi_robe")
			else
				giveItem(pInventory, "object/tangible/wearables/robe/robe_jedi_dark_s05.iff", -1)
					local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have been given a new robe befitting your rank.")
					sui.sendTo(pPlayer)
			end	
								local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_08") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_09") then
		awardSkill(pPlayer, "force_rank_dark_rank_09")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_07") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_08") then
		awardSkill(pPlayer, "force_rank_dark_rank_08")
			local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")

			if (pInventory == nil or SceneObject(pInventory):isContainerFullRecursive()) then
				CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:inventory_full_jedi_robe")
			else
				giveItem(pInventory, "object/tangible/wearables/robe/robe_jedi_dark_s04.iff", -1)
					local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have been given a new robe befitting your rank.")
					sui.sendTo(pPlayer)
			end	
								local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_06") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_07") then
		awardSkill(pPlayer, "force_rank_dark_rank_07")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end		
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_05") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_06") then
		awardSkill(pPlayer, "force_rank_dark_rank_06")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_04") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_05") then
		awardSkill(pPlayer, "force_rank_dark_rank_05")
			local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")

			if (pInventory == nil or SceneObject(pInventory):isContainerFullRecursive()) then
				CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:inventory_full_jedi_robe")
			else
				giveItem(pInventory, "object/tangible/wearables/robe/robe_jedi_dark_s03.iff", -1)
					local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have been given a new robe befitting your rank.")
					sui.sendTo(pPlayer)
			end	
								local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_03") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_04") then
		awardSkill(pPlayer, "force_rank_dark_rank_04")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_02") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_03") then
		awardSkill(pPlayer, "force_rank_dark_rank_03")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_01") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_02") then
		awardSkill(pPlayer, "force_rank_dark_rank_02")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_novice") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_01") then
		awardSkill(pPlayer, "force_rank_dark_rank_01")
			local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")

			if (pInventory == nil or SceneObject(pInventory):isContainerFullRecursive()) then
				CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:inventory_full_jedi_robe")
			else
				giveItem(pInventory, "object/tangible/wearables/robe/robe_jedi_dark_s02.iff", -1)
					local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have been given a new robe befitting your rank.")
					sui.sendTo(pPlayer)
			end	
								local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("Jedi Knight")
					sui.setPrompt("You have gained a Force Rank.")
					sui.sendTo(pPlayer)
		end
	end

		CreatureObject(pPlayer):playEffect("clienteffect/trap_electric_01.cef", "")
		CreatureObject(pPlayer):playMusicMessage("sound/music_become_jedi.snd")
		
		SceneObject(pSceneObject):destroyObjectFromWorld()
		SceneObject(pSceneObject):destroyObjectFromDatabase()
		
		CreatureObject(pPlayer):sendSystemMessage("The Holocron hums quietly and begins to glow! You have absorbed the ancient knowledge within the holocron.")
		--CreatureObject(pPlayer):awardExperience("jedi_general", 1000000, true) --no xp anymore
		
		if PlayerObject(pGhost):getVisibility() > 500 then
			FsIntro:startStepDelay(pPlayer, 3)
		end
		
		CreatureObject(pPlayer):addCooldown(USEDHOLOCRON, HOLOCRONCOOLDOWNTIME)
			

end

-- Send message to the player that he cannot replenish the force.
-- @param pPlayer pointer to the creature object of the player that tries to use the holocron.
function VillageJediManagerHolocron.cannotReplenishForce(pPlayer)
	-- You are already at your maximum Force power.
	CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:holocron_force_max")
end

-- Send message to the player that he cannot use the holocron.
-- @param pPlayer pointer to the creature object of the player that tries to use the holocron.
function VillageJediManagerHolocron.cannotUseHolocron(pPlayer)
	-- The holocron hums briefly, but otherwise does nothing.
	CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:holocron_no_effect")
end

-- Handling of the useHolocron event.
-- @param pSceneObject pointer to the holocron object.
-- @param pPlayer pointer to the creature object that used the holocron.
function VillageJediManagerHolocron.useHolocron(pSceneObject, pPlayer)
	if VillageJediManagerHolocron.canUseHolocron(pPlayer) then
		VillageJediManagerHolocron.useTheHolocron(pSceneObject, pPlayer)
	else
		CreatureObject(pPlayer):sendSystemMessage("But you are exhausted from using the last holocron! You must wait one hour from the last holocron you used.")
	end

end

return VillageJediManagerHolocron
