public OnPlayerLoad(playerid) {
    if(!g_PlayerLogged[playerid]) {
        SendClientMessage(playerid, COLOR_YELLOW, "[rGame.MP] ------------------------------");
        mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray),
        "SELECT * FROM `accounts` WHERE `Username` = '%e'", GetPlayerNameEx(playerid));
        mysql_tquery(MainPipeline, szMiscArray, "THREAD_CHECKACCOUNT", "d", playerid);
        TogglePlayerControllable(playerid, true);
        TogglePlayerSpectating(playerid, true);
    }
    else if(g_PlayerLogged[playerid]) {
        TextDrawShowForPlayer(playerid, TD_IP);
        if(PlayerInfo[playerid][pReg] != 0) {
            TogglePlayerControllable(playerid, false);
            TogglePlayerSpectating(playerid, false);

            GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);
            SetPlayerScore(playerid, PlayerInfo[playerid][pScore]);
            SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pVW]);

            SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
            SetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);
            
            SetSpawnInfo(playerid, NO_TEAM, PlayerInfo[playerid][pModel], PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ], PlayerInfo[playerid][pAngle], -1, -1, -1, -1, -1, -1);
            SpawnPlayer(playerid);

            ClearChatbox(playerid);

            new loadplayervehicle[256];
            mysql_format(MainPipeline, loadplayervehicle, sizeof(loadplayervehicle), "SELECT * FROM `vehicles` WHERE `ID` = %d", GetPlayerSQLID(playerid));
            mysql_tquery(MainPipeline, loadplayervehicle, "LoadPlayerVehicle", "d", playerid);

            new gmlogged[256];
            format(gmlogged, sizeof(gmlogged), "[Coming] %s da dang nhap la %s.", GetPlayerNameEx(playerid), GetStaffRank(playerid));
            Critical(gmlogged);

            new name[256];
            format(name, sizeof(name), "Chao mung ban da tro lai - %s.", GetPlayerNameEx(playerid));
            SendClientMessage(playerid, COLOR_WHITE, name);
            SendClientMessage(playerid, COLOR_YELLOW, "Neu ban la nguoi choi moi hay su dung /huongdan de biet them thong tin.");

        }
        else {
            PlayerInfo[playerid][pEnableSecurity] = 0;
            PlayerInfo[playerid][pReg] = 0;
            PlayerInfo[playerid][pTut] = 0;
            PlayerInfo[playerid][pCash] = 5000;
            PlayerInfo[playerid][pScore] = 1;
            PlayerInfo[playerid][pModel] = 2;
            PlayerInfo[playerid][pHealth] = 100;
            PlayerInfo[playerid][pArmour] = 0;
            PlayerInfo[playerid][pPosX] = 722.6266;
            PlayerInfo[playerid][pPosY] = -1494.5594;
            PlayerInfo[playerid][pPosZ] = 3.4223;
            PlayerInfo[playerid][pAngle] = 269.1425;
            PlayerInfo[playerid][pVW] = 0;
            PlayerInfo[playerid][pGender] = 1;
            format(PlayerInfo[playerid][pBirthday], 11, "0000-00-00");
            PlayerInfo[playerid][pNation] = 1;
            PlayerInfo[playerid][pGM] = 0;
            PlayerInfo[playerid][pModerator] = 0;
            PlayerInfo[playerid][pAdvisor] = 0;
            PlayerInfo[playerid][pHR] = 0;
            PlayerInfo[playerid][pPR] = 0;
            PlayerInfo[playerid][pST] = 0;
            PlayerInfo[playerid][pPhoneNumber] = 0;
            PlayerInfo[playerid][pRealName] = 0;
            PlayerInfo[playerid][pRealAddress] = 0;
            PlayerInfo[playerid][pCCCD] = 0;
            PlayerInfo[playerid][pDonator] = 0;
            PlayerInfo[playerid][pInjured] = 0;
            PlayerInfo[playerid][pJob] = 0;
            PlayerInfo[playerid][pJobDuty] = 0;
            PlayerInfo[playerid][pLang] = 0; // default 0 = Vietnamese , 2 = English.

            SetTimerEx("AdvancedTutorial", 3000, false, "d", playerid);
        }
    }
    return 1;
}