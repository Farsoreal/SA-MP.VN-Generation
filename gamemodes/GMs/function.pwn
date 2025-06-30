public KickEx(playerid) {
    Kick(playerid);
    return 1;
}
stock GetPlayerNameEx(playerid) {
    new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}
stock ClearChatbox(playerid) {
    for(new i = 0 ; i < 50 ; i++) {
        SendClientMessage(playerid, -1, "");
    }
    return 1;
}

stock GetPlayerNation(playerid) {
    new string[64];
    switch(PlayerInfo[playerid][pNation]) {
        case 1: {
            format(string, sizeof(string), "San Fierro");
        }
        case 2: {
            format(string, sizeof(string), "Los Santos");
        }
        case 3: {
            format(string, sizeof(string), "Bayes");
        }
        default: {
            format(string, sizeof(string), "-----");
        }
    }
    return string;
}

stock GetPlayerSex(playerid) {
    new string[64];
    switch(PlayerInfo[playerid][pGender]) {
        case 1: {
            format(string, sizeof(string), "Nam");
        }
        case 2: {
            format(string, sizeof(string), "Nu");
        }
        case 3: {
            format(string, sizeof(string), "LGBT");
        }
        default: {
            format(string, sizeof(string), "-----");
        }
    }
    return string;
}

stock GetPlayerCash(playerid) {
    return GetPlayerMoney(playerid);
}

stock GivePlayerCash(playerid, amount) {
    PlayerInfo[playerid][pCash] += amount;
    UpdatePlayerMoneyHUD(playerid);
}

stock UpdatePlayerMoneyHUD(playerid) {
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);
}

stock isNumeric(const inputtext[])
{
    for (new i = 0; i < strlen(inputtext); i++)
    {
        if (inputtext[i] < '0' || inputtext[i] > '9')
        {
            return 0;
        }
    }
    return 1;
}

stock VIE(playerid) {
    return PlayerInfo[playerid][pLang] == 0;
}

stock ENG(playerid) {
    return PlayerInfo[playerid][pLang] == 1;
}

stock Number_Format(number)
{
	new i, string[15];
	FIXES_valstr(string, number);
	if(strfind(string, "-") != -1) i = strlen(string) - 4;
	else i = strlen(string) - 3;
	while (i >= 1)
 	{
		if(strfind(string, "-") != -1) strins(string, ",", i + 1);
		else strins(string, ",", i);
		i -= 3;
	}
	return string;
}

stock FIXES_valstr(dest[], value, bool:pack = false)
{
    // format can't handle cellmin properly
    static const cellmin_value[] = !"-2147483648";

    if (value == cellmin)
        pack && strpack(dest, cellmin_value, 12) || strunpack(dest, cellmin_value, 12);
    else
        format(dest, 12, "%d", value) && pack && strpack(dest, dest, 12);
}

public Log(const file[], const text[])
{
    new entry[256];
    new year, month, day, hour, minutes, second;
    getdate(year, month, day);
    gettime(hour, minutes, second);

    format(entry, sizeof(entry), "[%04d-%02d-%02d %02d:%02d:%02d] %s\n",
           year, month, day, hour, minutes, second, text);

    new File:hFile = fopen(file, io_append);
    if (hFile)
    {
        fwrite(hFile, entry);
        fclose(hFile);
    }
}

public Critical(const text[]) {
    new entry[256];
    foreach(new i: Player) {
        if(PlayerInfo[i][pGM] >= 2) {
            format(entry, sizeof(entry), "%s", text);
            SendClientMessage(i, COLOR_YELLOW, text);
        }
    }
}