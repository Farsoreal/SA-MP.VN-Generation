#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {

    new string[1024];
    for(new i = 0 ; i < MAX_WAREHOUSES ; i++) {
        format(string, sizeof(string), "{EBD834}%s\n{FFFFFF}Gia thu mua: $%d / don vi\nSan luong: %d / %d", WarehouseInfo[i][wName], WarehouseInfo[i][wTrade], WarehouseInfo[i][wAmount], WarehouseInfo[i][wLimit]);
        WarehouseInfo[i][wDescription] = CreateDynamic3DTextLabel(string, COLOR_WHITE, WarehouseInfo[i][wPosX],  WarehouseInfo[i][wPosY], WarehouseInfo[i][wPosZ], 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
    }

   /* for(new i = 0 ; i < sizeof(ActorPosition) ; i++) {
        format(ActorInfo[i][aString], 256, "NPC (%d)\nHay /tuongtacnpc de tuong tac.", ActorInfo[i][aID]);
        ActorInfo[i][aDescription] = CreateDynamic3DTextLabel(ActorInfo[i][aString], COLOR_WHITE, ActorPosition[i][0], ActorPosition[i][1], ActorPosition[i][2], 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
        TotalActor++;
    }
    printf("[Streamer] %d actor da duoc add vao may chu.", TotalActor);*/
}