--[[
Title: ItemNplMicroRobotBlock
Author(s): leio
Date: 2019/12/27
Desc: 
use the lib:
------------------------------------------------------------
NPL.load("(gl)Mod/NplMicroRobot/ItemNplMicroRobotBlock.lua");
local ItemNplMicroRobotBlock = commonlib.gettable("MyCompany.Aries.Game.Items.ItemNplMicroRobotBlock");
-------------------------------------------------------
]]
NPL.load("(gl)script/apps/Aries/Creator/Game/Common/Files.lua");
local Files = commonlib.gettable("MyCompany.Aries.Game.Common.Files");
local EntityManager = commonlib.gettable("MyCompany.Aries.Game.EntityManager");
local BlockEngine = commonlib.gettable("MyCompany.Aries.Game.BlockEngine")
local block_types = commonlib.gettable("MyCompany.Aries.Game.block_types")
local GameLogic = commonlib.gettable("MyCompany.Aries.Game.GameLogic")
local ItemStack = commonlib.gettable("MyCompany.Aries.Game.Items.ItemStack");

local ItemNplMicroRobotBlock = commonlib.inherit(commonlib.gettable("MyCompany.Aries.Game.Items.Item"), commonlib.gettable("MyCompany.Aries.Game.Items.ItemNplMicroRobotBlock"));


local langConfigFile = "npl_micro_robot"
local codeLanguageType = "npl"
-- add purple color to the code block using 8bit color data
local color8_data = 0xe000; 
block_types.RegisterItemClass("ItemNplMicroRobotBlock", ItemNplMicroRobotBlock);

function ItemNplMicroRobotBlock:ctor()
end

function ItemNplMicroRobotBlock:TryCreate(itemStack, entityPlayer, x,y,z, side, data, side_region)
	if (itemStack and itemStack.count == 0) then
		return;
	elseif (entityPlayer and not entityPlayer:CanPlayerEdit(x,y,z, data, itemStack)) then
		return;
	elseif (self:CanPlaceOnSide(x,y,z,side, data, side_region, entityPlayer, itemStack)) then
		NPL.load("(gl)script/apps/Aries/Creator/Game/Items/ItemClient.lua");
		local ItemClient = commonlib.gettable("MyCompany.Aries.Game.Items.ItemClient");
		local names = commonlib.gettable("MyCompany.Aries.Game.block_types.names");
		local item = ItemClient.GetItem(names.CodeBlock);
		if(item) then
			NPL.load("(gl)script/apps/Aries/Creator/Game/Items/ItemStack.lua");
			local ItemStack = commonlib.gettable("MyCompany.Aries.Game.Items.ItemStack");
			local item_stack = ItemStack:new():Init(names.CodeBlock, 1);
			item_stack:SetDataField("langConfigFile", langConfigFile);
			item_stack:SetDataField("codeLanguageType", codeLanguageType);

			
			return item:TryCreate(item_stack, entityPlayer, x,y,z, side, (data or 0)+color8_data, side_region);
		end
	end
end
