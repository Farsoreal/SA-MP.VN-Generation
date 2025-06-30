#include <YSI_Coding\y_hooks>

new Float:TruckLoadingPoint[1][4] = { // Điểm lấy hàng
    {-1651.0007,28.9694,4.5606, 5.0}
};

hook OnPlayerKeyState(playerid, newstate, oldstate) {
    if(newstate == PLAYER_STATE_DRIVER && oldstate == PLAYER_STATE_ONFOOT && IsATruckVehicle(GetPlayerVehicleID(playerid))) {
        if(!IsATruckMember(playerid)) {
            RemovePlayerFromVehicle(playerid);
            SendClientMessage(playerid, COLOR_GRAY, "Ban khong phai la mot Shipment!");
        }
        else {
            new vstring[256];
            new Float:pos[3];
            new szLocation[MAX_ZONE_NAME];
            GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
            Get3DZone(pos[0], pos[1], pos[2], szLocation, sizeof(szLocation));
            format(vstring, sizeof(vstring), "[HUONG DAN] Hay su dung /layhang de mua hang hoa tu ben cang %s.", szLocation);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, vstring);
        }
    }
    return 1;
}

hook OnPlayerEnterCheckpoint(playerid) {
    if(GetPVarInt(playerid, "Delivery") == 1)  {
        ProductCategory(playerid);
        DisablePlayerCheckpoint(playerid);
    }
    return 1;
}

hook OnPlayerConnect(playerid) {
    DeletePVar(playerid, "Delivery");
    DeletePVar(playerid, "CCFridge");
    DeletePVar(playerid, "CCMedical");
    DeletePVar(playerid, "CCPowder");
    return 1;
}

stock IsATruckVehicle(vehicleid) {
    for(new x = 0 ; x < 19 ; x++) {
        if(vehicleid == b_Vehicle[x]) return 1;
    }
    return 0;
}

stock IsATruckMember(playerid) {
    if(GetPlayerJob(playerid) == 1) return 1;
    return 0;
}

CMD:takegoods(playerid, params[]) {
    return cmd_layhang(playerid, params);
}
CMD:layhang(playerid, params[]) {
    if(g_PlayerLogged[playerid]) {
        if(!IsATruckMember(playerid)) {
            SendClientMessage(playerid, COLOR_GRAY, "Ban khong phai la mot Shipment!");
        }
        else {
            SetPVarInt(playerid, "Delivery", 1);
            new rand = random(sizeof(TruckLoadingPoint));
            SetPlayerCheckpoint(playerid, TruckLoadingPoint[rand][0], TruckLoadingPoint[rand][1], TruckLoadingPoint[rand][2], TruckLoadingPoint[rand][3]);
            return SendClientMessage(playerid, COLOR_YELLOW, "Ban hay di den vi tri duoc danh dau tren ban do de tien hanh viec mua hang hoa.");
        }
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban can dang nhap vao client truoc khi lam dieu nay!");
    }
    return 1;
}

CMD:sellgoods(playerid, params[]) {
    return cmd_banhang(playerid, params);
}
CMD:banhang(playerid, params[]) {
    if(g_PlayerLogged[playerid]) {
        new 
            vstring[256];
        if(IsAtWarehouseCC(playerid) != -1) {
            if(GetPVarInt(playerid, "CCFridge") >= 1) {
                new wid = IsAtWarehouseCC(playerid);
                if(WarehouseInfo[wid][wType] == 1) {
                    if(WarehouseInfo[wid][wAmount] <= WarehouseInfo[wid][wLimit]) {
                        new listitem = GetPVarInt(playerid, "CCFridge");
                        GivePlayerCash(playerid, commercialfridgeproductprice[listitem] + WarehouseInfo[wid][wTrade]);
                        WarehouseInfo[wid][wAmount]++;
                        UpdateWarehousesLabel();
                        SetPVarInt(playerid, "CCFridge", 0);
                        SetPVarInt(playerid, "Delivery", 0);
                        format(vstring, sizeof(vstring), "[WAREHOUSE] %s vua thanh ly %s cho kho voi gia tien $%d.", GetPlayerNameEx(playerid), commercialfridgeproduct[listitem], commercialfridgeproductprice[listitem] + WarehouseInfo[wid][wTrade]);
                        foreach(new i: Player) {
                            if(GetPlayerJob(i) == 1) {
                                SendClientMessage(i, COLOR_YELLOW, vstring);
                            }
                        }
                    }
                    else {
                        SendClientMessage(playerid, COLOR_GRAY, "Kho da dat den gioi han nen ban khong the thanh ly tai day!");
                    }
                }
                else {
                    SendClientMessage(playerid, COLOR_GRAY, "Ban khong o kho tieu dung!");
                }
            }
            else if(GetPVarInt(playerid, "CCMedical") >= 1) {
                new wid = IsAtWarehouseCC(playerid);
                if(WarehouseInfo[wid][wType] == 2) {
                    if(WarehouseInfo[wid][wAmount] <= WarehouseInfo[wid][wLimit]) {
                        new listitem = GetPVarInt(playerid, "CCMedical");
                        GivePlayerCash(playerid, commercialmedicalproductprice[listitem] + WarehouseInfo[wid][wTrade]);
                        WarehouseInfo[wid][wAmount]++;
                        UpdateWarehousesLabel();
                        SetPVarInt(playerid, "CCMedical", 0);
                        SetPVarInt(playerid, "Delivery", 0);
                        format(vstring, sizeof(vstring), "[WAREHOUSE] %s vua thanh ly %s cho kho voi gia tien $%d.", GetPlayerNameEx(playerid), commercialmedicalproduct[listitem], commercialmedicalproductprice[listitem] + WarehouseInfo[wid][wTrade]);
                        foreach(new i: Player) {
                            if(GetPlayerJob(i) == 1) {
                                SendClientMessage(i, COLOR_YELLOW, vstring);
                            }
                        }
                    }
                    else {
                        SendClientMessage(playerid, COLOR_GRAY, "Kho da dat den gioi han nen ban khong the thanh ly tai day!");
                    }
                }
                else {
                    SendClientMessage(playerid, COLOR_GRAY, "Ban khong o kho y te!");
                }
            }
            else if(GetPVarInt(playerid, "CCPowder") >= 1) {
                new wid = IsAtWarehouseCC(playerid);
                if(WarehouseInfo[wid][wType] == 3) {
                    if(WarehouseInfo[wid][wAmount] <= WarehouseInfo[wid][wLimit]) {
                        new listitem = GetPVarInt(playerid, "CCPowder");
                        GivePlayerCash(playerid, commercialpowderproductprice[listitem] + WarehouseInfo[wid][wTrade]);
                        WarehouseInfo[wid][wAmount]++;
                        UpdateWarehousesLabel();
                        SetPVarInt(playerid, "CCPowder", 0);
                        SetPVarInt(playerid, "Delivery", 0);
                        format(vstring, sizeof(vstring), "[WAREHOUSE] %s vua thanh ly %s cho kho voi gia tien $%d.", GetPlayerNameEx(playerid), commercialpowderproduct[listitem], commercialpowderproductprice[listitem] + WarehouseInfo[wid][wTrade]);
                        foreach(new i: Player) {
                            if(GetPlayerJob(i) == 1) {
                                SendClientMessage(i, COLOR_YELLOW, vstring);
                            }
                        }
                    }
                    else {
                        SendClientMessage(playerid, COLOR_GRAY, "Kho da dat den gioi han nen ban khong the thanh ly tai day!");
                    }
                }
                else {
                    SendClientMessage(playerid, COLOR_GRAY, "Ban khong o kho quoc phong!");
                }
            }
            else {
                SendClientMessage(playerid, COLOR_GRAY, "Ban khong co mat hang nao phu hop voi kho de ban!");
            }
        }
        else {
            SendClientMessage(playerid, COLOR_GRAY, "Ban khong o warehouse nao!");
        }
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban can dang nhap vao client truoc khi lam dieu nay!");
    }
    return 1;
}

CMD:canceldelivery(playerid, params[]) {
    return cmd_huyhanghoa(playerid, params);
}
CMD:huyhanghoa(playerid, params[]) {
    if(g_PlayerLogged[playerid]) {
        if(GetPVarInt(playerid, "Delivery") != 0) {
            DeletePVar(playerid, "CCFridge");
            DeletePVar(playerid, "CCMedical");
            DeletePVar(playerid, "CCPowder");
            DeletePVar(playerid, "Delivery");
            SendClientMessage(playerid, COLOR_LIGHTRED, "Ban da huy hang hoa thanh cong!");
        }
        else {
            SendClientMessage(playerid, COLOR_GRAY, "Ban khong co hang hoa nao de huy.");
        }
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban can dang nhap vao client truoc khi lam dieu nay!");
    }
    return 1;
}