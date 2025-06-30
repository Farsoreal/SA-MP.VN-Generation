CMD:setskin(playerid, params[]) {
    if(PlayerInfo[playerid][pGM] >= 4) {
        new
            targetid,
            skinid;
        if(sscanf(params, "ud", targetid, skinid)) return SendClientMessage(playerid, COLOR_GRAY, "SU DUNG: /setskin [targetid] [skinid]");
        if(0 < skinid && skinid != 74) {
            if(IsPlayerConnected(targetid) && g_PlayerLogged[targetid]) {
                PlayerInfo[targetid][pModel] = skinid;
                SetPlayerSkin(targetid, PlayerInfo[targetid][pModel]);

                new
                    vstring[256],
                    estring[256],
                    pset[256];

                format(vstring, sizeof(vstring), "Ban da nhan duoc trang phuc %d boi GM+ %s.", skinid, GetPlayerNameEx(playerid));
                format(estring, sizeof(estring), "You have been set a skin id %d by GM+ %s.", skinid, GetPlayerNameEx(playerid));
                format(pset, sizeof(pset), "You have set for member %s skin id %d.", GetPlayerNameEx(targetid), skinid);
                SendClientMessage(playerid, COLOR_WHITE, pset);
                if(VIE(targetid)) return SendClientMessage(targetid, COLOR_WHITE, vstring);
                if(ENG(targetid)) return SendClientMessage(targetid, COLOR_WHITE, estring);
            }
            else {
                if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Nguoi choi chua dang nhap vao client nen khong the thuc hien hanh dong nay!");
                if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "The player is not connected to the client, so this action cannot be performed!");
            }
        }
        else {
            if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Hay nhap mot skin hop le (0 < skinid != 74).");
            if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Please enter a valid skin id (0 < skinid != 74).");
        }
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban khong du quyen han de su dung lenh nay!");
    }
    return 1;
}

CMD:veh(playerid, params[]) {
    if(PlayerInfo[playerid][pGM] >= 4) {
        new
            vehicleid,
            color1,
            color2;
        if(sscanf(params, "ddd", vehicleid, color1, color2)) return SendClientMessage(playerid, COLOR_GRAY, "SU DUNG: /veh [vehicleid] [color1] [color2]");
        new Float:pos[4];
        GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
        GetPlayerFacingAngle(playerid, pos[3]);
        CreateVehicle(vehicleid, pos[0], pos[1], pos[2], pos[3], color1, color2, -1);
        if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Ban da tao thanh cong mot phuong tien!");
        if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "You have created successfully a vehicle!");
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban khong du quyen han de su dung lenh nay!");
    }
    return 1;
}

CMD:makeadmin(playerid, params[]) {
    if(PlayerInfo[playerid][pGM] >= 1339) {
        new
            targetid,
            leveladmin;
        if(sscanf(params, "ud", targetid, leveladmin)) return SendClientMessage(playerid, COLOR_GRAY, "SU DUNG: /makeadmin [targetid] [level admin]");
        else if(IsPlayerConnected(targetid) && g_PlayerLogged[playerid]) {
            PlayerInfo[targetid][pGM] = leveladmin;
            new szLog[256], vstring[256], estring[256];
            format(szLog, sizeof(szLog), "AdmCmd: %s has been made to %s by %s.", GetPlayerNameEx(targetid), GetStaffRank(targetid), GetPlayerNameEx(playerid));
            format(vstring, sizeof(vstring), "%s tuyen dung ban tro thanh %s.", GetPlayerNameEx(playerid), GetStaffRank(targetid));
            format(estring, sizeof(estring), "%s has hired you for the position of %s.", GetPlayerNameEx(playerid), GetStaffRank(targetid));
            foreach(new i: Player) {
                if(PlayerInfo[i][pGM] >= 2) {
                    SendClientMessage(i, COLOR_LIGHTRED, szLog);
                }
            }
            Log("logs/admin/adminset.log", szLog);
            if(VIE(targetid)) return SendClientMessage(targetid, COLOR_LIGHTBLUE, vstring);
            if(ENG(targetid)) return SendClientMessage(targetid, COLOR_LIGHTBLUE, estring);
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

CMD:jetpack(playerid, params[]) {
    if(g_PlayerLogged[playerid]) {
        if(PlayerInfo[playerid][pGM] >= 2 && PlayerInfo[playerid][pGM] < 4) {
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
        }
        else if(PlayerInfo[playerid][pGM] >= 4) {
            new
                targetid;
            if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_GRAY, "SU DUNG: /jetpack [targetid]");
            else if(IsPlayerConnected(targetid) && g_PlayerLogged[targetid]) {
                SetPlayerSpecialAction(targetid, SPECIAL_ACTION_USEJETPACK);
                new szLog[256];
                format(szLog, sizeof(szLog), "AdminCmd: %s has set for %s a jetpack.", GetPlayerNameEx(playerid), GetPlayerNameEx(targetid));
                SendClientMessageToAll(COLOR_LIGHTRED, szLog);
                Log("logs/admin/adminset.log", szLog);
                if(VIE(playerid)) return SendClientMessage(targetid, COLOR_GRAY, "Ban da nhan duoc jetpack!");
                if(ENG(playerid)) return SendClientMessage(targetid, COLOR_GRAY, "You have received jetpack from GM+");
            }
            else {
                if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Nguoi choi chua dang nhap vao client nen khong the thuc hien hanh dong nay!");
                if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "The player is not connected to the client, so this action cannot be performed!");
            }
        }
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban khong du quyen han de su dung lenh nay!");
    }
    return 1;
}

CMD:report(playerid, params[]) {
    if(PlayerInfo[playerid][pGM] >= 2) {
        new vstring[256];
        SendClientMessage(playerid, COLOR_LIGHTRED, "______________________________ PENDING ______________________________");
        for(new i ; i < MAX_PLAYERS ; i++) {
            if(ReportInfo[i][rPend] != 0) {
                new id = ReportInfo[i][rID];
                new rid = ReportInfo[i][rRID];
                new rplayer = ReportInfo[i][rRPlayer];
                format(vstring, sizeof(vstring), "** %s (%d) | RID: %d | Nguoi choi vi pham: %s (%d) | Ly do: %s.", GetPlayerNameEx(id), id, rid, GetPlayerNameEx(rplayer), rplayer, ReportInfo[i][rReason]);
                SendClientMessage(playerid, COLOR_LIGHTRED, vstring);
            }
        }
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban khong du quyen han de su dung lenh nay!");
    }
    return 1;
}

stock GetStaffRank(playerid) {
    if(PlayerInfo[playerid][pGM] >= 2) {
        switch(PlayerInfo[playerid][pGM]) {
            case 2: szMiscArray = "Junior Admin";
            case 3: szMiscArray = "General Admin";
            case 4: szMiscArray = "Senior Admin";
            case 1337: szMiscArray = "Head Admin";
            case 1338: szMiscArray = "Game Master";
            case 1339: szMiscArray = "Game Operator";
            case 99999: szMiscArray = "Administrator";
        }
    }
    
    if(PlayerInfo[playerid][pHR] >= 1) {
        switch(PlayerInfo[playerid][pHR]) {
            case 1: szMiscArray = "Human Resources (1)";
            case 2: szMiscArray = "Human Resources (2)";
        }
    }

    if(PlayerInfo[playerid][pPR] >= 1) {
        switch(PlayerInfo[playerid][pPR]) {
            case 1: szMiscArray = "Admin PR (1)";
            case 2: szMiscArray = "Admin PR (2)";
        }
    }

    if(PlayerInfo[playerid][pST] >= 1) {
        switch(PlayerInfo[playerid][pST]) {
            case 1: szMiscArray = "Shop Technician (1)";
            case 2: szMiscArray = "Shop Technician (2)";
        }
    }

    if(PlayerInfo[playerid][pAdvisor] >= 1) {
        switch(PlayerInfo[playerid][pAdvisor]) {
            case 1: szMiscArray = "Helper";
            case 2: szMiscArray = "Community Advisor";
            case 3: szMiscArray = "Senior Advisor";
            case 4: szMiscArray = "Chief Advisor";
            case 5: szMiscArray = "Advisor Moderator";
            case 6: szMiscArray = "Senior Moderator";
            case 7: szMiscArray = "Super Moderator";
        }
    }
    
    return szMiscArray;
}

stock GetAdminRank(playerid) {
    if(PlayerInfo[playerid][pGM] >= 2) {
        switch(PlayerInfo[playerid][pGM]) {
            case 2: szMiscArray = "{3737AB}Junior Admin{FFFFFF}";
            case 3: szMiscArray = "{4FFA11}General Admin{FFFFFF}";
            case 4: szMiscArray = "{FFD875}Senior Admin{FFFFFF}";
            case 1337: szMiscArray = "{BF3F3F}Head Admin{FFFFFF}";
            case 1338: szMiscArray = "{A4DB23}Game Master{FFFFFF}";
            case 1339: szMiscArray = "{0061F2}Administrator (1){FFFFFF}";
            case 99999: szMiscArray = "{0061F2}Administrator (2){FFFFFF}";
        }
    }

    if(PlayerInfo[playerid][pAdvisor] >= 1) {
        switch(PlayerInfo[playerid][pAdvisor]) {
            case 1: szMiscArray = "Helper";
            case 2: szMiscArray = "Community Advisor";
            case 3: szMiscArray = "Senior Advisor";
            case 4: szMiscArray = "Chief Advisor";
            case 5: szMiscArray = "Advisor Moderator";
            case 6: szMiscArray = "Senior Moderator";
            case 7: szMiscArray = "Super Moderator";
        }
    }
    
    return szMiscArray;
}