#include <YSI_Coding\y_hooks>

new const VIEJobName[MAX_JOBS][] = {
    "Nguoi van chuyen"
};

new const ENGJobName[MAX_JOBS][] = {
    "Shipment"
};

new Float:JobLocation[MAX_JOBS][3] = {
    {-1562.8480,124.8993,3.5547}
};

stock GetPlayerJob(playerid) {
    return PlayerInfo[playerid][pJob];
}

stock ShowPlayerDialogJoblist(playerid) {
    new vstring[256], estring[256];
    for(new i = 0 ; i < MAX_JOBS ; i++) {
        format(vstring, sizeof(vstring), "%s\n", VIEJobName[i]);
        format(estring, sizeof(estring), "%s\n", ENGJobName[i]);
    }
    ShowPlayerDialog(playerid, JOBLIST, DIALOG_STYLE_LIST, "Cong viec", vstring, "Chon", "Huy");
    if(ENG(playerid)) return ShowPlayerDialog(playerid, JOBLIST, DIALOG_STYLE_LIST, "Job", estring, "Choose", "Cancel");
    return 1;
}