new szMiscArray[4096];
new MySQL:MainPipeline;
new b_Object[25];
new b_Vehicle[19];
new TotalReports = 0;
new PassAttemp[MAX_PLAYERS];
new bool:g_PlayerLogged[MAX_PLAYERS];
// tutorial
new _TimeRepeat[MAX_PLAYERS];
// Textdraw
new Text:TD_IP;

// enum
new PlayerInfo[MAX_PLAYERS][pInfo];
new WarehouseInfo[MAX_WAREHOUSES][wInfo];
new PlayerVehicleInfo[MAX_PLAYERS][MAX_PLAYERS_VEHICLE][pvInfo];
new ProtectArea[MAX_PROTECT_AREA][paInfo];
new ReportInfo[MAX_PLAYERS][rInfo];
// List Vehicle
new const VehicleName[212][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Perennial","Sentinel","Dumper","Firetruck","Trashmaster","Stretch",
	"Manana","Infernus","Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi",
	"Washington","Bobcat","Mr Whoopee","BF Injection","Hunter","Premier","Enforcer","Securicar","Banshee","Predator",
	"Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie","Stallion","Rumpo","RC Bandit", "Romero",
	"Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder","Reefer","Tropic","Flatbed",
	"Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler",
	"ZR-350","Walton","Regina","Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper",
	"Rancher","FBI Rancher","Virgo","Greenwood","Jetmax","Hotring Racer","Sandking","Blista Compact","Police Maverick",
	"Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B","Bloodring Banger","Rancher","Super GT",
	"Elegant","Journey","Bike","Mountain Bike","Beagle","Cropduster","Stuntplane","Tanker","Road Train","Nebula","Majestic",
	"Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV-1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent",
	"Bullet","Clover","Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility",
	"Nevada","Yosemite","Windsor","Monster A","Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger",
	"Flash","Tahoma","Savanna","Bandito","Freight","Trailer","Kart","Mower","Duneride","Sweeper","Broadway",
	"Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer","Emperor","Wayfarer",
	"Euros","Hotdog","Club","Trailer","Trailer","Andromada","Dodo","RCCam","Launch","Police Car (LSPD)","Police Car (SFPD)",
	"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A",
	"Luggage Trailer B","Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};

// A
forward AdvancedTutorial(playerid);
// C
forward Critical(const text[]);
forward CreatedPlayerVehicle(playerid, playervehicleid);
forward CreatedProtectArea(index, area);
// O
forward OnPlayerLoad(playerid);
// S
forward ShowMainMenu(playerid, resultid);
forward SavePlayerVehicles(playerid, playervehicleid);
// T
forward THREAD_CHECKACCOUNT(playerid);
forward THREAD_ONCREATEDACCOUNT(playerid);
forward THREAD_ONLOGINCHECK(playerid);
forward _TutorialRepeat(playerid);
// K
forward KickEx(playerid);
// L
forward Log(const file[], const text[]);
forward LoadPlayerVehicle(playerid);
forward LoadProtectArea();
// R
forward RemoveBuildingForPlayers(playerid);
// I
forward Initategamemode();