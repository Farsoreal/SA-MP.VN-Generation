#include <YSI_Coding\y_hooks>

new const commercialfridgeproduct[MAX_WAREHOUSES_CATEGORY][] = {
    "Thuoc la (Cigar)", "Ao khoac hoodie (Hoodie jacket)", "Quan jeans (Jean pants)", "Goi om tiger (Tiger body pillow)"
};

new const commercialmedicalproduct[MAX_WAREHOUSES_CATEGORY][] = {
    "Hop cuu thuong (Medkit)", "Bang gat (Wiper tape)", "Nuoc bien (Saline solution)", "Thuoc gay me (anesthetic)"
};

new const commercialpowderproduct[MAX_WAREHOUSES_CATEGORY][] = {
    "Thuoc sung (Gunpowder)", "Dan AK47 (Ammo)", "Dan 9mm (Ammo)", "Dan M4 (Ammo)"
};

new const commercialfridgeproductprice[MAX_WAREHOUSES_CATEGORY] = {
    5000, 15000, 9000, 8000,
};

new const commercialmedicalproductprice[MAX_WAREHOUSES_CATEGORY] = {
    9000, 6000, 11000, 13000
};

new const commercialpowderproductprice[MAX_WAREHOUSES_CATEGORY] = {
    17000, 15000, 11000, 14000
};


hook OnGameModeInit() {
    // Warehouse 1
    WarehouseInfo[0][wID]  = 0;
    WarehouseInfo[0][wType] = 1;
    format(WarehouseInfo[0][wName], 128, "Commercial Fridge");
    WarehouseInfo[0][wAmount] = 0;
    WarehouseInfo[0][wLimit] = 60;
    WarehouseInfo[0][wTrade] = 0;
    WarehouseInfo[0][wLock] = 0;
    WarehouseInfo[0][wPosX] = -1874.7463;
    WarehouseInfo[0][wPosY] = 1418.5681;
    WarehouseInfo[0][wPosZ] = 7.1763;
    WarehouseInfo[0][wVirtualWorld] = 0; // default

    // Warehouse 2
    WarehouseInfo[1][wID]  = 1;
    WarehouseInfo[1][wType] = 1;
    format(WarehouseInfo[1][wName], 128, "Commercial Fridge");
    WarehouseInfo[1][wAmount] = 0;
    WarehouseInfo[1][wLimit] = 60;
    WarehouseInfo[1][wTrade] = 0;
    WarehouseInfo[1][wLock] = 0;
    WarehouseInfo[1][wPosX] = -1741.8062;
    WarehouseInfo[1][wPosY] = 1429.1285;
    WarehouseInfo[1][wPosZ] = 7.1875;
    WarehouseInfo[1][wVirtualWorld] = 0; // default

    // Warehouse 3
    WarehouseInfo[2][wID]  = 2;
    WarehouseInfo[2][wType] = 2;
    format(WarehouseInfo[2][wName], 128, "Commercial Medical");
    WarehouseInfo[2][wAmount] = 0;
    WarehouseInfo[2][wLimit] = 70;
    WarehouseInfo[2][wTrade] = 0;
    WarehouseInfo[2][wLock] = 0;
    WarehouseInfo[2][wPosX] = -2276.8362;
    WarehouseInfo[2][wPosY] = 526.9984;
    WarehouseInfo[2][wPosZ] = 35.1719;
    WarehouseInfo[2][wVirtualWorld] = 0; // default

    // Warehouse 4
    WarehouseInfo[3][wID]  = 3;
    WarehouseInfo[3][wType] = 3;
    format(WarehouseInfo[3][wName], 128, "Commercial Powder");
    WarehouseInfo[3][wAmount] = 0;
    WarehouseInfo[3][wLimit] = 80;
    WarehouseInfo[3][wTrade] = 0;
    WarehouseInfo[3][wLock] = 0;
    WarehouseInfo[3][wPosX] = -2447.5354;
    WarehouseInfo[3][wPosY] = 523.3190;
    WarehouseInfo[3][wPosZ] = 30.3672;
    WarehouseInfo[3][wVirtualWorld] = 0; // default
    
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    switch(dialogid) {
        case PRODUCTCATEGORY: {
            if(!response) {
                SetPVarInt(playerid, "Delivery", 0);
                SendClientMessage(playerid, COLOR_LIGHTRED, "Ban da xoa bo mot lenh mua hang!");
                return 1;
            }
            else {
                switch(listitem) {
                    case 0: {
                        new 
                            vstring[256];
                        format(vstring, sizeof(vstring), "Mat hang tieu dung\nCong nghe y hoc\nCong nghiep quoc phong\n");
                        ShowPlayerDialog(playerid, WAREHOUSE, DIALOG_STYLE_LIST, "Hay lua chon {FF0000}Mat hang", vstring, "Chon","");
                    }
                }
            }
        }
        case WAREHOUSE: {
            if(!response) {
                SetPVarInt(playerid, "Delivery", 0);
                SendClientMessage(playerid, COLOR_LIGHTRED, "Ban da xoa bo mot lenh mua hang!");
                return 1;
            }
            else {
                switch(listitem) {
                    case 0: {
                        new 
                            vstring[4096];
                        format(vstring, sizeof(vstring), "Ten mat hang\tGia niem yet / don vi\n");
                        for(new x = 0 ; x < MAX_WAREHOUSES_CATEGORY ; x++) {
                            format(vstring, sizeof(vstring), "%s%s\t{88FF19}$%d\n", vstring, commercialfridgeproduct[x], commercialfridgeproductprice[x]);
                        }
                        ShowPlayerDialog(playerid, CCFRIDGE, DIALOG_STYLE_TABLIST_HEADERS, "Danh sach mat hang", vstring, "Chon","");
                    }
                    case 1: {
                        new 
                            vstring[4096];
                        format(vstring, sizeof(vstring), "Ten mat hang\tGia niem yet / don vi\n");
                        for(new x = 0 ; x < MAX_WAREHOUSES_CATEGORY ; x++) {
                            format(vstring, sizeof(vstring), "%s%s\t{88FF19}$%d\n", vstring, commercialmedicalproduct[x], commercialmedicalproductprice[x]);
                        }
                        ShowPlayerDialog(playerid, CCMEDICAL, DIALOG_STYLE_TABLIST_HEADERS, "Danh sach mat hang", vstring, "Chon","");
                    }
                    case 2: {
                        new 
                            vstring[4096];
                        format(vstring, sizeof(vstring), "Ten mat hang\tGia niem yet / don vi\n");
                        for(new x = 0 ; x < MAX_WAREHOUSES_CATEGORY ; x++) {
                            format(vstring, sizeof(vstring), "%s%s\t{88FF19}$%d\n", vstring, commercialpowderproduct[x], commercialpowderproductprice[x]);
                        }
                        ShowPlayerDialog(playerid, CCPOWDER, DIALOG_STYLE_TABLIST_HEADERS, "Danh sach mat hang", vstring, "Chon","");
                    }
                }
            }
        }
        case CCFRIDGE: {
            if(!response) {
                SetPVarInt(playerid, "Delivery", 0);
                SendClientMessage(playerid, COLOR_LIGHTRED, "Ban da xoa bo mot lenh mua hang!");
            }
            else {
                if(IsATruckVehicle(GetPlayerVehicleID(playerid))) {
                    if(GetPVarInt(playerid, "Delivery") == 1) {
                        new 
                            vstring[256];
                        GivePlayerCash(playerid, -commercialfridgeproductprice[listitem]);
                        SetPVarInt(playerid, "Delivery", commercialfridgeproductprice[listitem]);
                        SetPVarInt(playerid, "CCFridge", listitem);
                        format(vstring, sizeof(vstring), "Mua %s voi gia $%d", commercialfridgeproduct[listitem], commercialfridgeproductprice[listitem]);
                        SendClientMessage(playerid, COLOR_YELLOW, vstring);
                        SendClientMessage(playerid, COLOR_LIGHTRED, "Hay su dung /warehouse de xem danh sach kho co the dap ung duoc mat hang.");
                    }
                    else {
                        SendClientMessage(playerid, COLOR_GRAY, "Ban con mot lenh mua hang chua duoc xu ly!");
                    }
                }
                else {
                    SendClientMessage(playerid, COLOR_GRAY, "Ban khong o tren phuong tien Shipment!");
                }
            }
        }
        case CCMEDICAL: {
            if(!response) {
                SetPVarInt(playerid, "Delivery", 0);
                SendClientMessage(playerid, COLOR_LIGHTRED, "Ban da xoa bo mot lenh mua hang!");
                return 1;
            }
            else {
                if(IsATruckVehicle(GetPlayerVehicleID(playerid))) {
                    if(GetPVarInt(playerid, "Delivery") == 1) {
                        new 
                            vstring[256];
                        GivePlayerCash(playerid, -commercialmedicalproductprice[listitem]);
                        SetPVarInt(playerid, "Delivery", commercialmedicalproductprice[listitem]);
                        SetPVarInt(playerid, "CCMedical", listitem);
                        format(vstring, sizeof(vstring), "Mua %s voi gia $%d", commercialmedicalproduct[listitem], commercialmedicalproductprice[listitem]);
                        SendClientMessage(playerid, COLOR_YELLOW, vstring);
                        SendClientMessage(playerid, COLOR_LIGHTRED, "Hay su dung /warehouse de xem danh sach kho co the dap ung duoc mat hang.");
                    }
                    else {
                        SendClientMessage(playerid, COLOR_GRAY, "Ban con mot lenh mua hang chua duoc xu ly!");
                    }
                }
                else {
                    SendClientMessage(playerid, COLOR_GRAY, "Ban khong o tren phuong tien Shipment!");
                }
            }
        }
        case CCPOWDER: {
            if(!response) {
                SetPVarInt(playerid, "Delivery", 0);
                SendClientMessage(playerid, COLOR_LIGHTRED, "Ban da xoa bo mot lenh mua hang!");
                return 1;
            }
            else {
                if(IsATruckVehicle(GetPlayerVehicleID(playerid))) {
                    if(GetPVarInt(playerid, "Delivery") == 1) {
                        new 
                            vstring[256];
                        GivePlayerCash(playerid, -commercialpowderproductprice[listitem]);
                        SetPVarInt(playerid, "Delivery", commercialpowderproductprice[listitem]);
                        SetPVarInt(playerid, "CCPowder", listitem);
                        format(vstring, sizeof(vstring), "Mua %s voi gia $%d", commercialpowderproduct[listitem], commercialpowderproductprice[listitem]);
                        SendClientMessage(playerid, COLOR_YELLOW, vstring);
                        SendClientMessage(playerid, COLOR_LIGHTRED, "Hay su dung /warehouse de xem danh sach kho co the dap ung duoc mat hang.");
                    }
                    else {
                        if(VIE(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Ban con mot lenh mua hang chua duoc xu ly!");
                    }
                }
                else {
                    SendClientMessage(playerid, COLOR_GRAY, "Ban khong o tren phuong tien Shipment!");
                }
            }
        }
        case CCLOCATION: {
            if(!response) {
                return 1;
            }
            else {
                SetPlayerCheckpoint(playerid, WarehouseInfo[listitem][wPosX],WarehouseInfo[listitem][wPosY], WarehouseInfo[listitem][wPosZ], 5.0);
            }
        }
    }
    return 1;
}

task WarehouseTrade[1200000]() {
    WarehouseInfo[0][wTrade] = random(7001) + 1000;
    WarehouseInfo[1][wTrade] = random(7001) + 1000;
    WarehouseInfo[2][wTrade] = random(8001) + 1000;
    WarehouseInfo[3][wTrade] = random(8001) + 1000;

    SendClientMessageToAll(COLOR_WHITE, "{FFE600}[WAREHOUSES] {FFFFFF}Da dieu chinh gia trao doi hang hoa hay nhanh chong cap nhat gia moi!");

    UpdateWarehousesLabel();

    // new string[1024];
    // for(new i = 0 ; i < MAX_WAREHOUSES ; i++) {
    //     format(string, sizeof(string), "{EBD834}%s\n{FFFFFF}Gia giao dich: $%d / san pham\nSo luong: %d / %d", WarehouseInfo[i][wName], WarehouseInfo[i][wTrade], WarehouseInfo[i][wAmount], WarehouseInfo[i][wLimit]);
    //     UpdateDynamic3DTextLabelText(WarehouseInfo[i][wDescription], COLOR_WHITE, string);
    // }
}

stock UpdateWarehousesLabel() {
    new string[1024];
    for(new i = 0 ; i < MAX_WAREHOUSES ; i++) {
        format(string, sizeof(string), "{EBD834}%s\n{FFFFFF}Gia thu mua: $%d / don vi\nSan luong: %d / %d", WarehouseInfo[i][wName], WarehouseInfo[i][wTrade], WarehouseInfo[i][wAmount], WarehouseInfo[i][wLimit]);
        UpdateDynamic3DTextLabelText(WarehouseInfo[i][wDescription], COLOR_WHITE, string);
    }
    return 1;
}

stock ProductCategory(playerid) {
    new 
        vstring[256];
    format(vstring, sizeof(vstring), "Cong nghiep van tai\n");
    ShowPlayerDialog(playerid, PRODUCTCATEGORY, DIALOG_STYLE_LIST, "{FFFFFF}Hay lua chon {FF0000}danh muc ban can tim kiem{FFFFFF}", vstring, "Chon","");
    return 1;
}

stock ProductWarehouse(playerid) {
    new 
        vstring[4096];
    new szLocation[MAX_ZONE_NAME];
    format(vstring, sizeof(vstring), "Ten kho\tDia diem\tGia thu\tSo don hang co the nhan\n");
    for(new i = 0 ; i < MAX_WAREHOUSES ; i++) {
        Get3DZone(WarehouseInfo[i][wPosX],  WarehouseInfo[i][wPosY], WarehouseInfo[i][wPosZ], szLocation, sizeof(szLocation));
        format(vstring, sizeof(vstring), "%s%s\t%s\t$%d / san pham\t%d\n", vstring, WarehouseInfo[i][wName], szLocation, WarehouseInfo[i][wTrade], WarehouseInfo[i][wLimit] - WarehouseInfo[i][wAmount]);
    }
    ShowPlayerDialog(playerid, CCLOCATION, DIALOG_STYLE_TABLIST_HEADERS, "Danh sach kho", vstring, "Chon", "Huy");
    return 1;
}

stock IsAtWarehouseCC(playerid)
{
    for(new i = 0 ; i < MAX_WAREHOUSES ; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, WarehouseInfo[i][wPosX], WarehouseInfo[i][wPosY], WarehouseInfo[i][wPosZ]))
            return i;
    }
    return -1;
}

CMD:warehouse(playerid, params[]) {
    if(g_PlayerLogged[playerid]) {
        ProductWarehouse(playerid);
    }
    else {
        SendClientMessage(playerid, COLOR_GRAY, "Ban can dang nhap vao client truoc khi lam dieu nay!");
    }
    return 1;
}