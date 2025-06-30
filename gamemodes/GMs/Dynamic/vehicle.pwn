#include <YSI_Coding\y_hooks>
CMD:createpvehicle(playerid, params[]) {
    if(PlayerInfo[playerid][pGM] >= 1337) {
        new
            targetid,
            modelid,
            color1,
            color2;
        if(sscanf(params, "uiii", targetid, modelid, color1, color2)) return SendClientMessage(playerid, COLOR_GRAY, "SU DUNG: /createpvehicle [targetid] [modelid] [color 1] [color 2]");
        else if(IsPlayerConnected(targetid) && g_PlayerLogged[targetid]) {
            new Float:iPos[4];
            GetPlayerPos(targetid, iPos[0], iPos[1], iPos[2]);
            GetPlayerFacingAngle(targetid, iPos[3]);

            CreatePlayerVehicle(targetid, GetPlayerVehicleFree(targetid), modelid, iPos[0], iPos[1], iPos[2], iPos[3], color1, color2, -1);

            new szLog[256];
            format(szLog, sizeof(szLog), "AdmCmd: %s da co gang tao mot chiec xe cho %s (ModelID: %d, Color: %d - %d).", GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), modelid, color1, color2);
            Critical(szLog);
            Log("logs/admin/adminset.log", szLog);
        }
        else {
            if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Nguoi choi chua dang nhap vao client nen khong the thuc hien hanh dong nay!");
            if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "The player is not connected to the client, so this action cannot be performed!");
        }
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban khong du quyen han de su dung lenh nay!");
    }
    return 1;
}

CMD:gotopveh(playerid, params[]) {
    if(PlayerInfo[playerid][pGM] >= 1337) {
        new targetid;
        if(sscanf(params, "i", targetid)) return SendClientMessage(playerid, COLOR_GRAY, "SU DUNG: /gotopveh [targetid]");
        else if(IsPlayerConnected(targetid) && g_PlayerLogged[targetid]) {
            new 
                vname[128],
                string[4096];
            format(vname, sizeof(vname), "%s - Vehicle", GetPlayerNameEx(targetid));
            for(new i , iModelID ; i < MAX_PLAYERS_VEHICLE ; i++) {
                if((iModelID = PlayerVehicleInfo[targetid][i][pvModelID] - 400) >= 0) {
                    format(string, sizeof(string), "%s%s\n", string, VehicleName[iModelID]);
                }
                else {
                    strcat(string, "(E)\n");
                }
            }
            SetPVarInt(playerid, "pvTargetid", targetid);
            ShowPlayerDialog(playerid, VSTORAGE3, DIALOG_STYLE_LIST, vname, string, "(De) goto","");
        }
        else {
            if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Nguoi choi chua dang nhap vao client nen khong the thuc hien hanh dong nay!");
            if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "The player is not connected to the client, so this action cannot be performed!");
        }
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban khong du quyen han de su dung lenh nay!");
    }
    return 1;
}

stock CreatePlayerVehicle(playerid, playervehicleid, modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, respawn) {
    if(playervehicleid != -1) {
        PlayerVehicleInfo[playerid][playervehicleid][pvModelID] = modelid;
        PlayerVehicleInfo[playerid][playervehicleid][pvPosX] = x;
        PlayerVehicleInfo[playerid][playervehicleid][pvPosY] = y;
        PlayerVehicleInfo[playerid][playervehicleid][pvPosZ] = z;
        PlayerVehicleInfo[playerid][playervehicleid][pvAngle] = angle;
        PlayerVehicleInfo[playerid][playervehicleid][pvVirtualWorld] = GetPlayerVirtualWorld(playerid);
        PlayerVehicleInfo[playerid][playervehicleid][pvInterior] = GetPlayerInterior(playerid);
        PlayerVehicleInfo[playerid][playervehicleid][pvHealth] = 1000.0;
        PlayerVehicleInfo[playerid][playervehicleid][pvColor] = color1;
        PlayerVehicleInfo[playerid][playervehicleid][pvColor2] = color2;
        PlayerVehicleInfo[playerid][playervehicleid][pvSpawned] = true;
        PlayerVehicleInfo[playerid][playervehicleid][pvMaxSpawned]++;
        PlayerVehicleInfo[playerid][playervehicleid][pvDisable] = 0;
        PlayerVehicleInfo[playerid][playervehicleid][pvTicket] = 0;

        PlayerVehicleInfo[playerid][playervehicleid][pvVehicleID] = CreateVehicle(modelid, x, y, z, angle, color1, color2, respawn);
        SetVehicleHealth(PlayerVehicleInfo[playerid][playervehicleid][pvVehicleID], PlayerVehicleInfo[playerid][playervehicleid][pvHealth]);
        SetVehicleVirtualWorld(PlayerVehicleInfo[playerid][playervehicleid][pvVehicleID], PlayerVehicleInfo[playerid][playervehicleid][pvVirtualWorld]);
        LinkVehicleToInterior(PlayerVehicleInfo[playerid][playervehicleid][pvVehicleID], PlayerVehicleInfo[playerid][playervehicleid][pvInterior]);

        mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "INSERT INTO `vehicles` (`ID`) VALUES (%d)", GetPlayerSQLID(playerid));
        mysql_tquery(MainPipeline, szMiscArray, "CreatedPlayerVehicle", "dd", playerid, playervehicleid);
        
        if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Ban da nhan duoc mot phuong tien tu BQT!");
        if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "You have received a vehicle from GM+");
    }
    return 0;
}

stock GetPlayerVehicleFree(playerid) {
    for(new i = 0 ; i < MAX_PLAYERS_VEHICLE ; i++) {
        if(PlayerVehicleInfo[playerid][i][pvModelID] == 0) {
            return i;
        }
    }
    return -1;
}

stock GetPlayerVehicleTicket(playerid, playervehicleid) {
    if(PlayerVehicleInfo[playerid][playervehicleid][pvTicket] >= 0) {
        switch(PlayerVehicleInfo[playerid][playervehicleid][pvTicket]) {
            case 0: szMiscArray = "NO";
            case 1: szMiscArray = "1T";
        }
    }
    return szMiscArray;
}