public OnPlayerConnect(playerid) {
    g_PlayerLogged[playerid] = false;
    PassAttemp[playerid] = 0;
    OnPlayerLoad(playerid);
    RemoveBuildingForPlayers(playerid);
    return 1;
}

public OnPlayerDisconnect(playerid, reason) {
    if(g_PlayerLogged[playerid]) {
        g_PlayerLogged[playerid] = false;
        PlayerInfo[playerid][pOnline] = 0;
        SetPVarInt(playerid, "GetJob", 0);
        DBSave(playerid);
    }
    return 1;
}

public OnPlayerEnterCheckpoint(playerid) {
    SendClientMessage(playerid, COLOR_YELLOW, "Ban da den dia diem duoc danh dau.");
    DisablePlayerCheckpoint(playerid);
    return 1;
}