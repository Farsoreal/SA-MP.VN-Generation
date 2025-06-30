#include <YSI_Coding\y_hooks>

new TotalProtectArea = 0;

hook OnPlayerConnect(playerid) {
    DeletePVar(playerid, "DisablePlayerWeapon");
}

hook OnPlayerUpdate(playerid) {
    if(IsAtProtectArea(playerid)) {
        SetPlayerArmedWeapon(playerid, 0);
        if(GetPVarInt(playerid, "DisablePlayerWeapon") == 0) {
            SetPVarInt(playerid, "DisablePlayerWeapon", 1);
            if(VIE(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{82748A}[WARN] {FFFFFF}Ban dang o trong khu vuc duoc bao ve.");
        }
    }
    else {
        if(GetPVarInt(playerid, "DisablePlayerWeapon") == 1) {
            DeletePVar(playerid, "DisablePlayerWeapon");
            if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "{82748A}[WARN] {FFFFFF}Ban da roi khu vuc duoc bao ve.");
        }
    }
    return 1;
}

public CreatedProtectArea(index, area) {
    ProtectArea[index][pa_SQLID] = cache_insert_id();
    SaveProtectArea(index);
    return 1;
}

public LoadProtectArea() {
    new rows;
    cache_get_row_count(rows);
    TotalProtectArea = rows;
    if(rows > 0) {
        new i = 0;
        while(i < rows) {
            if(i >= MAX_PROTECT_AREA)
                break;

            cache_get_value_name_int(i, "SQLID", ProtectArea[i][pa_SQLID]);
            cache_get_value_name_int(i, "ID", ProtectArea[i][pa_ID]);
            cache_get_value_name_float(i, "PosX", ProtectArea[i][pa_PosX]);
            cache_get_value_name_float(i, "PosY", ProtectArea[i][pa_PosY]);
            cache_get_value_name_float(i, "PosZ", ProtectArea[i][pa_PosZ]);
            cache_get_value_name_float(i, "Range", ProtectArea[i][pa_Range]);

            format(ProtectArea[i][pa_String], 165, "{FF0000}(%d) Khu vuc duoc bao ho\n{FFFFFF}Neu ban khong phai nhan vien thuc thi phap luat, ban se khong duoc phep tan cong bat ki ai tai day.", ProtectArea[i][pa_ID]);
            ProtectArea[i][pa_Text] = CreateDynamic3DTextLabel(ProtectArea[i][pa_String], COLOR_WHITE, ProtectArea[i][pa_PosX], ProtectArea[i][pa_PosY], ProtectArea[i][pa_PosZ], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);

            i++;
        }
        printf("[LoadAreas] Succesfully %d area loaded.", TotalProtectArea);
    }
    else {
        printf("[LoadProtectAreas] Failed to load any area.");
    }
    return 1;
}

stock LoadProtectAreas() {
    mysql_tquery(MainPipeline, "SELECT * FROM `protectareas`", "LoadProtectArea", "");
}

stock GetProtectAreaIndex() {
    for(new i ; i < MAX_PROTECT_AREA ; i++) {
        if(ProtectArea[i][pa_ID] == 0) {
            return i;
        }
    }
    return -1;
}

stock GetPlayerProtectAreaIndexExist(playerid, area) {
    for(new i ; i < MAX_PROTECT_AREA ; i++) {
        if(ProtectArea[i][pa_ID] == area) {
            SetPVarInt(playerid, "SetPlayerIndex", i);
            return 0;
        }
    }
    return 1;
}

stock CreateProtectArea(index, area, Float:x, Float:y, Float:z, Float:range) {
    ProtectArea[index][pa_ID] = area;
    ProtectArea[index][pa_PosX] = x;
    ProtectArea[index][pa_PosY] = y;
    ProtectArea[index][pa_PosZ] = z;
    ProtectArea[index][pa_Range] = range;

    TotalProtectArea++;

    format(ProtectArea[index][pa_String], 165, "{FF0000}(%d) Khu vuc duoc bao ho\n{FFFFFF}Neu ban khong phai nhan vien thuc thi phap luat, ban se khong duoc phep tan cong bat ki ai tai day.", area);
    ProtectArea[index][pa_Text] = CreateDynamic3DTextLabel(ProtectArea[index][pa_String], COLOR_WHITE, ProtectArea[index][pa_PosX], ProtectArea[index][pa_PosY], ProtectArea[index][pa_PosZ], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
    
    new query[128];
    mysql_format(MainPipeline, query, sizeof(query), "INSERT INTO `protectareas` (`ID`) VALUES (%d)", area);
    mysql_tquery(MainPipeline, query, "CreatedProtectArea", "dd", index, area);
    return 1;
}

stock SaveProtectArea(index) {
    szMiscArray[0] = 0;
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "UPDATE `protectareas` SET");
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `PosX` = %.2f,", szMiscArray, ProtectArea[index][pa_PosX]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `PosY` = %.2f,", szMiscArray, ProtectArea[index][pa_PosY]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `PosZ` = %.2f,", szMiscArray, ProtectArea[index][pa_PosZ]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Range` = %.2f", szMiscArray, ProtectArea[index][pa_Range]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s WHERE `SQLID` = %d", szMiscArray, ProtectArea[index][pa_SQLID]);
    mysql_tquery(MainPipeline, szMiscArray);
    return 1;
}

stock IsAtProtectArea(playerid) {
    for(new i ; i < MAX_PROTECT_AREA ; i++) {
        if(IsPlayerInRangeOfPoint(playerid, ProtectArea[i][pa_Range], ProtectArea[i][pa_PosX], ProtectArea[i][pa_PosY], ProtectArea[i][pa_PosZ])) return 1;
    }
    return 0;
}

CMD:aedit(playerid, params[]) {
    if(PlayerInfo[playerid][pGM] >= 1337 || PlayerInfo[playerid][pST] >= 2) {
        new
            choice[64],
            area,
            Float:amount;
        if(sscanf(params, "s[32]dF(0)", choice, area, amount)) {
            SendClientMessage(playerid, COLOR_GRAY, "Choice: 1. Add, 2. Delete, 3. Range.");
            SendClientMessage(playerid, COLOR_GRAY, "SU DUNG: /aedit [choice] [area id] [amount (Option)]");
        }
        else {
            if(strcmp(choice, "Add", true) == 0) {
                if(TotalProtectArea >= MAX_PROTECT_AREA) return SendClientMessage(playerid, COLOR_GRAY, "Khong the them mot khu vuc an toan ngay bay gio!");
                if(area < 1) return SendClientMessage(playerid, COLOR_GRAY, "Vui long nhap ID tu 1 tro len.");
                if(GetPlayerProtectAreaIndexExist(playerid, area)) {
                    new Float:pos[3];
                    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
                    CreateProtectArea(GetProtectAreaIndex(), area, pos[0], pos[1], pos[2], amount);
                    
                    new szLog[256];
                    new szLocation[256];
                    Get3DZone(pos[0], pos[1], pos[2], szLocation, sizeof(szLocation));
                    format(szLog, sizeof(szLog), "AdmCmd: %s da co gang tao mot protect area (%d - Dia diem: %s).", GetPlayerNameEx(playerid), area, szLocation);
                    Critical(szLog);
                }
                else {
                    SendClientMessage(playerid, COLOR_GRAY, "ID nay da co trong he thong!");
                }
            }
            else if(strcmp(choice, "Delete", true) == 0) {
                if(area < 1) return SendClientMessage(playerid, COLOR_GRAY, "Vui long nhap ID tu 1 tro len.");
                if(!GetPlayerProtectAreaIndexExist(playerid, area)) {
                    new index = GetPVarInt(playerid, "SetPlayerIndex");
                    new szLog[256];
                    new szLocation[256];
                    Get3DZone(ProtectArea[index][pa_PosX], ProtectArea[index][pa_PosY], ProtectArea[index][pa_PosZ], szLocation, sizeof(szLocation));
                    format(szLog, sizeof(szLog), "AdmCmd: %s da xoa mot protect area (%d - Dia diem: %s).", GetPlayerNameEx(playerid), area, szLocation);
                    Critical(szLog);

                    new query[128];
                    mysql_format(MainPipeline, query, sizeof(query), "DELETE FROM `protectareas` WHERE `SQLID` = %d", ProtectArea[index][pa_SQLID]);
                    mysql_tquery(MainPipeline, query);

                    ProtectArea[index][pa_SQLID] = 0;
                    ProtectArea[index][pa_ID] = 0;
                    ProtectArea[index][pa_PosX] = 0;
                    ProtectArea[index][pa_PosY] = 0;
                    ProtectArea[index][pa_PosZ] = 0;
                    ProtectArea[index][pa_Range] = 0;
                    TotalProtectArea--;
                    strcpy(ProtectArea[index][pa_String], "0");
                    DestroyDynamic3DTextLabel(ProtectArea[index][pa_Text]);
                    DeletePVar(playerid, "SetPlayerIndex");

                }
                else {
                    SendClientMessage(playerid, COLOR_GRAY, "ID nay khong ton tai trong he thong!");
                }
            }
            else if(strcmp(choice, "Range", true) == 0) {
                if(area < 1) return SendClientMessage(playerid, COLOR_GRAY, "Vui long nhap ID tu 1 tro len.");
                if(!GetPlayerProtectAreaIndexExist(playerid, area)) {
                    new index = GetPVarInt(playerid, "SetPlayerIndex");
                    new szLog[256];
                    new szLocation[256];
                    Get3DZone(ProtectArea[index][pa_PosX], ProtectArea[index][pa_PosY], ProtectArea[index][pa_PosZ], szLocation, sizeof(szLocation));
                    format(szLog, sizeof(szLog), "AdmCmd: %s da thay doi range protect area (%d - Dia diem: %s).", GetPlayerNameEx(playerid), area, szLocation);
                    Critical(szLog);

                    ProtectArea[index][pa_Range] = amount;
                    SaveProtectArea(index);

                    DeletePVar(playerid, "SetPlayerIndex");
                }
                else {
                    SendClientMessage(playerid, COLOR_GRAY, "ID nay khong ton tai trong he thong!");
                }
            }
        }
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban khong du quyen han de su dung lenh nay!");
    }
    return 1;
}