#include <a_samp>
#include <zCMD>
#include <sscanf2>
#include <a_mysql>
#include <streamer>

//DB
#define DB_HOST "127.0.0.1"
#define DB_USER "samp"
#define DB_PAS "samp"
#define DB_DB "dm"



#define COLOR_RED 0xFF0000FF
#define COLOR_YELLOW 0xFFFA00FF
#define COLOR_GREY 0x828282FF
#define COLOR_DARK_RED 0x6A0000FF
#define COLOR_GREEN 0x00FF00FF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_HGREEN 0x9ACD32FF
#define COLOR_BLACK 0x000000FF
#define COLOR_BLUE 0x0000FFFF
#define COLOR_HBLUE 0x51CCFFFF
#define COLOR_PINK 0xFFA1C8FF
#define COLOR_ORANGE 0xFF8C00FF
#define COLOR_CHAT 0xFFFFFFFF
#define COLOR_FADE1 0xE6E6E6FF
#define COLOR_FADE2 0xD1CFD1FF
#define COLOR_FADE3 0xBEC1BEFF
#define COLOR_FADE4 0x919397FF
#define COLOR_FCHAT 0x00FFFFFF
#define COLOR_OCHAT 0xCEEAEAFF

//Dialoge
#define DIALOG_TP 1
#define DIALOG_REGISTER 2
#define DIALOG_LOGIN 3
#define DIALOG_ADMIN 4


enum playerInfo{
	eingeloggt,
	level,
 	db_id,
 	adminlevel,
 	skin,
}


new kmhtd;
new dbhandle;
new sInfo[MAX_PLAYERS][playerInfo];




forward OnUserCheck(playerid);
forward OnPasswordResponse(playerid);
forward OnPlayerRegister(playerid);
main()
{
}


public OnGameModeInit()
{


   	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	dbhandle=mysql_connect(DB_HOST,DB_USER,DB_DB,DB_PAS);
	return 1;
}
public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
SetPlayerVirtualWorld(playerid, 3);
SetCameraBehindPlayer(playerid);
}
public OnUserCheck(playerid)
{
	new num_rows,num_fields;
	cache_get_data(num_rows,num_fields,dbhandle);
	if(num_rows==0)
	{
	    //Registrierung
	    ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_INPUT,"Registrierung","Gib bitte dein gewünschtes Passwort an:","Okay","Abbrechen");
	}
	else
	{
	    //Login
	    ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,"Login","Gibt bitte dein Passwort ein:","Okay","Abbrechen");
	}
	return 1;
}
public OnPlayerConnect(playerid)
{
	DisablePlayerCheckpoint(playerid);
	new nachricht[128],Float:x,Float:y,Float:z;
	SetPlayerCameraPos(playerid,1481.3153,-1722.0088,17.9948);
	SetPlayerCameraLookAt(playerid,1481.5920,-1766.3236,18.7958);
	GetPlayerPos(playerid, x, y, z);
	PlayAudioStreamForPlayer(playerid, "http://127.0.0.1/Musik/musik.mp3",0.0,0.0,0.0, 1);
	format(nachricht,sizeof(nachricht),"Du bist mit der ID %i verbunden.",playerid);
	SendClientMessage(playerid,COLOR_RED,nachricht);

	//login/Register
	new name[MAX_PLAYER_NAME],query[128];
	GetPlayerName(playerid,name,sizeof(name));
	format(query,sizeof(query),"SELECT id FROM user WHERE username='%s'",name);
	mysql_function_query(dbhandle,query,true,"OnUserCheck","i",playerid);

	GetPlayerName(playerid,name,sizeof(name));
	format(query,sizeof(query),"SELECT skin FROM user WHERE username='%s'",name);
	mysql_function_query(dbhandle,query,true,"OnUserCheck","i",playerid);
	SetPlayerScore(playerid,sInfo[playerid][level]);
}
public OnPasswordResponse(playerid)
{
	new num_fields,num_rows;
	cache_get_data(num_rows,num_fields,dbhandle);
	if(num_rows==1)
	{
	    //Passwort richtig Spieler Laden
	    sInfo[playerid][eingeloggt] = 1;
	    sInfo[playerid][level] = cache_get_field_content_int(0,"level",dbhandle);
	    SetPlayerScore(playerid,sInfo[playerid][level]);
	    sInfo[playerid][db_id] = cache_get_field_content_int(0,"id",dbhandle);
	    SetPlayerMoney(playerid,50000);
	    sInfo[playerid][adminlevel] = cache_get_field_content_int(0,"adminlevel",dbhandle);
	    sInfo[playerid][skin] = cache_get_field_content_int(0,"skin",dbhandle);



	/*	if(isAdmin(playerid,1)){
   		new name[128],string[128];
		GetPlayerName(playerid,name,sizeof(name));
		format(string, sizeof(string),"[NeS]%s",name);
		SetPlayerName(playerid,string);
		return 1;
}*/

		SetSpawnInfo(playerid, 0, sInfo[playerid][skin], 1481.59,-1766.32, 18.7958,0, 0, 5, 0, 0, 0, 0);
		SpawnPlayer(playerid);
	   	return 1;
	   	}

	else
	{
	    //Passwort falsch
	    SendClientMessage(playerid,COLOR_RED,"Das eingegebene Passwort ist falsch.");
	    ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,"Login","Gibt bitte dein Passwort ein:","Okay","Abbrechen");
		return 1;
	}
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
	return 1;
}
SetPlayerMoney(playerid,money)
{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,money);
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
