#include <YSI_Coding\y_hooks>

CMD:accountsetting(playerid, params[]) {
    return cmd_caidattaikhoan(playerid, params);
}
CMD:caidattaikhoan(playerid, params[]) {
    if(g_PlayerLogged[playerid]) {
        new 
            vstring[4096],
            estring[4096];

        format(vstring, sizeof(vstring), "Danh muc\tTrang thai\n");
        format(vstring, sizeof(vstring), "%sSo dien thoai:\t%s\n", vstring, GetPlayerPhoneNumber(playerid));
        format(vstring, sizeof(vstring), "%sHo va ten:\t%s\n", vstring, GetPlayerOOCName(playerid));
        format(vstring, sizeof(vstring), "%sDia chi:\t%s\n", vstring, GetPlayerOOCAddress(playerid));
        format(vstring, sizeof(vstring), "%sCan cuoc cong dan\t%s\n", vstring, GetPlayerOOCCCCD(playerid));
        format(vstring, sizeof(vstring), "%sMa dang nhap\t%s\n", vstring, GetPlayerSecurityStatus(playerid));
        format(vstring, sizeof(vstring), "%sNgon ngu\t%s\n", vstring, GetPlayerLanguage(playerid));

        format(estring, sizeof(estring), "Category\tStatus\n");
        format(estring, sizeof(estring), "%s(R) Phone Number:\t%s\n", estring, GetPlayerPhoneNumber(playerid));
        format(estring, sizeof(estring), "%s(R) Full name:\t%s\n", estring, GetPlayerOOCName(playerid));
        format(estring, sizeof(estring), "%s(R) Address:\t%s\n", estring, GetPlayerOOCAddress(playerid));
        format(estring, sizeof(estring), "%s(R) Identifier\t%s\n", estring, GetPlayerOOCCCCD(playerid));
        format(estring, sizeof(estring), "%s(G) Login code\t%s\n", estring, GetPlayerSecurityStatus(playerid));
        format(estring, sizeof(estring), "%s(G) Language\t%s\n", estring, GetPlayerLanguage(playerid));

        ShowPlayerDialog(playerid, ACCOUNTSETTING, DIALOG_STYLE_TABLIST_HEADERS, "Cai dat tai khoan", vstring, "Chon","Huy");
        if(ENG(playerid)) return ShowPlayerDialog(playerid, ACCOUNTSETTING, DIALOG_STYLE_TABLIST_HEADERS, "Account Setting", estring, "Choose","Cancel");
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban can dang nhap vao client truoc khi lam dieu nay!");
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    switch(dialogid) {
        case ACCOUNTSETTING: {
            if(!response) {}
            else {
                switch(listitem) {
                    case 0: {
                        ShowPlayerDialog(playerid, REALPHONEINPUT, DIALOG_STYLE_INPUT, "So dien thoai", "Hay nhap so dien thoai ben ngoai cua ban vao day:", "Nhap", "Huy");
                        if(ENG(playerid)) return ShowPlayerDialog(playerid, REALPHONEINPUT, DIALOG_STYLE_INPUT, "(R) Phone number", "Please enter your phone number below:", "Send", "Cancel");
                    }
                    case 1: {
                        ShowPlayerDialog(playerid, REALNAMEINPUT, DIALOG_STYLE_INPUT, "Ho va ten", "Hay nhap ten that cua ban vao day (VD: Tang Long):", "Nhap", "Huy");
                        if(ENG(playerid)) return ShowPlayerDialog(playerid, REALNAMEINPUT, DIALOG_STYLE_INPUT, "(R) Full name", "Please enter your phone number below (Ex: Tang Long):", "Send", "Cancel");
                    }
                    case 2: {
                        ShowPlayerDialog(playerid, REALADDRESSINPUT, DIALOG_STYLE_INPUT, "Dia chi", "Hay nhap dia chi thuong tru cua ban vao day:\n\
                        (VD: So nha, To/Ap/Khu pho, Phuong, Thanh pho, Tinh):", "Nhap", "Huy");
                        if(ENG(playerid)) return ShowPlayerDialog(playerid, REALADDRESSINPUT, DIALOG_STYLE_INPUT, "(R) Address", "Please enter your address below:\n\
                        (Ex: House No. / Block / Ward / City / Province):", "Send", "Cancel");
                    }
                    case 3: {
                        ShowPlayerDialog(playerid, REALCCCDINPUT, DIALOG_STYLE_INPUT, "Can cuoc cong dan", "Hay nhap ma can cuoc cong dan hoac chung minh thu cua ban:", "Nhap", "Huy");
                        if(ENG(playerid)) return ShowPlayerDialog(playerid, REALCCCDINPUT, DIALOG_STYLE_INPUT, "(R) Identifier", "Please enter your identifier code below:", "Send", "Cancel");
                    }
                    case 4: {
                        ShowPlayerDialog(playerid, SECURITYSETTING, DIALOG_STYLE_LIST, "Ma dang nhap", "Mo\nTat", "Chon", "Huy");
                        if(ENG(playerid)) return ShowPlayerDialog(playerid, SECURITYSETTING, DIALOG_STYLE_LIST, "(G) Login code", "Turn on\nTurn off", "Choose", "Cancel");
                    }
                    case 5: {
                        ShowPlayerDialog(playerid, LANGSETTING, DIALOG_STYLE_LIST, "Ngon ngu", "Tieng Viet\nTieng Anh (English)", "Chon", "Huy");
                        if(ENG(playerid)) return ShowPlayerDialog(playerid, LANGSETTING, DIALOG_STYLE_LIST, "(G) Language", "Tieng Viet (Vietnamese)\nTieng Anh (English)", "Choose", "Cancel");
                    }
                }
            }
        }
        case REALPHONEINPUT: {
            if(!response) {}
            else {
                if(PlayerInfo[playerid][pPhoneNumber] != 0) {
                    if(VIE(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[THONG TIN TAI KHOAN] {FFFFFF}Vui long lien he BQT de chinh sua lai so dien thoai.");
                    if(ENG(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[USER INFORMATION] {FFFFFF}Please contact GM+ to edit your phone number.");
                }
                else {
                    if(IsNumeric(inputtext) && strlen(inputtext) > 5 && strlen(inputtext) <= 15) {
                        SetPVarString(playerid, "pPhone", inputtext);
                        PlayerInfo[playerid][pPhoneNumber] = 1;
                        new 
                            query[300],
                            sizePhone[60],
                            vstring[356],
                            estring[356],
                            szLog[256];
                        GetPVarString(playerid, "pPhone", sizePhone, sizeof(sizePhone));
                        mysql_format(MainPipeline, query, sizeof(query), "UPDATE `accounts` SET `RealPhone` = %d, `OOCPhone` = '%s' WHERE `Username` = '%e'", PlayerInfo[playerid][pPhoneNumber], sizePhone, GetPlayerNameEx(playerid));
                        mysql_tquery(MainPipeline, query);
                        format(szLog, sizeof(szLog), "%s da cap nhat so dien thoai cua minh thanh %s.", GetPlayerNameEx(playerid), sizePhone);
                        Critical(szLog);
                        Log("logs/protect/accountsetting.log", szLog);
                        format(vstring, sizeof(vstring), "{0091FF}[THONG TIN TAI KHOAN] {FFFFFF}So dien thoai cua ban da cap nhat thanh {FF0000}(+84)%s{FFFFFF}.", sizePhone);
                        format(estring, sizeof(estring), "{0091FF}[USER INFORMATION] {FFFFFF}Your phone number has updated {FF0000}(+84)%s{FFFFFF}.", sizePhone);
                        if(VIE(playerid)) return SendClientMessage(playerid, COLOR_WHITE, vstring);
                        if(ENG(playerid)) return SendClientMessage(playerid, COLOR_WHITE, estring);
                    }
                    else {
                        ShowPlayerDialog(playerid, REALPHONEINPUT, DIALOG_STYLE_INPUT, "So dien thoai", "Hay nhap so dien thoai ben ngoai cua ban vao day:", "Nhap", "Huy");
                        if(ENG(playerid)) return ShowPlayerDialog(playerid, REALPHONEINPUT, DIALOG_STYLE_INPUT, "(R) Phone number", "Please enter your phone number below:", "Send", "Cancel");
                    }
                }
            }
        }
        case REALNAMEINPUT: {
            if(!response) {}
            else {
                if(PlayerInfo[playerid][pRealName] == 0) {
                    if(!IsNumeric(inputtext) && strlen(inputtext) > 5 && strlen(inputtext) <= 35) {
                        SetPVarString(playerid, "pRealName", inputtext);
                        new
                            query[300],
                            sizeName[60],
                            vstring[356],
                            estring[356],
                            szLog[256];
                        GetPVarString(playerid, "pRealName", sizeName, sizeof(sizeName));
                        PlayerInfo[playerid][pRealName] = 1;
                        mysql_format(MainPipeline, query, sizeof(query), "UPDATE `accounts` SET `RealName` = %d, `OOCName` = '%s' WHERE `Username` = '%e'", PlayerInfo[playerid][pRealName], sizeName, GetPlayerNameEx(playerid));
                        mysql_tquery(MainPipeline, query);
                        format(szLog, sizeof(szLog), "%s da cap nhat ten chinh chu cua minh thanh %s.", GetPlayerNameEx(playerid), sizeName);
                        Critical(szLog);
                        Log("logs/protect/accountsetting.log", szLog);
                        format(vstring, sizeof(vstring), "{0091FF}[THONG TIN TAI KHOAN] {FFFFFF}Ten cua ban da duoc cap nhat thanh {FF0000}%s{FFFFFF}.", sizeName);
                        format(estring, sizeof(estring), "{0091FF}[USER INFORMATION] {FFFFFF}Your name has updated {FF0000}%s{FFFFFF}.", sizeName);
                        if(VIE(playerid)) return SendClientMessage(playerid, COLOR_WHITE, vstring);
                        if(ENG(playerid)) return SendClientMessage(playerid, COLOR_WHITE, estring);
                    }
                    else {
                        ShowPlayerDialog(playerid, REALNAMEINPUT, DIALOG_STYLE_INPUT, "Ho va ten", "Hay nhap ten that cua ban vao day (VD: Tang Long):", "Nhap", "Huy");
                        if(ENG(playerid)) return ShowPlayerDialog(playerid, REALNAMEINPUT, DIALOG_STYLE_INPUT, "(R) Full name", "Please enter your phone number below (Ex: Tang Long):", "Send", "Cancel");
                    }
                }
                else {
                    if(VIE(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[THONG TIN TAI KHOAN] {FFFFFF}Vui long lien he BQT de chinh sua lai ten that.");
                    if(ENG(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[USER INFORMATION] {FFFFFF}Please contact GM+ to edit your real name.");
                }
            }
        }
        case REALADDRESSINPUT: {
            if(!response) {

            }
            else {
                if(PlayerInfo[playerid][pRealAddress] != 0) {
                    if(VIE(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[THONG TIN TAI KHOAN] {FFFFFF}Vui long lien he BQT de chinh sua lai dia chi thuong tru.");
                    if(ENG(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[USER INFORMATION] {FFFFFF}Please contact GM+ to edit your address.");
                }
                else {
                    if(!IsNumeric(inputtext) && strlen(inputtext) > 5) {
                        SetPVarString(playerid, "pRealAddress", inputtext);
                        new
                            query[450],
                            sizeAddress[100],
                            vstring[300],
                            estring[300],
                            szLog[256];
                        PlayerInfo[playerid][pRealAddress] = 1;
                        GetPVarString(playerid, "pRealAddress", sizeAddress, sizeof(sizeAddress));
                        mysql_format(MainPipeline, query, sizeof(query), "UPDATE `accounts` SET `RealAddress` = %d, `OOCAddress` = '%s' WHERE `Username` = '%e'", PlayerInfo[playerid][pRealAddress], sizeAddress, GetPlayerNameEx(playerid));
                        mysql_tquery(MainPipeline, query);
                        format(szLog, sizeof(szLog), "%s da cap nhat dia chi thuong tru cua minh thanh %s.", GetPlayerNameEx(playerid), sizeAddress);
                        Critical(szLog);
                        Log("logs/protect/accountsetting.log", szLog);
                        format(vstring, sizeof(vstring), "{0091FF}[THONG TIN TAI KHOAN] {FFFFFF}Dia chi cua ban da duoc cap nhat thanh {FF0000}%s{FFFFFF}.", sizeAddress);
                        format(estring, sizeof(estring), "{0091FF}[USER INFORMATION] {FFFFFF}Your address has updated {FF0000}%s{FFFFFF}.", sizeAddress);
                        if(VIE(playerid)) return SendClientMessage(playerid, COLOR_WHITE, vstring);
                        if(ENG(playerid)) return SendClientMessage(playerid, COLOR_WHITE, estring);
                    }
                    else {
                        ShowPlayerDialog(playerid, REALADDRESSINPUT, DIALOG_STYLE_INPUT, "Dia chi", "Hay nhap dia chi thuong tru cua ban vao day:\n\
                        (VD: So nha, To/Ap/Khu pho, Phuong, Thanh pho, Tinh):", "Nhap", "Huy");
                        if(ENG(playerid)) return ShowPlayerDialog(playerid, REALADDRESSINPUT, DIALOG_STYLE_INPUT, "(R) Address", "Please enter your address below:\n\
                        (Ex: House No. / Block / Ward / City / Province):", "Send", "Cancel");
                    }
                }
            }
        }
        case REALCCCDINPUT: {
            if(!response) {}
            else {
                if(PlayerInfo[playerid][pCCCD] != 0) {
                    if(VIE(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[THONG TIN TAI KHOAN] {FFFFFF}Vui long lien he BQT de chinh sua lai thong tin can cuoc.");
                    if(ENG(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[USER INFORMATION] {FFFFFF}Please contact GM+ to edit your identifier code.");
                }
                else {
                    if(IsNumeric(inputtext) && strlen(inputtext) > 5 && strlen(inputtext) <= 13) {
                        SetPVarString(playerid, "pCCCD", inputtext);
                        new
                            query[300],
                            sizeCCCD[60],
                            vstring[300],
                            estring[300],
                            szLog[256];
                        GetPVarString(playerid, "pCCCD", sizeCCCD, sizeof(sizeCCCD));
                        PlayerInfo[playerid][pCCCD] = 1;
                        mysql_format(MainPipeline, query, sizeof(query), "UPDATE `accounts` SET `RealCCCD` = %d, `OOCCCCD` = '%s' WHERE `Username` = '%s'", PlayerInfo[playerid][pCCCD], sizeCCCD, GetPlayerNameEx(playerid));
                        mysql_tquery(MainPipeline, query);
                        format(szLog, sizeof(szLog), "%s da cap nhat ma CCCD cua minh thanh %s.", GetPlayerNameEx(playerid), sizeCCCD);
                        Critical(szLog);
                        Log("logs/protect/accountsetting.log", szLog);
                        format(vstring, sizeof(vstring), "{0091FF}[THONG TIN TAI KHOAN] {FFFFFF}Ma so can cuoc cua ban da duoc cap nhat thanh {FF0000}%s{FFFFFF}.", sizeCCCD);
                        format(estring, sizeof(estring), "{0091FF}[USER INFORMATION] {FFFFFF}Your identifier code has updated {FF0000}%s{FFFFFF}.", sizeCCCD);
                        if(VIE(playerid)) return SendClientMessage(playerid, COLOR_WHITE, vstring);
                        if(ENG(playerid)) return SendClientMessage(playerid, COLOR_WHITE, estring);
                    }
                    else {
                        ShowPlayerDialog(playerid, REALCCCDINPUT, DIALOG_STYLE_INPUT, "Can cuoc cong dan", "Hay nhap ma can cuoc cong dan hoac chung minh thu cua ban:", "Nhap", "Huy");
                        if(ENG(playerid)) return ShowPlayerDialog(playerid, REALCCCDINPUT, DIALOG_STYLE_INPUT, "(R) Identifier", "Please enter your identifier code below:", "Send", "Cancel");
                    }
                }
            }
        }
        case SECURITYSETTING: {
            if(!response) {

            }
            else {
                switch(listitem) {
                    case 0: {
                        if(PlayerInfo[playerid][pEnableSecurity] == 0) {
                            ShowPlayerDialog(playerid, SECURITYINPUT, DIALOG_STYLE_INPUT, "Kich hoat bao mat", "Vui long nhap ma xac thuc moi cua ban vao day (4 so):\nVD: 1975", "Nhap", "Huy");
                            if(ENG(playerid)) return ShowPlayerDialog(playerid, SECURITYINPUT, DIALOG_STYLE_INPUT, "Enable security", "Please enter your new login code below:\nEx: 1975", "Send", "Cancel");
                        }
                        else {
                            if(VIE(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[THONG TIN TAI KHOAN] {FFFFFF}Ban da kich hoat chuc nang nay roi.");
                            if(ENG(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[USER INFORMATION] {FFFFFF}You have enable this feature already.");
                        }
                    }
                    case 1: {
                        if(PlayerInfo[playerid][pEnableSecurity] != 0) {
                            PlayerInfo[playerid][pEnableSecurity] = 0;
                            if(VIE(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[THONG TIN TAI KHOAN] {FFFFFF}Ban da ngung kich hoat chuc nang bao mat 4 so.");
                            if(ENG(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[USER INFORMATION] {FFFFFF}The 4-digit security code has been deactived.");
                        }
                        else {
                            if(VIE(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[THONG TIN TAI KHOAN] {FFFFFF}Ban can kich hoat roi moi co the tat.");
                            if(ENG(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[USER INFORMATION] {FFFFFF}You need to enable this feature before deactivating it.");
                        }
                    }
                }
            }
        }
        case SECURITYINPUT: {
            if(!response) {}
            else {
                if(IsNumeric(inputtext)) {
                    if(strlen(inputtext) == 4) {
                        SetPVarString(playerid, "pSecurity", inputtext);
                        new
                            query[300],
                            sizeSecurity[10],
                            vstring[256],
                            estring[256];
                        PlayerInfo[playerid][pEnableSecurity] = 1;
                        GetPVarString(playerid, "pSecurity", sizeSecurity, sizeof(sizeSecurity));
                        mysql_format(MainPipeline, query, sizeof(query), "UPDATE `accounts` SET `EnableSecurity` = %d, `Security` = '%s' WHERE `Username` = '%e'", PlayerInfo[playerid][pEnableSecurity], sizeSecurity, GetPlayerNameEx(playerid));
                        mysql_tquery(MainPipeline, query);
                        format(vstring, sizeof(vstring), "{0091FF}[THONG TIN TAI KHOAN] {FFFFFF}Ban da cap nhat ma bao mat (4 so cua minh thanh) {FF0000}%s{FFFFFF}.", sizeSecurity);
                        format(estring, sizeof(estring), "{0091FF}[USER INFORMATION] {FFFFFF}Your login code (4-digit of you) updated {FF0000}%s{FFFFFF}.", sizeSecurity);
                        if(VIE(playerid)) return SendClientMessage(playerid, COLOR_WHITE, vstring);
                        if(ENG(playerid)) return SendClientMessage(playerid, COLOR_WHITE, estring);
                    }
                    else {
                        if(VIE(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[THONG TIN TAI KHOAN] {FFFFFF}Vui long chi nhap do dai la 4.");
                        if(ENG(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[USER INFORMATION] {FFFFFF}Please enter exactly 4 characters.");
                    }
                }
                else {
                    if(VIE(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[THONG TIN TAI KHOAN] {FFFFFF}Vui long chi nhap ma 4 so.");
                    if(ENG(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "{0091FF}[USER INFORMATION] {FFFFFF}Please enter extractly 4 characters.");
                }
            }
        }
    }
    return 1;
}

hook OnPlayerConnect(playerid) {
    DeletePVar(playerid, "pPhone");
    DeletePVar(playerid, "pRealName");
    DeletePVar(playerid, "pRealAddress");
    DeletePVar(playerid, "pCCCD");
    DeletePVar(playerid, "pSecurity");
    return 1;
}

stock GetPlayerPhoneNumber(playerid) {
    if(PlayerInfo[playerid][pPhoneNumber] >= 0 && VIE(playerid)) {
        switch(PlayerInfo[playerid][pPhoneNumber]) {
            case 0: szMiscArray = "Chua cap nhat";
            case 1: szMiscArray = "Da cap nhat";
            case 2: szMiscArray = "Dang tranh chap";
        }
    }

    if(PlayerInfo[playerid][pPhoneNumber] >= 0 && ENG(playerid)) {
        switch(PlayerInfo[playerid][pPhoneNumber]) {
            case 0: szMiscArray = "Not update yet";
            case 1: szMiscArray = "Updated";
            case 2: szMiscArray = "Under dispute";
        }
    }
    return szMiscArray;
}

stock GetPlayerOOCName(playerid) {
    if(PlayerInfo[playerid][pRealName] >= 0 && VIE(playerid)) {
        switch(PlayerInfo[playerid][pRealName]) {
            case 0: szMiscArray = "Chua cap nhat";
            case 1: szMiscArray = "Da cap nhat";
            case 2: szMiscArray = "Dang tranh chap";
        }
    }

    if(PlayerInfo[playerid][pRealName] >= 0 && ENG(playerid)) {
        switch(PlayerInfo[playerid][pRealName]) {
            case 0: szMiscArray = "Not update yet";
            case 1: szMiscArray = "Updated";
            case 2: szMiscArray = "Under dispute";
        }
    }
    return szMiscArray;
}

stock GetPlayerOOCAddress(playerid) {
    if(PlayerInfo[playerid][pRealAddress] >= 0 && VIE(playerid)) {
        switch(PlayerInfo[playerid][pRealAddress]) {
            case 0: szMiscArray = "Chua cap nhat";
            case 1: szMiscArray = "Da cap nhat";
            case 2: szMiscArray = "Dang tranh chap";
        }
    }

    if(PlayerInfo[playerid][pRealAddress] >= 0 && ENG(playerid)) {
        switch(PlayerInfo[playerid][pRealAddress]) {
            case 0: szMiscArray = "Not update yet";
            case 1: szMiscArray = "Updated";
            case 2: szMiscArray = "Under dispute";
        }
    }
    return szMiscArray;
}

stock GetPlayerOOCCCCD(playerid) {
    if(PlayerInfo[playerid][pCCCD] >= 0 && VIE(playerid)) {
        switch(PlayerInfo[playerid][pCCCD]) {
            case 0: szMiscArray = "Chua cap nhat";
            case 1: szMiscArray = "Da cap nhat";
            case 2: szMiscArray = "Dang tranh chap";
        }
    }

    if(PlayerInfo[playerid][pCCCD] >= 0 && ENG(playerid)) {
        switch(PlayerInfo[playerid][pCCCD]) {
            case 0: szMiscArray = "Not update yet";
            case 1: szMiscArray = "Updated";
            case 2: szMiscArray = "Under dispute";
        }
    }
    return szMiscArray;
}

stock GetPlayerSecurityStatus(playerid) {
    if(PlayerInfo[playerid][pEnableSecurity] >= 0 && VIE(playerid)) {
        switch(PlayerInfo[playerid][pEnableSecurity]) {
            case 0: szMiscArray = "Chua kich hoat";
            case 1: szMiscArray = "Da kich hoat";
        }
    }

    if(PlayerInfo[playerid][pEnableSecurity] >= 0 && ENG(playerid)) {
        switch(PlayerInfo[playerid][pEnableSecurity]) {
            case 0: szMiscArray = "Not actived yet";
            case 1: szMiscArray = "Actived";
        }
    }
    return szMiscArray;
}

stock GetPlayerLanguage(playerid) {
    if(PlayerInfo[playerid][pLang] >= 0) {
        switch(PlayerInfo[playerid][pLang]) {
            case 0: szMiscArray = "Vietnamese (VIE) ";
            case 1: szMiscArray = "English (ENG) (Pause support)";
        }
    }
    return szMiscArray;
}