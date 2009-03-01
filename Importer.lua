--   This program is free software: you can redistribute it and/or modify
--   it under the terms of the GNU General Public License as published by
--   the Free Software Foundation, either version 3 of the License, or
--   (at your option) any later version.
--
--   This program is distributed in the hope that it will be useful,
--   but WITHOUT ANY WARRANTY; without even the implied warranty of
--   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--   GNU General Public License for more details.
--
--   You should have received a copy of the GNU General Public License
--   along with this program.  If not, see <http://www.gnu.org/licenses/>.

--[[

Just a quick note to anyone reading this code.

The sorting code for the importer is quite poorly written,
hacked together in the middle of the night, probably in a drunken state.

I know the worst comments are those that apologise for bad code, but, well
what can I say? I intend to clean it all up at some point.

]]



function GuildPanel:StartImporter()
	if (self.importerState ~= 0) or (self.downloaderState ~=0) then return end
	GuildPanelInformationScrollBG:Hide()
	GuildPanelWindowPanelOverlayInformationCloseButton:Hide()
	GuildPanelWindowPanelOverlayInformationSaveButton:Hide()
	GuildPanelInformationScrollBar:Hide()
	GuildPanelImporterButton:Show()
	self.importerState = 1
	GuildPanelWindowPanelOverlay:Show()
	GuildPanelImporterButton:SetScript("OnClick", function () self:Importer() end)
	GuildPanel:Importer()
end

function GuildPanel:Importer()
	if self.importerState == 0 then
		return
	elseif self.importerState == 1 then
		GuildPanelWindowPanelOverlayTitle:SetText("Importer")
		GuildPanelImporterStatusbar:Show()
		GuildPanelImporterStatusbar:SetValue(0.2)
		GuildPanelImporterStateText:SetText("Step 1: Start Scan")
		GuildPanelImporterDetailsText:SetText("This Wizard will step you through scanning |cFFFFFF33Guild Notes|r for\nmain-alt associations.\n\nThis process is quite |cFFFFFF33computationally intensive|r.\n\nAs such, it may take some time to complete, and it may seem\nthat WoW is not responding.\n\nGive it time to finish.\n\n|cFFFF5555Note for officers:|r Try to only put a player name in the public note\nif it's the name of the alt's main. e.g. don't mention other players.")
		self.importerState = 2
	elseif self.importerState == 2 then
		self:CreateAssociations()
		GuildPanelImporterStatusbar:SetValue(0.4)
		GuildPanelImporterStateText:SetText("Step 2: Sort Data")
		local matches = 0
		local possible = 0
		
		for i=1,#self.importerData.associations do
			if self.importerData.associations[i][1] == "match" then
				matches = matches + 1
			else
				possible = possible + 1
			end
		end
		
		GuildPanelImporterDetailsText:SetText("Results:\n\nMatches: "..tostring(matches).."\nPossible Matches: "..tostring(possible).."\n\n|cFFCCCCCCIn the next section:|r\n• All |cFF88FF00Possible Matches|r where a |cFF00FF00Match|r has already been found\nwill be deleted.\n• |cFF0088FFDuplicates|r will be deleted. (An alt matching to 2 mains will\nbe set to the first one only)\n• The |cFF8888FFHighest Possible Matches|r will be found for possible matches\nwhere the match is itself matched to another possibility.")
		GuildPanelImporterButtonText:SetText("Sort Data")
		self.importerState = 3
	elseif self.importerState == 3 then
		self:PruneAssociations()
		GuildPanelImporterStatusbar:SetValue(0.6)
		GuildPanelImporterStateText:SetText("Step 3: Create Database")
		GuildPanelImporterDetailsText:SetText("Results:\n\nMatches: "..tostring(#self.importerData.matches).."\nPossible Matches: "..tostring(#self.importerData.possibles).."\n\nNext we will create a new database of mains with\ntheir associated alts.")
		GuildPanelImporterButtonText:SetText("Create Database")
		self.importerState = 4
	elseif self.importerState == 4 then
		self:ImporterFinalizeDatabase()
		GuildPanelImporterStatusbar:SetValue(0.8)
		GuildPanelImporterStateText:SetText("Step 4: Confirmation")
		GuildPanelImporterDetailsText:SetText("Done for now...")
		GuildPanelImporterButtonText:SetText("Close")
		self.importerState = 5
	elseif self.importerState == 5 then
		GuildPanelWindowPanelOverlay:Hide()
		GUILDPANEL_SHOWOFFLINE = false
		GuildPanelWindowToggleOfflineButtonText:SetText("Show Offline")
		GuildPanel:DrawDataView()
		GuildPanel:DrawDataView()
		self.importerData = {}
		self.importerState = 0
	end
end
function GuildPanel:PrintToInfo(text)
	GuildPanelInformationScrollBarInfoBox:SetText(GuildPanelInformationScrollBarInfoBox:GetText()..text)
end


function GuildPanel:StrCommonStartLength(str1, str2)
	local l1 = strlen(str1)
	local l2 = strlen(str2)
	if l1 == 0 or l2 == 0 then
		return 0
	end
	local len = 0
	local c1
	local c2
	
	for i=1,math.min(l1,l2) do
		c1 = strsub(str1, i, i)
		c2 = strsub(str2, i, i)
		if c1 == c2 then
			len = len + 1
		else
			return len
		end
	end
	return len
end


function GuildPanel:StrTok(str)
	local tokens = {}
	local tokidx = 1
	
	str = strlower(str)
	
	local char
	for i=1,strlen(str) do
		local char = strsub(str, i, i)
		if string.find(char, "%a") then
			if not tokens[tokidx] then
				tokens[tokidx] = char
			else
				tokens[tokidx] = tokens[tokidx]..char
			end
		else
			if tokens[tokidx] then
				tokidx = tokidx + 1
			end
		end
	end
	--for i=1,#tokens do
	--	self:Print(tokens[i])
	--end
	return tokens
end
function GuildPanel:TokenIsUseful(tok)
	if 	   tok == "of"				then return false
	elseif tok == "alt"				then return false
	elseif tok == "bank"			then return false
	elseif tok == "herbalism"		then return false
	elseif tok == "herbalist"		then return false
	elseif tok == "mining"			then return false
	elseif tok == "miner"			then return false
	elseif tok == "skinning"		then return false
	elseif tok == "skinner"			then return false
	elseif tok == "skin"			then return false
	elseif tok == "alchemy"			then return false
	elseif tok == "alchemist"		then return false
	elseif tok == "alch"			then return false
	elseif tok == "blacksmithing"	then return false
	elseif tok == "blacksmith"		then return false
	elseif tok == "bs"				then return false
	elseif tok == "enchanting"		then return false
	elseif tok == "enchanter"		then return false
	elseif tok == "ench"			then return false
	elseif tok == "engineering"		then return false
	elseif tok == "engineer"		then return false
	elseif tok == "eng"				then return false
	elseif tok == "leatherworking"	then return false
	elseif tok == "leatherworker"	then return false
	elseif tok == "lw"				then return false
	elseif tok == "tailoring"		then return false
	elseif tok == "tailor"			then return false
	elseif tok == "jewelcrafting"	then return false
	elseif tok == "jewelcrafter"	then return false
	elseif tok == "jc"				then return false
	elseif tok == "inscription"		then return false
	else return true
	end
end
function GuildPanel:CreateAssociations()
	GUILDPANEL_SHOWOFFLINE = true
	self.dataFilter = ""
	
	self:UpdateList("STD")
	GuildPanelImporterStatusbar:SetValue(0.0)
	--GuildPanelInformationScrollBar:Show()
	self:DrawScrollBarTex(GuildPanelInformationScrollBar)
	--self:PrintToInfo("Starting...\n")
	count = #self.stdList
	self.importerData.associations = {}
	
	local cur
	local other
	for i=1,count do
		cur = self.stdList[i]
		GuildPanelImporterStateText:SetText("Scanning "..cur.name)
		if cur.note ~= "" then
			noteTokens = self:StrTok(cur.note)
			for j=1,#noteTokens do
				tok = noteTokens[j]
				if self:TokenIsUseful(tok) then
					for k=1,count do
						if i ~= k then
							other = self.stdList[k]
							if tok ~= strlower(cur.name) then
								if tok == strlower(other.name) then
									--self:PrintToInfo("***MATCH*** "..cur.name.." -> "..other.name.."\n")
									table.insert(self.importerData.associations, {"match", cur.name, other.name})
								else
									lcs = self:StrCommonStartLength(strlower(other.name), tok)
									if lcs >= 4 then
										table.insert(self.importerData.associations, {"possible", cur.name, other.name})
										--self:PrintToInfo("***POSSIBLE MATCH*** "..cur.name.." -> "..other.name.." ("..tok..")".."\n")
									end
								end
							end
						end
					end
				end -- this series of ends is pretty. lol.
			end
		end
	end
end

function GuildPanel:PruneAssociations()
	local matches = {}
	local temp_possible = {}
	local temp_possible2 = {}
	local temp_possible3 = {}
	local possible_duplicates = {}
	
	-- sort the associations into matches and possible matches
	for index,value in ipairs(self.importerData.associations) do
		if value[1] == "match" then
			table.insert(matches, {value[2], value[3]})
		elseif value[1] == "possible" then
			table.insert(temp_possible, {value[2], value[3]})
		end
	end

	-- next we are looking for Matches with the same Alt name as the Possible
	for ip,pv in ipairs(temp_possible) do
		local foundmatch = false
		for im,mv in ipairs(matches) do
			if mv[1] == pv[1] then
				foundmatch = true
			end
		end
		if foundmatch == false then
			table.insert(temp_possible2, pv)
		end
	end
	
	-- now we're looking for duplicate possibles
	for ip,pv in ipairs(temp_possible2) do
		for ip2,pv2 in ipairs(temp_possible2) do
			if ip ~= ip2 then
				if pv2[1] == pv[1] then
					table.remove(temp_possible2, ip2)
				end
			end
		end
	end
	
	-- now we're looking for duplicate matches
	for im,mv in ipairs(matches) do
		for im2,mv2 in ipairs(matches) do
			if im ~= im2 then
				if mv2[1] == mv[1] then
					table.remove(matches, im2)
				end
			end
		end
	end
	
	-- converge on one possible match
	-- for example, main = canderus, one alt = candes
	-- guild note written as "candy" or w/e
	-- but a load of random other alts sometimes match to canderus,
	-- but sometimes to candes, but candes only matches to canderus,
	-- so converge them all to canderus
	local findHighestPossibleMatch
 	findHighestPossibleMatch = function (possi)
		local found = false
		local highest = nil
		local pv = temp_possible2[possi]
				
		for ip2,pv2 in ipairs(temp_possible2) do
			if possi ~= ip2 then
				if pv[2] == pv2[1] then
					found = true
					highest = findHighestPossibleMatch(ip2)
				end
			end
		end
		if found == true then
			return highest
		else
			return pv[2]
		end
	end
	local findHighestMatch
 	findHighestMatch = function (match)
		local found = false
		local highest = nil
		local mv = matches[match]
		for im2,mv2 in ipairs(matches) do
			if match ~= im2 then
				--self:Print(tostring(match).." ~= "..tostring(im2))
				if mv[2] == mv2[1] then
				
					if mv[1] == mv2[2] then
						found = true
						highest = mv[1]
					else
				
						found = true
						highest = findHighestMatch(im2)
					end
				end
			end
		end
		if found == true then
			return highest
		else
			return mv[2]
		end
	end
	
	for im,mv in ipairs(matches) do
		matches[im][2] = findHighestMatch(im)
	end
	
	for ip,pv in ipairs(temp_possible2) do
		temp_possible2[ip][2] = findHighestPossibleMatch(ip)
	end
	
	self.importerData.matches = matches
	self.importerData.possibles = temp_possible2
end

function GuildPanel:ImporterFinalizeDatabase()
	-- All this code is crazy and I wrote it when I was really tired so dont
	-- even try to read it lol

	self.db.char.alts = {}
	self.db.char.mains = {}


	for ip,pv in ipairs(self.importerData.possibles) do
		if pv[1] ~= pv[2] then
			table.insert(self.db.char.alts, {alt=pv[1], main=pv[2]})
		end
	end
	
	for im,mv in ipairs(self.importerData.matches) do
		if mv[1] ~= mv[2] then
			table.insert(self.db.char.alts, {alt=mv[1], main=mv[2]})
		end
	end

	local countMainAlts = function (name)
		count = 0
		for i,v in ipairs(self.db.char.alts) do
			if v.main == name then
				count = count + 1
			end
		end
		return count
	end
	for i,v in ipairs(self.db.char.alts) do
		if v ~= nil then
			for i2,v2 in ipairs(self.db.char.alts) do
				if i ~= i2 then
					vc = countMainAlts(v.main)
					v2c = countMainAlts(v2.main)
					if v.alt == v2.main and v2.alt == v.main then
						if vc > v2c then
							table.remove(self.db.char.alts, i2)
						elseif v2c > vc then
							table.remove(self.db.char.alts, i)
						else
							table.remove(self.db.char.alts, i2)
						end
					elseif v.alt == v2.main and v2.alt ~= v.main then
						if vc > v2c then
							self.db.char.alts[i2].main = self.db.char.alts[i].main
						else
							self.db.char.alts[i].main = self.db.char.alts[i2].main
						end
					end
				end
			end
		end
	end
	for i,v in ipairs(self.db.char.alts) do
		if v.alt == v.main then
			table.remove(self.db.char.alts, i)
		end
	end
	
	
	for i,v in ipairs(self.db.char.alts) do
		if self.db.char.mains[v.main] == nil then
			self.db.char.mains[v.main] = {}
		end
		table.insert(self.db.char.mains[v.main], v.alt)
	end

	self.db.char.dbTimestamp = self:GetTimestamp()
end
