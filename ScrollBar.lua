function GuildPanel:DrawScrollBarTex(frame)
	getglobal(frame:GetName() .. "ScrollBarThumbTexture"):SetTexture("Interface\\Addons\\Aloha\\Scroller\\thumb")
	getglobal(frame:GetName() .. "ScrollBarThumbTexture"):SetHeight(32)
	getglobal(frame:GetName() .. "ScrollBarThumbTexture"):SetBlendMode("BLEND")
	getglobal(frame:GetName() .. "ScrollBarThumbTexture"):SetTexCoord(0,0,0,1,1,0,1,1)
	--[[getglobal(frame:GetName() .. "ScrollBarScrollUpButton"):SetWidth(0)
	getglobal(frame:GetName() .. "ScrollBarScrollUpButton"):SetHeight(0)
	
	getglobal(frame:GetName() .. "ScrollBarScrollUpButton"):Hide()
	getglobal(frame:GetName() .. "ScrollBarScrollDownButton"):Hide()]]
end

function GuildPanel:UpdateScrollBar(frame)
	GuildPanel:DrawScrollBarTex(frame)
end

function GuildPanelScrollFrame_OnMouseWheel(self, value, scrollBar)
  scrollBar = scrollBar or getglobal(self:GetName() .. "ScrollBar");
  if ( value > 0 ) then
    scrollBar:SetValue(scrollBar:GetValue() - (scrollBar:GetHeight() / 6));
  else
    scrollBar:SetValue(scrollBar:GetValue() + (scrollBar:GetHeight() / 6));
  end
end

function GuildPanelDataViewScrollBar_OnVerticalScroll(frame)
	GuildPanel:CloseAllPopupMenus()
	GuildPanel:UpdateScrollBar(frame)
end
function GuildPanelInformationScrollBar_OnVerticalScroll()
	GuildPanel:UpdateScrollBar(GuildPanelInformationScrollBar)
end
function GuildPanelInformationScrollBar_OnScrollRangeChanged(frame, scrollrange, scrollbg)
	local scrollbar = getglobal(frame:GetName().."ScrollBar");
	if ( not scrollrange ) then
		scrollrange = frame:GetVerticalScrollRange();
	end
	local value = scrollbar:GetValue();
	if ( value > scrollrange ) then
		value = scrollrange;
	end
	scrollbar:SetMinMaxValues(0, scrollrange);
	scrollbar:SetValue(value);
	if ( floor(scrollrange) == 0 ) then
		scrollbg:Hide();
		if (this.scrollBarHideable ) then
			getglobal(this:GetName().."ScrollBar"):Hide();
			getglobal(scrollbar:GetName().."ScrollDownButton"):Hide();
			getglobal(scrollbar:GetName().."ScrollUpButton"):Hide();
		end
		getglobal(scrollbar:GetName().."ThumbTexture"):Hide();
	else
		scrollbg:Show();
		getglobal(frame:GetName().."ScrollBar"):Show();
		getglobal(scrollbar:GetName().."ThumbTexture"):Show();
	end
	
	-- Hide/show scrollframe borders
	local top = getglobal(frame:GetName().."Top");
	local bottom = getglobal(frame:GetName().."Bottom");
	local middle = getglobal(frame:GetName().."Middle");
	if ( top and bottom and frame.scrollBarHideable) then
		if ( this:GetVerticalScrollRange() == 0 ) then
			top:Hide();
			bottom:Hide();
		else
			top:Show();
			bottom:Show();
		end
	end
	if ( middle and this.scrollBarHideable) then
		if ( frame:GetVerticalScrollRange() == 0 ) then
			middle:Hide();
		else
			middle:Show();
		end
	end
end
