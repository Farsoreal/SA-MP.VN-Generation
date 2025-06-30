stock LoadTextDraws() {
    TD_IP = TextDrawCreate(561.000, 420.000, "rgame.mp");
    TextDrawLetterSize(TD_IP, 0.309, 1.699);
    TextDrawAlignment(TD_IP, 1);
    TextDrawColor(TD_IP, -1);
    TextDrawSetShadow(TD_IP, 1);
    TextDrawSetOutline(TD_IP, 1);
    TextDrawBackgroundColor(TD_IP, 255);
    TextDrawFont(TD_IP, 3);
    TextDrawSetProportional(TD_IP, 1);

    return 1;
}