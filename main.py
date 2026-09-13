import time
import psutil
from dataManager import dataManager
from discordManager import discordManager


dataManager = dataManager()
discordManager = discordManager()


def is_game_running():
    return any(
        p.name().lower() == "isaac-ng.exe"
        for p in psutil.process_iter(["name"])
    )


was_running = False

while True:
    running = is_game_running()

    if running:
        if not was_running:
            print("Gra została uruchomiona")
            was_running = True

        game_data = dataManager.getGameData()

        if game_data != discordManager.game_data:
            print("Powiadamiam discord")
            discordManager.updatePresence(game_data)

    else:
        if was_running:
            print("Gra została zamknięta")
            discordManager.updatePresence(None)
            was_running = False

    time.sleep(2)
