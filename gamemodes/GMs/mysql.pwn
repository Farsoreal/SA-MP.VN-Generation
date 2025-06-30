public THREAD_CHECKACCOUNT(playerid) {
    new rows;
    cache_get_row_count(rows);
    if(rows > 0) {
        ShowMainMenu(playerid, 1);
    }
    else {
        ShowMainMenu(playerid, 2);
    }
    return 1;
}

public THREAD_ONCREATEDACCOUNT(playerid) {
    PlayerInfo[playerid][pID] = cache_insert_id();
    g_PlayerLogged[playerid] = true;
    OnPlayerLoad(playerid);
    return 1;
}

public THREAD_ONLOGINCHECK(playerid) {
    new rows;
    cache_get_row_count(rows);
    if(rows > 0) { // có ít nhất 1 dòng có giá trị tương ứng với điều kiện WHERE tên của người chơi
        new row = 0;
        cache_get_value_name_int(row, "ID", PlayerInfo[playerid][pID]);
        cache_get_value_name_int(row, "Online", PlayerInfo[playerid][pOnline]);
        cache_get_value_name_int(row, "EnableSecurity", PlayerInfo[playerid][pEnableSecurity]);
        cache_get_value_name_int(row, "Reg", PlayerInfo[playerid][pReg]);
        cache_get_value_name_int(row, "Tut", PlayerInfo[playerid][pTut]);
        cache_get_value_name_int(row, "Cash", PlayerInfo[playerid][pCash]);
        cache_get_value_name_int(row, "Score", PlayerInfo[playerid][pScore]);
        cache_get_value_name_int(row, "Model", PlayerInfo[playerid][pModel]);
        cache_get_value_name_int(row, "VW", PlayerInfo[playerid][pVW]);
        cache_get_value_name_int(row, "Gender", PlayerInfo[playerid][pGender]);
        cache_get_value_name_int(row, "Nation", PlayerInfo[playerid][pNation]);
        cache_get_value_name_int(row, "GM", PlayerInfo[playerid][pGM]);
        cache_get_value_name_int(row, "Moderator", PlayerInfo[playerid][pModerator]);
        cache_get_value_name_int(row, "Advisor", PlayerInfo[playerid][pAdvisor]);
        cache_get_value_name_int(row, "HR", PlayerInfo[playerid][pHR]);
        cache_get_value_name_int(row, "PR", PlayerInfo[playerid][pPR]);
        cache_get_value_name_int(row, "ST", PlayerInfo[playerid][pST]);
        cache_get_value_name_int(row, "RealPhone", PlayerInfo[playerid][pPhoneNumber]);
        cache_get_value_name_int(row, "RealName", PlayerInfo[playerid][pRealName]);
        cache_get_value_name_int(row, "RealAddress", PlayerInfo[playerid][pRealAddress]);
        cache_get_value_name_int(row, "RealCCCD", PlayerInfo[playerid][pCCCD]);
        cache_get_value_name_int(row, "Donator", PlayerInfo[playerid][pDonator]);
        cache_get_value_name_int(row, "Injured", PlayerInfo[playerid][pInjured]);
        cache_get_value_name_int(row, "Job", PlayerInfo[playerid][pJob]);
        cache_get_value_name_int(row, "JobDuty", PlayerInfo[playerid][pJobDuty]);
        cache_get_value_name_int(row, "Lang", PlayerInfo[playerid][pLang]);

        cache_get_value_name(row, "Birthday", PlayerInfo[playerid][pBirthday], 12);
        cache_get_value_name(row, "Security", PlayerInfo[playerid][pSecurity], 5);

        cache_get_value_name_float(row, "Health", PlayerInfo[playerid][pHealth]);
        cache_get_value_name_float(row, "Armour", PlayerInfo[playerid][pArmour]);
        cache_get_value_name_float(row, "PosX", PlayerInfo[playerid][pPosX]);
        cache_get_value_name_float(row, "PosY", PlayerInfo[playerid][pPosY]);
        cache_get_value_name_float(row, "PosZ", PlayerInfo[playerid][pPosZ]);
        cache_get_value_name_float(row, "Angle", PlayerInfo[playerid][pAngle]);

        PlayerInfo[playerid][pOnline] = 1;
        szMiscArray[0] = 0;
        mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "UPDATE `accounts` SET");
        mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Online` = %d", szMiscArray, PlayerInfo[playerid][pOnline]);
        format(szMiscArray, sizeof(szMiscArray), "%s WHERE `Username` = '%e'", szMiscArray, GetPlayerNameEx(playerid));
        mysql_tquery(MainPipeline, szMiscArray);

        g_PlayerLogged[playerid] = true;
        OnPlayerLoad(playerid);
    }
    else {
        PassAttemp[playerid]++;
        ShowMainMenu(playerid, 1);
        if(PassAttemp[playerid] == 3) {
            SetTimerEx("KickEx", 1000, false, "d", playerid);
        }
    }
    return 1;
}

stock DBSave(playerid) {

    new 
        Float:ha[2],
        Float:iPos[4];

    PlayerInfo[playerid][pCash] = GetPlayerCash(playerid);
    PlayerInfo[playerid][pScore] = GetPlayerScore(playerid);
    PlayerInfo[playerid][pModel] = GetPlayerSkin(playerid);

    GetPlayerHealth(playerid, ha[0]);
    GetPlayerArmour(playerid, ha[1]);

    PlayerInfo[playerid][pHealth] = ha[0];
    PlayerInfo[playerid][pArmour] = ha[1];

    GetPlayerPos(playerid, iPos[0], iPos[1], iPos[2]);
    GetPlayerFacingAngle(playerid, iPos[3]);

    PlayerInfo[playerid][pPosX] = iPos[0];
    PlayerInfo[playerid][pPosY] = iPos[1];
    PlayerInfo[playerid][pPosZ] = iPos[2];
    PlayerInfo[playerid][pAngle] = iPos[3];
    PlayerInfo[playerid][pVW] = GetPlayerVirtualWorld(playerid);

    szMiscArray[0] = 0;
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "UPDATE `accounts` SET");
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Username` = '%s',", szMiscArray, GetPlayerNameEx(playerid));
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Online` = %d,", szMiscArray, PlayerInfo[playerid][pOnline]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `EnableSecurity` = %d,", szMiscArray, PlayerInfo[playerid][pEnableSecurity]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Security` = %d,", szMiscArray, PlayerInfo[playerid][pSecurity]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Reg` = %d,", szMiscArray, PlayerInfo[playerid][pReg]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Tut` = %d,", szMiscArray, PlayerInfo[playerid][pTut]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Cash` = %d,", szMiscArray, PlayerInfo[playerid][pCash]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Score` = %d,", szMiscArray, PlayerInfo[playerid][pScore]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Model` = %d,", szMiscArray, PlayerInfo[playerid][pModel]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Health` = '%.2f',", szMiscArray, PlayerInfo[playerid][pHealth]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Armour` = '%.2f',", szMiscArray, PlayerInfo[playerid][pArmour]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `PosX` = '%.2f',", szMiscArray, PlayerInfo[playerid][pPosX]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `PosY` = '%.2f',", szMiscArray, PlayerInfo[playerid][pPosY]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `PosZ` = '%.2f',", szMiscArray, PlayerInfo[playerid][pPosZ]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Angle` = '%.2f',", szMiscArray, PlayerInfo[playerid][pAngle]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `VW` = %d,", szMiscArray, PlayerInfo[playerid][pVW]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Gender` = %d,", szMiscArray, PlayerInfo[playerid][pGender]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Birthday` = '%s',", szMiscArray, PlayerInfo[playerid][pBirthday]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Nation` = %d,", szMiscArray, PlayerInfo[playerid][pNation]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `GM` = %d,", szMiscArray, PlayerInfo[playerid][pGM]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Moderator` = %d,", szMiscArray, PlayerInfo[playerid][pModerator]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Advisor` = %d,", szMiscArray, PlayerInfo[playerid][pAdvisor]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `HR` = %d,", szMiscArray, PlayerInfo[playerid][pHR]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `PR` = %d,", szMiscArray, PlayerInfo[playerid][pPR]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `ST` = %d,", szMiscArray, PlayerInfo[playerid][pST]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `RealPhone` = %d,", szMiscArray, PlayerInfo[playerid][pPhoneNumber]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `RealName` = %d,", szMiscArray, PlayerInfo[playerid][pRealName]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `RealAddress` = %d,", szMiscArray, PlayerInfo[playerid][pRealAddress]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `RealCCCD` = %d,", szMiscArray, PlayerInfo[playerid][pCCCD]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Donator` = %d,", szMiscArray, PlayerInfo[playerid][pDonator]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Injured` = %d,", szMiscArray, PlayerInfo[playerid][pInjured]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Job` = %d,", szMiscArray, PlayerInfo[playerid][pJob]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `JobDuty` = %d,", szMiscArray, PlayerInfo[playerid][pJobDuty]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s `Lang` = %d", szMiscArray, PlayerInfo[playerid][pLang]);
    mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s WHERE `Username` = '%e'", szMiscArray, GetPlayerNameEx(playerid));
    mysql_tquery(MainPipeline, szMiscArray);

    // save dynamic
    new i = 0;
    while(i < MAX_PLAYERS_VEHICLE) {
        if(PlayerVehicleInfo[playerid][i][pvModelID] != 0) {
            SavePlayerVehicles(playerid, i);
        }
        i++;
    }
    return 1;
}

stock GetPlayerSQLID(playerid) {
    return PlayerInfo[playerid][pID];
}

public LoadPlayerVehicle(playerid) {
    new rows;
    cache_get_row_count(rows);
    if(rows > 0) {
        new i = 0;
        while(i < rows) {
            if(i >= MAX_PLAYERS_VEHICLE)
                break;
            cache_get_value_name_int(i, "SQLID", PlayerVehicleInfo[playerid][i][pvSQLID]);
            cache_get_value_name_int(i, "ModelID", PlayerVehicleInfo[playerid][i][pvModelID]);
            if(PlayerVehicleInfo[playerid][i][pvModelID] != 0) {
                cache_get_value_name_float(i, "PosX", PlayerVehicleInfo[playerid][i][pvPosX]);
                cache_get_value_name_float(i, "PosY", PlayerVehicleInfo[playerid][i][pvPosY]);
                cache_get_value_name_float(i, "PosZ", PlayerVehicleInfo[playerid][i][pvPosZ]);
                cache_get_value_name_float(i, "Angle", PlayerVehicleInfo[playerid][i][pvAngle]);
                cache_get_value_name_int(i, "VW", PlayerVehicleInfo[playerid][i][pvVirtualWorld]);
                cache_get_value_name_int(i, "Interior", PlayerVehicleInfo[playerid][i][pvInterior]);
                cache_get_value_name_float(i, "Health", PlayerVehicleInfo[playerid][i][pvHealth]);
                cache_get_value_name_int(i, "Color", PlayerVehicleInfo[playerid][i][pvColor]);
                cache_get_value_name_int(i, "Color2", PlayerVehicleInfo[playerid][i][pvColor2]);
                cache_get_value_name_int(i, "Ticket", PlayerVehicleInfo[playerid][i][pvTicket]);
                cache_get_value_name_int(i, "Disable", PlayerVehicleInfo[playerid][i][pvDisable]);
            }
            else {
                mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "DELETE FROM `vehicles` WHERE `SQLID` = %d", PlayerVehicleInfo[playerid][i][pvSQLID]);
                mysql_tquery(MainPipeline, szMiscArray);
            }
            i++;
        }
    }
    else {
        //
    }
    return 1;
}

stock g_MySQL_Init() {

    MainPipeline = mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DB);

    if(mysql_errno(MainPipeline) != 0) {
        printf("A potential hidden error has occurred within the content assigned to MainPipeline!");
        printf("Please check whether the internal elements match the configurations you have set.");
        printf("Element details: HOST = %s, USER = %s, PASS = %s, DB = %s.", SQL_HOST, SQL_USER, SQL_PASS, SQL_DB);
        mysql_close(MainPipeline);
    }
    else {
        printf("______________________________________________________________________________\n");
        printf(" The Revolution Gaming Network Multiplayer (2025)\n");
        printf(" Owner: pyszkova\n");
        printf(" Leader of Script: pyszkova\n");
        printf(" Gamemode release 03DL by Vietnamese.\n");
        printf("______________________________________________________________________________\n");
    }
    Initategamemode();
    return 1;
}

stock g_MySQL_Init_Exit() {
    mysql_close(MainPipeline);
    return 1;
}