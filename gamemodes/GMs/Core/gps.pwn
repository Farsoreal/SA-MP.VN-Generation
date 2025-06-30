#include <YSI_Coding\y_hooks>

CMD:findlocation(playerid, params[]) {
    return cmd_timduong(playerid, params);
}
CMD:timduong(playerid, params[]) {
    if(g_PlayerLogged[playerid]) {
        ShowPlayerDialog(playerid, DPA, DIALOG_STYLE_LIST, "Map", "San Fierro\nLos Santos", "Chon", "Huy");
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban can dang nhap vao client truoc khi lam dieu nay!");
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    switch(dialogid) {
        case DPA: {
            if(!response) {
                return 1;
            }
            else {
                switch(listitem) {
                    case 0: {
                        ShowPlayerDialogSanFierro(playerid);
                    }
                    case 1: {
                        ShowPlayerDialogLosSantos(playerid);
                    }
                }
            }
        }
        case DPA2: {
            if(!response) {
                return 1;
            }
            else {
                switch(listitem) {
                    case 0: {
                        ShowPlayerDialogJoblist(playerid);
                    }
                    case 1: {
                        ShowPlayerDialogHospitalList(playerid);
                    }
                }
            }
        }
        case JOBLIST: {
            if(!response) {
                return 1;
            }
            else {
                SetPlayerCheckpoint(playerid, JobLocation[listitem][0], JobLocation[listitem][1], JobLocation[listitem][2], 5.0);
                SendClientMessage(playerid, COLOR_YELLOW, "Ban hay di den dia diem duoc danh dau tren ban do.");
            }
        }
        case HOSPITALLIST: {
            if(!response) {
                return 1;
            }
            else {
                switch(listitem) {
                    case 0: {
                        SetPlayerCheckpoint(playerid, -2654.2036,613.1639,14.4531, 5.0);
                        SendClientMessage(playerid, COLOR_YELLOW, "Ban hay di den dia diem duoc danh dau tren ban do.");
                    }
                }
            }
        }
    }
    return 1;
}

stock ShowPlayerDialogSanFierro(playerid) {
    new
        vstring[256],
        estring[256];
    format(vstring, sizeof(vstring),
    "Cong viec\nBenh vien\nTrung tam sat hach\nTrung tam thuong mai\nVIP\nTru so CA/QD\n");
    format(estring, sizeof(estring),
    "Job\nHospital\nDriving test center\nMarket center\nVIP\nPolice / Army headquarters\n");
    ShowPlayerDialog(playerid, DPA2, DIALOG_STYLE_LIST, "San Fierro", vstring, "Chon", "Huy");
    if(ENG(playerid)) return ShowPlayerDialog(playerid, DPA2, DIALOG_STYLE_LIST, "San Fierro", estring, "Choose", "Cancel");
    return 1;
}

stock ShowPlayerDialogLosSantos(playerid) {
    new
        vstring[256],
        estring[256];
    format(vstring, sizeof(vstring),
    "Cong viec\nBenh vien\nTrung tam sat hach\nTrung tam thuong mai\nVIP\nTru so CA/QD\n");
    format(estring, sizeof(estring),
    "Job\nHospital\nDriving test center\nMarket center\nVIP\nPolice / Army headquarters\n");
    ShowPlayerDialog(playerid, DPA3, DIALOG_STYLE_LIST, "Los Santos", vstring, "Chon", "Huy");
    if(ENG(playerid)) return ShowPlayerDialog(playerid, DPA3, DIALOG_STYLE_LIST, "Los Santos", estring, "Choose", "Cancel");
    return 1;
}

stock ShowPlayerDialogHospitalList(playerid) {
    new vstring[256];
    format(vstring, sizeof(vstring), "Santa Flora (SF)\n");
    ShowPlayerDialog(playerid, HOSPITALLIST, DIALOG_STYLE_LIST, "Benh vien", vstring, "Chon", "Huy");
}