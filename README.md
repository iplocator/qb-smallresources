# qb-smallresources - Useable Car Parts (Items)

Base script for QB-Core Framework :building_construction: Copyright (C) 2021 Joshua Eger

This script adds useable car parts (items) to your server.

No copyright intended.

# License

    QBCore Framework
    Copyright (C) 2021 Joshua Eger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>


## Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core)

## Features
- Consumeable foods/beverages/drinks/drugs (sandwich, water_bottle, tosti, beer, vodka etc.)
- Removal of GTA's default weapons drops
- Drug effects
- Removal of GTA's default vehicle spawns (planes, helicopters, emergency vehicles etc.)
- Removal of GTA's default emergency service npcs
- Removal of GTA's default wanted system
- Useable binoculars
- Weapon draw animations (normal/holster)
- Ability to add teleport markers (from a place to another place)
- Taking hostage
- Pointing animation with finger (by pressing "B")
- Seatbelt and cruise control
- Useable parachute
- Useable armor
- Weapon recoil (specific to each weapon)
- Tackle
- Calm AI (adjusting npc/gang npc aggresiveness)
- Race Harness
- /id to see the id
- Adjusting npc/vehicle/parked vehicle spawn rates
- Infinite ammo for fire extinguisher and petrol can
- Removal of GTA's default huds (weapon wheel, cash etc.)
- Fireworks
- Automatically engine on after entering vehicle
- Discord rich presence
- Crouch and prone
- Useable Car Parts (Items)


## Installation
### Manual

### Step 1
- Edit qb-core/shared.lua
- add:
```
	["turbo"] 		                 = {["name"] = "turbo", 			            ["label"] = "Turbo Kit", 	            ["weight"] = 100, 		["type"] = "item", 		["image"] = "turbo.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Turbo"},
	["engine1"] 		             = {["name"] = "engine1", 			            ["label"] = "Level 1 Engine Kit", 		["weight"] = 100, 		["type"] = "item", 		["image"] = "engine1.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 1 Engine Upgrade"},
	["engine2"] 		             = {["name"] = "engine2", 			            ["label"] = "Level 2 Engine Kit", 	    ["weight"] = 100, 		["type"] = "item", 		["image"] = "engine2.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 2 Engine Upgrade"},
	["engine3"] 		             = {["name"] = "engine3", 			            ["label"] = "Level 3 Engine Kit", 		["weight"] = 100, 		["type"] = "item", 		["image"] = "engine3.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 3 Engine Upgrade"},
	["engine4"] 		             = {["name"] = "engine4", 			            ["label"] = "Level 4 Engine Kit", 	    ["weight"] = 100, 		["type"] = "item", 		["image"] = "engine4.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 4 Engine Upgrade"},
	["engine5"] 		             = {["name"] = "engine5", 			            ["label"] = "Level 5 Engine Kit", 		["weight"] = 100, 		["type"] = "item", 		["image"] = "engine5.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 5 Engine Upgrade"},
	["brake1"] 		             	 = {["name"] = "brake1", 			            ["label"] = "Level 1 Brake Kit", 		["weight"] = 100, 		["type"] = "item", 		["image"] = "brake1.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 1 Brake Upgrade"},
	["brake2"] 		             	 = {["name"] = "brake2", 			            ["label"] = "Level 2 Brake Kit", 	    ["weight"] = 100, 		["type"] = "item", 		["image"] = "brake2.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 2 Brake Upgrade"},
	["brake3"] 		             	 = {["name"] = "brake3", 			            ["label"] = "Level 3 Brake Kit", 		["weight"] = 100, 		["type"] = "item", 		["image"] = "brake3.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 3 Brake Upgrade"},
	["brake4"] 		             	 = {["name"] = "brake4", 			            ["label"] = "Level 4 Brake Kit", 	    ["weight"] = 100, 		["type"] = "item", 		["image"] = "brake4.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 4 Brake Upgrade"},
	["trans1"] 		             	 = {["name"] = "trans1", 			            ["label"] = "Level 1 Transmission Kit", ["weight"] = 100, 		["type"] = "item", 		["image"] = "trans1.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 1 Transmission Upgrade"},
	["trans2"] 		             	 = {["name"] = "trans2", 			            ["label"] = "Level 2 Transmission Kit", ["weight"] = 100, 		["type"] = "item", 		["image"] = "trans2.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 2 Transmission Upgrade"},
	["trans3"] 		             	 = {["name"] = "trans3", 			            ["label"] = "Level 3 Transmission Kit", ["weight"] = 100, 		["type"] = "item", 		["image"] = "trans3.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 3 Transmission Upgrade"},
	["trans4"] 		             	 = {["name"] = "trans4", 			            ["label"] = "Level 4 Transmission Kit", ["weight"] = 100, 		["type"] = "item", 		["image"] = "trans4.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 4 Transmission Upgrade"},
	["susp1"] 		             	 = {["name"] = "susp1", 			            ["label"] = "Level 1 Suspension Kit", 	["weight"] = 100, 		["type"] = "item", 		["image"] = "susp1.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 1 Suspension Upgrade"},
	["susp2"] 		             	 = {["name"] = "susp2", 			            ["label"] = "Level 2 Suspension Kit", 	["weight"] = 100, 		["type"] = "item", 		["image"] = "susp2.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 2 Suspension Upgrade"},
	["susp3"] 		             	 = {["name"] = "susp3", 			            ["label"] = "Level 3 Suspension Kit", 	["weight"] = 100, 		["type"] = "item", 		["image"] = "susp3.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 3 Suspension Upgrade"},
	["susp4"] 		             	 = {["name"] = "susp4", 			            ["label"] = "Level 4 Suspension Kit", 	["weight"] = 100, 		["type"] = "item", 		["image"] = "susp4.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 4 Suspension Upgrade"},
	["susp5"] 		             	 = {["name"] = "susp5", 			            ["label"] = "Level 5 Suspension Kit", 	["weight"] = 100, 		["type"] = "item", 		["image"] = "susp5.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 5 Suspension Upgrade"},
	["arm1"] 		             	 = {["name"] = "arm1", 			           		["label"] = "Level 1 Armour Kit", 		["weight"] = 100, 		["type"] = "item", 		["image"] = "arm1.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 1 Armour Upgrade"},
	["arm2"] 		             	 = {["name"] = "arm2", 			           		["label"] = "Level 2 Armour Kit", 	    ["weight"] = 100, 		["type"] = "item", 		["image"] = "arm2.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 2 Armour Upgrade"},
	["arm3"] 		             	 = {["name"] = "arm3", 			           		["label"] = "Level 3 Armour Kit", 		["weight"] = 100, 		["type"] = "item", 		["image"] = "arm3.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 3 Armour Upgrade"},
	["arm4"] 		             	 = {["name"] = "arm4", 			           		["label"] = "Level 4 Armour Kit", 	    ["weight"] = 100, 		["type"] = "item", 		["image"] = "arm4.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 4 Armour Upgrade"},
	["arm5"] 		             	 = {["name"] = "arm5", 			           		["label"] = "Level 5 Armour Kit", 		["weight"] = 100, 		["type"] = "item", 		["image"] = "arm5.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 5 Armour Upgrade"},
	["arm6"] 		             	 = {["name"] = "arm6", 			           		["label"] = "Level 6 Armour Kit", 		["weight"] = 100, 		["type"] = "item", 		["image"] = "arm6.png", 	        	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Level 6 Armour Upgrade"},
```	
### Step 2

- Download the script and put the images folder into: qb-inventory/html/images/

### Step 3

- Move qb-smallresources to `[qb]` directory.
- Add the following code to your server.cfg/resouces.cfg

```
ensure qb-smallresources
```

- Restart Server





```
Each feature has a different file name correlative with its function. You can configure each one by its own.
```
