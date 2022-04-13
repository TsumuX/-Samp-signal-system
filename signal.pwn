//Radio signal
//Credit:TsumuX
#include <a_samp>
#include <streamer>
#define PlayerToPoint%5(%0,%1,%2,%3,%4) 				IsPlayerInRangeOfPoint%5(%1,%0,%2,%3,%4)
#include <zcmd>

enum J_dt
{
	Internet
}
new StatusJaringan[MAX_PLAYERS][J_dt];

new Float: tower[][] =
{
	{1835.657470, -1867.758544, 12.382812},
	{458.571411, -1787.563720, 4.546875},
	{1185.168579, -1337.905273, 12.570312},
	{1945.893920, -1221.026855, 19.013828},
	{1439.545776, -1690.628051, 12.546875},
	{-509.108886, -96.931404, 61.698348},
	{2262.095947, -1652.567382, 14.443929},
	{1934.778564, -1453.555175, 12.546875},
	{293.881134, -1229.876220, 74.452018},
	{-2014.673461, 244.875717, 28.611841},
	{1384.351928, -2322.764404, 12.546875},
	{-601.785644, -1510.149902, 11.833873}
}; //tower location

main()//OnGamemodeInit
{
    LoadTower();
	return 1;
}

public OnPlayerUpdate(playerid)
{
    if(IsPlayerInTower(playerid))
	{
		StatusJaringan[playerid][Internet] = 1;
	}
	if(!IsPlayerInTower(playerid))
	{
	    StatusJaringan[playerid][Internet] = 0;
	}
	return 1;
}

stock LoadTower()
{
    for(new i, z = sizeof tower; i < z; i++)
    {
        CreateDynamicObject(4574, tower[i][0], tower[i][1], tower[i][2], 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
        Create3DTextLabel("{FFFF00}[TOWER]\n{FFFFFF}Status:{00FF00}Normal", 0xFFFFFFFF, tower[i][0], tower[i][1], tower[i][2], 100.0, 0);
        print("[TsumuX] Tower Dimuat");
    }
	return 0;
}

stock IsPlayerInTower(playerid)
{
    for(new i, z = sizeof tower; i < z; i++)
        if(PlayerToPoint(100.0, playerid, tower[i][0], tower[i][1], tower[i][2])) return 1;
	return 0;
}

//signal status taroh di tempat yang mau dilihat status jaringan contoh(dibawH)
CMD:internet(playerid)
{
	new status[120];
	new STR[999];
	if(StatusJaringan[playerid][Internet] == 1) status = "Normal";
	if(StatusJaringan[playerid][Internet] == 0) status = "No internet";
	format(STR, sizeof(STR), "Status jaringan: %s", status);
	ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX, "Internet", STR, "batal", "");
	return 1;
}

