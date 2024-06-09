// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>

#define COLOR_RED 0xCC210AFF
#define COLOR_GREEN 0x4BB400FF
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Autoswapgun ");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{}

#endif

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	new weapon[5] = {25,29,30,31,33};
	new w = weapon[random(5)];
	SetPVarInt(playerid,"swapgun",w);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_PASSENGER){
	new pvar = GetPVarInt(playerid,"swapgun");
	new WeaponData[13][2];
	new premium = 1;
	
	if(!pvar)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du hast keine Waffe ausgesucht!");
	for (new i = 0; i < 13; i++)
		{
			GetPlayerWeaponData(playerid, i, WeaponData[i][0], WeaponData[i][1]);
			if(WeaponData[i][0] == pvar){

				if((pvar == 30 || pvar == 31)){
				    if(premium == 1){
					GivePlayerWeapon(playerid, pvar,WeaponData[i][1]);
					SendClientMessage(playerid, COLOR_GREEN,"AUTOSWAPGUN: {FFFFFF}Waffe ausgerüstet.");
					return 0;
					}else{
							return SendClientMessage(playerid,COLOR_RED,"FEHLER: Du kannst keine AK-47/M4 nutzen, da du kein Premium hast.");
					}

				}else{
					GivePlayerWeapon(playerid, pvar,WeaponData[i][1]);
					SendClientMessage(playerid, COLOR_GREEN,"AUTOSWAPGUN: {FFFFFF}Waffe ausgerüstet.");
					return 1;
				}
        	}
}

	return 1;
}
return 1;
}
public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
