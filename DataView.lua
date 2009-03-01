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


function GuildPanel:SetDrawMode(mode)
	if mode == "STD" then
		if getglobal("GuildPanelDataView_AltMain") ~= nil then
			GuildPanelDataView_AltMain:Hide()
		end
		if getglobal("GuildPanelDataView_Search") ~= nil then
			GuildPanelDataView_Search:Hide()
		end
		if getglobal("GuildPanelManageView") ~= nil then
			GuildPanelManageView:Hide()
		end
		if getglobal("GuildPanelVotingBoothView") ~= nil then
			GuildPanelVotingBoothView:Hide()
		end
		GuildPanelWindowStandardModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.2)
		GuildPanelWindowAltMainModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowAdvSearchModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowVoteModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowManageModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		self.drawMode = "STD"
	elseif mode == "ALTMAIN" then
		if getglobal("GuildPanelDataView_Standard") ~= nil then
			GuildPanelDataView_Standard:Hide()
		end
		if getglobal("GuildPanelDataView_Search") ~= nil then
			GuildPanelDataView_Search:Hide()
		end
		if getglobal("GuildPanelManageView") ~= nil then
			GuildPanelManageView:Hide()
		end
		if getglobal("GuildPanelVotingBoothView") ~= nil then
			GuildPanelVotingBoothView:Hide()
		end
		GuildPanelWindowStandardModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowAltMainModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.2)
		GuildPanelWindowAdvSearchModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowVoteModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowManageModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		self.drawMode = "ALTMAIN"
	elseif mode == "SEARCH" then
		if getglobal("GuildPanelDataView_Standard") ~= nil then
			GuildPanelDataView_Standard:Hide()
		end
		if getglobal("GuildPanelDataView_AltMain") ~= nil then
			GuildPanelDataView_AltMain:Hide()
		end
		if getglobal("GuildPanelManageView") ~= nil then
			GuildPanelManageView:Hide()
		end
		if getglobal("GuildPanelVotingBoothView") ~= nil then
			GuildPanelVotingBoothView:Hide()
		end
		GuildPanelWindowStandardModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowAltMainModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowAdvSearchModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.2)
		GuildPanelWindowVoteModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowManageModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		self.drawMode = "SEARCH"
	elseif mode == "MANAGE" then
		if getglobal("GuildPanelDataView_Standard") ~= nil then
			GuildPanelDataView_Standard:Hide()
		end
		if getglobal("GuildPanelDataView_AltMain") ~= nil then
			GuildPanelDataView_AltMain:Hide()
		end
		if getglobal("GuildPanelDataView_Search") ~= nil then
			GuildPanelDataView_Search:Hide()
		end
		if getglobal("GuildPanelVotingBoothView") ~= nil then
			GuildPanelVotingBoothView:Hide()
		end
		GuildPanelWindowStandardModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowAltMainModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowAdvSearchModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowVoteModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowManageModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.2)
		self.drawMode = "MANAGE"
	elseif mode == "VOTING" then
		if getglobal("GuildPanelDataView_Standard") ~= nil then
			GuildPanelDataView_Standard:Hide()
		end
		if getglobal("GuildPanelDataView_AltMain") ~= nil then
			GuildPanelDataView_AltMain:Hide()
		end
		if getglobal("GuildPanelDataView_Search") ~= nil then
			GuildPanelDataView_Search:Hide()
		end
		if getglobal("GuildPanelManageView") ~= nil then
			GuildPanelManageView:Hide()
		end
		GuildPanelWindowStandardModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowAltMainModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowAdvSearchModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		GuildPanelWindowVoteModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.2)
		GuildPanelWindowManageModeSelectTexture:SetVertexColor(1.0,1.0,1.0,0.0)
		self.drawMode = "VOTING"
	end
	
	self:DrawDataView()
end

function GuildPanel:PredicateMatch(predicate, name, level, class, zone, rank, publicnote, officernote)
	if predicate.value == "" then
		return false
	end
	if predicate.field == "name" then
		if predicate.cond == "equals" then
			return (strlower(name) == strlower(predicate.value))
		elseif predicate.cond == "!equals" then
			return (strlower(name) ~= strlower(predicate.value))
		elseif predicate.cond == "contains" then
			return string.find(strlower(name), strlower(predicate.value))
		elseif predicate.cond == "!contains" then
			return (not string.find(strlower(name), strlower(predicate.value)))
		elseif predicate.cond == "startswith" then
			return string.find(strlower(name), "^"..strlower(predicate.value))
		elseif predicate.cond == "endswith" then
			return string.find(strlower(name), strlower(predicate.value).."$")
		end
	elseif predicate.field == "class" then
		if predicate.cond == "equals" then
			return (class == predicate.value)
		elseif predicate.cond == "!equals" then
			return (class ~= predicate.value)
		end
	elseif predicate.field == "level" then
		if predicate.cond == "equals" then
			return (tonumber(level) == tonumber(predicate.value))
		elseif predicate.cond == "!equals" then
			return (tonumber(level) ~= tonumber(predicate.value))
		elseif predicate.cond == "gt" then
			return (tonumber(level) > tonumber(predicate.value))
		elseif predicate.cond == "lt" then
			return (tonumber(level) < tonumber(predicate.value))
		end
	elseif predicate.field == "zone" then
		if predicate.cond == "equals" then
			return (strlowr(zone) == strlower(predicate.value))
		elseif predicate.cond == "!equals" then
			return (strlower(zone) ~= strlower(predicate.value))
		elseif predicate.cond == "contains" then
			return string.find(strlower(zone), strlower(predicate.value))
		elseif predicate.cond == "!contains" then
			return (not string.find(strlower(zone), strlower(predicate.value)))
		elseif predicate.cond == "startswith" then
			return string.find(strlower(zone), "^"..strlower(predicate.value))
		elseif predicate.cond == "endswith" then
			return string.find(strlower(zone), strlower(predicate.value).."$")
		end
	elseif predicate.field == "rank" then
		if predicate.cond == "equals" then
			return (rank == predicate.value)
		elseif predicate.cond == "!equals" then
			return (rank ~= predicate.value)
		end
	elseif predicate.field == "publicnote" then
		if predicate.cond == "contains" then
			return string.find(strlower(publicnote), strlower(predicate.value))
		elseif predicate.cond == "!contains" then
			return (not string.find(strlower(publicnote), strlower(predicate.value)))
		end
	elseif predicate.field == "officercnote" then
		if predicate.cond == "contains" then
			return string.find(strlower(officernote), strlower(predicate.value))
		elseif predicate.cond == "!contains" then
			return (not string.find(strlower(officernote), strlower(predicate.value)))
		end
	end
		
end
function GuildPanel:AllPredicatesMatch(name, level, class, zone, rank, publicnote, officernote)
	local result = true
	for i,predicate in ipairs(self.searchPredicates) do
		result = result and self:PredicateMatch(predicate, name, level, class, zone, rank, publicnote, officernote)
	end
	return result
end

function GuildPanel:UpdateList(list)
	SetGuildRosterShowOffline(1);
	GuildRoster();
	
	if CanGuildInvite() then
		GuildPanelWindowInviteButton:Enable();
		GuildPanelWindowInviteButton:SetAlpha(1.0);
		GuildPanelWindowInviteButtonLabel:SetAlpha(1.0);
	else
		GuildPanelWindowInviteButton:Disable();
		GuildPanelWindowInviteButton:SetAlpha(0.5);
		GuildPanelWindowInviteButtonLabel:SetAlpha(0.5);
	end
	
	if CanEditMOTD() then
		GuildPanelWindowMOTDButton:Enable();
		GuildPanelWindowMOTDButton:SetAlpha(1.0)
		GuildPanelWindowMOTDButtonLabel:SetAlpha(1.0)
	else
		GuildPanelWindowMOTDButton:Disable();
		GuildPanelWindowMOTDButton:SetAlpha(0.5);
		GuildPanelWindowMOTDButtonLabel:SetAlpha(0.5);
	end
		
	
	local playerInfo = function (i)
		local pname, prank, prankIndex, plevel, pclass, pzone, pnote, pofficernote, ponline, pstatus = GetGuildRosterInfo(i);
		local pyears, pmonths, pdays, phours = GetGuildRosterLastOnline(i);
		if not pzone then
			pzone = "<Unknown>"
		end
		return pname,prank,prankIndex,plevel,pclass,pzone,pnote,pofficernote,ponline,pstatus,pyears,pmonths,pdays,phours
	end
	
	local playerIdForName = function (name, count)
		for i=1,count do
			local pname, prank, prankIndex, plevel, pclass, pzone, pnote, pofficernote, ponline, pstatus = GetGuildRosterInfo(i);
			if pname == name then
				return i
			end
		end
		return 0
	end
	
	local filterMatch = function (name, level, class, zone)
		return (string.find(strlower(name), self.dataFilter)
			or string.find(strlower(tostring(level)), self.dataFilter)
			or string.find(strlower(class), self.dataFilter)
			or string.find(strlower(zone), self.dataFilter))
	end
	
	if list == "STD" then
		
		count = GetNumGuildMembers(GUILDPANEL_SHOWOFFLINE)
		table.wipe(self.stdList)
		self.stdList._empty = true
		local j = 0
		for i=1,count do
			local pname,prank,prankIndex,plevel,pclass,pzone,pnote,pofficernote,ponline,pstatus,pyears,pmonths,pdays,phours = playerInfo(i);
			if pname ~= nil then
				if string.find(strlower(pname), self.dataFilter)
					or string.find(strlower(tostring(plevel)), self.dataFilter)
					or string.find(strlower(pclass), self.dataFilter)
					or string.find(strlower(pzone), self.dataFilter) then
					if ((not GUILDPANEL_SHOWOFFLINE) and (ponline == 1)) or (GUILDPANEL_SHOWOFFLINE) then
						self.stdList._empty = false
						table.insert(self.stdList, {name = pname, level = plevel, class = pclass, zone = pzone, online = ponline, rank = prank, days = pdays, status = pstatus, note=pnote, officernote = pofficernote})
						j = j+1
					end
				end
			end
		end
		if self.stdList._empty == true then
			GuildPanel:SetResultsText("0 players found.")
		else
			if self.dataFilter ~= "" then
				GuildPanel:SetResultsText(tostring(j).." players found. Searched for: '"..self.dataFilter.."'.")
			else
				GuildPanel:SetResultsText(tostring(j).." players found.")
			end
		end
	elseif list == "SEARCH" then

		count = GetNumGuildMembers(1)
		table.wipe(self.searchList)
		self.searchList._empty = true
		local j = 0
		for i=1,count do
			local pname,prank,prankIndex,plevel,pclass,pzone,pnote,pofficernote,ponline,pstatus,pyears,pmonths,pdays,phours = playerInfo(i);
			if pname ~= nil then
				if self:AllPredicatesMatch(pname, plevel, pclass, pzone, prank, pnote, pofficernote) then
					if ((not GUILDPANEL_SHOWOFFLINE) and (ponline == 1)) or (GUILDPANEL_SHOWOFFLINE) then
						self.searchList._empty = false
						table.insert(self.searchList, {name = pname, level = plevel, class = pclass, zone = pzone, online = ponline, rank = prank, days = pdays, status = pstatus, note=pnote, officernote = pofficernote})
						j = j+1
					end
				end
			end
		end
		if self.searchList._empty == true then
			if GUILDPANEL_SHOWOFFLINE == false then
				UIFrameFlash(GuildPanelWindowHelpArrow, 0.5, 0.5, 2, false, 0, 0)
			end
			GuildPanel:SetResultsText("0 players found.")
		else
			if self.dataFilter ~= "" then
				GuildPanel:SetResultsText(tostring(j).." players found. Searched for: '"..self.dataFilter.."'.")
			else
				GuildPanel:SetResultsText(tostring(j).." players found.")
			end
		end
	elseif list == "ALTMAIN" then
		count = GetNumGuildMembers(true)
		table.wipe(self.altMainList)
		j=0
		for i=1,count do
			local pname, prank, prankIndex, plevel, pclass, pzone, pnote, pofficernote, ponline, pstatus = GetGuildRosterInfo(i);
			if pname ~= nil then
				if (not GUILDPANEL_SHOWOFFLINE) and ponline then
					local pname,prank,prankIndex,plevel,pclass,pzone,pnote,pofficernote,ponline,pstatus,pyears,pmonths,pdays,phours = playerInfo(i);
					if filterMatch(pname, plevel, pclass, pzone) then
						self.altMainList._empty = false
						local main = self:GetMain(pname)
						if main then
							mainId = playerIdForName(main, count)
							local mname,mrank,mrankIndex,mlevel,mclass,mzone,mnote,mofficernote,monline,mstatus,myears,mmonths,mdays,mhours = playerInfo(mainId);
							table.insert(self.altMainList, {type=1, data={name = mname, level = mlevel, class = mclass, zone = mzone, online = monline, rank = mrank, days = mdays, status = mstatus, note = mnote, officernote = mofficernote}})
							table.insert(self.altMainList, {type=2, data={name = pname, level = plevel, class = pclass, zone = pzone, online = ponline, rank = prank, days = pdays, status = pstatus, note = pnote, officernote = pofficernote}})
							j = j+1
						else
							table.insert(self.altMainList, {type=1, data={name = pname, level = plevel, class = pclass, zone = pzone, online = ponline, rank = prank, days = pdays, status = pstatus, note = pnote, officernote = pofficernote}})
							j=j+1
						end
					end
				elseif GUILDPANEL_SHOWOFFLINE then
					local pname,prank,prankIndex,plevel,pclass,pzone,pnote,pofficernote,ponline,pstatus,pyears,pmonths,pdays,phours = playerInfo(i);
					if filterMatch(pname, plevel, pclass, pzone) then
						self.altMainList._empty = false
					
						local main = self:GetMain(pname)

						if main == nil then
						
							table.insert(self.altMainList, {type=1, data={name = pname, level = plevel, class = pclass, zone = pzone, online = ponline, rank = prank, days = pdays, status = pstatus, note = pnote, officernote = pofficernote}})
							j=j+1
							local alts = self.db.char.mains[pname]
						
							if alts then
								for ia,av in ipairs(alts) do
									local id = playerIdForName(av, count)
									local aname,arank,arankIndex,alevel,aclass,azone,anote,aofficernote,aonline,astatus,ayears,amonths,adays,ahours = playerInfo(id);
									if aname ~= nil then	
										if filterMatch(aname, aclass, alevel, azone) then
											self.altMainList._empty = false
											table.insert(self.altMainList, {type=2, data={name = aname, level = alevel, class = aclass, zone = azone, online = aonline, rank = arank, days = adays, status = astatus, note = anote, officernote = aofficernote}})
											j=j+1
										end
									end
								end
							end
						elseif main and (self.dataFilter ~= "") then
							--[[mainId = playerIdForName(main, count)
							local mname,mrank,mrankIndex,mlevel,mclass,mzone,mnote,mofficernote,monline,mstatus,myears,mmonths,mdays,mhours = playerInfo(mainId);
						
							local alts = self.db.char.mains[pname]
							found = false
						
							for k,v in ipairs(alts)do
						
							end
						
							if filterMatch(mname, mlevel, mclass, mzone) then
							
							else
								table.insert(self.altMainList, {type=1, data={name = mname, level = mlevel, class = mclass, zone = mzone, online = monline, rank = mrank, days = mdays, note = mnote, officernote = mofficernote}})
								table.insert(self.altMainList, {type=2, data={name = pname, level = plevel, class = pclass, zone = pzone, online = ponline, rank = prank, days = pdays, note = pnote, officernote = pofficernote}})
								j = j+1
							end]]
						end
					else
						local alts = self.db.char.mains[pname]
						if alts then
							local printedMain = false
							for ia,av in ipairs(alts) do
								local id = playerIdForName(av, count)
								local aname,arank,arankIndex,alevel,aclass,azone,anote,aofficernote,aonline,astatus,ayears,amonths,adays,ahours = playerInfo(id);
								if aname ~= nil then
									if filterMatch(aname, aclass, alevel, azone) then
										self.altMainList._empty = false
							
										if printedMain == false then
											table.insert(self.altMainList, {type=1, data={name = pname, level = plevel, class = pclass, zone = pzone, online = ponline, rank = prank, days = pdays, status = pstatus, note = pnote, officernote = pofficernote}})
											j=j+1
											printedMain = true
										end
										table.insert(self.altMainList, {type=2, data={name = aname, level = alevel, class = aclass, zone = azone, online = aonline, rank = arank, days = adays, status = astatus, note = anote, officernote = aofficernote}})
										j=j+1
									end
								end
							end
						end
					end
				end
			end
		end
		if self.altMainList._empty == true then
			GuildPanel:SetResultsText("0 players found.")
		else
			if self.dataFilter ~= "" then
				GuildPanel:SetResultsText(tostring(j).." players found. Searched for: '"..self.dataFilter.."'.")
			else
				GuildPanel:SetResultsText(tostring(j).." players found.")
			end
		end
	end
end


-- TODO: standardize the drawing functions, DRY
function GuildPanel:DrawDataView()
	if GuildPanelWindow:IsShown() ~= 1 then
		return
	end
	if self.drawMode == "STD" then
		self:DrawStdDataView()
	elseif self.drawMode == "ALTMAIN" then
		self:DrawAltMainDataView()
	elseif self.drawMode == "SEARCH" then
		self:DrawSearchDataView()
	elseif self.drawMode == "MANAGE" then
		self:DrawManageView()
	elseif self.drawMode == "VOTING" then
		self:DrawVotingBoothView()
	end
end

function GuildPanel:OnListCellClicked(cell, button)
	self:CloseAllPopupMenus()
	
	local entry = nil
	
	if self.drawMode == "STD" then
		list = self.stdList
	elseif self.drawMode == "ALTMAIN" then
		list = self.altMainList
	elseif self.drawMode == "SEARCH" then
		list = self.searchList
	end
	
	
	for i=1,#list do
		if list[i]._cell == cell then
			entry = list[i]
		end
	end
	if (not entry) then
		error("GuildPanel encountered a display error.")
		return
	end
	
	if self.drawMode == "ALTMAIN" then
		entry = entry.data
	end
	
	if button == "LeftButton" then
		if self.selectedName == entry.name then
			self.selectedName = nil
		
		else
			self.selectedName = entry.name
		end

		GuildPanel:DrawDataView()
	elseif button == "RightButton" then
		local marktext
		if self:IsNameMarked(entry.name) == true then
			marktext = "*Unmark"
		else
			marktext = "*Mark"
		end
		local ppmItems = {
			{
				name = "Whisper",
				func = function () 
					ChatFrame_SendTell(entry.name)
					GuildPanel:ClosePopupMenu("PlayerCellMenu")
				end
			},
			{
				name = "Invite",
				func = function () 
					InviteUnit(entry.name)
					GuildPanel:ClosePopupMenu("PlayerCellMenu")
				end
			},
			{
				name = "Ignore",
				func = function () 
					AddOrDelIgnore(entry.name)
					GuildPanel:ClosePopupMenu("PlayerCellMenu")
				end
			},
			{
				name = marktext,
				func = function () 
					if self:IsNameMarked(entry.name) == true then
						self:UnmarkName(entry.name)
					else
						self:MarkName(entry.name)
					end
					GuildPanel:ClosePopupMenu("PlayerCellMenu")
					self:DrawDataView()
				end
			},
			{
				name = "-Cancel-",
				func = function () 
					GuildPanel:ClosePopupMenu("PlayerCellMenu")
				end
			},
		}
		local x,y = GetCursorPosition()
		x = x/UIParent:GetEffectiveScale();
		y = y/UIParent:GetEffectiveScale();
		GuildPanel:DrawPopupMenu("PlayerCellMenu", x, y-(#ppmItems*16), UIParent, "BOTTOMLEFT", 64, ppmItems)
	end
	
end

function GuildPanel:DrawManageView()
	if (not self.manageView) then
		self.manageView = CreateFrame("Frame", "GuildPanelManageView", GuildPanelWindowContentRect, "GuildPanelManageViewParent")
	end
	self.manageView:ClearAllPoints();
	self.manageView:SetPoint("TOPLEFT", GuildPanelWindowContentRect, "TOPLEFT", 0, 0)
	
	GuildPanelManageViewLowerFrame:SetPoint("BOTTOMLEFT", self.manageView, "BOTTOMLEFT", 0.0, 0.0)
	
	--GuildPanelManageViewScrollBar:SetBackdropColor(0.7,0.7,0.7,1.0)
	local tab = getglobal(self.manageView:GetName() .. "ScrollBarTable")
	
	tab:SetHeight(100)
	
	local drawOffset = 0
	for i,item in ipairs(self.manageItems) do
		if item.viewFunc() == true then
			local header
			if getglobal("GuildPanelManageViewHeader"..i) == nil then
				header = CreateFrame("Frame", "GuildPanelManageViewHeader"..i, tab, "GuildPanelManageViewHeader")
			else
				header = getglobal("GuildPanelManageViewHeader"..i)
			end
			header:SetPoint("TOPLEFT", tab, "TOPLEFT", 10, -drawOffset)
			drawOffset = drawOffset + 25
			getglobal(header:GetName().."Text"):SetText(item.name)
		
			local onClick = function ()
				if self.manageItems[i].disclosed == true then
					self.manageItems[i].disclosed = false
				else
					self.manageItems[i].disclosed = true
				end
				self:DrawDataView()
			end
			header:SetScript("OnMouseUp", onClick)
			header:EnableMouse(true)
		
			if item.disclosed == true then
				getglobal(header:GetName().."LeftTexture"):SetTexture("Interface\\AddOns\\GuildPanel\\Manage\\disclosedLeft")
				local frame
				if getglobal(item.frame.."Instance") == nil then
					frame = CreateFrame("Frame", item.frame.."Instance", tab, item.frame)
				else
					frame = getglobal(item.frame.."Instance")
				end
				frame:SetPoint("TOPLEFT", tab, "TOPLEFT", 0, -drawOffset)
				drawOffset = drawOffset + item.height
				frame:Show()
				item.load(frame)
			else
				getglobal(header:GetName().."LeftTexture"):SetTexture("Interface\\AddOns\\GuildPanel\\Manage\\closedLeft")
				if getglobal(item.frame.."Instance") == nil then
					frame = CreateFrame("Frame", item.frame.."Instance", tab, item.frame)
				else
					frame = getglobal(item.frame.."Instance")
				end
				frame:Hide()
			end
		end
		
	end
	
	GuildPanelManageViewLowerFrameActionGroupSelect:Hide()
	GuildPanelManageViewLowerFrameInviteButton:Hide()
	GuildPanelManageViewLowerFrameGKickButton:Hide()
	GuildPanelManageViewLowerFramePromoteButton:Hide()
	GuildPanelManageViewLowerFrameDemoteButton:Hide()
	
	GuildPanelManageView:Show()
end

function GuildPanel:DrawAltMainDataView()
	if(not self.altMainDataView) then
		self.altMainDataView = CreateFrame("Frame", "GuildPanelDataView_AltMain", GuildPanelWindowContentRect, "GuildPanelDataView")
	end
	self.altMainDataView:ClearAllPoints();
	self.altMainDataView:SetPoint("TOPLEFT", GuildPanelWindowContentRect, "TOPLEFT", 0, 0)
	
	GuildPanelDataView_AltMainLowerFrame:SetPoint("BOTTOMLEFT", self.altMainDataView, "BOTTOMLEFT", 0.0, 0.0)
	
	if getglobal("GuildPanelDataView_AltMain_Details") ~= nil then
		getglobal("GuildPanelDataView_AltMain_Details"):Hide()
	end
	
	self:DrawScrollBarTex(GuildPanelDataView_AltMainScrollBar)
	
	self:UpdateList("ALTMAIN")
	
	local tab = getglobal(self.altMainDataView:GetName() .. "ScrollBarTable")

	local count = #self.altMainList;
	
	tab:SetHeight(count*16);
	
	local shownDetailsFrame = false
	
	if self.altMainDrawIdx then
		for i=1,self.altMainDrawIdx do
			getglobal("GuildPanelDataView_AltMain_Item"..i):Hide()
		end
	end
	self.altMainDrawIdx = 0	
	if self.altMainList._empty == false then
		for i,entry in ipairs(self.altMainList) do
			--local frameName = "GuildPanelDataView_ListItem"..(i%2)
			local frameName
			frameName = "GuildPanelDataView_ListItem"
		
			local item
			if getglobal("GuildPanelDataView_AltMain_Item"..i) == nil then
				item = CreateFrame("Frame", "GuildPanelDataView_AltMain_Item"..i, tab, frameName)
			else
				item = getglobal("GuildPanelDataView_AltMain_Item"..i)
			end
		

			if shownDetailsFrame == true then
				item:SetPoint("TOPLEFT", tab, "TOPLEFT", 0, (16*i*-1)+16-110)
				--self:Print(entry.name.." @ "..tostring((16*i*-1)+16-110))
			else
				item:SetPoint("TOPLEFT", tab, "TOPLEFT", 0, (16*i*-1)+16)
				--self:Print(entry.name.." @ "..tostring((16*i*-1)+16))
			end
		
			--if i == 1 then
			--	item:SetHeight(16.8) -- compensation for the drawing bug
			--end
		
			local nameText = getglobal(item:GetName() .. "NameText")
			local classText = getglobal(item:GetName() .. "ClassText")
			local levelText = getglobal(item:GetName() .. "LevelText")
			local zoneText = getglobal(item:GetName() .. "ZoneText")
			local L = getglobal(item:GetName() .. "L")
			
		
			local class = entry.data.class
			local level = entry.data.level
			local zone = entry.data.zone
			local rank = entry.data.rank
			local note = entry.data.note
			local officernote = entry.data.officernote
			
			local officernote = ""
			if CanViewOfficerNote() == 1 then
				officernote = entry.data.officernote
			end
		
			local name
		
			local selected = false
		
			if entry.data.name == self.selectedName then
				selected = true
			end		
			if entry.data.name == nil then
				return
			end
			if entry.data.online == 1 then
				name = self:GetClassColorModifier(class) .. entry.data.name .. "|r"
				if selected == true then
					GuildPanel:SetTableCellType(item, 3, entry.data.status, self:IsNameMarked(entry.data.name))
				else
					GuildPanel:SetTableCellType(item, 1, entry.data.status, self:IsNameMarked(entry.data.name))
				end	
			else
				if selected == true then
					name = "|cFFFFFFFF" .. entry.data.name .. "|r"
					GuildPanel:SetTableCellType(item, 2, entry.data.status, self:IsNameMarked(entry.data.name))
				else
					name = "|cFF444444" .. entry.data.name .. "|r"
					GuildPanel:SetTableCellType(item, 0, entry.data.status, self:IsNameMarked(entry.data.name))
				end
			end
		
			if entry.type == 2 then
				name = "  "..name
				L:Show()
			else
				L:Hide()
			end
			
			nameText:SetText(name)
			classText:SetText(class)
			levelText:SetText(level)
			zoneText:SetText(zone)
		
			self.altMainList[i]._cell = item
		
			item:EnableMouse(true)
		
			if selected == true then
				if getglobal("GuildPanelDataView_AltMain_Details") == nil then
					detailsFrame = CreateFrame("Frame", "GuildPanelDataView_AltMain_Details", tab, "GuildPanelDataView_Details")
				else
					detailsFrame = getglobal("GuildPanelDataView_AltMain_Details")
				end
				detailsFrame:SetPoint("TOPLEFT", item, "TOPLEFT", 0, -16)
			
				getglobal(detailsFrame:GetName() .. "LevelClassText"):SetText("Level "..level.." "..class)
				getglobal(detailsFrame:GetName() .. "ZoneText"):SetText(zone)
				getglobal(detailsFrame:GetName() .. "RankText"):SetText(rank)
				--self:Print(detailsFrame:GetName() .. "PublicNote")
				getglobal(detailsFrame:GetName() .. "PublicNote"):SetText(note)
				
				if CanViewOfficerNote() == 1 then
					getglobal(detailsFrame:GetName() .. "OfficerNote"):Show()
					getglobal(detailsFrame:GetName() .. "OfficerNoteLabel"):Show()
					getglobal(detailsFrame:GetName() .. "OfficerNote"):SetText(officernote)
				else
					getglobal(detailsFrame:GetName() .. "OfficerNote"):Hide()
					getglobal(detailsFrame:GetName() .. "OfficerNoteLabel"):Hide()
				end
				if CanEditOfficerNote() == 1 then
					getglobal(detailsFrame:GetName() .. "EditOfficerNoteButton"):Show()
				else
					getglobal(detailsFrame:GetName() .. "EditOfficerNoteButton"):Hide()
				end
				if CanEditPublicNote() == 1 then
					getglobal(detailsFrame:GetName() .. "EditPublicNoteButton"):Show()
				else
					getglobal(detailsFrame:GetName() .. "EditPublicNoteButton"):Hide()
				end
				
				
				lastOnlineDays = entry.data.days
				if lastOnlineDays == nil then
					lastOnlineDays = "Online"
				else
					lastOnlineDays = tostring(lastOnlineDays).. " days"
				end
				getglobal(detailsFrame:GetName() .. "LastOnlineText"):SetText(lastOnlineDays)
			
				local altOptionsButton = getglobal(detailsFrame:GetName() .. "AltOptionsPopupButton")
				getglobal(altOptionsButton:GetName().."Text"):SetText("Click for Alt Options...")
				altOptionsOnClick = function ()
					ppmItems = self:GetAltOptionsMenu(entry.data.name)
					GuildPanel:DrawPopupMenu("AltOptionsMenu", -10, -1, altOptionsButton, "TOPRIGHT", 132, ppmItems)
				end
				altOptionsButton:SetScript("OnMouseUp", altOptionsOnClick)
				
				detailsFrame:EnableMouse(true)
			
				--detailsFrame:SetAlpha(0.0)
				detailsFrame:Show()
				--UIFrameFadeIn(detailsFrame, 0.3, 0.0, 1.0)
				shownDetailsFrame = true
			end
			self.altMainDrawIdx = self.altMainDrawIdx+1
			item:Show()
		end
	end
	
	self.altMainDataView:Show();
	self:DrawScrollBarTex(GuildPanelDataView_AltMainScrollBar)
	
	
	if CanGuildRemove() == 1 then
		GuildPanelDataView_AltMainLowerFrameGKickButton:Show()
	else                          
		GuildPanelDataView_AltMainLowerFrameGKickButton:Hide()
	end                           
	if CanGuildPromote() == 1 then
		GuildPanelDataView_AltMainLowerFramePromoteButton:Show()
	else                          
		GuildPanelDataView_AltMainLowerFramePromoteButton:Hide()
	end                           
	if CanGuildDemote() == 1 then 
		GuildPanelDataView_AltMainLowerFrameDemoteButton:Show()
	else                                    
		GuildPanelDataView_AltMainLowerFrameDemoteButton:Hide()	
	end
	
end

function GuildPanel:DrawStdDataView()
	if(not self.stdDataView) then
		self.stdDataView = CreateFrame("Frame", "GuildPanelDataView_Standard", GuildPanelWindowContentRect, "GuildPanelDataView")
	end
	self.stdDataView:ClearAllPoints();
	self.stdDataView:SetPoint("TOPLEFT", GuildPanelWindowContentRect, "TOPLEFT", 0, 0)
	
	GuildPanelDataView_StandardScrollBar:Show()
	
	if getglobal("GuildPanelDataView_Standard_Details") ~= nil then
		getglobal("GuildPanelDataView_Standard_Details"):Hide()
	end
	
	self:DrawScrollBarTex(GuildPanelDataView_StandardScrollBar)
	
	self:UpdateList("STD")
	
	local tab = getglobal(self.stdDataView:GetName() .. "ScrollBarTable")

	local count = #self.stdList;
	
	tab:SetHeight(count*16);
	
	local shownDetailsFrame = false
	
	if self.stdDrawIdx then
		for i=1,self.stdDrawIdx do
			getglobal("GuildPanelDataView_Standard_Item"..i):Hide()
		end
	end
	self.stdDrawIdx = 0
	
	if self.stdList._empty == false then
		for i,entry in ipairs(self.stdList) do
			--local frameName = "GuildPanelDataView_ListItem"..(i%2)
			local frameName
			frameName = "GuildPanelDataView_ListItem"
		
			local item
			if getglobal("GuildPanelDataView_Standard_Item"..i) == nil then
				item = CreateFrame("Frame", "GuildPanelDataView_Standard_Item"..i, tab, frameName)
			else
				item = getglobal("GuildPanelDataView_Standard_Item"..i)
			end
		

			if shownDetailsFrame == true then
				item:SetPoint("TOPLEFT", tab, "TOPLEFT", 0, (16*i*-1)+16-110)
				--self:Print(entry.name.." @ "..tostring((16*i*-1)+16-110))
			else
				item:SetPoint("TOPLEFT", tab, "TOPLEFT", 0, (16*i*-1)+16)
				--self:Print(entry.name.." @ "..tostring((16*i*-1)+16))
			end
			
		
			--if i == 1 then
		--		item:SetHeight(16.8) -- compensation for the drawing bug
			--end
		
			local nameText = getglobal(item:GetName() .. "NameText")
			local classText = getglobal(item:GetName() .. "ClassText")
			local levelText = getglobal(item:GetName() .. "LevelText")
			local zoneText = getglobal(item:GetName() .. "ZoneText")
			local L = getglobal(item:GetName() .. "L")
			L:Hide()
			
		
			local class = entry.class
			local level = entry.level
			local zone = entry.zone
			local rank = entry.rank
			local note = entry.note
			local officernote = entry.officernote
			
			local officernote = ""
			if CanViewOfficerNote() == 1 then
				officernote = entry.officernote
			end
		
			local name
		
			local selected = false
		
			if entry.name == self.selectedName then
				selected = true
			end
		
			if entry.online == 1 then
				name = self:GetClassColorModifier(class) .. entry.name .. "|r"
				if selected == true then
					GuildPanel:SetTableCellType(item, 3, entry.status, self:IsNameMarked(entry.name))
				else
					GuildPanel:SetTableCellType(item, 1, entry.status, self:IsNameMarked(entry.name))
				end	
			else
				if selected == true then
					name = "|cFFFFFFFF" .. entry.name .. "|r"
					GuildPanel:SetTableCellType(item, 2, entry.status, self:IsNameMarked(entry.name))
				else
					name = "|cFF444444" .. entry.name .. "|r"
					GuildPanel:SetTableCellType(item, 0, entry.status, self:IsNameMarked(entry.name))
				end
			end
		
			nameText:SetText(name)
			classText:SetText(class)
			levelText:SetText(level)
			zoneText:SetText(zone)
		
			entry._cell = item
		
			item:EnableMouse(true)
		
			if selected == true then
				if getglobal("GuildPanelDataView_Standard_Details") == nil then
					detailsFrame = CreateFrame("Frame", "GuildPanelDataView_Standard_Details", tab, "GuildPanelDataView_Details")
				else
					detailsFrame = getglobal("GuildPanelDataView_Standard_Details")
				end
				detailsFrame:SetPoint("TOPLEFT", item, "TOPLEFT", 0, -16)
			
				getglobal(detailsFrame:GetName() .. "LevelClassText"):SetText("Level "..level.." "..class)
				getglobal(detailsFrame:GetName() .. "ZoneText"):SetText(zone)
				getglobal(detailsFrame:GetName() .. "RankText"):SetText(rank)
				--self:Print(detailsFrame:GetName() .. "PublicNote")
				getglobal(detailsFrame:GetName() .. "PublicNote"):SetText(note)
				
				if CanViewOfficerNote() == 1 then
					getglobal(detailsFrame:GetName() .. "OfficerNote"):Show()
					getglobal(detailsFrame:GetName() .. "OfficerNoteLabel"):Show()
					getglobal(detailsFrame:GetName() .. "OfficerNote"):SetText(officernote)
				else
					getglobal(detailsFrame:GetName() .. "OfficerNote"):Hide()
					getglobal(detailsFrame:GetName() .. "OfficerNoteLabel"):Hide()
				end
				if CanEditOfficerNote() == 1 then
					getglobal(detailsFrame:GetName() .. "EditOfficerNoteButton"):Show()
				else
					getglobal(detailsFrame:GetName() .. "EditOfficerNoteButton"):Hide()
				end
				if CanEditPublicNote() == 1 then
					getglobal(detailsFrame:GetName() .. "EditPublicNoteButton"):Show()
				else
					getglobal(detailsFrame:GetName() .. "EditPublicNoteButton"):Hide()
				end
				
				lastOnlineDays = entry.days
				if lastOnlineDays == nil then
					lastOnlineDays = "Online"
				else
					lastOnlineDays = tostring(lastOnlineDays).. " days"
				end
				getglobal(detailsFrame:GetName() .. "LastOnlineText"):SetText(lastOnlineDays)
				
				local altOptionsButton = getglobal(detailsFrame:GetName() .. "AltOptionsPopupButton")
				getglobal(altOptionsButton:GetName().."Text"):SetText("Click for Alt Options...")
				altOptionsOnClick = function ()
					ppmItems = self:GetAltOptionsMenu(entry.name)
					GuildPanel:DrawPopupMenu("AltOptionsMenu", -10, -1, altOptionsButton, "TOPRIGHT", 132, ppmItems)
				end
				altOptionsButton:SetScript("OnMouseUp", altOptionsOnClick)
				
				detailsFrame:EnableMouse(true)
				--detailsFrame:SetAlpha(0.0)
				detailsFrame:Show()
				--UIFrameFadeIn(detailsFrame, 0.3, 0.0, 1.0)
				shownDetailsFrame = true
			end
			self.stdDrawIdx = self.stdDrawIdx+1
			item:Show()
		end
	end
	self.stdDataView:Show();
	
	if CanGuildRemove() == 1 then
		GuildPanelDataView_StandardLowerFrameGKickButton:Show()
	else
		GuildPanelDataView_StandardLowerFrameGKickButton:Hide()
	end
	if CanGuildPromote() == 1 then
		GuildPanelDataView_StandardLowerFramePromoteButton:Show()
	else
		GuildPanelDataView_StandardLowerFramePromoteButton:Hide()
	end
	if CanGuildDemote() == 1 then
		GuildPanelDataView_StandardLowerFrameDemoteButton:Show()
	else                                
		GuildPanelDataView_StandardLowerFrameDemoteButton:Hide()	
	end
end

function GuildPanel:DrawSearchDataView()
	if(not self.searchDataView) then
		self.searchDataView = CreateFrame("Frame", "GuildPanelDataView_Search", GuildPanelWindowContentRect, "GuildPanelDataView")
	end
	self.searchDataView:ClearAllPoints();
	self.searchDataView:SetPoint("TOPLEFT", GuildPanelWindowContentRect, "TOPLEFT", 0, 0)
	
	GuildPanelDataView_SearchScrollBar:Show()
	GuildPanelDataView_SearchLowerFrame:SetPoint("BOTTOMLEFT", self.searchDataView, "BOTTOMLEFT", 0.0, 0.0)
	GuildPanelDataView_SearchLowerFrame:Show()
	
	if getglobal("GuildPanelDataView_Search_Details") ~= nil then
		getglobal("GuildPanelDataView_Search_Details"):Hide()
	end
	
	self:DrawScrollBarTex(GuildPanelDataView_SearchScrollBar)

	self:UpdateList("SEARCH")
	
	local tab = getglobal(self.searchDataView:GetName() .. "ScrollBarTable")

	local count = #self.searchList;
	
	tab:SetHeight((count*16)+(#self.searchPredicates*25));
	
	local shownDetailsFrame = false
	
	if self.searchDrawIdx then
		for i=1,self.searchDrawIdx do
			getglobal("GuildPanelDataView_Search_Item"..i):Hide()
		end
	end
	if self.searchPredicateDrawIdx then
		for i=1,self.searchPredicateDrawIdx do
			getglobal("GuildPanelDataView_Search_Criteria"..i):Hide()
		end
	end
	
	self.searchDrawIdx = 0
	self.searchPredicateDrawIdx = 0
	
	local predicatesOffset = #self.searchPredicates * 25
	
	for i,predicate in ipairs(self.searchPredicates) do
		local predcell
		if getglobal("GuildPanelDataView_Search_Criteria"..i) == nil then
			predcell = CreateFrame("Frame", "GuildPanelDataView_Search_Criteria"..i, tab, "GuildPanelDataView_SearchCriteria")
		else
			predcell = getglobal("GuildPanelDataView_Search_Criteria"..i)
		end
		predcell:SetPoint("TOP", tab, "TOP", -2, self.searchPredicateDrawIdx*-25)
		predcell:EnableMouse(true)
		predcell:SetHeight(25)
		
		if i == 1 then
			getglobal(predcell:GetName().."AndText"):Hide()
			if #self.searchPredicates == 1 then
				getglobal(predcell:GetName().."RemovePredicateButton"):Hide()
			else
				getglobal(predcell:GetName().."RemovePredicateButton"):Show()
			end
		else
			getglobal(predcell:GetName().."AndText"):Show()
			getglobal(predcell:GetName().."RemovePredicateButton"):Show()
		end
		if predicate.field == "name" then
			getglobal(predcell:GetName().."PredicateFieldSelectText"):SetText("Name")
		elseif predicate.field == "class" then
			getglobal(predcell:GetName().."PredicateFieldSelectText"):SetText("Class")
		elseif predicate.field == "level" then
			getglobal(predcell:GetName().."PredicateFieldSelectText"):SetText("Level")
		elseif predicate.field == "zone" then
			getglobal(predcell:GetName().."PredicateFieldSelectText"):SetText("Zone")
		elseif predicate.field == "rank" then
			getglobal(predcell:GetName().."PredicateFieldSelectText"):SetText("Rank")
		elseif predicate.field == "publicnote" then
			getglobal(predcell:GetName().."PredicateFieldSelectText"):SetText("PublicNote")
		elseif predicate.field == "officernote" then
			getglobal(predcell:GetName().."PredicateFieldSelectText"):SetText("OfficerNote")
		end
		local fieldPPMItems = {
			{
				name = "Name",
				func = function ()
					self.searchPredicates[i].field = "name"
					self.searchPredicates[i].cond = "contains"
					self:DrawDataView()
					self:ClosePopupMenu("PredicateFieldSelect")
				end
			},
			{
				name = "Class",
				func = function ()
					self.searchPredicates[i].field = "class"
					self.searchPredicates[i].cond = "equals"
					self.searchPredicates[i].value = "Death Knight"
					self:DrawDataView()
					self:ClosePopupMenu("PredicateFieldSelect")
				end
			},
			{
				name = "Level",
				func = function ()
					self.searchPredicates[i].field = "level"
					self.searchPredicates[i].cond = "equals"
					self:DrawDataView()
					self:ClosePopupMenu("PredicateFieldSelect")
				end
			},
			{
				name = "Zone",
				func = function ()
					self.searchPredicates[i].field = "zone"
					self.searchPredicates[i].cond = "contains"
					self:DrawDataView()
					self:ClosePopupMenu("PredicateFieldSelect")
				end
			},
			{
				name = "Rank",
				func = function ()
					self.searchPredicates[i].field = "rank"
					self.searchPredicates[i].cond = "equals"
					self.searchPredicates[i].value = GuildControlGetRankName(1)
					self:DrawDataView()
					self:ClosePopupMenu("PredicateFieldSelect")
				end
			},
			{
				name = "PublicNote",
				func = function ()
					self.searchPredicates[i].field = "publicnote"
					self.searchPredicates[i].cond = "contains"
					self:DrawDataView()
					self:ClosePopupMenu("PredicateFieldSelect")
				end
			},
			{
				name = "OfficerNote",
				func = function ()
					self.searchPredicates[i].field = "officernote"
					self.searchPredicates[i].cond = "equals"
					self:DrawDataView()
					self:ClosePopupMenu("PredicateFieldSelect")
				end,
				disabled = (not CanViewOfficerNote())
			},
		}
		
		if predicate.cond == "equals" then
			getglobal(predcell:GetName().."PredicateConditionSelectText"):SetText("Equals")
		elseif predicate.cond == "contains" then
			getglobal(predcell:GetName().."PredicateConditionSelectText"):SetText("Contains")
		elseif predicate.cond == "!equals" then
			getglobal(predcell:GetName().."PredicateConditionSelectText"):SetText("!Equals")
		elseif predicate.cond == "!contains" then
			getglobal(predcell:GetName().."PredicateConditionSelectText"):SetText("!Contains")
		elseif predicate.cond == "startswith" then
			getglobal(predcell:GetName().."PredicateConditionSelectText"):SetText("Starts With")
		elseif predicate.cond == "endswith" then
			getglobal(predcell:GetName().."PredicateConditionSelectText"):SetText("Ends With")
		elseif predicate.cond == "gt" then
			getglobal(predcell:GetName().."PredicateConditionSelectText"):SetText("         > ")
		elseif predicate.cond == "lt" then
			getglobal(predcell:GetName().."PredicateConditionSelectText"):SetText("         < ")
		end
		local condPPMItems
		if predicate.field == "class" or predicate.field == "rank" then
			condPPMItems = {
				{
					name = "Equals",
					func = function ()
						self.searchPredicates[i].cond = "equals"
						self:DrawDataView()
						self:ClosePopupMenu("Predicate"..i.."ConditionSelect")
					end
				},
				{
					name = "Does Not Equal",
					func = function ()
						self.searchPredicates[i].cond = "!equals"
						self:DrawDataView()
						self:ClosePopupMenu("Predicate"..i.."ConditionSelect")
					end
				}
			}
		elseif predicate.field == "publicnote" or predicate.field == "officernote" then
			condPPMItems = {
				{
					name = "Contains",
					func = function ()
						self.searchPredicates[i].cond = "contains"
						self:DrawDataView()
						self:ClosePopupMenu("Predicate"..i.."ConditionSelect")
					end
				},
				{
					name = "Does Not Contain",
					func = function ()
						self.searchPredicates[i].cond = "!contains"
						self:DrawDataView()
						self:ClosePopupMenu("Predicate"..i.."ConditionSelect")
					end
				}
			}
		elseif predicate.field == "level" then
			condPPMItems = {
				{
					name = "Equals",
					func = function ()
						self.searchPredicates[i].cond = "equals"
						self:DrawDataView()
						self:ClosePopupMenu("PredicateConditionSelect")
					end
				},
				{
					name = "Does Not Equal",
					func = function ()
						self.searchPredicates[i].cond = "!equals"
						self:DrawDataView()
						self:ClosePopupMenu("PredicateConditionSelect")
					end
				},
				{
					name = "Is Greater Than",
					func = function ()
						self.searchPredicates[i].cond = "gt"
						self:DrawDataView()
						self:ClosePopupMenu("PredicateConditionSelect")
					end
				},
				{
					name = "Is Less Than",
					func = function ()
						self.searchPredicates[i].cond = "lt"
						self:DrawDataView()
						self:ClosePopupMenu("PredicateConditionSelect")
					end
				}
			}
		else
			condPPMItems = {
				{
					name = "Equals",
					func = function ()
						self.searchPredicates[i].cond = "equals"
						self:DrawDataView()
						self:ClosePopupMenu("PredicateConditionSelect")
					end
				},
				{
					name = "Does Not Equal",
					func = function ()
						self.searchPredicates[i].cond = "!equals"
						self:DrawDataView()
						self:ClosePopupMenu("PredicateConditionSelect")
					end
				},
				{
					name = "Contains",
					func = function ()
						self.searchPredicates[i].cond = "contains"
						self:DrawDataView()
						self:ClosePopupMenu("PredicateConditionSelect")
					end
				},
				{
					name = "Does Not Contain",
					func = function ()
						self.searchPredicates[i].cond = "!contains"
						self:DrawDataView()
						self:ClosePopupMenu("PredicateConditionSelect")
					end
				},
				{
					name = "Starts With",
					func = function ()
						self.searchPredicates[i].cond = "startswith"
						self:DrawDataView()
						self:ClosePopupMenu("PredicateConditionSelect")
					end
				},
				{
					name = "Ends With",
					func = function ()
						self.searchPredicates[i].cond = "endswith"
						self:DrawDataView()
						self:ClosePopupMenu("PredicateConditionSelect")
					end
				}
			}
		end
		
		if predicate.field == "rank" then
			getglobal(predcell:GetName().."PredicateValueField"):Hide()
			local rankCount = GuildControlGetNumRanks()
			local valuePPMItems = {}
			for j=1,rankCount do
				local rankName = GuildControlGetRankName(j)
				local item = {
					name = rankName,
					func = function ()
						self.searchPredicates[i].value = rankName
						self:DrawDataView()
						self:ClosePopupMenu("PredicateValueSelect")
					end
				}
				table.insert(valuePPMItems, item)
			end
			getglobal(predcell:GetName().."PredicateValueSelect"):Show()
			valueOnClick = function ()
				GuildPanel:CloseAllPopupMenus()
				GuildPanel:DrawPopupMenu("PredicateValueSelect", -10, -1, getglobal(predcell:GetName().."PredicateValueSelect"), "TOPRIGHT", 100, valuePPMItems)
			end
			getglobal(predcell:GetName().."PredicateValueSelectText"):SetText(predicate.value)
			getglobal(predcell:GetName().."PredicateValueSelect"):SetScript("OnMouseUp", valueOnClick)
		elseif predicate.field == "class" then
			getglobal(predcell:GetName().."PredicateValueField"):Hide()
			local classes = { "Death Knight", "Druid", "Hunter", "Mage", "Paladin", "Priest", "Rogue", "Shaman", "Warlock", "Warrior" }
			local valuePPMItems = {}
			for j,class in ipairs(classes) do
				local item = {
					name = class,
					func = function ()
						self.searchPredicates[i].value = class
						self:DrawDataView()
						self:ClosePopupMenu("PredicateValueSelect")
					end
				}
				table.insert(valuePPMItems, item)
			end
			getglobal(predcell:GetName().."PredicateValueSelect"):Show()
			valueOnClick = function ()
				GuildPanel:CloseAllPopupMenus()
				GuildPanel:DrawPopupMenu("PredicateValueSelect", -10, -1, getglobal(predcell:GetName().."PredicateValueSelect"), "TOPRIGHT", 100, valuePPMItems)
			end
			getglobal(predcell:GetName().."PredicateValueSelectText"):SetText(predicate.value)
			getglobal(predcell:GetName().."PredicateValueSelect"):SetScript("OnMouseUp", valueOnClick)
		else
			getglobal(predcell:GetName().."PredicateValueSelect"):Hide()
			submitFunc = function ()
				self.searchPredicates[i].value = getglobal(predcell:GetName().."PredicateValueField"):GetText()
				self:DrawDataView()
			end
			getglobal(predcell:GetName().."PredicateValueField"):SetScript("OnEnterPressed", submitFunc)
			getglobal(predcell:GetName().."PredicateValueField"):SetScript("OnEscapePressed", submitFunc)
			getglobal(predcell:GetName().."PredicateValueField"):Show()
		end
	
		local fieldOnClick = function ()
			GuildPanel:CloseAllPopupMenus()
			GuildPanel:DrawPopupMenu("PredicateFieldSelect", -10, -1, getglobal(predcell:GetName().."PredicateFieldSelect"), "TOPRIGHT", 80, fieldPPMItems)
		end
		local condOnClick = function ()
			GuildPanel:CloseAllPopupMenus()
			GuildPanel:DrawPopupMenu("PredicateConditionSelect", -10, -1, getglobal(predcell:GetName().."PredicateConditionSelect"), "TOPRIGHT", 100, condPPMItems)
		end
		local addOnClick = function ()
			local blankPred = {
				field = "name",
				cond = "contains",
				value = ""
			}
			table.insert(self.searchPredicates, blankPred)
			GuildPanel:CloseAllPopupMenus()
			self:DrawDataView()
		end
		local removeOnClick = function ()
			table.remove(self.searchPredicates, i)
			GuildPanel:CloseAllPopupMenus()
			self:DrawDataView()
		end
		getglobal(predcell:GetName().."PredicateFieldSelect"):SetScript("OnMouseUp", fieldOnClick)
		getglobal(predcell:GetName().."PredicateConditionSelect"):SetScript("OnMouseUp", condOnClick)
		getglobal(predcell:GetName().."AddPredicateButton"):SetScript("OnClick", addOnClick)
		getglobal(predcell:GetName().."RemovePredicateButton"):SetScript("OnClick", removeOnClick)
				
		predcell:Show()
		self.searchPredicateDrawIdx = self.searchPredicateDrawIdx + 1
	end
	
	
	if self.searchList._empty == false then
		for i,entry in ipairs(self.searchList) do
			--local frameName = "GuildPanelDataView_ListItem"..(i%2)
			local frameName
			frameName = "GuildPanelDataView_ListItem"
		
			local item
			if getglobal("GuildPanelDataView_Search_Item"..i) == nil then
				item = CreateFrame("Frame", "GuildPanelDataView_Search_Item"..i, tab, frameName)
			else
				item = getglobal("GuildPanelDataView_Search_Item"..i)
			end
		

			if shownDetailsFrame == true then
				item:SetPoint("TOPLEFT", tab, "TOPLEFT", 0, (16*i*-1)+16-110-predicatesOffset)
				--self:Print(entry.name.." @ "..tostring((16*i*-1)+16-110))
			else
				item:SetPoint("TOPLEFT", tab, "TOPLEFT", 0, (16*i*-1)+16-predicatesOffset)
				--self:Print(entry.name.." @ "..tostring((16*i*-1)+16))
			end
			
		
			--if i == 1 then
			--	item:SetHeight(16.8) -- compensation for the drawing bug
			--end
		
			local nameText = getglobal(item:GetName() .. "NameText")
			local classText = getglobal(item:GetName() .. "ClassText")
			local levelText = getglobal(item:GetName() .. "LevelText")
			local zoneText = getglobal(item:GetName() .. "ZoneText")
			local L = getglobal(item:GetName() .. "L")
			L:Hide()
			
		
			local class = entry.class
			local level = entry.level
			local zone = entry.zone
			local rank = entry.rank
			local note = entry.note
			local officernote = entry.officernote
			
			local officernote = ""
			if CanViewOfficerNote() == 1 then
				officernote = entry.officernote
			end
		
			local name
		
			local selected = false
		
			if entry.name == self.selectedName then
				selected = true
			end
		
			if entry.online == 1 then
				name = self:GetClassColorModifier(class) .. entry.name .. "|r"
				if selected == true then
					GuildPanel:SetTableCellType(item, 3, entry.status, self:IsNameMarked(entry.name))
				else
					GuildPanel:SetTableCellType(item, 1, entry.status, self:IsNameMarked(entry.name))
				end	
			else
				if selected == true then
					name = "|cFFFFFFFF" .. entry.name .. "|r"
					GuildPanel:SetTableCellType(item, 2, entry.status, self:IsNameMarked(entry.name))
				else
					name = "|cFF444444" .. entry.name .. "|r"
					GuildPanel:SetTableCellType(item, 0, entry.status, self:IsNameMarked(entry.name))
				end
			end
		
			nameText:SetText(name)
			classText:SetText(class)
			levelText:SetText(level)
			zoneText:SetText(zone)
		
			entry._cell = item
		
			item:EnableMouse(true)
		
			if selected == true then
				if getglobal("GuildPanelDataView_Search_Details") == nil then
					detailsFrame = CreateFrame("Frame", "GuildPanelDataView_Search_Details", tab, "GuildPanelDataView_Details")
				else
					detailsFrame = getglobal("GuildPanelDataView_Search_Details")
				end
				detailsFrame:SetPoint("TOPLEFT", item, "TOPLEFT", 0, -16)
			
				getglobal(detailsFrame:GetName() .. "LevelClassText"):SetText("Level "..level.." "..class)
				getglobal(detailsFrame:GetName() .. "ZoneText"):SetText(zone)
				getglobal(detailsFrame:GetName() .. "RankText"):SetText(rank)
				--self:Print(detailsFrame:GetName() .. "PublicNote")
				getglobal(detailsFrame:GetName() .. "PublicNote"):SetText(note)
				
				if CanViewOfficerNote() == 1 then
					getglobal(detailsFrame:GetName() .. "OfficerNote"):Show()
					getglobal(detailsFrame:GetName() .. "OfficerNoteLabel"):Show()
					getglobal(detailsFrame:GetName() .. "OfficerNote"):SetText(officernote)
				else
					getglobal(detailsFrame:GetName() .. "OfficerNote"):Hide()
					getglobal(detailsFrame:GetName() .. "OfficerNoteLabel"):Hide()
				end
				if CanEditOfficerNote() == 1 then
					getglobal(detailsFrame:GetName() .. "EditOfficerNoteButton"):Show()
				else
					getglobal(detailsFrame:GetName() .. "EditOfficerNoteButton"):Hide()
				end
				if CanEditPublicNote() == 1 then
					getglobal(detailsFrame:GetName() .. "EditPublicNoteButton"):Show()
				else
					getglobal(detailsFrame:GetName() .. "EditPublicNoteButton"):Hide()
				end
				
				lastOnlineDays = entry.days
				if lastOnlineDays == nil then
					lastOnlineDays = "Online"
				else
					lastOnlineDays = tostring(lastOnlineDays).. " days"
				end
				getglobal(detailsFrame:GetName() .. "LastOnlineText"):SetText(lastOnlineDays)
				
				local altOptionsButton = getglobal(detailsFrame:GetName() .. "AltOptionsPopupButton")
				getglobal(altOptionsButton:GetName().."Text"):SetText("Click for Alt Options...")
				altOptionsOnClick = function ()
					ppmItems = self:GetAltOptionsMenu(entry.name)
					GuildPanel:DrawPopupMenu("AltOptionsMenu", -10, -1, altOptionsButton, "TOPRIGHT", 132, ppmItems)
				end
				altOptionsButton:SetScript("OnMouseUp", altOptionsOnClick)
				
				detailsFrame:EnableMouse(true)
				--detailsFrame:SetAlpha(0.0)
				detailsFrame:Show()
				--UIFrameFadeIn(detailsFrame, 0.3, 0.0, 1.0)
				shownDetailsFrame = true
			end
			self.searchDrawIdx = self.searchDrawIdx+1
			item:Show()
		end
	end
	self.searchDataView:Show();
	
	
	if CanGuildRemove() == 1 then
		GuildPanelDataView_SearchLowerFrameGKickButton:Show()
	else                          
		GuildPanelDataView_SearchLowerFrameGKickButton:Hide()
	end                           
	if CanGuildPromote() == 1 then
		GuildPanelDataView_SearchLowerFramePromoteButton:Show()
	else                          
		GuildPanelDataView_SearchLowerFramePromoteButton:Hide()
	end                           
	if CanGuildDemote() == 1 then 
		GuildPanelDataView_SearchLowerFrameDemoteButton:Show()
	else                                    
		GuildPanelDataView_SearchLowerFrameDemoteButton:Hide()	
	end
end

function GuildPanel:SetTableCellType(cell, celltype, status, marked)
	if celltype == 0 then
		cell:SetBackdrop({bgFile = "Interface\\Addons\\GuildPanel\\dataViewListBG0"})
		getglobal(cell:GetName().."NameText"):SetFontObject("GuildPanelFontNormal")
		getglobal(cell:GetName().."NameText"):SetShadowColor(0.8,0.8,0.8)
		
		getglobal(cell:GetName().."ZoneText"):SetTextColor(0.2,0.2,0.2)
		getglobal(cell:GetName().."ZoneText"):SetShadowColor(0.8,0.8,0.8)
		
		getglobal(cell:GetName().."LevelText"):SetTextColor(0.2,0.2,0.2)
		getglobal(cell:GetName().."LevelText"):SetShadowColor(0.8,0.8,0.8)
		
		getglobal(cell:GetName().."ClassText"):SetTextColor(0.2,0.2,0.2)
		getglobal(cell:GetName().."ClassText"):SetShadowColor(0.8,0.8,0.8)
		
		
		getglobal(cell:GetName().."Onoff"):SetTexture("Interface\\Addons\\GuildPanel\\offline")
		
		
	elseif celltype == 1 then
		cell:SetBackdrop({bgFile = "Interface\\Addons\\GuildPanel\\dataViewListBG1"})
		getglobal(cell:GetName().."NameText"):SetFontObject("GuildPanelFontBold")
		getglobal(cell:GetName().."NameText"):SetShadowColor(0.3,0.3,0.3)
		
		getglobal(cell:GetName().."ZoneText"):SetTextColor(0.0,0.0,0.0)
		getglobal(cell:GetName().."ZoneText"):SetShadowColor(0.3,0.3,0.3)
		
		getglobal(cell:GetName().."LevelText"):SetTextColor(0.0,0.0,0.0)
		getglobal(cell:GetName().."LevelText"):SetShadowColor(0.3,0.3,0.3)
		
		getglobal(cell:GetName().."ClassText"):SetTextColor(0.0,0.0,0.0)
		getglobal(cell:GetName().."ClassText"):SetShadowColor(0.3,0.3,0.3)
		
		if status == "<AFK>" then
			getglobal(cell:GetName().."Onoff"):SetTexture("Interface\\Addons\\GuildPanel\\afk")
		elseif status == "<DND>" then
			getglobal(cell:GetName().."Onoff"):SetTexture("Interface\\Addons\\GuildPanel\\dnd")
		else
			getglobal(cell:GetName().."Onoff"):SetTexture("Interface\\Addons\\GuildPanel\\online")
		end
	elseif celltype == 2 then
		cell:SetBackdrop({bgFile = "Interface\\Addons\\GuildPanel\\dataViewListBGselected"})
		getglobal(cell:GetName().."NameText"):SetFontObject("GuildPanelFontNormal")
		getglobal(cell:GetName().."NameText"):SetShadowColor(0.3,0.3,0.3)
		
		getglobal(cell:GetName().."ZoneText"):SetTextColor(0.0,0.0,0.0)
		getglobal(cell:GetName().."ZoneText"):SetShadowColor(0.3,0.3,0.3)
		
		getglobal(cell:GetName().."LevelText"):SetTextColor(0.0,0.0,0.0)
		getglobal(cell:GetName().."LevelText"):SetShadowColor(0.3,0.3,0.3)
		
		getglobal(cell:GetName().."ClassText"):SetTextColor(0.0,0.0,0.0)
		getglobal(cell:GetName().."ClassText"):SetShadowColor(0.3,0.3,0.3)
		
		getglobal(cell:GetName().."Onoff"):SetTexture("Interface\\Addons\\GuildPanel\\offline")
	elseif celltype == 3 then
		cell:SetBackdrop({bgFile = "Interface\\Addons\\GuildPanel\\dataViewListBGselected"})
		getglobal(cell:GetName().."NameText"):SetFontObject("GuildPanelFontBold")
		getglobal(cell:GetName().."NameText"):SetShadowColor(0.1,0.1,0.1)
		
		getglobal(cell:GetName().."ZoneText"):SetTextColor(0.0,0.0,0.0)
		getglobal(cell:GetName().."ZoneText"):SetShadowColor(0.3,0.3,0.3)
		
		getglobal(cell:GetName().."LevelText"):SetTextColor(0.0,0.0,0.0)
		getglobal(cell:GetName().."LevelText"):SetShadowColor(0.3,0.3,0.3)
		
		getglobal(cell:GetName().."ClassText"):SetTextColor(0.0,0.0,0.0)
		getglobal(cell:GetName().."ClassText"):SetShadowColor(0.3,0.3,0.3)
		
		if status == "<AFK>" then
			getglobal(cell:GetName().."Onoff"):SetTexture("Interface\\Addons\\GuildPanel\\afk")
		elseif status == "<DND>" then
			getglobal(cell:GetName().."Onoff"):SetTexture("Interface\\Addons\\GuildPanel\\dnd")
		else
			getglobal(cell:GetName().."Onoff"):SetTexture("Interface\\Addons\\GuildPanel\\online")
		end
	end
	if marked == true then
		if celltype ~= 2 and celltype ~= 3 then
			cell:SetBackdrop({bgFile = "Interface\\Addons\\GuildPanel\\dataViewListBGmarked"})
		end
		getglobal(cell:GetName().."Marked"):Show()
	else
		getglobal(cell:GetName().."Marked"):Hide()
	end
end

function GuildPanel:GetClassColorModifier(class)
	-- |cFFrrggbb
	local modifier
	if class == "Death Knight" then
		modifier = "|cFFC41F3B"
	elseif class == "Druid" then
		modifier = "|cFFFF7D0A"
	elseif class == "Hunter" then
		modifier = "|cFFABD473"
	elseif class == "Mage" then
		modifier = "|cFF69CCF0"
	elseif class == "Paladin" then
		modifier = "|cFFF58CBA"
	elseif class == "Priest" then
		modifier = "|cFFFFFFFF"
	elseif class == "Rogue" then
		modifier = "|cFFFFF569"
	elseif class == "Shaman" then
		modifier = "|cFF2459FF"
	elseif class == "Warlock" then
		modifier = "|cFFBEAEED"
	elseif class == "Warrior" then
		modifier = "|cFFe5c29d"
	end
	return modifier
end
