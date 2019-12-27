--[[
Title: 
Author(s): leio
Date: 2019/12/27
Desc: 
use the lib:
------------------------------------------------------------
NPL.load("(gl)Mod/NplMicroRobot/main.lua");
------------------------------------------------------------
]]
local CmdParser = commonlib.gettable("MyCompany.Aries.Game.CmdParser");	

local NplMicroRobot = commonlib.inherit(commonlib.gettable("Mod.ModBase"),commonlib.gettable("Mod.NplMicroRobot"));

local block_id = 10517;
function NplMicroRobot:ctor()
end

-- virtual function get mod name
function NplMicroRobot:GetName()
	return "NplMicroRobot"
end

-- virtual function get mod description 
function NplMicroRobot:GetDesc()
	return "NplMicroRobot is a plugin in paracraft"
end

function NplMicroRobot:init()
	LOG.std(nil, "info", "NplMicroRobot", "plugin initialized");

	-- register a new block item, id < 10512 is internal items, which is not recommended to modify. 
	GameLogic.GetFilters():add_filter("block_types", function(xmlRoot) 
		local blocks = commonlib.XPath.selectNode(xmlRoot, "/blocks/");
		if(blocks) then
			NPL.load("(gl)Mod/NplMicroRobot/ItemNplMicroRobotBlock.lua");
			blocks[#blocks+1] = {name="block", attr={ name="NplMicroRobotBlock",
				id = block_id, item_class="ItemNplMicroRobotBlock", text=L"npl robot 代码模型",
				icon = "Mod/NplMicroRobot/textures/icon.png",
			}}
			LOG.std(nil, "info", "NplMicroRobot", "npl robot  is registered");

		end
		return xmlRoot;
	end)

	-- add block to category list to be displayed in builder window (E key)
	GameLogic.GetFilters():add_filter("block_list", function(xmlRoot) 
		for node in commonlib.XPath.eachNode(xmlRoot, "/blocklist/category") do
			if(node.attr.name == "tool" or node.attr.name == "character") then
				node[#node+1] = {name="block", attr={name="NplMicroRobotBlock"} };
			end
		end
		return xmlRoot;
	end)
end

function NplMicroRobot:OnLogin()
end
-- called when a new world is loaded. 

function NplMicroRobot:OnWorldLoad()
end
-- called when a world is unloaded. 

function NplMicroRobot:OnLeaveWorld()
end

function NplMicroRobot:OnDestroy()
end


