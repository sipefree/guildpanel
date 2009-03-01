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

-- TODO: Weird characters in names cause problems

function GuildPanel:CheckMains()
	local showOffline = GUILDPANEL_SHOWOFFLINE
	local filter = self.dataFilter
	GUILDPANEL_SHOWOFFLINE = true
	self.dataFilter = ""
	GuildPanel:UpdateList("STD")
	for main,alts in pairs(self.db.char.mains) do
		local found = false
		for i,v in ipairs(self.stdList) do
			if v.name == main then
				found = true
			end
		end
		if found == false then
			-- Member has been kicked or gquit.
			-- Best solution is pick first Alt then do SwapWithMain
			local firstAlt = alts[1]
			self:SwapWithMain(firstAlt)
		end

	end
	GUILDPANEL_SHOWOFFLINE = showOffline
	self.dataFilter = filter
end
function GuildPanel:RemoveAlt(name, main)
	for i,v in ipairs(self.db.char.alts) do
		if v.alt == name then
			
			table.remove(self.db.char.alts, i)
		end
	end
	for i,v in ipairs(self.db.char.mains[main]) do
		if v == name then
			table.remove(self.db.char.mains[main], i)
		end
	end
	if #self.db.char.mains[main] == 0 then
		self.db.char.mains[main] = nil
	end
	self.db.char.dbTimestamp = self:GetTimestamp()
end

function GuildPanel:AddAlt(name, amain)
	amain = amain:gsub("(%a)([%w_']*)", function (first, rest) return first:upper()..rest:lower() end)
	if name == amain then
		return
	end
	if self.db.char.mains[amain] == nil then
		self.db.char.mains[amain] = {}
	end
	table.insert(self.db.char.mains[amain], name)
	table.insert(self.db.char.alts, {alt=name, main=amain})
	self.db.char.dbTimestamp = self:GetTimestamp()
end

function GuildPanel:GetMain(name)
	name = name:gsub("(%a)([%w_']*)", function (first, rest) return first:upper()..rest:lower() end)
	for idx,alt in ipairs(self.db.char.alts) do
		if alt.alt == name then
			return alt.main
		end
	end
	return nil
end
function GuildPanel:SwapWithMain(name)
	local main = self:GetMain(name)
	if main == nil then
		return
	end
	-- first, remove our entry in the alts list
	for i,v in ipairs(self.db.char.alts) do
		if v.alt == name then
			table.remove(self.db.char.alts, i)
		end
	end
	
	-- remove our entry in the main's alt table
	for i,v in ipairs(self.db.char.mains[main]) do
		if v == name then
			table.remove(self.db.char.mains[main], i)
		end
	end
	
	-- add entry in mains table by copying old one
	self.db.char.mains[name] = self.db.char.mains[main]
	
	-- delete old entry
	self.db.char.mains[main] = nil
	
	-- add entry for old main
	table.insert(self.db.char.mains[name], main)
	table.insert(self.db.char.alts, {alt=main, main=name})
	
	-- switch all entries in alts table for old main
	for i,v in ipairs(self.db.char.alts) do
		if v.main == main then
			self.db.char.alts[i].main = name
		end
	end
	self:DrawDataView()
	self.db.char.dbTimestamp = self:GetTimestamp()
end
function GuildPanel:RemoveAllAlts(name)
	alts = self.db.char.mains[name]
	if alts == nil then
		return
	end
	
	-- remove each from the alts table
	for i,v in ipairs(alts) do
		for i2,v2 in ipairs(self.db.char.alts) do
			if v == v2.alt then
				table.remove(self.db.char.alts, i2)
			end
		end
	end
	
	-- remove from mains table
	self.db.char.mains[name] = nil
	self.db.char.dbTimestamp = self:GetTimestamp()
end
function GuildPanel:ShowPromptToSetAlt(name)
	if self.db.char.mains[name] ~= nil then
		return
	end
	local func = function ()
		local main = GuildPanelWindowPromptEditBox:GetText()
		local showOffline = GUILDPANEL_SHOWOFFLINE
		local filter = self.dataFilter
		GUILDPANEL_SHOWOFFLINE = true
		self.dataFilter = ""
		GuildPanel:UpdateList("STD")
		local found = false
		for i,v in ipairs(GuildPanel.stdList) do
			if v.name == main then
				found = true
			end
		end
		if found == false then
			GuildPanel:Print(main.." is not a member of your guild!")
		else
			if GuildPanel:GetMain(main) ~= nil then
				GuildPanel:Print(main.." is already an alt of "..GuildPanel:GetMain(main).."!")
			else
				GuildPanel:AddAlt(name, main)
			end
		end
		GUILDPANEL_SHOWOFFLINE = showOffline
		self.dataFilter = filter
		GuildPanel:DrawDataView()
		GuildPanelWindowPrompt:Hide()
	end
	GuildPanelWindowPromptTitle:SetText("Type a Character Name")
	GuildPanelWindowPromptOkayButton:SetScript("OnClick", func)
	GuildPanelWindowPromptEditBox:SetScript("OnEnterPressed", func)
	GuildPanelWindowPrompt:Show()
	GuildPanelWindowPromptEditBox:SetFocus(true)
end

function GuildPanel:GetAltOptionsMenu(name)
	local main = GuildPanel:GetMain(name)
	if main ~= nil then
		ppmItems = {
			{
				name = "(Alt of "..main..")",
				func = nil,
				disabled = true
			},
			{
				name = "Swap with "..main,
				func = function ()
					GuildPanel:SwapWithMain(name)
					GuildPanel:ClosePopupMenu("AltOptionsMenu")
				end
			},
			{
				name = "Remove Alt",
				func = function ()
					self:RemoveAlt(name, main)
					GuildPanel:ClosePopupMenu("AltOptionsMenu")
					self:DrawDataView()
				end
			},
			{
				name = "-Cancel-",
				func = function () 
					GuildPanel:ClosePopupMenu("AltOptionsMenu")
				end
			},
		}
	else
		local alts = self.db.char.mains[name]
		if alts == nil then
			ppmItems = {
				{
					name = "(Has no Alts)",
					func = nil,
					disabled = true
				},
				{
					name = "Set Main...",
					func = function ()
						GuildPanel:ShowPromptToSetAlt(name)
						GuildPanel:ClosePopupMenu("AltOptionsMenu")
					end
				},
				{
					name = "-Cancel-",
					func = function () 
						GuildPanel:ClosePopupMenu("AltOptionsMenu")
					end
				},
			}
		else
			ppmItems = {
				{
					name = "(Has "..#alts.." Alts)",
					func = nil,
					disabled = true
				},
				--[[{
					name = "Set Main (Including Alts)",
					func = function ()
						GuildPanel:ClosePopupMenu("AltOptionsMenu")
					end
				},]]
				{
					name = "Remove All Alts",
					func = function ()
						GuildPanel:RemoveAllAlts(name)
						GuildPanel:DrawDataView()
						GuildPanel:ClosePopupMenu("AltOptionsMenu")
					end
				},
				{
					name = "-Cancel-",
					func = function () 
						GuildPanel:ClosePopupMenu("AltOptionsMenu")
					end
				},
			}
		end
	end
	return ppmItems
end
