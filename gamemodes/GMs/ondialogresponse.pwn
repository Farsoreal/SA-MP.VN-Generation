public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if(dialogid == MAINMENU2) {
        if(!response) {
            SetTimerEx("KickEx", 1000, false, "d", playerid);
            return 1;
        }
        else {
            if(strlen(inputtext) != 0 && strlen(inputtext) < 40) {
                szMiscArray[0] = 0;
                mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray),
                "INSERT INTO `accounts` (`Username`, `PassHash`) VALUES ('%e', SHA2('%e',256))", GetPlayerNameEx(playerid), inputtext);
                mysql_tquery(MainPipeline, szMiscArray, "THREAD_ONCREATEDACCOUNT", "d", playerid);
            }
        }
    }
    else if(dialogid == MAINMENU) {
        if(!response) {
            SetTimerEx("KickEx", 1000, false, "d", playerid);
            return 1;
        }
        else {
            szMiscArray[0] = 0;
            mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "SELECT * FROM `accounts` WHERE `Username` = '%e' AND `PassHash` = SHA2('%e', 256)", GetPlayerNameEx(playerid), inputtext);
            mysql_tquery(MainPipeline, szMiscArray, "THREAD_ONLOGINCHECK", "d", playerid);
        }
    }
    else if(dialogid == LANGSETTING) {
        if(!response) {
            return 1;
        }
        else {
            switch(listitem) {
                case 0: {
                    SendClientMessage(playerid, COLOR_GRAY, "Hien tai da tam ngung ho tro ngon ngu nay!");
                }
                case 1: {
                    SendClientMessage(playerid, COLOR_GRAY, "Hien tai da tam ngung ho tro ngon ngu nay!");
                }
            }
        }
    }
    else if(dialogid == VSTORAGE) {
        if(response) {
            if(PlayerVehicleInfo[playerid][listitem][pvModelID] != 0) {
                if(PlayerVehicleInfo[playerid][listitem][pvTicket] == 0) {
                    if(PlayerVehicleInfo[playerid][listitem][pvDisable] == 0) {
                        if(PlayerVehicleInfo[playerid][listitem][pvSpawned]) {
                            DestroyVehicle(PlayerVehicleInfo[playerid][listitem][pvVehicleID]);
                            PlayerVehicleInfo[playerid][listitem][pvSpawned] = false;
                            PlayerVehicleInfo[playerid][listitem][pvMaxSpawned]--;

                            if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Ban da cat mot chiec xe thanh cong.");
                            if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "You have successfully stored 1 vehicle in the warehouse.");
                        }
                        else if(PlayerVehicleInfo[playerid][listitem][pvMaxSpawned] <= 3 && !PlayerVehicleInfo[playerid][listitem][pvSpawned]) {
                            PlayerVehicleInfo[playerid][listitem][pvVehicleID] = CreateVehicle(PlayerVehicleInfo[playerid][listitem][pvModelID], PlayerVehicleInfo[playerid][listitem][pvPosX], PlayerVehicleInfo[playerid][listitem][pvPosY], PlayerVehicleInfo[playerid][listitem][pvPosZ], PlayerVehicleInfo[playerid][listitem][pvAngle], PlayerVehicleInfo[playerid][listitem][pvColor], PlayerVehicleInfo[playerid][listitem][pvColor2], -1);
                            PlayerVehicleInfo[playerid][listitem][pvSpawned] = true;
                            PlayerVehicleInfo[playerid][listitem][pvMaxSpawned]++;

                            SetVehicleHealth(PlayerVehicleInfo[playerid][listitem][pvVehicleID], PlayerVehicleInfo[playerid][listitem][pvHealth]);
                            SetVehicleVirtualWorld(PlayerVehicleInfo[playerid][listitem][pvVehicleID], PlayerVehicleInfo[playerid][listitem][pvVirtualWorld]);
                            LinkVehicleToInterior(PlayerVehicleInfo[playerid][listitem][pvVehicleID], PlayerVehicleInfo[playerid][listitem][pvInterior]);

                            if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Ban da spawn mot chiec xe thanh cong!");
                            if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "You have spawned a vehicle succesfully!");
                        }
                        else {
                            if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Ban da tao ra qua nhieu xe, hay cat vao kho bot!");
                            if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "You have spawned too many vehicles, please reduce into storage!");
                        }
                    }
                    else {
                        if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Xe nay dang o trang thai (Disable) ban can phai kich hoat lai de su dung no.");
                        if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "This vehicle is currently (Disable) you need right enable again to use it.");
                    }
                }
                else {
                    if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Ban can thanh toan ve phat tai DMV truoc khi lay chiec xe nay ra.");
                    if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "You need to pay the penalty ticket at DMV before spawning this vehicle.");
                }
            }
            else {
                if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Day la slot trong nen khong the spawn xe.");
                if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "This is empty slot, so you no hope vehicle spawn.");
            }
        }
        else {
            return 1;
        }
    }
    else if(dialogid == VSTORAGE2) {
        if(response) {
            if(PlayerVehicleInfo[playerid][listitem][pvModelID] != 0) {
                if(PlayerVehicleInfo[playerid][listitem][pvDisable] != 0) {
                    PlayerVehicleInfo[playerid][listitem][pvVehicleID] = 0;
                    PlayerVehicleInfo[playerid][listitem][pvModelID] = 0;
                    PlayerVehicleInfo[playerid][listitem][pvPosX] = 0;
                    PlayerVehicleInfo[playerid][listitem][pvPosY] = 0;
                    PlayerVehicleInfo[playerid][listitem][pvPosZ] = 0;
                    PlayerVehicleInfo[playerid][listitem][pvVirtualWorld] = 0;
                    PlayerVehicleInfo[playerid][listitem][pvInterior] = 0;
                    PlayerVehicleInfo[playerid][listitem][pvHealth] = 0;
                    PlayerVehicleInfo[playerid][listitem][pvColor] = 0;
                    PlayerVehicleInfo[playerid][listitem][pvColor2] = 0;
                    PlayerVehicleInfo[playerid][listitem][pvSpawned] = false;
                    PlayerVehicleInfo[playerid][listitem][pvMaxSpawned]--;
                    PlayerVehicleInfo[playerid][listitem][pvTicket] = 0;
                    PlayerVehicleInfo[playerid][listitem][pvDisable] = 0;

                    new query[128];
                    mysql_format(MainPipeline, query, sizeof(query), "DELETE FROM `vehicles` WHERE `SQLID` = %d", PlayerVehicleInfo[playerid][listitem][pvSQLID]);
                    mysql_tquery(MainPipeline, query);

                    if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Xe cua ban da bi xoa vinh vien khoi he thong!");
                    if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Your vehicle has been deleted permanently out of the system!");

                }
                else {
                    PlayerVehicleInfo[playerid][listitem][pvDisable] = 1;
                    if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Xe cua ban da bi vo hieu hoa, vui long /xoaxde mot lan nua de xoa.");
                    if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Your vehicle has been disable, please /pvdisable again to delete a vehicle.");
                }
            }
            else {
                if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Day la slot trong nen khong the su dung tinh nang nay.");
                if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "This is empty slot, so you no hope use this feature.");
            }
        }
        else {
            if(PlayerVehicleInfo[playerid][listitem][pvModelID] != 0) {
                if(PlayerVehicleInfo[playerid][listitem][pvDisable] != 0) {
                    PlayerVehicleInfo[playerid][listitem][pvDisable] = 0;
                    if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Xe cua ban da duoc kich hoat su dung lai, neu muon xoa hay /xoaxe de thuc hien hanh dong lai.");
                    if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Your vehicle has been enable use again, please you want delete /pvdisable again to repeat the action.");
                }
                else {
                    if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Xe cua ban khong bi vo hieu hoa nen khong the thuc hanh dong hoan tac.");
                    if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Your vehicle not disable, so no hope perform an action enable.");
                }
            }
            else {
                if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Day la slot trong nen khong the su dung tinh nang nay.");
                if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "This is empty slot, so you no hope use this feature.");
            }
        }
    }
    else if(dialogid == VSTORAGE3) {
        if(!response) {
            DeletePVar(playerid, "pvTargetid");
        }
        else {
            new id = GetPVarInt(playerid, "pvTargetid");
            if(PlayerVehicleInfo[id][listitem][pvModelID] != 0) {
                SetPlayerPos(playerid, PlayerVehicleInfo[id][listitem][pvPosX], PlayerVehicleInfo[id][listitem][pvPosY], PlayerVehicleInfo[id][listitem][pvPosZ]);
                SetPlayerFacingAngle(playerid, PlayerVehicleInfo[id][listitem][pvAngle]);
                DeletePVar(playerid, "pvTargetid");
                if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Ban da duoc dich chuyen den xe cua nguoi choi.");
                if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "You have been goto to player vehicle.");
            }
            else {
                if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Day la slot trong nen khong the su dung tinh nang nay.");
                if(ENG(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "This is empty slot, so you no hope use this feature.");
                DeletePVar(playerid, "pvTargetid");
            }
        }
    }
    else if(dialogid == REPORTLIST) {
        if(response) {
            switch(listitem) {
                case 0: {
                    ShowPlayerDialog(playerid, REPORTHACK, DIALOG_STYLE_INPUT, "Bao cao vi pham", "Hay nhap ID nguoi choi vi pham:\n", "Gui","");
                }
                case 1: {
                    ShowPlayerDialog(playerid, REPORTRULE, DIALOG_STYLE_INPUT, "Bao cao vi pham", "Hay nhap ID nguoi choi vi pham:\n", "Gui","");
                }
                case 2: {
                    ShowPlayerDialog(playerid, REPORTSUPPORT, DIALOG_STYLE_INPUT, "Bao cao vi pham", "Hay nhap ID nguoi choi vi pham:\n", "Gui","");
                }
            }
        }
        else {
            return 1;
        }
    }
    else if(dialogid == REPORTHACK) {
        if(response) {
            new rid = strval(inputtext);
            if(IsNumeric(inputtext) && IsPlayerConnected(rid)) {
                SetPVarInt(playerid, "rRID", rid);
                ShowPlayerDialog(playerid, REPORTIDHACK, DIALOG_STYLE_INPUT, "Hacking", "Theo ban thi ho da su dung hack gi? (Neu khong biet hay ghi Hacking)\n", "Gui", "");
            }
            else {
                SendClientMessage(playerid, COLOR_GRAY, "Hay nhap ID hop le!");
            }
        }
        else {
            return 1;
        }
    }
    else if(dialogid == REPORTRULE) {
        if(response) {
            ShowPlayerDialog(playerid, REPORTIDRULE, DIALOG_STYLE_INPUT, "Vi pham luat le", "Theo ban thi ho da vi pham luat gi? (Chang han Metagaming)\n", "Gui", "");
        }
        else {
            return 1;
        }
    }
    else if(dialogid == REPORTSUPPORT) {
        if(response) {
            // Build
        }
        else {
            return 1;
        }
    }
    else if(dialogid == REPORTIDHACK) {
        if(response) {
            if(strlen(inputtext) <= 128) {
                ReportInfo[playerid][rID] = playerid;
                ReportInfo[playerid][rRID] = TotalReports;
                ReportInfo[playerid][rRPlayer] = GetPVarInt(playerid, "rRID");
                format(ReportInfo[playerid][rReason], 128, inputtext);
                ReportInfo[playerid][rPend] = 1;
                TotalReports++;

                new vstring[560];
                format(vstring, sizeof(vstring), "** %s (ID: %d) | RID: %d | Nguoi choi vi pham: %s (%d) | Ly do: %s.", GetPlayerNameEx(playerid), playerid, ReportInfo[playerid][rRID], GetPlayerNameEx(GetPVarInt(playerid, "rRID")), GetPVarInt(playerid, "rRID"), ReportInfo[playerid][rReason]);
                foreach(new i: Player) {
                    if(PlayerInfo[i][pGM] >= 2) {
                        SendClientMessage(i, COLOR_LIGHTRED, vstring);
                    }
                }
            }
            else {
                SendClientMessage(playerid, COLOR_GRAY, "Hay mo ta tinh huong < 128 ky tu.");
            }
        }
        else {
            return 1;
        }
    }
    else if(dialogid == REPORTIDRULE) {
        if(response) {
            if(strlen(inputtext) <= 128) {
                ReportInfo[playerid][rID] = playerid;
                ReportInfo[playerid][rRID] = TotalReports;
                ReportInfo[playerid][rRPlayer] = GetPVarInt(playerid, "rRID");
                format(ReportInfo[playerid][rReason], 128, inputtext);
                ReportInfo[playerid][rPend] = 1;
                TotalReports++;

                new vstring[560];
                format(vstring, sizeof(vstring), "** %s (ID: %d) | RID: %d | Nguoi choi vi pham: %s (%d) | Ly do: %s.", GetPlayerNameEx(playerid), playerid, ReportInfo[playerid][rRID], GetPlayerNameEx(GetPVarInt(playerid, "rRID")), GetPVarInt(playerid, "rRID"), ReportInfo[playerid][rReason]);
                foreach(new i: Player) {
                    if(PlayerInfo[i][pGM] >= 2) {
                        SendClientMessage(i, COLOR_LIGHTRED, vstring);
                    }
                }
            }
            else {
                SendClientMessage(playerid, COLOR_GRAY, "Hay mo ta tinh huong < 128 ky tu.");
            }
        }
        else {
            return 1;
        }
    }
    return 1;
}