#include <a_samp>
#include <ocmd>
#include <sscanf2>
#include <a_mysql>

//ENUM

enum playerInfo{
	eingeloggt,
	level,
 	db_id,
 	adminlevel,
 	fschein,
 	skin,
 	sx,
 	sy,
 	sz,
 	aduty
}


//saveplayer
savePlayer(playerid)
{
	if(sInfo[playerid][eingeloggt]==0)return 1;
	//speichern level,money
	new query[128];
	format(query,sizeof(query),"UPDATE user SET level='%i',money='%i,adminlevel='%i',skin='i'WHERE id='%i'",sInfo[playerid][level],GetPlayerMoney(playerid),sInfo[playerid][adminlevel],GetPlayerSkin(playerid),sInfo[playerid][db_id]);
	mysql_function_query(dbhandle,query,false,"","");
	return 1;
}


//FARBEN
#define COLOR_RED 0xFF0000FF
#define COLOR_YELLOW 0xFFC800FF
#define COLOR_GREY 0x828282FF
#define COLOR_DARK_RED 0x6A0000FF
#define COLOR_GREEN 0x00FF00FF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_HGREEN 0x9ACD32FF
//globalr VAR
new sInfo[MAX_PLAYERS][playerInfo];

//Abfragen
isAdmin(playerid,a_level)
{
	if(sInfo[playerid][adminlevel]>=a_level)return 1;
	return 0;
}
isaduty(playerid)
{
	if(sInfo[playerid][aduty] == 1)return 1;
	return 0;
}




//Adminbefehle


ocmd:sethp(playerid,params[])
{
	new ahp,pID;
	if(sscanf(params,"ii",pID,ahp))return SendClientMessage(playerid,COLOR_GREY,"INFO: /sethp [playerid] [HP]");
	SetPlayerHealth(pID, ahp);
	return 1;

}
ocmd:setarmour(playerid,params[])
{
	new aarmour, pID;
   	if(sscanf(params,"ui",pID,aarmour))return SendClientMessage(playerid,COLOR_GREY,"INFO: /sethp [playerid] [Armour]");
	SetPlayerArmour(pID, aarmour);
	return 1;
 }


ocmd:suicide(playerid,params[])
{
	SetPlayerHealth(playerid,0.0);
	SetPlayerArmour(playerid,0.0);
	return 1;
}

ocmd:makeadmin(playerid,params[])
{
	if(!isAdmin(playerid,6))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	new pID,a_level;
	if(sscanf(params,"ui",pID,a_level))return SendClientMessage(playerid,COLOR_GREY,"INFO: /setadmin [playerid] [Adminlevel]");
	sInfo[pID][adminlevel]=a_level;
	savePlayer(pID);
	SendClientMessage(pID,COLOR_YELLOW,"Dein Adminrang wurde geändert.");
	SendClientMessage(playerid,COLOR_YELLOW,"Du hast den Adminrang geändert.");
	return 1;
}


ocmd:kill(playerid,params[])
{
	if(!isAdmin(playerid,3))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	new pID;
	if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"Testnachricht");
	SetPlayerHealth(pID,0.0);
	SetPlayerArmour(pID,0.0);
	return 1;
}

ocmd:tpmenu(playerid,params[])
{
    if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	ShowPlayerDialog(playerid,DIALOG_TP,DIALOG_STYLE_LIST,"TP-Menü","spawn\nBSN\nLSPD\nrandom\nTaxijob","Weiter","Abbrechen");
	return 1;
}


ocmd:gotols(playerid,params[]){
if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
SetPlayerPos(playerid, 1129.4788,-1457.1837,15.7969);
return SendClientMessage(playerid, COLOR_RED, "ADMIN: {FFFFFF}Du hast dich erfolgreich nach LS teleportiert.");
}


ocmd:getphere(playerid,params[]){
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
new pID, Float:x,Float:y,Float:z;
GetPlayerPos(pID, x,y,z);
SetPlayerPos(playerid, x,y,z);
return 1;
}


ocmd:gotovehicle(playerid,params[])
{
new vehID, Float:vehX, Float:vehY,Float:vehZ;
if(sscanf(params,"i",vehID))return SendClientMessage(playerid,COLOR_GREY,"/gotovehicle [vehicleID]");
 GetVehiclePos(vehID, vehX, vehY, vehZ);
 SetPlayerPos(playerid, vehX, vehY, vehZ);
 return 1;
}


ocmd:aduty(playerid,params[])
{
new name[MAX_PLAYER_NAME + 1], farbe,string[MAX_PLAYER_NAME + 23 + 100];
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
GetPlayerName(playerid, name, sizeof(name));
if(sInfo[playerid][aduty]==0){
farbe = GetPlayerColor(playerid);
SetPlayerColor(playerid, COLOR_RED);
format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als ServerOwner im Dienst.", name);
SendClientMessageToAll(COLOR_RED, string);
sInfo[playerid][aduty]=1;
return 1;
}
else{
SetPlayerColor(playerid, farbe);
format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als ServerOwner außer Dienst.", name);
SendClientMessageToAll(COLOR_RED, string);
sInfo[playerid][aduty]=0;
return 1;
}}


ocmd:givegun(playerid,params[])
{
	new pID,gun,ammo;
	if(sscanf(params,"iii",pID,gun,ammo))return SendClientMessage(playerid,COLOR_GREY,"/givegun [playerid] [WaffenID] [Munition]");
    GivePlayerWeapon(pID, gun, ammo);
    return 1;
}

ocmd:gethere(playerid,params[])
{
new pID, Float:x, Float:y, Float:z;
if(sscanf(params,"i",pID))return SendClientMessage(playerid,COLOR_GREY,"/gethere [playerid]");
    GetPlayerPos(playerid, x, y, z);
    SetPlayerPos(pID, x, y, z);
    return 1;
}


ocmd:setskin(playerid,params[])
{
 new pID,sID;
if(sscanf(params,"ii",pID,sID))return SendClientMessage(playerid,COLOR_GREY,"/setskin [playerid] [skinid]");
SetPlayerSkin(pID,sID);
return 1;
}


ocmd:veh(playerid,params[])
{
    if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	new vID,pID;
	if(sscanf(params,"ui",pID,vID))return SendClientMessage(playerid,COLOR_GREY,"/veh [playerid] [model] [Farbe1] [Farbe2]");
	if(vID<400 || vID>611)return SendClientMessage(playerid,COLOR_RED,"ungültiges Modell");
	new Float:xc,Float:yc,Float:zc,Float:rc;
	GetPlayerPos(pID,xc,yc,zc);
	GetPlayerFacingAngle(pID,rc);
	createCar(pID,vID,xc,yc,zc,rc);
	SendClientMessage(playerid, COLOR_WHITE, "SYSTEM: Du hast dir erfolgreich ein Fahrzeug gespawned.");
	return 1;
}



ocmd:delveh(playerid,params[])
{
 if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	new vID;
	if(sscanf(params,"i",vID))return SendClientMessage(playerid,COLOR_GREY,"/delveh [vID]");
	DestroyVehicle(vID);
	return 1;
}

//---------[ kick ]---------
ocmd:kick(playerid,params[])
{
	new pID, Grund, string[128], kname[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME],kadmin[MAX_PLAYER_NAME];
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	if(sscanf(params,"ss",pID,Grund))return SendClientMessage(playerid,COLOR_GREY,"/kick [playerid] [Grund]");
	GetPlayerName(playerid, name, sizeof(name));
	GetPlayerName(playerid, kname, sizeof(kname));
	format(string,sizeof(string),"Admcmd: %s wurde von %s vom Server gekickt. Grund: %s",name,kadmin,Grund);
	SendClientMessageToAll(COLOR_RED,string);
	Kick(pID);
	return 0;
}

	ocmd:gmx(playerid,params[]){
	if(!isAdmin(playerid,3))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	SendClientMessageToAll(COLOR_DARK_RED, "RESTART ERFOLGT JETZT!!!");
	SendRconCommand("gmx");
	return 1;
	}
	ocmd:test(playerid,params[])
	{
	    SendClientMessage(playerid,COLOR_RED,"Du hast /test eingegeben.");
	    return 1;
	}

