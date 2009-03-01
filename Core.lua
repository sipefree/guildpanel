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


-- TODO: Scroll guild info to top always; DOUBLE ARGH!
-- TODO: Message Board
-- TODO: Voting Booth
-- TODO: Quick switch to hotkey mode and show regular Guild frame
-- TODO: Look out for C stack overflow bug

GuildPanel = LibStub("AceAddon-3.0"):NewAddon("GuildPanel", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceComm-3.0", "AceSerializer-3.0")
local options = {
    name = "GuildPanel",
    handler = GuildPanel,
    type = 'group',
    args = {
		test = {
		            type = "execute",
		            name = "Test",
		            desc = "test",
					func = "Test"
		        },
		show = {
					type = "execute",
					name = "Show",
					desc = "Show the GuildPanel Window",
					func = "ShowWindow"
		},
		hide = {
					type = "execute",
					name = "Hide",
					desc = "Hide the GuildPanel Window",
					func = "HideWindow"
		}
    },
}

BINDING_HEADER_GUILDPANEL = "GuildPanel"
BINDING_NAME_TOGGLEGUILDPANEL = "Toggle GuildPanel Window"

GUILDPANEL_CONTENTRECT_W = 376;
GUILDPANEL_CONTENTRECT_H = 346

-- TODO: make GUILDPANEL_SHOWOFFLINE into an instance variable. why is it not?
GUILDPANEL_SHOWOFFLINE = false



function GuildPanel:GetTimestamp()
	hours,minutes = GetGameTime();
	weekday, month, day, year = CalendarGetDate();
	if month < 10 then
		month = "0"..tostring(month)
	end
	if day < 10 then
		day = "0"..tostring(day)
	end
	if hours < 10 then
		hours = "0"..tostring(hours)
	end
	if minutes < 10 then
		minutes = "0"..tostring(minutes)
	end
	timestamp = year..month..day..hours..minutes
	return tonumber(timestamp)
end

function table_to_string(data, indent) 
    local str = "" 

    if(indent == nil) then 
        indent = 0 
    end 

    -- Check the type 
    if(type(data) == "string") then 
        str = str .. (" "):rep(indent) .. data .. "\n" 
    elseif(type(data) == "number") then 
        str = str .. (" "):rep(indent) .. data .. "\n" 
    elseif(type(data) == "boolean") then 
        if(data == true) then 
            str = str .. "true" 
        else 
            str = str .. "false" 
        end 
    elseif(type(data) == "table") then 
        local i, v 
        for i, v in pairs(data) do 
            -- Check for a table in a table 
            if(type(v) == "table") then 
                str = str .. (" "):rep(indent) .. i .. ":\n" 
                str = str .. table_to_string(v, indent + 2) 
            else 
                str = str .. (" "):rep(indent) .. i .. ": " .. table_to_string(v, 0) 
            end 
        end 
    end 

    return str 
end

function GuildPanel:OnInitialize()
	-- Called when the addon is loaded
	LibStub("AceConfig-3.0"):RegisterOptionsTable("GuildPanel", options, {"GuildPanel"})
	self.db = LibStub("AceDB-3.0"):New("GuildPanelDB")
	
	
	if not self.db.char.alts then self.db.char.alts = { } end
	if not self.db.char.mains then self.db.char.mains = { } end
	if not self.db.char.dbTimestamp then self.db.char.dbTimestamp = 0 end
	if not self.db.char.activationMode then self.db.char.activationMode = "EMBED" end
	if not self.db.char.snapToSocial then self.db.char.snapToSocial = true end
	
	self.votingView = nil

	
	
	--
	
	self.stdDataView = nil
	self.stdList = {}
	self.stdDrawIdx = nil
	self.altMainList = {}
	self.altMainDrawIdx = nil
	self.searchList = {}
	self.searchDrawIdx = nil
	self.searchPredicateDrawIdx = nil
	self.searchPredicates = {
		{
			field = "name",
			cond = "contains",
			value = ""
		}
	}
	self.manageView = nil
	self.manageSelectedRank = nil
	self.manageItems = {
		{
			name = "Preferences",
			disclosed = false,
			height = 100,
			frame = "GuildPanelManageView_Preferences",
			viewFunc = function () return true end,
			load = function (frame)
				if self.db.char.activationMode == "SOLO" then
					getglobal(frame:GetName().."SoloModeButton"):SetChecked(true)
					getglobal(frame:GetName().."EmbedModeButton"):SetChecked(false)
				elseif self.db.char.activationMode == "EMBED" then
					getglobal(frame:GetName().."SoloModeButton"):SetChecked(false)
					getglobal(frame:GetName().."EmbedModeButton"):SetChecked(true)
				end
				getglobal(frame:GetName().."SnapToSocial"):SetChecked(self.db.char.snapToSocial)
				local hotkey = GetBindingKey("TOGGLEGUILDPANEL")
				if hotkey == nil then
					hotkey = "none"
				end
				getglobal(frame:GetName().."HotkeyText"):SetText("Current Hotkey: "..hotkey)
			end
		},
		{
			name = "Alt/Main Database",
			disclosed = false,
			height = 100,
			frame = "GuildPanelManageView_AltMain",
			viewFunc = function () return true end,
			load = function ()
			
			end
		},
		{
			name = "Guild Control",
			disclosed = false,
			height = 100,
			frame = "GuildPanelManageView_GuildControlBeta",
			viewFunc = function ()
				if IsGuildLeader("player") then
					return true
				else
					return false
				end
			end,
			load = function (frame)--[[
				local rankSelect = getglobal(frame:GetName().."RankSelect")
				local rankSelectText = getglobal(frame:GetName().."RankSelectText")
				local numRanks = GuildControlGetNumRanks()
				self.manageSelectedRank = 1
				GuildControlSetRank(self.manageSelectedRank);
				rankSelectText:SetText(GuildControlGetRankName(self.manageSelectedRank))
				local ppmItems = {}
				for i=1,numRanks do
					ppmItems[i] = {
						name = GuildControlGetRankName(i),
						func = function ()
							self.manageSelectedRank = i
							GuildControlSetRank(self.manageSelectedRank);
							rankSelectText:SetText(GuildControlGetRankName(self.manageSelectedRank))
							GuildPanel:SetRankFlags(frame)
							GuildPanel:ClosePopupMenu("GuildRankSelect")
						end
					}
				end
				local rankSelectOnClick = function ()
					GuildPanel:DrawPopupMenu("GuildRankSelect", -10, -1, rankSelect, "TOPRIGHT", 132, ppmItems)
				end
				rankSelect:SetScript("OnMouseUp", rankSelectOnClick)
				
				GuildPanel:SetRankFlags(frame)]]
			end
		},
	}
	
	self.selectedName = nil
	self.dataFilter = ""
	self.markedNames = {}
	self.actionGroup = "SELECTED"
	
	self.importerState = 0
	self.importerData = {}
	
	self.downloaderState = 0
	self.downloaderData = { peers = {} }
	
	self.popupMenus = {}
	
	self.isSelectedSocialTab = false
	
	self.guildUpdateFunctionQueue = {}
	
	
end
function GuildPanel:OnEnable()
	self.db.char.motd = self:GetMOTD()
	--self.db.char.tabardFiles = self:GetTabardFiles()
	--self:Print(self.db.char.tabardFiles)
	
	self:RegisterEvent("GUILD_ROSTER_UPDATE");
	self:RegisterEvent("PLAYER_GUILD_UPDATE")
	self:RegisterEvent("GUILD_MOTD");
	
	self:RegisterComm("GuildPanel-LIST"); -- a request for a list of clients with the database
	self:RegisterComm("GuildPanel-INFO"); -- telling the crowd what kind of database we have
	self:RegisterComm("GuildPanel-DOWNLOAD"); -- asking a client for a download
	self:RegisterComm("GuildPanel-UPLOAD"); -- a response to Download, containing the database
	
	GuildPanelBlurredWindow:Hide()
	GuildPanelWindow:Hide()
	GuildPanelWindowPanelOverlay:Hide()
	GuildPanelWindowPrompt:Hide()
	GuildPanelImporterStatusbar:Hide()
	
	if #self.db.char.alts == 0 then
		self:SetDrawMode("STD")
	else
		self:SetDrawMode("ALTMAIN")
	end

	self.regularSocialTabHandler = FriendsFrameTab3:GetScript("OnClick")
	local socialOrGuildPanelToggleFunc = function ()
		if FriendsFrame:IsShown() == 1 and GuildPanelWindow:IsShown() == nil then
			if self.isSelectedSocialTab == true then
				HideUIPanel(FriendsFrame)
				GuildPanel:ShowWindow()
			end
		elseif FriendsFrame:IsShown() == 1 and GuildPanelWindow:IsShown() == 1 then
			if self.db.char.activationMode == "EMBED" then
				HideUIPanel(FriendsFrame);
				GuildPanel:HideWindow()
				self.isSelectedSocialTab = true
			end
		end
	end
	hooksecurefunc("ToggleFriendsFrame", socialOrGuildPanelToggleFunc);
	self:SetupActivation()
	self.isSelectedSocialTab = false
	
	if GetBindingKey("TOGGLEGUILDPANEL") == nil then
		SetBinding("ALT-o", "TOGGLEGUILDPANEL")
		SaveBindings(2)
	end
end

function GuildPanel:SetupActivation()
	if self.db.char.activationMode == "EMBED" then
		local showGuildPanelFunc = function ()
			HideUIPanel(FriendsFrame)
			if self.db.char.snapToSocial == true then
				GuildPanelWindow:SetPoint("TOPLEFT", FriendsFrame, "TOPLEFT", 0, 0)
			end
			self.isSelectedSocialTab = true
			self:ShowWindow()
		end
		FriendsFrameTab3:SetScript("OnClick", showGuildPanelFunc)
		GuildPanelWindowFriendsTab:Show()
		GuildPanelWindowWhoTab:Show()
		GuildPanelWindowGuildTab:Show()
		GuildPanelWindowChatTab:Show()
		GuildPanelWindowRaidTab:Show()
		
		HideUIPanel(FriendsFrame)
		self.isSelectedSocialTab = true
	elseif self.db.char.activationMode == "SOLO" then
		self.isSelectedSocialTab = false
		FriendsFrameTab3:SetScript("OnClick", self.regularSocialTabHandler)
		GuildPanelWindowFriendsTab:Hide()
		GuildPanelWindowWhoTab:Hide()
		GuildPanelWindowGuildTab:Hide()
		GuildPanelWindowChatTab:Hide()
		GuildPanelWindowRaidTab:Hide()
	end
end

function GuildPanel:MarkName(name)
	self:SetActionGroup("MARKED")
	table.insert(self.markedNames, name)
end
function GuildPanel:UnmarkName(name)
	for i,v in ipairs(self.markedNames) do
		if v == name then
			table.remove(self.markedNames, i)
		end
	end
	-- I recommend Weezer. Good band.
end
function GuildPanel:IsNameMarked(name)
	local found = false
	for i,v in ipairs(self.markedNames) do
		if v == name then
			found = true
		end
	end
	return found
end
function GuildPanel:SetActionGroup(group)
	if group == "SELECTED" then
		self.actionGroup = group
		GuildPanelDataView_AltMainLowerFrameActionGroupSelectText:SetText("With Selected")
		GuildPanelDataView_StandardLowerFrameActionGroupSelectText:SetText("With Selected")
	elseif group == "MARKED" then
		self.actionGroup = group
		GuildPanelDataView_AltMainLowerFrameActionGroupSelectText:SetText("With Marked")
		GuildPanelDataView_StandardLowerFrameActionGroupSelectText:SetText("With Marked")
	end
end
function GuildPanel:PerformActionToGroup(action)
	if action == "INVITE" then
		if self.actionGroup == "SELECTED" then
			if self.selectedName ~= UnitName("player") then
				InviteUnit(self.selectedName)
			else
				self:Print("|cFFFF3300You cannot invite yourself to a group!|r")
			end
		elseif self.actionGroup == "MARKED" then
			local triedToInviteSelf = false
			local count = 0
			for i,v in ipairs(self.markedNames) do
				if v ~= UnitName("player") then
					count = count + 1
					InviteUnit(v)
				else
					triedToInviteSelf = true
				end
			end
			self:Print("|cFF11FF11Trying to invite |r"..count.." characters...")
			if triedToInviteSelf == true then
				self:Print("|cFFFF3300Could not invite self to group!|r (Divide by Zero error)")
			end
		end
	elseif action == "GKICK" then
		if self.actionGroup == "SELECTED" then
			if CanGuildRemove() == 1 then
				if self.selectedName ~= UnitName("player") then
					GuildUninvite(self.selectedName)
				else
					self:Print("|cFFFF3300Please use the '/gkick' command to remove yourself from your guild.|r")
				end
			end
		elseif self.actionGroup == "MARKED" then
			if CanGuildRemove() == 1 then
				local triedToKickSelf = false
				local count = 0
				for i,v in ipairs(self.markedNames) do
					if v ~= UnitName("player") then
						count = count + 1
						GuildUninvite(v)
					else
						triedToKickSelf = true
					end
				end
				self:Print("|cFF11FF11Trying to gkick |r"..count.." characters...")
				if triedToKickSelf == true then
					self:Print("|cFFFF3300You cannot kick yourself from the guild! This will cause your function to not complete. Use '/gquit'.|r")
				end
			end
		end
	elseif action == "PROMOTE" then
		if self.actionGroup == "SELECTED" then
			if CanGuildPromote() == 1 then
				if self.selectedName ~= UnitName("player") then
					GuildPromote(self.selectedName)
				else
					self:Print("|cFFFF3300You cannot promote or demote yourself.|r")
				end
			end
		elseif self.actionGroup == "MARKED" then
			-- This cannot be done all at once.
			-- We create a table of anonymous functions that
			-- will be called one by one as GUILD_ROSTER_UPDATEs are received.
			-- Thank the gods for closures!
			if CanGuildPromote() == 1 then
				local triedToPromoteSelf = false
				local count = 0
				self.guildUpdateFunctionQueue = {}
				for i,v in ipairs(self.markedNames) do
					if v ~= UnitName("player") then
						count = count + 1
						table.insert(self.guildUpdateFunctionQueue, function ()
							GuildPromote(v)
						end)
					else
						triedToPromoteSelf = true
					end
				end
				self:Print("|cFF11FF11Trying to promote |r"..count.." characters...")
				if triedToKickSelf == true then
					self:Print("|cFFFF3300You cannot promote or demote yourself!|r")
				end
				
				local i = #self.guildUpdateFunctionQueue
				self.guildUpdateFunctionQueue[i]()
				table.remove(self.guildUpdateFunctionQueue, i)
			end
		end
	elseif action == "DEMOTE" then
		if self.actionGroup == "SELECTED" then
			if CanGuildDemote() == 1 then
				if self.selectedName ~= UnitName("player") then
					GuildDemote(self.selectedName)
				else
					self:Print("|cFFFF3300You cannot promote or demote yourself.|r")
				end
			end
		elseif self.actionGroup == "MARKED" then
			if CanGuildDemote() == 1 then
				local triedToDemoteSelf = false
				local count = 0
				self.guildUpdateFunctionQueue = {}
				for i,v in ipairs(self.markedNames) do
					if v ~= UnitName("player") then
						count = count + 1
						table.insert(self.guildUpdateFunctionQueue, function ()
							GuildDemote(v)
						end)
					else
						triedToDemoteSelf = true
					end
				end
				self:Print("|cFF11FF11Trying to demote |r"..count.." characters...")
				if triedToKickSelf == true then
					self:Print("|cFFFF3300You cannot promote or demote yourself!|r")
				end
				
				local i = #self.guildUpdateFunctionQueue
				self.guildUpdateFunctionQueue[i]()
				table.remove(self.guildUpdateFunctionQueue, i)
			end
		end
	end
end

-- Get the MOTD. Sometimes bugs and will return empty, so use the last saved one.
function GuildPanel:GetMOTD()
	local MOTD = GetGuildRosterMOTD()
	if (MOTD == "") then
		MOTD = self.db.char.motd
	end
	return MOTD
end
function GuildPanel:GetTabardFiles()
	local files = GetGuildTabardFileNames()
	if(not self:CheckTabardFiles(files)) then
		return nil
	else
		return files
	end
end

function GuildPanel:SetRankFlags(frame)
	self:Print("set rank flags")
	local gChatListen, gChatSpeak, oChatListen, oChatSpeak, promote, demote, inv, rem, motdSet, pnoteSet, onoteView, onoteSet, infoSet, eventCreate, repair, gold, eventCreate2 = GuildControlGetRankFlags()
	if gChatListen then
		getglobal(frame:GetName().."GChatListenCheck"):SetChecked(true)
	else
		getglobal(frame:GetName().."GChatListenCheck"):SetChecked(false)
	end
	if gChatSpeak then
		getglobal(frame:GetName().."GChatTalkCheck"):SetChecked(true)
	else
		getglobal(frame:GetName().."GChatTalkCheck"):SetChecked(false)
	end
	if oChatListen then
		getglobal(frame:GetName().."OChatListenCheck"):SetChecked(true)
	else
		getglobal(frame:GetName().."OChatListenCheck"):SetChecked(false)
	end
	if oChatSpeak then
		getglobal(frame:GetName().."OChatTalkCheck"):SetChecked(true)
	else
		getglobal(frame:GetName().."OChatTalkCheck"):SetChecked(false)
	end
	if promote then
		getglobal(frame:GetName().."PromoteCheck"):SetChecked(true)
	else
		getglobal(frame:GetName().."PromoteCheck"):SetChecked(false)
	end
	if demote then
		getglobal(frame:GetName().."DemoteCheck"):SetChecked(true)
	else
		getglobal(frame:GetName().."DemoteCheck"):SetChecked(false)
	end
	if inv then
		getglobal(frame:GetName().."InviteMemberCheck"):SetChecked(true)
	else
		getglobal(frame:GetName().."InviteMemberCheck"):SetChecked(false)
	end
	if rem then
		getglobal(frame:GetName().."RemoveMemberCheck"):SetChecked(true)
	else
		getglobal(frame:GetName().."RemoveMemberCheck"):SetChecked(false)
	end
	if motdSet then
		getglobal(frame:GetName().."SetMOTDCheck"):SetChecked(true)
	else
		getglobal(frame:GetName().."SetMOTDCheck"):SetChecked(false)
	end
	if pnoteSet then
		getglobal(frame:GetName().."EditPublicNoteCheck"):SetChecked(true)
	else
		getglobal(frame:GetName().."EditPublicNoteCheck"):SetChecked(false)
	end
	if onoteView then
		getglobal(frame:GetName().."ViewOfficerNoteCheck"):SetChecked(true)
	else
		getglobal(frame:GetName().."ViewOfficerNoteCheck"):SetChecked(false)
	end
	if onoteSet then
		getglobal(frame:GetName().."EditOfficerNoteCheck"):SetChecked(true)
	else
		getglobal(frame:GetName().."EditOfficerNoteCheck"):SetChecked(false)
	end
	if infoSet then
		getglobal(frame:GetName().."ModifyGuildInfoCheck"):SetChecked(true)
	else
		getglobal(frame:GetName().."ModifyGuildInfoCheck"):SetChecked(false)
	end
	if eventCreate then
		getglobal(frame:GetName().."CreateGuildEventCheck"):SetChecked(true)
	else
		getglobal(frame:GetName().."CreateGuildEventCheck"):SetChecked(false)
	end
	if eventCreate2 then
		getglobal(frame:GetName().."CreateGuildEventCheck"):SetChecked(true)
	else
		getglobal(frame:GetName().."CreateGuildEventCheck"):SetChecked(false)
	end
	if repair then
	
	else
	
	end
	if gold then
	
	else
	
	end
	
end



function GuildPanel:ClosePopupMenu(name)
	if self.popupMenus[name] ~= nil then
		for i,v in ipairs(self.popupMenus[name].items) do
			v.frame:Hide()
		end
		self.popupMenus[name].frame:Hide()
	end
end
function GuildPanel:CloseAllPopupMenus()
	for k,v in pairs(self.popupMenus) do
		GuildPanel:ClosePopupMenu(k)
	end
end
function GuildPanel:DrawPopupMenu(name, pointX, pointY, relativeTo, point, width, items)
	if self.popupMenus[name] == nil then
		self.popupMenus[name] = {}
		self.popupMenus[name].frame = CreateFrame("Frame", "GuildPanelPopupMenu_"..name, GuildPanelWindow, "GuildPanelPopupMenu")
		self.popupMenus[name].items = {}
	end
	local frame = self.popupMenus[name].frame
	frame:SetHeight((#items)*16)
	frame:SetWidth(width)
	frame:SetFrameStrata("DIALOG")
	frame:SetPoint(point, relativeTo, point, pointX, pointY)
	for i,v in ipairs(items) do
		if self.popupMenus[name].items[i] == nil then
			self.popupMenus[name].items[i] = {}
			self.popupMenus[name].items[i].frame = CreateFrame("Frame", "GuildPanelPopupMenu_"..name.."Item"..i, frame, "GuildPanelPopupMenu_Item")
		end
		local cell = self.popupMenus[name].items[i].frame
		cell:SetWidth(width)
		cell:SetHeight(16)
		cell:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, (i-1)*16*-1)
		getglobal(cell:GetName().."Text"):SetText(v.name)
		
		if v.disabled ~= nil then
			getglobal(cell:GetName().."Text"):SetTextColor(0.2,0.2,0.2)
			cell._disabled = true
		else
			cell._disabled = false
			cell:SetScript("OnMouseUp", v.func)
		end
		
		cell:Show()
	end
	UIFrameFadeIn(frame, 0.1, 0.0, 1.0)
end

-- This is a lovely hack.
-- Basically, if any of the files from GetGuildTabardFileNames are missing (which they frequently are gg blizz)
-- then it will subsidize them with files available from a hidden TabardModel frame, which is used for creation of
-- tabards at the Guild Master in cities. This automatically snaps to the current guild tabard.
-- Unfortunately, the border texture is not available from this, so it is replaced with a default one if not available.
function GuildPanel:GetTabardFiles()
	--GuildPanelWindowTabardModel:InitializeTabardColors()
	--local tabardBackgroundUpperSub = GuildPanelWindowTabardModel:GetUpperBackgroundFileName()
	--local tabardBackgroundLowerSub = GuildPanelWindowTabardModel:GetLowerBackgroundFileName()
	--local tabardEmblemUpperSub = GuildPanelWindowTabardModel:GetUpperEmblemFileName()
	--local tabardEmblemLowerSub = GuildPanelWindowTabardModel:GetLowerEmblemFileName()
	local tabardBackgroundUpper, tabardBackgroundLower, tabardEmblemUpper, tabardEmblemLower, tabardBorderUpper, tabardBorderLower = GetGuildTabardFileNames()
	--[[if (not tabardBackgroundUpper) then
		tabardBackgroundUpper = tabardBackgroundUpperSub
	end
	if (not tabardBackgroundLower) then
		tabardBackgroundLower = tabardBackgroundLowerSub
	end
	if (not tabardEmblemLower) then
		tabardEmblemLower = tabardBackgroundLowerSub
	end
	if (not tabardEmblemLower) then
		tabardEmblemLower = tabardBackgroundLowerSub
	end
	
	-- WARNING, FECKING HACK ALERT OMG
	-- Replaces the border texture with a standard whitish one if it can't be got
	if (not tabardBorderLower) then
		tabardBorderLower = "Textures\\GuildEmblems\\Border_01_03_TU_U"
	end
	if (not tabardBorderUpper) then
		tabardBorderLower = "Textures\\GuildEmblems\\Border_01_03_TL_U"
	end
	GuildPanelWindowTabardModel:Hide()]]
	return tabardBackgroundUpper, tabardBackgroundLower, tabardEmblemUpper, tabardEmblemLower, tabardBorderUpper, tabardBorderLower
end

function GuildPanel:HideWindow()
	if IsInGuild() == nil then
		PlaySound("igMainMenuClose");
		GuildPanelBlurredWindow:Hide()
	else
		PlaySound("igMainMenuClose");
		GuildPanelWindow:Hide()
	end
end

function GuildPanel:ToggleWindow()
	if GuildPanelWindow:IsShown() or GuildPanelBlurredWindow:IsShown() then
		self:HideWindow()
	else
		self:ShowWindow()
	end
end

function GuildPanel:ShowWindow()
	if IsInGuild() == nil then
		PlaySound("igCharacterInfoTab");
		GuildPanelBlurredWindow:Show()
	else

		local guildName, guildRankName, guildRankIndex = GetGuildInfo('player');
		local guildMOTD = self:GetMOTD()
	
		-- long guild names don't get the fancy font in favor of displaying the entire
		-- name and not just ... after 15 characters...
	
		--if strlen(guildName) > 15 then
		--	GuildPanelWindowGuildName:SetTextHeight(12)
		--	GuildPanelWindowGuildName:SetFontObject("GuildPanelFontNormal")
		--end
	
		GuildPanelWindowGuildName:SetWidth(210)
		GuildPanelWindowGuildName:SetHeight(20)
		GuildPanelWindowGuildName:SetText("<" .. guildName .. ">")
		GuildPanelWindowPlayerRank:SetText(guildRankName .. " of")
		GuildPanelWindowMOTD:SetText(guildMOTD)
	
		--tabardFiles = self:CheckTabardFiles(tabardFiles)
		--self:Print("TABARD FILES: "..tostring(self:CheckTabardFiles(tabardFiles)))
		--self:CheckTabardFiles(tabardFiles)
		local tabardBackgroundUpper, tabardBackgroundLower, tabardEmblemUpper, tabardEmblemLower, tabardBorderUpper, tabardBorderLower = self:GetTabardFiles()
	
		GuildPanelWindowEmblemBackgroundUL:SetTexture(tabardBackgroundUpper);
		GuildPanelWindowEmblemBackgroundUR:SetTexture(tabardBackgroundUpper);
		GuildPanelWindowEmblemBackgroundBL:SetTexture(tabardBackgroundLower);
		GuildPanelWindowEmblemBackgroundBR:SetTexture(tabardBackgroundLower);

		GuildPanelWindowEmblemUL:SetTexture(tabardEmblemUpper);
		GuildPanelWindowEmblemUR:SetTexture(tabardEmblemUpper);
		GuildPanelWindowEmblemBL:SetTexture(tabardEmblemLower);
		GuildPanelWindowEmblemBR:SetTexture(tabardEmblemLower);

		GuildPanelWindowEmblemBorderUL:SetTexture(tabardBorderUpper);
		GuildPanelWindowEmblemBorderUR:SetTexture(tabardBorderUpper);
		GuildPanelWindowEmblemBorderBL:SetTexture(tabardBorderLower);
		GuildPanelWindowEmblemBorderBR:SetTexture(tabardBorderLower);
	
		if(not self.altMainDataView) then
			self.altMainDataView = CreateFrame("Frame", "GuildPanelDataView_AltMain", GuildPanelWindowContentRect, "GuildPanelDataView")
			self.altMainDataView:Hide()
		end
		if(not self.stdDataView) then
			self.stdDataView = CreateFrame("Frame", "GuildPanelDataView_Standard", GuildPanelWindowContentRect, "GuildPanelDataView")
			self.stdDataView:Hide()
		end

		PlaySound("igCharacterInfoTab");
		GuildPanelWindow:Show()
		GuildPanelWindowContentRect:Show()
		self:DrawDataView()
	end
end


function GuildPanel:SetResultsText(text)
	GuildPanelWindowResultsText:SetText(text)
end


function GuildPanel:SetDataFilter(str)
	self.dataFilter = strlower(str)
	if self.drawMode == "STD" then
		local scrmin, scrmax = getglobal("GuildPanelDataView_StandardScrollBarScrollBar"):GetMinMaxValues();
		getglobal("GuildPanelDataView_StandardScrollBarScrollBar"):SetValue(scrmin)
		self:DrawStdDataView()
	elseif self.drawMode == "ALTMAIN" then
		local scrmin, scrmax = getglobal("GuildPanelDataView_AltMainScrollBarScrollBar"):GetMinMaxValues();
		getglobal("GuildPanelDataView_AltMainScrollBarScrollBar"):SetValue(scrmin)
		self:DrawAltMainDataView()
	end
end

-- This is a big giant horrible function that draws the standard data table
-- It updates the local list by using self:UpdateList()
-- It loops through all the items in the list:
--	- Takes a GuildPanelDataView_ListItem (either the next available one or creates a new one)
--	- Places the data in it
--	- Formats the cell with SetTableCellType()
--	- Places the cell into the table offset from the previous one.


function GuildPanel:OnDisable()
	-- Called when the addon is disabled
end

function GuildPanel:Test()
	error(table_to_string(self.db.char.mains).."\n"..table_to_string(self.db.char.alts))
--	error(table_to_string(self.searchPredicates))
	--self:Print(#self.searchList)
	--self:Print(GuildControlGetRankFlags())
end

function GuildPanel:OnInviteButtonClick()
	StaticPopup_Show("ADD_GUILDMEMBER");
end

function GuildPanel:OnInfoButtonClick()
	if GuildPanelWindowPanelOverlay:IsShown() and self.importerState == 0 and self.downloaderState == 0 then
		GuildPanelWindowPanelOverlay:Hide()
	else
		GuildPanelInformationScrollBG:Show()
		GuildPanelWindowPanelOverlayInformationCloseButton:Show()
		GuildPanelWindowPanelOverlayInformationSaveButton:Show()
		GuildPanelWindowPanelOverlayInformationSaveButton:Show()
		
		if CanEditGuildInfo() == 1 then
			GuildPanelWindowPanelOverlayInformationSaveButton:Enable()
			GuildPanelWindowPanelOverlayInformationSaveButton:SetAlpha(1.0)
		else
			GuildPanelWindowPanelOverlayInformationSaveButton:Disable()
			GuildPanelWindowPanelOverlayInformationSaveButton:SetAlpha(0.5)
		end
		
		GuildPanelImporterButton:Hide()
		GuildPanelInformationScrollBar:Show()
		GuildPanelInformationScrollBarInfoBox:SetText(GetGuildInfoText())
		GuildPanelWindowPanelOverlay:Show()
		self:DrawScrollBarTex(GuildPanelInformationScrollBar)
		GuildPanelInformationScrollBarScrollBar:SetValue(0)
	end
end

function GuildPanel:SaveGuildInformation()
	local newInfo = GuildPanelInformationScrollBarInfoBox:GetText()
	if CanEditGuildInfo() == 1 then
		SetGuildInfoText(newInfo)
		self:Print("Saved Guild Info text!")
	else
		self:Print("Error: You do not have the ability to save Guild Info text. Contact your Guild Master or QQ more.")
	end
end

function GuildPanel:ToggleShowOffline()
	if GUILDPANEL_SHOWOFFLINE == true then
		GUILDPANEL_SHOWOFFLINE = false
		GuildPanelWindowToggleOfflineButtonText:SetText("Show Offline")
	else
		GUILDPANEL_SHOWOFFLINE = true
		GuildPanelWindowToggleOfflineButtonText:SetText("Hide Offline")
	end
	GuildPanel:DrawDataView()
end

function GuildPanel:OnUpdate(elapsed)

end


function GuildPanel:GUILD_MOTD(type, motd)
	self.db.char.motd = motd
	GuildPanelWindowMOTD:SetText(motd)
end
function GuildPanel:PLAYER_GUILD_UPDATE(update)
	if GuildPanelWindow:IsShown() then
		if IsInGuild() == nil then
			self:HideWindow()
			self:ShowWindow()
		end
	elseif GuildPanelBlurredWindow:IsShown() then
		if IsInGuild() == 1 then
			self:HideWindow()
			self:ShowWindow()
		end
	end
end
function GuildPanel:GUILD_ROSTER_UPDATE(update)
	if self.drawMode ~= "MANAGE" and GuildPanelWindow:IsShown() == 1 then
		self:CheckMains()
		GuildPanel:DrawDataView()
	end
	GuildControlPopupFrame_Initialize()
	if #self.guildUpdateFunctionQueue > 0 then
		local i = #self.guildUpdateFunctionQueue
		self.guildUpdateFunctionQueue[i]()
		table.remove(self.guildUpdateFunctionQueue, i)
	end
end

function GuildPanel:ShowPromptToSetRankName(frame)
	local func = function ()
		local rankSelectText = getglobal(frame:GetName().."RankSelectText")
		local rankName = GuildPanelWindowPromptEditBox:GetText()
		GuildControlSaveRank(rankName);
		rankSelectText:SetText(GuildControlGetRankName(self.manageSelectedRank))
		GuildPanelWindowPrompt:Hide()
	end
	GuildPanelWindowPromptTitle:SetText("Type a name for this Rank:")
	GuildPanelWindowPromptOkayButton:SetScript("OnClick", func)
	GuildPanelWindowPromptEditBox:SetScript("OnEnterPressed", func)
	GuildPanelWindowPrompt:Show()
	GuildPanelWindowPromptEditBox:SetFocus(true)
end

function GuildPanel:ShowPromptToSetMOTD()
	local func = function ()
		local motd = GuildPanelWindowPromptEditBox:GetText()
		motd = strsub(motd, 1, 128)
		GuildSetMOTD(motd)
		GuildPanelWindowPrompt:Hide()
	end
	GuildPanelWindowPromptTitle:SetText("Set Message of the Day:")
	GuildPanelWindowPromptEditBox:SetText("")
	GuildPanelWindowPromptOkayButton:SetScript("OnClick", func)
	GuildPanelWindowPromptEditBox:SetScript("OnEnterPressed", func)
	GuildPanelWindowPrompt:Show()
	GuildPanelWindowPromptEditBox:SetFocus(true)
end

function GuildPanel:ShowPromptToSetPublicNote()
	local func = function ()
		local note = GuildPanelWindowPromptEditBox:GetText()
		local name = self.selectedName
		local playerIdForName = function (name, count)
			for i=1,count do
				local pname, prank, prankIndex, plevel, pclass, pzone, pnote, pofficernote, ponline, pstatus = GetGuildRosterInfo(i);
				if pname == name then
					return i
				end
			end
			return 0
		end
		count = GetNumGuildMembers(GUILDPANEL_SHOWOFFLINE)
		GuildRosterSetPublicNote(playerIdForName(name, count), note);
		GuildPanel:DrawDataView()
		GuildPanelWindowPrompt:Hide()
	end
	GuildPanelWindowPromptTitle:SetText("Set Public Note for "..self.selectedName)
	GuildPanelWindowPromptOkayButton:SetScript("OnClick", func)
	GuildPanelWindowPromptEditBox:SetScript("OnEnterPressed", func)
	GuildPanelWindowPrompt:Show()
	GuildPanelWindowPromptEditBox:SetFocus(true)
end

function GuildPanel:ShowPromptToSetOfficerNote()
	local func = function ()
		local note = GuildPanelWindowPromptEditBox:GetText()
		local name = self.selectedName
		local playerIdForName = function (name, count)
			for i=1,count do
				local pname, prank, prankIndex, plevel, pclass, pzone, pnote, pofficernote, ponline, pstatus = GetGuildRosterInfo(i);
				if pname == name then
					return i
				end
			end
			return 0
		end
		count = GetNumGuildMembers(GUILDPANEL_SHOWOFFLINE)
		GuildRosterSetOfficerNote(playerIdForName(name, count), note);
		GuildPanel:DrawDataView()
		GuildPanelWindowPrompt:Hide()
	end
	GuildPanelWindowPromptTitle:SetText("Set Officer Note for "..self.selectedName)
	GuildPanelWindowPromptOkayButton:SetScript("OnClick", func)
	GuildPanelWindowPromptEditBox:SetScript("OnEnterPressed", func)
	GuildPanelWindowPrompt:Show()
	GuildPanelWindowPromptEditBox:SetFocus(true)
end

function GuildPanelGuildControlPopupAcceptButton_OnClick()
	local amount = GuildControlWithdrawGoldEditBox:GetText();
	if(amount and amount ~= "" and amount ~= UNLIMITED and tonumber(amount) and tonumber(amount) > 0) then
		SetGuildBankWithdrawLimit(amount);
	else
		SetGuildBankWithdrawLimit(0);
	end
	SavePendingGuildBankTabPermissions()
	GuildControlSaveRank(GuildControlPopupFrameEditBox:GetText());
	GuildStatus_Update();
	HideUIPanel(FriendsFrame);
	GuildControlPopupAcceptButton:Disable();
	UIDropDownMenu_SetText(GuildControlPopupFrameDropDown, GuildControlPopupFrameEditBox:GetText());
	GuildControlPopupFrame:Hide();
	ClearPendingGuildBankPermissions();
end
