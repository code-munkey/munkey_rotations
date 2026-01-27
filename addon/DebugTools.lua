local SPELL_SEARCH_MAX_ID = 2500000
local ITEM_SEARCH_MAX_ID = 2500000
local SPELL_SEARCH_CHUNK_SIZE = 5000
local TEST_ACTION_SLOT = 1
local isSearching = false

local function IsSpellPlaceable(spellId)
	if InCombatLockdown() then
		return false
	end

	ClearCursor()

	-- Try to pick up the spell
	if C_Spell and C_Spell.PickupSpell then
		C_Spell.PickupSpell(spellId)
	else
		PickupSpell(spellId)
	end

	-- Check if we actually picked up the expected spell
	local cursorType, cursorId = GetCursorInfo()
	if cursorType ~= "spell" and cursorType ~= "item" then
		ClearCursor()
		return false
	end

	-- Temporarily place it on the action bar
	-- This swaps the current action (if any) to the cursor
	PlaceAction(TEST_ACTION_SLOT)

	-- Verify it was placed
	local actionType, actionId, _ = GetActionInfo(TEST_ACTION_SLOT)
	local isMatch = (actionId == spellId)

	-- Restore the original action
	-- If we successfully placed it, the original action (or nil) is on the cursor.
	-- Calling PlaceAction again will put the cursor content back into the slot
	-- and put our test spell back onto the cursor.
	PlaceAction(TEST_ACTION_SLOT)

	-- Clean up our test spell from the cursor
	ClearCursor()

	return isMatch
end

local function FindSpellWithRange(targetRange)
	-- Converts targetRange to number
	local targetVal = tonumber(targetRange)
	if not targetVal then
		print("Usage: /findspellrange <range>")
		return
	end

	if isSearching then
		print("|cffff0000Search already in progress. Please wait.|r")
		return
	end

	if InCombatLockdown() then
		print("|cffff0000Cannot search while in combat (requires ActionBar manipulation).|r")
		return
	end

	isSearching = true
	print(string.format("Searching for PLACEABLE spells with range %d...", targetVal))

	local currentId = 1
	local foundCount = 0

	local function SearchChunk()
		if InCombatLockdown() then
			print("|cffff0000Combat detected, stopping search.|r")
			isSearching = false
			return
		end

		local endId = math.min(currentId + SPELL_SEARCH_CHUNK_SIZE, SPELL_SEARCH_MAX_ID)

		for spellId = currentId, endId do
			local name, minRange, maxRange

			if C_Spell and C_Spell.GetSpellInfo then
				local spellInfo = C_Spell.GetSpellInfo(spellId)
				if spellInfo then
					name = spellInfo.name
					minRange = spellInfo.minRange
					maxRange = spellInfo.maxRange
				end
			else
				-- Fallback for older clients
				local _
				name, _, _, _, minRange, maxRange = GetSpellInfo(spellId)
			end

			-- In some versions minRange/maxRange might be nil if not applicable
			if maxRange and maxRange == targetVal then
				-- Verify if it is placeable on action bar
				if IsSpellPlaceable(spellId) then
					print(
						string.format(
							"Found: |cff71d5ff[%d] %s|r (Min: %s, Max: %s)",
							spellId,
							name,
							tostring(minRange),
							tostring(maxRange)
						)
					)
					foundCount = foundCount + 1
					if foundCount >= 20 then
						print("Found 20 matches, stopping search.")
						isSearching = false
						return
					end
				end
			end
		end

		currentId = endId + 1
		if currentId <= SPELL_SEARCH_MAX_ID then
			C_Timer.After(0.01, SearchChunk)
		else
			print("Search complete.")
			isSearching = false
		end
	end

	SearchChunk()
end

local function FindItemWithRange(targetRange)
	local targetVal = tonumber(targetRange)
	if not targetVal then
		print("Usage: /finditemrange <range>")
		return
	end

	if isSearching then
		print("|cffff0000Search already in progress. Please wait.|r")
		return
	end

	isSearching = true
	print(string.format("Searching for ITEMS with range %d...", targetVal))

	local currentId = 1
	local foundCount = 0

	local function SearchChunk()
		local endId = math.min(currentId + SPELL_SEARCH_CHUNK_SIZE, ITEM_SEARCH_MAX_ID)

		for itemId = currentId, endId do
			-- Ensure the item actually has a range property (optimization and validity check)
			if ItemHasRange(itemId) then
				-- Ensure the item exists/is cached to some degree, or just try to get the spell.
				-- GetItemSpell often returns nil if not cached.
				local spellName, spellId = GetItemSpell(itemId)
				if spellId then
					local minRange, maxRange
					if C_Spell and C_Spell.GetSpellInfo then
						local spellInfo = C_Spell.GetSpellInfo(spellId)
						if spellInfo then
							minRange = spellInfo.minRange
							maxRange = spellInfo.maxRange
						end
					else
						_, _, _, _, minRange, maxRange = GetSpellInfo(spellId)
					end

					if (minRange and minRange == targetVal) or (maxRange and maxRange == targetVal) then
						local itemName = GetItemInfo(itemId) or spellName or "Unknown Item"
						print(
							string.format(
								"Found Item: |cff71d5ff[%d] %s|r (SpellID: %d, Min: %s, Max: %s)",
								itemId,
								itemName,
								spellId,
								tostring(minRange),
								tostring(maxRange)
							)
						)
						foundCount = foundCount + 1
						if foundCount >= 20 then
							print("Found 20 matches, stopping search.")
							isSearching = false
							return
						end
					end
				end
			end
		end

		currentId = endId + 1
		if currentId <= ITEM_SEARCH_MAX_ID then
			C_Timer.After(0.01, SearchChunk)
		else
			print("Search complete.")
			isSearching = false
		end
	end

	SearchChunk()
end

SLASH_FINDSPELLRANGE1 = "/findspellrange"
SLASH_FINDSPELLRANGE2 = "/fsr"
SlashCmdList["FINDSPELLRANGE"] = function(msg)
	FindSpellWithRange(msg)
end

SLASH_FINDITEMRANGE1 = "/finditemrange"
SLASH_FINDITEMRANGE2 = "/fir"
SlashCmdList["FINDITEMRANGE"] = function(msg)
	FindItemWithRange(msg)
end
