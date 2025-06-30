enum pInfo {
    pID[11],
    pPassword[65],
    pOnline,
    pEnableSecurity,
    pSecurity[65],
    pReg,
    pTut,
    pCash,
    pScore,
    pModel,
    Float:pHealth,
    Float:pArmour,
    Float:pPosX,
    Float:pPosY,
    Float:pPosZ,
    Float:pAngle,
    pVW,
    pGender,
    pBirthday[256],
    pNation,
    pGM,
    pModerator,
    pAdvisor,
    pHR,
    pPR,
    pST,
    // account settings
    pPhoneNumber,
    pRealName,
    pRealAddress,
    pCCCD,
    pDonator,
    pInjured,
    pJob,
    pJobDuty,
    pLang
};

enum wInfo {
    wID,
    wName[256],
    wType,
    Text3D:wDescription,
    wString,
    wAmount,
    wLimit,
    wTrade,
    wLock, // 0 = open , 1 = closed
    Float:wPosX,
    Float:wPosY,
    Float:wPosZ,
    Float:wVirtualWorld // default 0
};

enum pvInfo {
    pvSQLID,
    pvVehicleID,
    pvModelID,
    Float:pvPosX,
    Float:pvPosY,
    Float:pvPosZ,
    Float:pvAngle,
    pvVirtualWorld,
    pvInterior,
    Float:pvHealth,
    pvColor,
    pvColor2,
    bool:pvSpawned,
    pvTicket,
    pvMaxSpawned,
    pvDisable
};

enum paInfo {
    pa_SQLID,
    pa_ID,
    Float:pa_PosX,
    Float:pa_PosY,
    Float:pa_PosZ,
    Float:pa_Range,
    pa_String[256],
    Text3D:pa_Text
};

enum rInfo {
    rID,
    rRID,
    rRPlayer,
    rReason[256],
    rPend
};