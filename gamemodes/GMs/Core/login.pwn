public ShowMainMenu(playerid, resultid) {
    new
        vtitlestring[64],
        vstring[120],
        etitlestring[64],
        estring[120];
    switch(resultid) {
        case 1: {
            format(vtitlestring, sizeof(vtitlestring), "Dang nhap - %s", GetPlayerNameEx(playerid));
            format(vstring, sizeof(vstring),
            "Ban da co tai khoan tai RGAME.MP\n\nHay nhap mat khau ben duoi de dang nhap:");
            if(PassAttemp[playerid] != 0) strcat(vstring, "\n\nMat khau ban nhap vao khong dung!");

            format(etitlestring, sizeof(etitlestring), "Login - %s", GetPlayerNameEx(playerid));
            format(estring, sizeof(estring),
            "You already have an account.\n\nPlease enter your password below to log in:");
            if(PassAttemp[playerid] != 0) strcat(estring, "\n\nWrong password! enter your password again!");

            ShowPlayerDialog(playerid, MAINMENU, DIALOG_STYLE_INPUT, vtitlestring, vstring, "Dang nhap", "Huy");
            if(ENG(playerid)) return ShowPlayerDialog(playerid, MAINMENU, DIALOG_STYLE_INPUT, etitlestring, estring, "Login", "Cancel");
        }
        case 2: {
            format(vtitlestring, sizeof(vtitlestring), "Dang ki - %s", GetPlayerNameEx(playerid));
            format(vstring, sizeof(vstring),
            "Ban chua co tai khoan tai RGAME.MP\n\nHay nhap mat khau ben duoi de dang ki:");

            format(etitlestring, sizeof(etitlestring), "Register - %s", GetPlayerNameEx(playerid));
            format(estring, sizeof(estring),
            "You not yet account at RGAME.MP\n\nPlease enter your password below to register in:");

            ShowPlayerDialog(playerid, MAINMENU2, DIALOG_STYLE_INPUT, vtitlestring, vstring, "Dang ki", "Huy");
            if(ENG(playerid)) return ShowPlayerDialog(playerid, MAINMENU2, DIALOG_STYLE_INPUT, etitlestring, estring, "Register", "Cancel");
        }
    }
    return 1;
}