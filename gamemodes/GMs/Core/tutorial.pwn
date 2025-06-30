#include <YSI_Coding\y_hooks>

public AdvancedTutorial(playerid) { // Camera
    ClearChatbox(playerid);
    Join_Camera(playerid);
    return 1;
}

public _TutorialRepeat(playerid) {
    if(GetPVarInt(playerid, "_TutorialTimer") > 0) {
        SetPVarInt(playerid, "_TutorialTimer", GetPVarInt(playerid, "_TutorialTimer")-1);
        JoinTutorial(playerid);
    }
    else {
        KillTimer(_TimeRepeat[playerid]);
    }
    return 1;
}

JoinTutorial(playerid) {
    new countstring[64];
    if(GetPVarInt(playerid, "_TutorialTimer") == 0) {
        format(countstring, sizeof(countstring), "Tiep tuc");
    }
    else {
        valstr(countstring, GetPVarInt(playerid, "_TutorialTimer"));
    }
    switch(PlayerInfo[playerid][pTut]) {
        case 0: {
            format(szMiscArray, sizeof(szMiscArray), "{FFFFFF}Chao mung den voi {FF0000}RGAME.MP - Revolution Gaming Network Multiplayer{FFFFFF}.\n");
            strcat(szMiscArray, "Day la mot cong dong nhap vai the gioi mo, noi ban se toa sang theo cach cua rieng ban.\n");
            strcat(szMiscArray, "Ban se nhap vai la mot cong dan, mot canh sat hoac hay hon nua tro thanh mot phan cua chung toi.\n");
            strcat(szMiscArray, "Khong kho de co the thong thao nhap vai, chi can su co gang no luc cua ban tung ngay.\n");
            strcat(szMiscArray, "Co rat nhieu lenh huu ich chang han nhu {F7E411}/b {FFFFFF}de noi ve nhung thu ngoai doi, {F7E411}/me {FFFFFF}de dien ta hanh dong cua nhan vat v.v...\n");
            strcat(szMiscArray, "Se co rat nhieu luat le de dam bao cong bang cho moi nguoi va han che xu huong phat trien bao luc cua game.\n");
            strcat(szMiscArray, "Bat ki nguoi choi nao tham chi la nhan vien cua chung toi cung se bi xu phat that nang neu vi pham luat, anh huong den cong dong.\n");
            strcat(szMiscArray, "Moi van de khieu nai xin ban hay chuyen ve {F7E411}discord.rgame.mp {FFFFFF}hoac {F7E411}4r.rgame.mp {FFFFFF}de duoc thu ly va giai quyet.");

            ShowPlayerDialog(playerid, TUTORIAL, DIALOG_STYLE_MSGBOX, "RGAME.MP - Gioi thieu chung", szMiscArray, countstring, "");
        }
        case 1: {
            format(szMiscArray, sizeof(szMiscArray), "{FF0000}Metagaming (MG){FFFFFF}: Su dung thong tin OOC (ngoai doi) de tron vao trong game (IC) gay anh huong den qua trinh nhap vai.\n");
            strcat(szMiscArray, "{FF0000}Powergaming (PG){FFFFFF}: Ao tuong suc manh cua ban than, lam nhung viec hau nhu khong ai dam lam.\n");
            strcat(szMiscArray, "{FF0000}Killing On Sight (KOS){FFFFFF}: Tan cong nguoi choi khac ma khong co ly do nhap vai thich hop.\n");
            strcat(szMiscArray, "{FF0000}Deathmatching (DM){FFFFFF}: Tuong tu nhu Killing On Sight nhung khac o cho day la tan cong nguoi khac ma khong co ly do chinh dang.\n");
            strcat(szMiscArray, "{FF0000}Bunny Hopping (BH){FFFFFF}: Nhay lien tuc ma cam giac khong thay met.\n");
            strcat(szMiscArray, "{FF0000}Y thuc toi thieu{FFFFFF}: Vi pham y thuc nghiem trong gay anh huong den nguoi choi khac.");
            
            ShowPlayerDialog(playerid, TUTORIAL, DIALOG_STYLE_MSGBOX, "RGAME.MP - Luat le", szMiscArray, countstring, "");
        }
        case 2: {
            format(szMiscArray, sizeof(szMiscArray), "{FFFFFF}Tai {FF0000}RGAME.MP{FFFFFF}, ban se duoc tan tinh giup do neu nhu gap bat ki kho khan nao.\n");
            strcat(szMiscArray, "RGAME.MP duoc sang lap boi mot nguoi choi lau nam (12 nam) voi nhieu goc nhin va kinh nghiem tich luy khac nhau.\n");
            strcat(szMiscArray, "Ban se duoc dam bao ve quyen loi va bao ve tuyet doi, dac biet chung toi huong toi mot cong dong phi loi nhuan.\n");
            strcat(szMiscArray, "Neu co bat ki kho khan nao, hay su dung {F7E411}/newb {FFFFFF}hoac {F7E411}/yeucautrogiup {FFFFFF}de duoc giup do.\n");
            strcat(szMiscArray, "Cong dong {FF0000}RGAME.MP {FFFFFF}duy tri lien tuc va se co gang ho tro ban 15/24.");

            ShowPlayerDialog(playerid, TUTORIAL, DIALOG_STYLE_MSGBOX, "RGAME.MP - Ho tro", szMiscArray, countstring, "");
        }
        case 3: {
            format(szMiscArray, sizeof(szMiscArray), "{FFFFFF}Huong dan ban giai quyet mot so tinh huong neu vo tinh gap phai:\n");
            strcat(szMiscArray, "Neu ban bi nguoi choi khac tan cong hay nop don tren {F7E411}4r.rgame.mp {FFFFFF}va cho doi giai quyet.\n");
            strcat(szMiscArray, "Ket qua duoc minh bach va cong bo boi BQT hoac STAFF duoc giao quyen. Neu co khieu nai hay gui ve muc to cao staff.\n");
            strcat(szMiscArray, "Ket qua to cao staff se duoc hoi dong cao nhat cua may chu tham dinh, neu sai sot ban se duoc den bu va xu ly nguoi vi pham.\n");
            strcat(szMiscArray, "Thoi han giai quyet cac don to cao dao dong it nhat tu 1 va toi da khong qua 15 ngay (doi voi hack/cheats, gia han them neu co).\n");
            
            ShowPlayerDialog(playerid, TUTORIAL, DIALOG_STYLE_MSGBOX, "RGAME.MP - Ho tro", szMiscArray, countstring, "");
        }
        case 4: {
            format(szMiscArray, sizeof(szMiscArray), "{FFFFFF}Neu ban bi that thoat tai san (hay goi la rollback) hay giai quyet theo cach nay:\n");
            strcat(szMiscArray, "Cach 1. Truy cap dien dan va nop don yeu cau den bu, ban se duoc Shop Technican kiem tra log va refund.\n");
            strcat(szMiscArray, "Cach 2. Lien he discord {F7E411}kelvingamer {FFFFFF}va nhan tin de duoc ho tro giai quyet nhanh nhat.\n");
            strcat(szMiscArray, "De duoc giai quyet, ban can co bang chung so huu hoac cung cap it nhat 1 thong tin ban nho.\n");
            strcat(szMiscArray, "Neu khong cung cap duoc thong tin thi phai cho kiem tra log, thoi gian toi da 1 tuan.\n");
            strcat(szMiscArray, "Neu viec that thoat lam anh huong nghiem trong den trai nghiem cua ban thi ban se duoc den bu phan tram.");

            ShowPlayerDialog(playerid, TUTORIAL, DIALOG_STYLE_MSGBOX, "RGAME.MP - Ho tro", szMiscArray, countstring, "");
        }
        case 5: {
            SetPlayerVirtualWorld(playerid, playerid + 1);
            PlayerAdjust(playerid);
        }
    }
    return szMiscArray;
}

Join_Camera(playerid) {
    switch(PlayerInfo[playerid][pTut]) {
        case 0: {
            InterpolateCameraPos(playerid, 1066.595825, -96.770256, 27.016403, 932.036193, -91.064292, 27.294929, 15000, CAMERA_MOVE); // Red Country
            InterpolateCameraLookAt(playerid, 1061.718261, -97.867866, 26.946874, 927.036254, -91.048110, 27.305606, 15000, CAMERA_MOVE);

            KillTimer(_TimeRepeat[playerid]);
            SetPVarInt(playerid, "_TutorialTimer", 10);
            _TimeRepeat[playerid] = SetTimerEx("_TutorialRepeat", 1000, true, "d", playerid);
            JoinTutorial(playerid);
        }
        case 1: {
            InterpolateCameraPos(playerid, 932.036193, -91.064292, 27.294929, 828.854553, -112.196945, 31.050434, 15000, CAMERA_MOVE); // Red Country
            InterpolateCameraLookAt(playerid, 927.039611, -90.956588, 27.445947, 824.650817, -114.903213, 30.980905, 15000, CAMERA_MOVE);
            
            KillTimer(_TimeRepeat[playerid]);
            SetPVarInt(playerid, "_TutorialTimer", 10);
            _TimeRepeat[playerid] = SetTimerEx("_TutorialRepeat", 1000, true, "d", playerid);
            JoinTutorial(playerid);
        }
        case 2: {
            InterpolateCameraPos(playerid, 79.032135, -1702.207763, 60.489837, 567.667907, -1753.242309, 57.028354, 15000, CAMERA_MOVE); // Beach
            InterpolateCameraLookAt(playerid, 84.010177, -1702.657104, 60.620811, 572.590515, -1754.108886, 57.159328, 15000, CAMERA_MOVE);

            KillTimer(_TimeRepeat[playerid]);
            SetPVarInt(playerid, "_TutorialTimer", 10);
            _TimeRepeat[playerid] = SetTimerEx("_TutorialRepeat", 1000, true, "d", playerid);
            JoinTutorial(playerid);
        }
        case 3: {
            InterpolateCameraPos(playerid, 725.810424, -1672.578369, 1.781461, 724.410095, -1907.170043, 3.967868, 15000, CAMERA_MOVE); // Maria
            InterpolateCameraLookAt(playerid, 725.703186, -1677.577148, 1.768319, 724.423156, -1912.167846, 4.115122, 15000, CAMERA_MOVE);

            KillTimer(_TimeRepeat[playerid]);
            SetPVarInt(playerid, "_TutorialTimer", 10);
            _TimeRepeat[playerid] = SetTimerEx("_TutorialRepeat", 1000, true, "d", playerid);
            JoinTutorial(playerid);
        }
        case 4: {
            InterpolateCameraPos(playerid, 1475.692871, -1772.157714, 58.681659, 1501.429565, -1602.902465, 42.404838, 15000, CAMERA_MOVE); // LSPD
            InterpolateCameraLookAt(playerid, 1478.423706, -1768.372680, 56.888404, 1504.091430, -1606.898803, 41.010551, 15000, CAMERA_MOVE);

            KillTimer(_TimeRepeat[playerid]);
            SetPVarInt(playerid, "_TutorialTimer", 10);
            _TimeRepeat[playerid] = SetTimerEx("_TutorialRepeat", 1000, true, "d", playerid);
            JoinTutorial(playerid);
        }
        case 5: {
            InterpolateCameraPos(playerid, 724.872619, -1988.570190, 5.087190, 728.436523, -1500.954711, 2.680446, 15000, CAMERA_MOVE);
            InterpolateCameraLookAt(playerid, 725.021118, -1983.574584, 4.937473, 726.318176, -1496.428833, 2.510686, 15000, CAMERA_MOVE);

            KillTimer(_TimeRepeat[playerid]);
            DeletePVar(playerid, "_TutorialTimer");
            JoinTutorial(playerid);
            JoinActor(playerid, PlayerInfo[playerid][pModel]);
        }
    }
    return 1;
}

JoinActor(playerid, skinid) {
    new id;
    id = GetPVarInt(playerid, "pActor");
    DestroyActor(id);
    SetPVarInt(playerid, "pActor", id);
    id = CreateActor(skinid, 722.6266,-1494.5594,3.4223,269.1425);
    SetActorVirtualWorld(id, playerid + 1);
    return 1;
}

PlayerAdjust(playerid) {
    new string[300];
    format(string, sizeof(string),
    "Nhan vat\t%s\n\
    Sinh nhat\t%s\n\
    Gioi tinh\t%s\n\
    Trang phuc\t%d\n\
    Quoc tich\t%s\n\
    Khoi tao",
    GetPlayerNameEx(playerid),
    PlayerInfo[playerid][pBirthday],
    GetPlayerSex(playerid),
    PlayerInfo[playerid][pModel],
    GetPlayerNation(playerid));
    ShowPlayerDialog(playerid, PLAYER_ADJUST, DIALOG_STYLE_TABLIST, "RGAME.MP - Nhan vat", string, "Lua chon","");
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    switch(dialogid) {
        case TUTORIAL: {
            switch(PlayerInfo[playerid][pTut]) {
                case 0.. 4: {
                    if(GetPVarInt(playerid, "_TutorialTimer") != 0) {
                        JoinTutorial(playerid);
                    }
                    else {
                        PlayerInfo[playerid][pTut]++;
                        Join_Camera(playerid);
                    }
                }
            }
        }
        case PLAYER_ADJUST: {
            if(response) {
                switch(listitem) {
                    case 0: {
                        PlayerAdjust(playerid);
                    }
                    case 1: {
                        new string[256];
                        format(string, sizeof(string),
                        "Ngay 1\nNgay 2\nNgay 3\nNgay 4\nNgay 5\nNgay 6\nNgay 7\nNgay 8\nNgay 9\nNgay 10\n\
                        Ngay 11\nNgay 12\nNgay 13\nNgay 14\nNgay 15\nNgay 16\nNgay 17\nNgay 18\nNgay 19\nNgay 20\n\
                        Ngay 21\nNgay 22\nNgay 23\nNgay 24\nNgay 25\nNgay 26\nNgay 27\nNgay 28\nNgay 29\nNgay 30\nNgay 31");
                        ShowPlayerDialog(playerid, BIRTHDAY_DAY, DIALOG_STYLE_LIST, "Ngay sinh", string, "Trang 1/3","");
                    }
                    case 2: {
                        ShowPlayerDialog(playerid, GENDER_SELECT, DIALOG_STYLE_LIST, "Gioi tinh", "Nam\nNu\nLGBT", "Lua chon","");
                    }
                    case 3: {
                        ShowPlayerDialog(playerid, MODEL_SELECT, DIALOG_STYLE_INPUT, "Ma trang phuc", "Nhap ID trang phuc yeu thich cua ban vao day", "Nhap","");
                    }
                    case 4: {
                        ShowPlayerDialog(playerid, NATION_SELECT, DIALOG_STYLE_LIST, "Quoc tich", "San Fierro\nLos Santos\nBayes", "Lua chon","");
                    }
                    case 5: {
                        if(GetPVarInt(playerid, "Birthday_Year") != 0 && PlayerInfo[playerid][pGender] != 0 && PlayerInfo[playerid][pNation] != 0) {
                            SendClientMessage(playerid, COLOR_WHITE, "Ban da dang ki thanh cong!");
                            PlayerInfo[playerid][pReg]++;
                            PlayerInfo[playerid][pVW] = 0;
                            OnPlayerLoad(playerid);

                            new id;
                            id = GetPVarInt(playerid, "pActor");
                            DestroyActor(id);
                        }
                        else {
                            PlayerAdjust(playerid);
                        }
                    }
                }
            }
            else {
                PlayerAdjust(playerid);
            }
        }
        case BIRTHDAY_DAY: {
            if(response) {
                SetPVarInt(playerid, "Birthday_Day", listitem + 1);
                new string[120], str[256];
                format(string, sizeof(string), "Ban da lua chon ngay sinh cua minh la {FF0000}'%d'{FFFFFF}.", GetPVarInt(playerid, "Birthday_Day"));
                SendClientMessage(playerid, COLOR_WHITE, string);

                format(str, sizeof(str),
                "Thang 1\nThang 2\nThang 3\nThang 4\nThang 5\nThang 6\nThang 7\nThang 8\nThang 9\nThang 10\nThang 11\nThang 12");
                ShowPlayerDialog(playerid, BIRTHDAY_MONTH, DIALOG_STYLE_LIST, "Thang sinh", str, "2/3","");
            }
            else {
                PlayerAdjust(playerid);
            }
        }
        case BIRTHDAY_MONTH: {
            if(response) {
                SetPVarInt(playerid, "Birthday_Month", listitem + 1);
                new string[120];
                szMiscArray[0] = 0;
                format(string, sizeof(string), "Ban da lua chon thang sinh cua minh la {FF0000}'%d'{FFFFFF}.", GetPVarInt(playerid, "Birthday_Month"));
                SendClientMessage(playerid, COLOR_WHITE, string);

                new
                    year,
                    month,
                    day;

                getdate(year, month, day);

                new startyear = year - 100;

                for(new i = startyear ; i < year ; i++) {
                    format(szMiscArray, sizeof(szMiscArray), "%s%d\n", szMiscArray, i);
                }
                ShowPlayerDialog(playerid, BIRTHDAY_YEAR, DIALOG_STYLE_LIST, "Nam sinh", szMiscArray, "3/3","");
            }
            else {
                PlayerAdjust(playerid);
            }
        }
        case BIRTHDAY_YEAR: {
            if(response) {

                new string[120];
                new
                    year,
                    month,
                    day;
                
                getdate(year, month, day);
                
                new startyear = year - 100;
                SetPVarInt(playerid, "Birthday_Year", listitem + startyear);
                format(string, sizeof(string), "Ban da lua chon nam sinh la {FF0000}%04d{FFFFFF}.", GetPVarInt(playerid, "Birthday_Year"));
                format(PlayerInfo[playerid][pBirthday], 11, "%04d-%02d-%02d", GetPVarInt(playerid, "Birthday_Year"), GetPVarInt(playerid, "Birthday_Month"), GetPVarInt(playerid, "Birthday_Day"));
                SendClientMessage(playerid, COLOR_WHITE, string);
                PlayerAdjust(playerid);
            }
            else {
                PlayerAdjust(playerid);
            }
        }
        case GENDER_SELECT: {
            if(response) {
                PlayerInfo[playerid][pGender] = listitem + 1;
                PlayerAdjust(playerid);
            }
            else {
                PlayerAdjust(playerid);
            }
        }
        case MODEL_SELECT: {
            if(response) {
                if(isNumeric(inputtext)) {
                    PlayerInfo[playerid][pModel] = strval(inputtext);
                    JoinActor(playerid, PlayerInfo[playerid][pModel]);
                    PlayerAdjust(playerid);
                }
                else {
                    ShowPlayerDialog(playerid, MODEL_SELECT, DIALOG_STYLE_INPUT, "Ma trang phuc", "Nhap ID trang phuc yeu thich cua ban vao day", "Nhap","");
                }
            }
            else {
                PlayerAdjust(playerid);
            }
        }
        case NATION_SELECT: {
            if(response) {
                PlayerInfo[playerid][pNation] = listitem + 1;
                PlayerAdjust(playerid);
            }
            else {
                PlayerAdjust(playerid);
            }
        }
    }
    return 1;
}

hook OnPlayerDisconnect(playerid, reason) {
    DeletePVar(playerid, "_TutorialTimer");
    DeletePVar(playerid, "pActor");
    DeletePVar(playerid, "Birthday_Day");
    DeletePVar(playerid, "Birthday_Month");
    DeletePVar(playerid, "Birthday_Year");
    KillTimer(_TimeRepeat[playerid]);
    return 1;
}