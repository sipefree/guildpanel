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

function GuildPanel:StartDownloader()
	if (self.importerState ~= 0) or (self.downloaderState ~=0) then return end
	GuildPanelInformationScrollBG:Hide()
	GuildPanelWindowPanelOverlayInformationCloseButton:Hide()
	GuildPanelWindowPanelOverlayInformationSaveButton:Hide()
	GuildPanelInformationScrollBar:Hide()
	GuildPanelImporterButton:Show()
	self.downloaderState = 1
	GuildPanelWindowPanelOverlay:Show()
	GuildPanelImporterButton:SetScript("OnClick", function() self:Downloader() end)
	GuildPanel:Downloader()
end

function GuildPanel:Downloader()
	
	if self.downloaderState == 0 then
		return
	elseif self.downloaderState == 1 then
		GuildPanelWindowPanelOverlayTitle:SetText("Download")
		GuildPanelImporterStatusbar:Show()
		GuildPanelImporterStatusbar:SetValue(0.2)
		GuildPanelImporterStateText:SetText("Step 1: Look for Peers")
		GuildPanelImporterDetailsText:SetText("This Wizard will step you through asking |cFFFFFF33Peers|r for\ntheir main-alt associations database.\n\nIf no one with GuildPanel is online, the system will\nalert you when they come online.")
		GuildPanelImporterButtonText:SetText("Connect")
		self.downloaderState = 2
	elseif self.downloaderState == 2 then
		self:SendCommMessage("GuildPanel-LIST", "nil", "GUILD")
		GuildPanelImporterStateText:SetText("Step 2: Talk to Peers")
		GuildPanelImporterDetailsText:SetText("Requesting...")
		GuildPanelImporterButtonText:SetText("Disabled")
		GuildPanelImporterButton:Disable()
		GuildPanelImporterButton:SetAlpha(0.5)
		
		local totalElapsed = 0.0;
		local function getList(self, elapsed)
			totalElapsed = totalElapsed + elapsed;
			GuildPanelImporterStatusbar:SetValue(0.2 + (0.6*(totalElapsed/3)))
			if (totalElapsed < 3) then
				return
			end
			totalElapsed = totalElapsed - floor(totalElapsed);
			GuildPanel.downloaderState = 3
			GuildPanel:Downloader()
		end
		GuildPanelWindowPanelOverlay:SetScript("OnUpdate", getList)
	elseif self.downloaderState == 3 then
		GuildPanelWindowPanelOverlay:SetScript("OnUpdate", function() end)
		GuildPanelImporterStateText:SetText("Step 3: Results")
		GuildPanelImporterStatusbar:SetValue(0.8)
		local text = "Choose a Download Client:"
		
		local buttons = {}
		for i=1,8 do
			if getglobal("GuildPanelDownloaderButton"..i) ~= nil then
				getglobal("GuildPanelDownloaderButton"..i):Hide()
			end
		end
		
		if #self.downloaderData.peers == 0 then
			GuildPanelImporterDetailsText:SetText("No download clients were available.\nTry again later.")
			GuildPanelImporterButtonText:SetText("Close")
			GuildPanelImporterButton:Enable()
			GuildPanelImporterButton:SetAlpha(1.0)
			self.downloaderState = 7;
		else
			for i,item in ipairs(self.downloaderData.peers) do
				if i <= 8 then
					if getglobal("GuildPanelDownloaderButton"..i) == nil then
						buttons[i] = CreateFrame("Button", "GuildPanelDownloaderButton"..i, GuildPanelWindowPanelOverlay, "GuildPanelLongButton")
					else
						buttons[i] = getglobal("GuildPanelDownloaderButton"..i)
					end
					getglobal(buttons[i]:GetName().."Text"):SetText(item[1]..":"..item[2])
					buttons[i]:SetPoint("TOPLEFT", GuildPanelWindowPanelOverlay, 128, -54-(i*16))
					buttons[i]:SetScript("OnClick", function() self.downloaderData.selectedPeer = item[1]; GuildPanel:Downloader(); end)
				end
			end
			GuildPanelImporterDetailsText:SetText(text)
			GuildPanelImporterButtonText:SetText("Choose")
			GuildPanelImporterButton:Disable()
			GuildPanelImporterButton:SetAlpha(0.5)

			self.downloaderState = 4
		end
	elseif self.downloaderState == 4 then
		for i=1,8 do
			if getglobal("GuildPanelDownloaderButton"..i) ~= nil then
				getglobal("GuildPanelDownloaderButton"..i):Hide()
			end
		end
		GuildPanelImporterStateText:SetText("Step 4: Downloading")
		GuildPanelImporterDetailsText:SetText("Downloading from "..self.downloaderData.selectedPeer.."...")
		GuildPanelImporterButtonText:SetText("Disabled")
		GuildPanelImporterButton:Disable()
		GuildPanelImporterButton:SetAlpha(0.0)
		self:SendCommMessage("GuildPanel-DOWNLOAD", "nil", "WHISPER", self.downloaderData.selectedPeer)

		self.downloaderState = 5
	elseif self.downloaderState == 5 then
		GuildPanelImporterStateText:SetText("Step 5: Finish!")
		GuildPanelImporterDetailsText:SetText("Complete!\n\nThe database was completely downloaded from "..self.downloaderData.selectedPeer.."!\n\nHit Save to finish.")
		GuildPanelImporterStatusbar:SetValue(1.0)
		GuildPanelImporterButtonText:SetText("Save")
		GuildPanelImporterButton:Enable()
		GuildPanelImporterButton:SetAlpha(1.0)
		
		self.downloaderState = 6
	elseif self.downloaderState == 6 then
		self.db.char.alts = self.downloaderData.alts
		self.db.char.mains = self.downloaderData.mains
		self.db.char.dbTimestamp = self.downloaderData.dbTimestamp
		
		GuildPanelWindowPanelOverlay:Hide()
		GUILDPANEL_SHOWOFFLINE = false
		GuildPanelWindowToggleOfflineButtonText:SetText("Show Offline")
		GuildPanel:DrawDataView()
		self.downloaderState = 0
		self.downloaderData = { peers = {} }
	elseif self.downloaderState == 7 then
		GuildPanelWindowPanelOverlay:Hide()
		GUILDPANEL_SHOWOFFLINE = false
		GuildPanelWindowToggleOfflineButtonText:SetText("Show Offline")
		GuildPanel:DrawDataView()
		self.downloaderState = 0
		self.downloaderData = { peers = {} }
	end
end

function GuildPanel:OnCommReceived(prefix, message, distribution, sender)
	if sender == UnitName("player") then return end
	if distribution == "GUILD" then
		if prefix == "GuildPanel-LIST" then
			if self.db.char.dbTimestamp ~= 0 then
				self:SendCommMessage("GuildPanel-INFO", tostring(self.db.char.dbTimestamp), "GUILD")
			end
		elseif (prefix == "GuildPanel-INFO") and (self.downloaderState == 2) then
			table.insert(self.downloaderData.peers, {sender, tonumber(message)})
		end
	elseif distribution == "WHISPER" then
		if prefix == "GuildPanel-DOWNLOAD" then
			packet = {alts = self.db.char.alts, mains = self.db.char.mains, ts = self.db.char.dbTimestamp}
			serial = self:Serialize(packet)
			self:SendCommMessage("GuildPanel-UPLOAD", serial, "WHISPER", sender)
		elseif (prefix == "GuildPanel-UPLOAD") and self.downloaderState == 5 then
			success, packet = self:Deserialize(message)
			if success == true then
				self.downloaderData.alts = packet.alts
				self.downloaderData.mains = packet.mains
				self.downloaderData.dbTimestamp = packet.ts
				self:Downloader()
			end
		end
	end
end