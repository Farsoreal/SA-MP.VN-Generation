#include <YSI_Coding\y_hooks>

public CreatedPlayerVehicle(playerid, playervehicleid) {
    PlayerVehicleInfo[playerid][playervehicleid][pvSQLID] = cache_insert_id();

    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "UPDATE `vehicles` SET `ModelID` = %d WHERE `SQLID` = %d", PlayerVehicleInfo[playerid][playervehicleid][pvModelID], PlayerVehicleInfo[playerid][playervehicleid][pvSQLID]);
    mysql_tquery(MainPipeline, szMiscArray);

    SavePlayerVehicles(playerid, playervehicleid);
    return 1;
}

public SavePlayerVehicles(playerid, playervehicleid) {
    szMiscArray[0] = 0;
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "UPDATE `vehicles` SET");
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `PosX` = %.2f,", szMiscArray, PlayerVehicleInfo[playerid][playervehicleid][pvPosX]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `PosY` = %.2f,", szMiscArray, PlayerVehicleInfo[playerid][playervehicleid][pvPosY]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `PosZ` = %.2f,", szMiscArray, PlayerVehicleInfo[playerid][playervehicleid][pvPosZ]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Angle` = %.2f,", szMiscArray, PlayerVehicleInfo[playerid][playervehicleid][pvAngle]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `VW` = %d,", szMiscArray, PlayerVehicleInfo[playerid][playervehicleid][pvVirtualWorld]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Interior` = %d,", szMiscArray, PlayerVehicleInfo[playerid][playervehicleid][pvInterior]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Health` = %.2f,", szMiscArray, PlayerVehicleInfo[playerid][playervehicleid][pvHealth]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Color` = %d,", szMiscArray, PlayerVehicleInfo[playerid][playervehicleid][pvColor]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Color2` = %d,", szMiscArray, PlayerVehicleInfo[playerid][playervehicleid][pvColor2]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Disable` = %d", szMiscArray, PlayerVehicleInfo[playerid][playervehicleid][pvDisable]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s WHERE `SQLID` = %d", szMiscArray, PlayerVehicleInfo[playerid][playervehicleid][pvSQLID]);
    mysql_tquery(MainPipeline, szMiscArray);
    return 1;
}

CMD:pvehicle(playerid, params[]) {
    return cmd_chinhxe(playerid, params);
}

CMD:vstorage(playerid, params[]) {
    return cmd_chinhxe(playerid, params);
}
CMD:chinhxe(playerid, params[]) {
    if(g_PlayerLogged[playerid]) {
        new 
            vstring[4096],
            estring[4096],
            szLocation[MAX_ZONE_NAME];
        format(vstring, sizeof(vstring), "Ten xe\tVi tri do\tTrang thai\tVe phat\n");
        format(estring, sizeof(estring), "Vehicle name\tPark location\tProgress\tPenalty ticket\n");
        for(new i , ModelID ; i < MAX_PLAYERS_VEHICLE ; i++) {
            Get3DZone(PlayerVehicleInfo[playerid][i][pvPosX], PlayerVehicleInfo[playerid][i][pvPosY], PlayerVehicleInfo[playerid][i][pvPosZ], szLocation, sizeof(szLocation));
            if((ModelID = PlayerVehicleInfo[playerid][i][pvModelID] - 400) >= 0) {
                if(PlayerVehicleInfo[playerid][i][pvSpawned]) {
                    format(vstring, sizeof(vstring), "%s%s\t%s\tChua su dung\t%s\n", vstring, VehicleName[ModelID], szLocation, GetPlayerVehicleTicket(playerid, i));
                    format(estring, sizeof(estring), "%s%s\t%s\tUnused\t%s\n", estring, VehicleName[ModelID], szLocation, GetPlayerVehicleTicket(playerid, i));
                }
                else if(!PlayerVehicleInfo[playerid][i][pvSpawned]) {
                    format(vstring, sizeof(vstring), "%s%s\t%s\tChua su dung\t%s\n", vstring, VehicleName[ModelID], szLocation, GetPlayerVehicleTicket(playerid, i));
                    format(estring, sizeof(estring), "%s%s\t%s\tUnused\t%s\n", estring, VehicleName[ModelID], szLocation, GetPlayerVehicleTicket(playerid, i));
                }
            }
            else {
                strcat(vstring, "(E)\t\t\t\n");
            }
        }

        ShowPlayerDialog(playerid, VSTORAGE, DIALOG_STYLE_TABLIST_HEADERS, "Danh sach xe dang so huu", vstring, "Chon","Huy");
        if(ENG(playerid)) return ShowPlayerDialog(playerid, VSTORAGE, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle owner list", estring, "Choose","Cancel");
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban can dang nhap vao client truoc khi lam dieu nay!");
    }
    return 1;
}

CMD:pvdisable(playerid, params[]) {
    return cmd_xoaxe(playerid, params);
}
CMD:xoaxe(playerid, params[]) {
    if(g_PlayerLogged[playerid]) {
        new string[4096];
        for(new i , iModelid ; i < MAX_PLAYERS_VEHICLE ; i++) {
            if((iModelid = PlayerVehicleInfo[playerid][i][pvModelID] - 400) >= 0) {
                if(PlayerVehicleInfo[playerid][i][pvDisable]  != 0) {
                    format(string, sizeof(string), "%s%s\tDisable\n", string, VehicleName[iModelid]);
                }
                else {
                    format(string, sizeof(string), "%s%s\tEnable\n", string, VehicleName[iModelid]);
                }
            }
            else {
                strcat(string, "(E)\t\n");
            }
        }
        ShowPlayerDialog(playerid, VSTORAGE2, DIALOG_STYLE_TABLIST, "V-Recycle", string, "(De) delete", "(Re) enable");
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban can dang nhap vao client truoc khi lam dieu nay!");
    }
    return 1;
}