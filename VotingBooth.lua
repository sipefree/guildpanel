function GuildPanel:DrawVotingBoothView()
	if (not self.votingView) then
		self.votingView = CreateFrame("Frame", "GuildPanelVotingBoothView", GuildPanelWindowContentRect, "GuildPanelVotingBoothViewParent")
	end
	self.votingView:ClearAllPoints();
	self.votingView:SetPoint("TOPLEFT", GuildPanelWindowContentRect, "TOPLEFT", 0, 0)
	
	GuildPanelVotingBoothViewLowerFrame:SetPoint("BOTTOMLEFT", self.votingView, "BOTTOMLEFT", 0.0, 0.0)
	
	--GuildPanelManageViewScrollBar:SetBackdropColor(0.7,0.7,0.7,1.0)
	local tab = getglobal(self.votingView:GetName() .. "ScrollBarTable")
	
	tab:SetHeight(100)
	
	local drawOffset = 0
	for i,item in ipairs(self.db.char.polls) do
		--[[
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
		end]]
		
	end
	
	GuildPanelVotingBoothView:Show()
end
