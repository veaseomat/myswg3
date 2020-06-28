local ObjectManager = require("managers.object.object_manager")

USEDHOLOCRON = "used_holocron"
HOLOCRONCOOLDOWNTIME =  1000 -- 1 sec

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
	
	
	if CreatureObject(pPlayer):hasSkill("force_title_jedi_rank_02") and not CreatureObject(pPlayer):hasSkill("force_title_jedi_rank_03") and not CreatureObject(pPlayer):villageKnightPrereqsMet("") then	
		local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
		sui.setTitle("JEDI PADAWAN")
		sui.setPrompt("You are not yet ready to continue your path padawan, keep training...")
		sui.sendTo(pPlayer)
		
		return
	end
	
	if CreatureObject(pPlayer):hasSkill("force_rank_dark_master") then
		local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
		sui.setTitle("JEDI MASTER")
		sui.setPrompt("Master Jedi, you have survived a long time. If you are killed now you will lose all of your FRS progress. Remain Vigilant!")
		sui.sendTo(pPlayer)
		return
	end
	
	if  CreatureObject(pPlayer):hasSkill("force_rank_light_master") then
		local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
		sui.setTitle("JEDI MASTER")
		sui.setPrompt("Master Jedi, you have survived a long time. If you are killed now you will lose all of your FRS progress. Remain Vigilant!")
		sui.sendTo(pPlayer)
		return
		--addSkillPoints(pPlayer, 200)
--		PlayerObject(pGhost):addSkillPoints(2)
	end
		
	if not CreatureObject(pPlayer):hasSkill("force_title_jedi_rank_02") then
	
		PlayerObject(pGhost):setJediState(2)
		
		awardSkill(pPlayer, "force_title_jedi_rank_02")
	
		CreatureObject(pPlayer):sendSystemMessage("You begin to feel attuned with the power of the Force, your Jedi skills have been unlocked.")
		
		local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
		sui.setTitle("JEDI UNLOCK")
		sui.setPrompt("You begin to feel attuned with the power of the Force, your Jedi skills have been unlocked. Use /findmytrainer to locate your jedi skill trainer. All of your non jedi skills have been REMOVED. May the Force be with you... Jedi")
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
		sui.setTitle("Surrender Knight Box")
		sui.setPrompt("You already have the Jedi Knight Force progression box, you must surrender it before you can choose a side.")
		sui.sendTo(pPlayer)
		return
	end	
	
	if CreatureObject(pPlayer):hasSkill("force_title_jedi_rank_03") then

		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_10") and not CreatureObject(pPlayer):hasSkill("force_rank_light_master") then
		awardSkill(pPlayer, "force_rank_light_master")
									local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You are now a Force Ranking System LEADER, if you are killed while in this position you will drop to rank 0, good luck Master Jedi.")
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
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("Welcome to the council! you will not lose any FRS rank if you are killed while in this position. You have been awared an extra 20 skill points and can now learn ALL of the jedi skills! Congratulations... Master Jedi")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_08") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_09") then
		awardSkill(pPlayer, "force_rank_light_rank_09")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. If you are killed while in this position you will drop down to rank 8.")
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
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. You will not lose any rank if killed while in this position.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_06") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_07") then
		awardSkill(pPlayer, "force_rank_light_rank_07")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. If you are killed in this position you will drop down to rank 5.")
					sui.sendTo(pPlayer)
		end		
		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_05") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_06") then
		awardSkill(pPlayer, "force_rank_light_rank_06")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. If you are killed while in this position you will drop down to rank 5.")
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
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. You will not lose any rank if killed while in this position.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_03") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_04") then
		awardSkill(pPlayer, "force_rank_light_rank_04")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. If you are killed while in this position you will drop down to rank 1.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_02") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_03") then
		awardSkill(pPlayer, "force_rank_light_rank_03")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. If you are killed while in this position you will drop down to rank 1.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_light_rank_01") and not CreatureObject(pPlayer):hasSkill("force_rank_light_rank_02") then
		awardSkill(pPlayer, "force_rank_light_rank_02")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. If you are killed while in this position you will drop down to rank 1.")
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
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You are now FRS rank 1. When you are killed in the FRS you will drop down to the first skill of that row. example: if you die as a rank 4 you will drop down to rank 1, but a rank 5 will not lose any rank. As a Rank 1 you will not lose any rank if killed. \rYou have also been awarded with 20 extra skill points (they do not show up like normal but will allow you to go into negative sp), each rank receives 20 skill points, a council member has enough skill points to learn ALL jedi skills, losing a rank will also revoke the added skill poitns of that rank.")
					sui.sendTo(pPlayer)
		end
		
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_10") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_master") then
		awardSkill(pPlayer, "force_rank_dark_master")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You are now a Force Ranking System LEADER, if you are killed while in this position you will drop to rank 0, good luck Master Jedi.")
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
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("Welcome to the council! you will not lose any FRS rank if you are killed while in this position. You have been awared an extra 20 skill points and can now learn ALL of the jedi skills! Congratulations... Master Jedi")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_08") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_09") then
		awardSkill(pPlayer, "force_rank_dark_rank_09")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. If you are killed while in this position you will drop down to rank 8.")
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
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. You will not lose any rank if killed while in this position.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_06") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_07") then
		awardSkill(pPlayer, "force_rank_dark_rank_07")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. If you are killed while in this position you will drop down to rank 5.")
					sui.sendTo(pPlayer)
		end		
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_05") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_06") then
		awardSkill(pPlayer, "force_rank_dark_rank_06")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. If you are killed while in this position you will drop down to rank 5.")
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
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. You will not lose any rank if killed while in this position.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_03") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_04") then
		awardSkill(pPlayer, "force_rank_dark_rank_04")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. If you are killed while in this position you will drop down to rank 1.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_02") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_03") then
		awardSkill(pPlayer, "force_rank_dark_rank_03")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. If you are killed while in this position you will drop down to rank 1.")
					sui.sendTo(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_01") and not CreatureObject(pPlayer):hasSkill("force_rank_dark_rank_02") then
		awardSkill(pPlayer, "force_rank_dark_rank_02")
							local sui = SuiMessageBox.new("JediTrials", "emptyCallback") -- No callback
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You have gained a Force Rank and have been awarded with 20 extra skill points. If you are killed while in this position you will drop down to rank 1.")
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
					sui.setTitle("FORCE RANKING SYSTEM")
					sui.setPrompt("You are now FRS rank 1. When you are killed in the FRS you will drop down to the first skill of that row. example: if you die as a rank 4 you will drop down to rank 1, but a rank 5 will not lose any rank. As a Rank 1 you will not lose any rank if killed. \rYou have also been awarded with 20 extra skill points (they do not show up like normal but will allow you to go into negative sp), each rank receives 20 skill points, a council member has enough skill points to learn ALL jedi skills, losing a rank will also revoke the added skill poitns of that rank.")
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
		CreatureObject(pPlayer):sendSystemMessage("Stop spamming the holocron!")
	end

end

return VillageJediManagerHolocron
