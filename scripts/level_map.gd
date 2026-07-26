extends Node2D

signal minigame_start(id)

func update_interactables(id):
	print("update interactables: ", id)
	if id == 'init':
		$Janitor.process_mode = Node.PROCESS_MODE_INHERIT
		$MailGuy.process_mode = Node.PROCESS_MODE_DISABLED
		$Mechanic.process_mode = Node.PROCESS_MODE_DISABLED
		$Oven.process_mode = Node.PROCESS_MODE_DISABLED
		$ITGuy.process_mode = Node.PROCESS_MODE_DISABLED
		$ServerRoom.process_mode = Node.PROCESS_MODE_DISABLED
		$CEO.process_mode = Node.PROCESS_MODE_DISABLED
		$ShipDoor.process_mode = Node.PROCESS_MODE_DISABLED
	if id == "Storage":
		$Janitor.process_mode = Node.PROCESS_MODE_DISABLED
		$Mechanic.process_mode = Node.PROCESS_MODE_INHERIT
	if id == "mechanic_conversation":
		print("update interactables: mechanic conversation")
		$Mechanic.process_mode = Node.PROCESS_MODE_DISABLED
		$Oven.process_mode = Node.PROCESS_MODE_INHERIT
	if id == "Cooking":
		$Oven.process_mode = Node.PROCESS_MODE_DISABLED
		$Mechanic.process_mode = Node.PROCESS_MODE_INHERIT
	if id == "mechanic_conversation2":
		$Mechanic.process_mode = Node.PROCESS_MODE_DISABLED
		$ITGuy.process_mode = Node.PROCESS_MODE_INHERIT
	if id == "Computer":
		$ITGuy.process_mode = Node.PROCESS_MODE_DISABLED
		$ServerRoom.process_mode = Node.PROCESS_MODE_INHERIT
	if id == "ServerRoom":
		$ServerRoom.process_mode = Node.PROCESS_MODE_DISABLED
		$CEO.process_mode = Node.PROCESS_MODE_INHERIT
	if id == "ceo_conversation":
		$CEO.process_mode = Node.PROCESS_MODE_DISABLED
		$MailGuy.process_mode = Node.PROCESS_MODE_INHERIT
	if id == "MailRoom":
		$MailGuy.process_mode = Node.PROCESS_MODE_DISABLED
		$CEO.process_mode = Node.PROCESS_MODE_INHERIT
	if id == "ceo_conversation2":
		$CEO.process_mode = Node.PROCESS_MODE_INHERIT
		$ShipDoor.process_mode = Node.PROCESS_MODE_INHERIT
	
func send_minigame_start(id):
	print("minigame start emitted")
	minigame_start.emit(id)
