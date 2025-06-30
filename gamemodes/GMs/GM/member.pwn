CMD:thongtin(playerid, params[]) {
    if(g_PlayerLogged[playerid]) {
        new 
            title[64],
            vstring[1024],
            szLocation[MAX_ZONE_NAME],
            Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        Get3DZone(x, y, z, szLocation, sizeof(szLocation));
        format(title, sizeof(title), "Thong tin cua %s", GetPlayerNameEx(playerid));
        format(vstring, sizeof(vstring), "%s\n", GetAdminRank(playerid));
        format(vstring, sizeof(vstring), "%sTai san in-game: $%s\n", vstring, Number_Format(GetPlayerCash(playerid)));
        format(vstring, sizeof(vstring), "%sCap do: %d\n", vstring, PlayerInfo[playerid][pScore]);
        format(vstring, sizeof(vstring), "%sSinh nhat: %s\n", vstring, PlayerInfo[playerid][pBirthday]);
        format(vstring, sizeof(vstring), "%sVi tri dang dung: %s\n", vstring, szLocation);
        ShowPlayerDialog(playerid, STATS, DIALOG_STYLE_MSGBOX, title, vstring, "Trang 1/1", "");
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban can dang nhap vao client truoc khi thuc hien dieu nay!");
    }
    return 1;
}

CMD:baocao(playerid, params[]) {
    if(g_PlayerLogged[playerid]) {
        if(ReportInfo[playerid][rPend] == 0) {
            new vstring[256];
            format(vstring, sizeof(vstring), "Hacking\nVi pham luat choi\nHo tro truc tiep\n");
            ShowPlayerDialog(playerid, REPORTLIST, DIALOG_STYLE_LIST, "Danh sach bao cao", vstring, "Chon","Huy");
        }
        else {
            SendClientMessage(playerid, COLOR_GRAY, "Ban can huy bao cao truoc khi gui bao cao moi.");
        }
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban can dang nhap vao client truoc khi thuc hien dieu nay!");
    }
    return 1;
}

CMD:huybaocao(playerid, params[]) {
    if(g_PlayerLogged[playerid]) {
        if(ReportInfo[playerid][rPend] != 0) {
            ReportInfo[playerid][rID] = 0;
            ReportInfo[playerid][rRID] = 0;
            ReportInfo[playerid][rRPlayer] = 0;
            strcpy(ReportInfo[playerid][rReason], "0");
            ReportInfo[playerid][rPend] = 0;
            TotalReports--;
            SendClientMessage(playerid, COLOR_GRAY, "Ban da huy bao cao thanh cong!");
        }
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban can dang nhap vao client truoc khi thuc hien dieu nay!");
    }
    return 1;
}