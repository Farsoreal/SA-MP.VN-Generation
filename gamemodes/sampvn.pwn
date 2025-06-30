/*

                                    /$$$$$$$   /$$$$$$   /$$$$$$  /$$      /$$ /$$$$$$$$
                                    | $$__  $$ /$$__  $$ /$$__  $$| $$$    /$$$| $$_____/
                                    | $$  \ $$| $$  \__/| $$  \ $$| $$$$  /$$$$| $$      
                                    | $$$$$$$/| $$ /$$$$| $$$$$$$$| $$ $$/$$ $$| $$$$$   
                                    | $$__  $$| $$|_  $$| $$__  $$| $$  $$$| $$| $$__/   
                                    | $$  \ $$| $$  \ $$| $$  | $$| $$\  $ | $$| $$      
                                    | $$  | $$|  $$$$$$/| $$  | $$| $$ \/  | $$| $$$$$$$$
                                    |__/  |__/ \______/ |__/  |__/|__/     |__/|________/

                                    (Revolution Gaming Network Multiplayer copyright holder)
                                    --------------------------------------------------------

                                * Organization:
                                    * CEO / Founder:
                                                                - Rain

    * RGAME.MP is a project established in 2025 based on the solid foundation of San Andreas Multiplayer.
    * The RGAME.MP version is unique, and the copyright holder is RGAME-Group.
    * Everything, from the script to the development ideas, is carried out by the copyright holder.
    * No one is allowed to access the source code or database unless authorized by the copyright holder.

    ----------------------------------------------------- [SAMPVN.PWN] -----------------------------------------------------

*/

// main include
#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS (500)

// extensions
#include <a_mysql>
#include <a_players>
#include <a_actor>
#include <a_zones>
#include <crashdetect>
#include <streamer>
#include <sscanf2>
#include <zcmd>

#include <YSI_Coding\y_hooks>
#include <YSI_Data\y_foreach>
#include <YSI_Coding\y_timers>

// scriptings
#include "./GMs/defines.pwn"
#include "./GMs/enums.pwn"
#include "./GMs/variables.pwn"
#include "./GMs/function.pwn"
#include "./GMs/mysql.pwn"
#include "./GMs/ondialogresponse.pwn"
#include "./GMs/onplayerload.pwn"
#include "./GMS/callbacks.pwn"
#include "./GMs/textdraw.pwn"

#include "./GMS/Jobs/warehouse.pwn"
#include "./GMs/Jobs/shipment.pwn"
#include "./GMs/Jobs/jobcore.pwn"

#include "./GMs/Core/Initategamemode.pwn"
#include "./GMs/Core/protectarea.pwn"
#include "./GMs/Core/tutorial.pwn"
#include "./GMS/Core/login.pwn"
#include "./GMs/Core/accountsetting.pwn"
#include "./GMs/Core/gps.pwn"

#include "./GMs/Streamer/actor.pwn"
#include "./GMs/Streamer/labels.pwn"
#include "./GMs/Streamer/objects.pwn"
#include "./GMs/Streamer/vehicle.pwn"
#include "./GMs/Streamer/removebuilds.pwn"

#include "./GMs/GM/admin.pwn"
#include "./GMs/GM/member.pwn"

#include "./GMs/Dynamic/vehicle.pwn"
#include "./GMs/Dynamic/playervehicle.pwn"

#define GAME_SCRIPTING "RGAME.MP"

public OnGameModeInit() {
    SetGameModeText(GAME_SCRIPTING);
    g_MySQL_Init();
    return 1;
}

public OnGameModeExit() {
    g_MySQL_Init_Exit();
    return 1;
}