queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

local TeleportService = game:GetService("TeleportService")

TeleportService:Teleport(131821755744402, game.Players.LocalPlayer, TeleportService:GetLocalPlayerTeleportData())

queueteleport()

