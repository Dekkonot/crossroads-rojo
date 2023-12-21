print("Leaderboard script version 3.00 loaded")


function onPlayerEntered(newPlayer)


	local stats = Instance.new("IntValue")
	stats.Name = "leaderstats"

	local kills = Instance.new("IntValue")
	kills.Name = "KOs"
	kills.Value = 0

	local deaths = Instance.new("IntValue")
	deaths.Name = "Wipeouts"
	deaths.Value = 0

	kills.Parent = stats
	deaths.Parent = stats

	-- VERY UGLY HACK
	-- Will this leak threads?
	-- Is the problem even what I think it is (player arrived before character)?
	while true do
		if newPlayer.Character ~= nil then break end
		wait(5)
	end

	local humanoid = newPlayer.Character.Humanoid

	humanoid.Died:connect(function() onHumanoidDied(humanoid, newPlayer) end )

	-- start to listen for new humanoid
	newPlayer.Changed:connect(function(property) onPlayerRespawn(property, newPlayer) end )


	stats.Parent = newPlayer

end

function Send_DB_Event_Died(victim, killer)
	-- killer may be nil
	local killername = "no one"
	if killer ~= nil then killername = killer.Name end
	print("DIED EVENT: ", victim.Name, " KILLED by ", killername)

	if shared["deaths"] ~= nil then 
		shared["deaths"](victim, killer)
		print("SENT DB DEATH EVENT")
	end
end

function Send_DB_Event_Kill(killer, victim)
	print("KILL EVENT. ", killer.Name, " BLOXXED ", victim.Name)
	if shared["kills"] ~= nil then 
		shared["kills"](killer, victim)
		print("SENT DB KILL EVENT")
	end
end



function onHumanoidDied(humanoid, player)
	local stats = player:findFirstChild("leaderstats")
	if stats ~= nil then
		local deaths = stats:findFirstChild("Wipeouts")
		deaths.Value = deaths.Value + 1

		-- do short dance to try and find the killer

		local killer = getKillerOfHumanoidIfStillInGame(humanoid)


		Send_DB_Event_Died(player, killer)
		handleKillCount(humanoid, player)
	end
end

function onPlayerRespawn(property, player)
	-- need to connect to new humanoid
	
	if property == "Character" and player.Character ~= nil then
		local humanoid = player.Character.Humanoid
			local p = player
			local h = humanoid
			humanoid.Died:connect(function() onHumanoidDied(h, p) end )
	end
end

function getKillerOfHumanoidIfStillInGame(humanoid)
	-- returns the player object that killed this humanoid
	-- returns nil if the killer is no longer in the game

	-- check for kill tag on humanoid - may be more than one - todo: deal with this
	local tag = humanoid:findFirstChild("creator")

	-- find player with name on tag
	if tag ~= nil then
		
		local killer = tag.Value
		if killer.Parent ~= nil then -- killer still in game
			return killer
		end
	end

	return nil
end

function handleKillCount(humanoid, player)
	local killer = getKillerOfHumanoidIfStillInGame(humanoid)
	if killer ~= nil then
		local stats = killer:findFirstChild("leaderstats")
		if stats ~= nil then
			local kills = stats:findFirstChild("KOs")
			if killer ~= player then
				kills.Value = kills.Value + 1
				
			else
				kills.Value = kills.Value - 1
				
			end
			Send_DB_Event_Kill(killer, player)
		end
	end
end

game.Players.ChildAdded:connect(onPlayerEntered)