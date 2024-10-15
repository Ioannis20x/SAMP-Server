//N:DM by Ioannis20x(Ioannis_Gutenberg)

#include <a_samp>
#include <streamer>
#include <zcmd>
#include <sscanf2>
#include <a_mysql>


//Farben
#define COLOR_RED 0xFF0000FF
#define COLOR_INFO 0x1FADCFFF
#define COLOR_HRED 0xFF6347FF
#define COLOR_YELLOW 0xFFFA00FF
#define COLOR_GREY 0x828282FF
#define COLOR_DARK_RED 0x6A0000FF
#define COLOR_GREEN 0x4BB400FF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_HGREEN 0x9ACD32FF
#define COLOR_BLACK 0x000000FF
#define COLOR_BLUE 0x2641FEAA
#define COLOR_HBLUE 0x01FCFFC8
#define COLOR_PINK 0xFFA1C8FF
#define COLOR_ORANGE 0xFFA000FF
#define COLOR_CHAT 0xFFFFFFFF
#define COLOR_FADE1 0xE6E6E6FF
#define COLOR_FADE2 0xD1CFD1FF
#define COLOR_FADE3 0xBEC1BEFF
#define COLOR_FADE4 0x919397FF
#define COLOR_FCHAT 0x00FFFFFF
#define COLOR_OCHAT 0xCEEAEAFF
#define COLOR_LILA 0xB799CEFF
#define COLOR_BROWN 0x8B4513FF
#define ADMINFS_MESSAGE_COLOR 0xFF444499
#define SERVERTAG  Nova e-Sports Trainingsserver
#define COLOR_RCHAT 0x0093FFFF

#define DIALOG_TP 1
#define DIALOG_REGISTER 2
#define DIALOG_LOGIN 3
#define DIALOG_ADMIN 4
#define DIALOG_VSPAWN 5
#define DIALOG_ASPAWN 6
#define DIALOG_BSPAWN 7
#define DIALOG_FSPAWN 8
#define DIALOG_FRAK 9
//DB-INFO
#define DB_HOST "mysql-mariadb-21-104.zap-hosting.com"
#define DB_USER "zap1004254-1"
#define DB_PAS "kK4NdGMrpobocamc"
#define DB_DB "zap1004254-1"


#define MAX_FRAKS 8

enum playerInfo{
    db_id,
	pName,
	eingeloggt,
	adminlevel,
	level,
	skin,
	kills,
	tode,
	smoney
}


enum frakEnum{
	f_ID,
	f_name[128],
	Float:f_x,
	Float:f_y,
	Float:f_z,
	Float:f_r,
	f_inter,
	f_world,
	f_color,
	Float:f_dx,
	Float:f_dy,
	Float:f_dz,
	Float:f_enx,
	Float:f_eny,
	Float:f_enz,
	Float:f_exx,
	Float:f_exy,
	Float:f_exz,
	}
	
	
//FRAKLIST
/*
0:LCN
1:YAKUZA
2:SCAFRO
3:BALLAS
4:GROVE STREET
5:TRIADEN
6:KORSAKOW
7:LOS VAGOS
*/



//globale Variablen
new dbhandle;
new sInfo[MAX_PLAYERS][playerInfo];
new Text:uhrzeitlabel;
new Text:adutylabel;
new weatherdone;
new weatherids[20] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20};
new fInfo[8][frakEnum] = {
{0,"La Cosa Nostra",-2720.1082,-318.7668,7.8438,270.0,0,0,COLOR_WHITE,0.0,0.0,0.0,2196.9661,1677.1620,12.3672,1701.3983,-1667.8174,20.2188},
{1,"Yakuza",-2624.1553,1410.2957,7.0938,90.0,0,0,COLOR_WHITE,0.0,0.0,0.0,2634.7559,1824.1881,11.0161,-2636.7302,1402.5090,906.4609},
{2,"Scarfo Family",1751.5862,-2056.1946,13.8528,270.0,0,0,COLOR_WHITE,0.0,0.0,0.0,1751.5009,-2054.3950,14.0731,1056.0479,2087.7456,10.8203},
{3,"Ballas Family",2322.7595,-1881.8774,13.6047,0.0,0,0,COLOR_WHITE,0.0,0.0,0.0,2333.3357,-1883.0869,15.0000,2466.4543,-1698.2504,1013.5078},
{4,"Grove Street Family",2495.4260,-1686.9517,13.5153,0.0,0,0,COLOR_WHITE,0.0,0.0,0.0,2495.3901,-1690.7659,14.7656,2495.9937,-1692.2738,1014.7422},
{5,"Triaden",-2173.0293,680.1008,55.1629,0.0,10,0,COLOR_WHITE,0.0,0.0,0.0,1923.7427,959.9255,10.8203,2019.0720,1017.9080,996.8750},
{6,"Korsakow Familie",-1954.3774,1344.4545,7.1875,0.0,12,0,COLOR_WHITE,0.0,0.0,0.0,2127.4836,2379.3384,10.8203,1133.3260,-15.5211,1000.6797},
{7,"Los Vagos",2260.2146,-1020.0849,59.2894,0.0,17,0,COLOR_WHITE,0.0,0.0,0.0,2259.6399,-1019.1033,59.2969,493.5826,-24.1817,1000.6797}
};

//forwards
forward OnUserCheck(playerid);
forward OnPasswordResponse(playerid);
forward sekunde();
forward OnPlayerRegister(playerid);

//Abfragen

isAdmin(playerid,a_level)
{
	if(sInfo[playerid][adminlevel]>=a_level)return 1;
	return 0;
}

isAlevel(playerid, a_level)
{
	if(sInfo[playerid][adminlevel]==a_level)return 1;
	return 0;
}

isaduty(playerid)
{
	if(GetPVarInt(playerid,"aduty")==1)return 1;
	return 0;
}
main(){}
public OnGameModeInit()
{

	//Servereinstellungen
	SetGameModeText("N:DM by Ioannis20x");
	SetTimer ("sekunde",1000,true);
	printf("1Server wurde gestartet!");
 	
 	//Spielereinstellungen
 	EnableStuntBonusForAll(false);
	DisableInteriorEnterExits();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	UsePlayerPedAnims();
	
	//Datenbank Login
	dbhandle=mysql_connect(DB_HOST,DB_USER,DB_DB,DB_PAS);
	
	//==============[Textdraws]=============
	//Uhrzeit
	new hour,minute,second;
	uhrzeitlabel = TextDrawCreate(549.0000, 14.0000, "00:00");
	TextDrawBackgroundColor(uhrzeitlabel, 255);
	TextDrawFont(uhrzeitlabel, 3);
	TextDrawLetterSize(uhrzeitlabel, 0.580000, 2.399999);
	TextDrawColor(uhrzeitlabel, -1);
	TextDrawSetOutline(uhrzeitlabel, 1);
	TextDrawSetProportional(uhrzeitlabel, true);
	gettime(hour,minute,second);
	SetWorldTime(hour);
	
	
	//adutylabel
	adutylabel = TextDrawCreate(575.000000, 55.000000, "Admindienst");
	TextDrawBackgroundColor(adutylabel, 255);
	TextDrawFont(adutylabel, 1);
	TextDrawLetterSize(adutylabel, 0.280000, 1.000000);
	TextDrawColor(adutylabel, -16776961);
	TextDrawSetOutline(adutylabel, 1);
	TextDrawSetProportional(adutylabel, true);
	TextDrawAlignment(adutylabel, 2);
	printf("2Server wurde gestartet!");
	return 1;
}

public OnGameModeExit()
{
	mysql_close(dbhandle);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerVirtualWorld(playerid, 0);
	SetCameraBehindPlayer(playerid);
	
	return 1;
}

public OnPlayerConnect(playerid)
{
	for(new i = 0; i < 35; i++) SendClientMessage(playerid,COLOR_GREY," ");
	DisablePlayerCheckpoint(playerid);
	new name[MAX_PLAYER_NAME],query[128];
	GetPlayerName(playerid,name,sizeof(name));
	format(query,sizeof(query),"SELECT * FROM user WHERE username='%s'",name);
	mysql_function_query(dbhandle,query,true,"OnUserCheck","i",playerid);
	
	//Uhrzeit
	TextDrawShowForPlayer(playerid, uhrzeitlabel);
	SetPlayerColor(playerid, COLOR_WHITE);
	return 1;
}


public OnUserCheck(playerid)
{
	new num_rows,num_fields;
	cache_get_data(num_rows,num_fields,dbhandle);
	if(num_rows==0)
	{
	    //Registrierung
	    ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_INPUT,"Registrierung","Gib bitte dein gew�nschtes Passwort an:","Okay","Abbrechen");
	}
	else
	{
	    //Login
	    ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,"Login","Bitte gebe dein Passwort ein:","Okay","Abbrechen");
	}
	return 1;
}

public OnPasswordResponse(playerid)
{
	new num_fields,num_rows;
	cache_get_data(num_rows,num_fields,dbhandle);
	if(num_rows==1)
	{
	    //Passwort richtig Spieler Laden
   	    sInfo[playerid][db_id] = cache_get_field_content_int(0,"id",dbhandle);
	    sInfo[playerid][level] = cache_get_field_content_int(0,"level",dbhandle);
	    SetPlayerScore(playerid,sInfo[playerid][level]);
	    SetPlayerMoney(playerid,cache_get_field_content_int(0,"money",dbhandle));
	    sInfo[playerid][adminlevel] = cache_get_field_content_int(0,"adminlevel",dbhandle);
	    sInfo[playerid][skin] = cache_get_field_content_int(0,"skin",dbhandle);
		sInfo[playerid][tode]=cache_get_field_content_int(0,"deaths",dbhandle);
		sInfo[playerid][kills]=cache_get_field_content_int(0,"kills",dbhandle);
		sInfo[playerid][smoney]=cache_get_field_content_int(0,"money",dbhandle);

		SetSpawnInfo(playerid,NO_TEAM,sInfo[playerid][skin],-49.9213,-270.2538,6.6332,0,0,0,0,0,0,0);
		SpawnPlayer(playerid);
		SetPVarInt(playerid,"inv_duel",-1);
		SetPVarInt(playerid,"inv_fraktion",-1);
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
	StopAudioStreamForPlayer(playerid);
	savePlayer(playerid);
	resetPlayer(playerid);
	new szString[64],
	playerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);

	new szDisconnectReason[3][] =
    {
        "Timeout/Crash",
        "Normal",
        "Kick/Ban"
    };

	format(szString, sizeof szString, "%s hat den Server verlassen (%s).", playerName, szDisconnectReason[reason]);
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) //GetPlayerPoolSize ist die h�chste online playerid   | i repr�sentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
		SendClientMessage(i,0xC4C4C4FF, szString);
	}}
	return 1;
}

public OnPlayerSpawn(playerid)
{

if(GetPVarInt(playerid,"inv_duel_entry") > 0)
{
SetPlayerHealth(playerid,100);
SetPlayerArmour(playerid,100);
GivePlayerWeapon(playerid,24,900);
SetPlayerInterior(playerid,6);
SetPlayerVirtualWorld(playerid,0);
SetPlayerPos(playerid,774.213989,-48.924297,1000.585937);
return 1;
}
else if(GetPVarInt(playerid,"inv_fraktion") >= 0){
new fID = GetPVarInt(playerid,"inv_fraktion");
SetPlayerPos(playerid,fInfo[fID][f_x],fInfo[fID][f_y],fInfo[fID][f_z]);
SetPlayerInterior(playerid,0);
giveequip(playerid);
return 1;
}
else{
	SetPlayerColor(playerid, 0xFFFFFFFF);
	StopAudioStreamForPlayer(playerid);
	SetPlayerSkin(playerid,sInfo[playerid][skin]);
	SetPlayerPos(playerid,-49.9213,-270.2538,6.6332);
	SetPlayerInterior(playerid,0);
	SetCameraBehindPlayer(playerid);
	SetPVarInt(playerid,"inv_fraktion",-1);
}
new string[128];
if(sInfo[playerid][eingeloggt]==0){
format(string, sizeof(string),"SERVER: {FFFFFF}%s betritt den Server",getPlayerName(playerid));
SendClientMessageToAll(COLOR_YELLOW,string);
sInfo[playerid][eingeloggt] = 1;
return 1;
}
return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
if(GetPVarInt(playerid,"inv_duel_entry") > -1)
{
SetPlayerHealth(playerid,100);
SetPlayerArmour(playerid,100);
GivePlayerWeapon(playerid,24,900);
SetPlayerInterior(playerid,6);
SetPlayerVirtualWorld(playerid,0);
SetPlayerPos(playerid,774.213989,-48.924297,1000.585937);
return 1;
}else{
	SetPlayerInterior(playerid,0);
}
new fID = GetPVarInt(playerid,"inv_fraktion");
if(GetPVarInt(playerid,"inv_fraktion")>=0){
SetPlayerPos(playerid,fInfo[fID][f_x],fInfo[fID][f_y],fInfo[fID][f_z]);
giveequip(playerid);
return 1;
}else{
SetPlayerInterior(playerid,0);
}
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
	if(dialogid==DIALOG_VSPAWN)
	{
	    if(response)
	    {
			if(listitem==0)
			{
			ShowPlayerDialog(playerid,DIALOG_ASPAWN,DIALOG_STYLE_LIST,"Eventsystem","Sultan\nInfernus\nHotring\nNRG\nTurismo\nComet","Weiter","Abbrechen");

			}
			if(listitem==1)
			{
            ShowPlayerDialog(playerid,DIALOG_BSPAWN,DIALOG_STYLE_LIST,"Eventsystem","Sqallo\nDinghy\nJetmax","Weiter","Abbrechen");
			}

			if(listitem==2)
			{
			ShowPlayerDialog(playerid,DIALOG_FSPAWN,DIALOG_STYLE_LIST,"Eventsystem","Dodo\nMaverick\nStuntplane\nRustler\nSparrow","Weiter","Abbrechen");
			}
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_RED,"Vorgang abgebrochen.");
	    }
		return 1;
	}
	if(dialogid==DIALOG_FRAK)
	{
	    if(response)
	    {
	    if(listitem==0){
	    //GS
			SetPlayerPos(playerid,fInfo[4][f_x],fInfo[4][f_y],fInfo[4][f_z]);
			giveequip(playerid);
			SetPVarInt(playerid,"inv_fraktion",4);
		}
		if(listitem==1){
		//BALLAS
			SetPlayerPos(playerid,fInfo[3][f_x],fInfo[3][f_y],fInfo[3][f_z]);
			giveequip(playerid);
			SetPVarInt(playerid,"inv_fraktion",3);
		}
		if(listitem==2){
		//SCARFO
			SetPlayerPos(playerid,fInfo[2][f_x],fInfo[2][f_y],fInfo[2][f_z]);
			giveequip(playerid);
			SetPVarInt(playerid,"inv_fraktion",2);
		}
		if(listitem==3){
		//LCN
			SetPlayerPos(playerid,fInfo[0][f_x],fInfo[0][f_y],fInfo[0][f_z]);
			giveequip(playerid);
			SetPVarInt(playerid,"inv_fraktion",0);
		}
		if(listitem==4){
		//LOS VAGOS
			SetPlayerPos(playerid,fInfo[7][f_x],fInfo[7][f_y],fInfo[7][f_z]);
			giveequip(playerid);
			SetPVarInt(playerid,"inv_fraktion",7);
		}
    	if(listitem==5){
    	//YAKUZA
			SetPlayerPos(playerid,fInfo[1][f_x],fInfo[1][f_y],fInfo[1][f_z]);
			giveequip(playerid);
			SetPVarInt(playerid,"inv_fraktion",1);
		}
		if(listitem==6){
		//TRIADEN
			SetPlayerPos(playerid,fInfo[5][f_x],fInfo[5][f_y],fInfo[5][f_z]);
			giveequip(playerid);
			SetPVarInt(playerid,"inv_fraktion",5);
		}
       	if(listitem==7){
       	//KORSAKOW
			SetPlayerPos(playerid,fInfo[6][f_x],fInfo[6][f_y],fInfo[6][f_z]);
			giveequip(playerid);
			SetPVarInt(playerid,"inv_fraktion",6);
		}

		}
		else{
			SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Vorgang abgebrochen.");
		}
		return 1;
	}
/*
0:LCN
1:YAKUZA
2:SCAFRO
3:BALLAS
4:GROVE STREET
5:TRIADEN
6:KORSAKOW
7:LOS VAGOS
*/
	if(dialogid==DIALOG_ASPAWN)
	{
	    if(response)
	    {
			if(listitem==0)
			{
			new Float:x,Float:y,Float:z,string[128];
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(560,x,y,z,0,-1,-1,0,true);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			format(string,sizeof(string),"ADMIN: {FFFFFF}%s hat ein Eventfahrzeug gespawned.",getPlayerName(playerid));
			SendAdminMessage(2,COLOR_RED,string);
			}
			if(listitem==1)
			{
			new Float:x,Float:y,Float:z,string[128];
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(411,x,y,z,0,-1,-1,0,true);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			format(string,sizeof(string),"ADMIN: {FFFFFF}%s hat ein Eventfahrzeug gespawned.",getPlayerName(playerid));
            SendAdminMessage(2,COLOR_RED,string);
			}

			if(listitem==2)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(494,x,y,z,0,-1,-1,0,true);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			}
			if(listitem==3)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(522,x,y,z,0,-1,-1,0,false);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			}

			if(listitem==4)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(451,x,y,z,0,-1,-1,0,false);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			}

			if(listitem==5)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(480,x,y,z,0,-1,-1,0,false);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			}

	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_RED,"Vorgang abgebrochen.");
	    }
		return 1;
	}
	if(dialogid==DIALOG_LOGIN)
	{
	    if(response)
	    {
	        new name[MAX_PLAYER_NAME],query[128],passwort[35];
	        GetPlayerName(playerid,name,sizeof(name));
	        if(strlen(inputtext)>0)
	        {
	            mysql_escape_string(inputtext,passwort,dbhandle);
	            format(query,sizeof(query),"SELECT * FROM user WHERE username='%s' AND passwort= MD5('%s')",name,passwort);
	            mysql_function_query(dbhandle,query,true,"OnPasswordResponse","i",playerid);
	        }
	        else
			{
				//Keine Eingabe
				SendClientMessage(playerid,COLOR_RED,"Gibt bitte dein Passwort ein.");
                ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,"Login","Gibt bitte dein Passwort ein:","Okay","Abbrechen");
   			}
	    }
	    else
	    {
	        Kick(playerid);
	    }
	    return 1;
}

	if(dialogid==DIALOG_REGISTER)
	{
	    if(response)
	    {
	        new name[MAX_PLAYER_NAME],query[128],passwort[35];
	        GetPlayerName(playerid,name,sizeof(name));
	        if(strlen(inputtext)>3)
	        {
	            //Registrierungsfunktion
	            mysql_escape_string(inputtext,passwort,dbhandle);
	            format(query,sizeof(query),"INSERT INTO user (username,passwort) VALUES ('%s',MD5('%s')) ",name,passwort);
	            mysql_function_query(dbhandle,query,true,"OnPlayerRegister","i",playerid);
	        }
	        else
	        {
	            //Kleiner als 4 Zeichen
	            SendClientMessage(playerid,COLOR_RED,"Dein Passwort muss mindestens 4 Zeichen lang sein.");
	            ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_INPUT,"Registrierung","Gib bitte dein gew�nschtes Passwort an:","Okay","Abbrechen");
	        }
	    }
	    else
	    {
	        Kick(playerid);
	        random(300);
	    }
	    return 1;
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
//Commands
CMD:gmx(playerid,params[]){
	if(!isAdmin(playerid,6))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
	restart();
	return 1;
}

CMD:1o1(playerid,params[])
{
if(GetPVarInt(playerid,"inv_duel") != -1)return SendClientMessage(playerid, COLOR_RED,"FEHLER: {FFFFFF}Du hast jemanden schon in ein Duell eingeladen oder wurdest in eins eingeladen.(/cancel1o1)");
if(GetPlayerInterior(playerid) != 0 || GetPVarInt(playerid,"inv_fraktion") != -1)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Verlasse erst die Arena!");
new pID;
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /1o1 [playerid]");
if(!IsPlayerConnected(pID))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Der Spieler ist nicht online.");
new string[128],selfstring[128];
format(string,sizeof(string),"DUEL: %s hat dich auf ein Duel herausgefordert.",getPlayerName(playerid));
SendClientMessage(pID, COLOR_ORANGE,string);
SendClientMessage(pID,COLOR_WHITE,"� Gib /accept1o1 oder /cancel1o1 ein. Diese Anfrage verfällt automatisch in 60 Sekunden.");

format(selfstring,sizeof(selfstring),"DUEL: Du hast %s zu einem Duell eingeladen. Warte auf seine Antwort.",getPlayerName(pID));
SendClientMessage(playerid, COLOR_YELLOW,selfstring);

SetPVarInt(pID,"inv_duel",playerid);
SetPVarInt(playerid,"inv_duel",pID);
return 1;
}


CMD:cancel1o1(playerid,params[])
{
new string[128];
new pID = GetPVarInt(playerid,"inv_duel");
if(GetPVarInt(playerid,"inv_duel")== -1)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du wurdest in kein Duel eingeladen.");
if(GetPVarInt(playerid,"inv_duel_entry") == 1)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist schon in einem Duell!");
format(string,sizeof(string),"DUEL: {FFFFFF}Deine Duelanfrage wurde abgelehnt.");
SendClientMessage(pID,COLOR_YELLOW,string);
SendClientMessage(playerid,COLOR_GREEN,"ERFOLG: {FFFFFF}Du hast die Anfrage erfolgreich abgelehnt.");
DeletePVar(pID,"inv_duel_entry");
SetPVarInt(pID,"inv_duel",-1);
DeletePVar(playerid,"inv_duel_entry");
SetPVarInt(playerid,"inv_duel",-1);
return 1;
}


CMD:exit(playerid,params[])
{
if(GetPlayerInterior(playerid)==0  || GetPVarInt(playerid,"inv_frak")>0){
SetPVarInt(playerid,"inv_fraktion", -1);
SetPlayerVirtualWorld(playerid,0);
SetPlayerInterior(playerid,0);
SpawnPlayer(playerid);
return 1;
}
DeletePVar(playerid,"inv_duel_entry");
DeletePVar(GetPVarInt(playerid,"inv_duel"),"inv_duel_entry");
SetPVarInt(GetPVarInt(playerid,"inv_duel"),"inv_duel",-1);
SetPVarInt(playerid,"inv_duel",-1);
SetPlayerVirtualWorld(playerid,0);
SetPlayerInterior(playerid,0);
SpawnPlayer(playerid);
SetPlayerPos(playerid,-49.9213,-270.2538,6.6332);
return 1;
}
CMD:accept1o1(playerid,params[])
{
if(GetPVarInt(playerid,"inv_duel")==-1)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du wurdest in kein Duel eingeladen.");
if(GetPVarInt(playerid,"inv_duel_entry") == 1)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du wurdest in kein Duel eingeladen oder bist bereits in einem Duel.");
SendClientMessage(GetPVarInt(playerid,"inv_duel"),COLOR_YELLOW,"DUEL: {FFFFFF}Deine Duelanfrage wurde angenommen");
SendClientMessage(playerid,COLOR_YELLOW,"DUEL: {FFFFFF}Du hast die Duelanfrage angenommen");

SetPlayerInterior(playerid,6);
SetPlayerInterior(GetPVarInt(playerid,"inv_duel"),6);
SetPlayerPos(playerid,774.213989,-48.924297,1000.585937);
SetPlayerPos(GetPVarInt(playerid,"inv_duel"),774.213989,-48.924297,1000.585937);

GivePlayerWeapon(playerid,24,900);
GivePlayerWeapon(GetPVarInt(playerid,"inv_duel"),24,900);
SetPlayerHealth(playerid,100);
SetPlayerHealth(GetPVarInt(playerid,"inv_duel"),100);
SetPlayerArmour(playerid,100);
SetPlayerArmour(GetPVarInt(playerid,"inv_duel"),100);

SetPVarInt(playerid,"inv_duel_entry",1);
SetPVarInt(GetPVarInt(playerid,"inv_duel"),"inv_duel_entry",1);
return 1;
}
CMD:fraktion(playerid,params[])
{
ShowPlayerDialog(playerid,DIALOG_FRAK,DIALOG_STYLE_LIST,"Fraktionsliste","{003300}Grove Street\n{6600FF}Ballas Family\n{00E3FF}Scarfo Family\n{008d44}La {FFFFFF}Cosa {c82a35}Nostra\n{FFCC33}Los Vagos\nYakuza\n{990000}Triaden\n{663300}Korsakow Familie","Betreten","Abbrechen");

return 1;
}
CMD:setworld(playerid,params[])
{
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
new pID,wID;
if(sscanf(params,"ui",pID,wID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /setworld [playerid] [worldid]");
SetPlayerVirtualWorld(pID,wID);
SetPlayerInterior(playerid,0);
return 1;
}

CMD:setint(playerid,params[])
{
new string[64],intid;
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF} Du bist nicht befugt diesen Befehl zu benutzen.");
if(sscanf(params,"i",intid))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /setint [interiorid]");
SetPlayerInterior(playerid,intid);
format(string,sizeof(string),"ADMIN: {FFFFFF}Du hast dein Interior auf  %i  gesetzt.",intid);
SendClientMessage(playerid,COLOR_RED,string);
return 1;
}

CMD:setpint(playerid,params[])
{
new intid,pID;
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF} Du bist nicht befugt diesen Befehl zu benutzen.");
if(sscanf(params,"ui",pID,intid))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /setpint [playerid] [interiorid]");
SetPlayerInterior(pID,intid);
return 1;
}
CMD:goto(playerid,params[])
{
	new pID, Float:x,Float:y,Float:z, adminstring[128],str[256],sint,sworld;
    //if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
    if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
    if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /goto [playerid]");
	if(!IsPlayerConnected(pID)) return SendClientMessage(playerid, COLOR_GREY, "Diese Person ist nicht online/du kannst dich nicht zu dir selber teleportieren.");
	GetPlayerPos(pID, x, y, z);
	sint = GetPlayerInterior(pID);
	sworld = GetPlayerVirtualWorld(pID);
	SetPlayerPos(playerid, x, y, z);
	SetPlayerInterior(playerid,sint);
	SetPlayerVirtualWorld(playerid,sworld);
	format(adminstring,sizeof(adminstring),"ADMIN: {FFFA00}Du hast dich zu %s teleportiert.",getPlayerName(pID));
	SendClientMessage(playerid, COLOR_RED, adminstring);
	format(str,sizeof(str),"* %s hat sich zu dir teleportiert.",getPlayerName(playerid));
	SendClientMessage(pID, COLOR_YELLOW, str);
	return 1;
}

CMD:aduty(playerid,params[])
{
new string[MAX_PLAYER_NAME + 23 + 100];
if(GetPVarInt(playerid,"aduty")==0)
{
switch(sInfo[playerid][adminlevel])
{
	case 0:
	{
	SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt!");
	}
	case 1:
	{
	SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt!");
	}
	case 2:
	{
	format(string,sizeof(string),"SERVER: {FFFFFF} %s ist nun als Moderator im Dienst",getPlayerName(playerid));
	SendClientMessageToAll(COLOR_RED,string);
	TextDrawShowForPlayer(playerid, adutylabel);
	SetPVarInt(playerid,"aduty",1);
	}
	case 3:
	{
	format(string,sizeof(string),"SERVER: {FFFFFF} %s ist nun als Administrator im Dienst",getPlayerName(playerid));
	SendClientMessageToAll(COLOR_RED,string);
	TextDrawShowForPlayer(playerid, adutylabel);
	SetPVarInt(playerid,"aduty",1);
	}
	case 4:
	{
	format(string,sizeof(string),"SERVER: {FFFFFF} %s ist nun als Super Administrator im Dienst",getPlayerName(playerid));
	SendClientMessageToAll(COLOR_RED,string);
	TextDrawShowForPlayer(playerid, adutylabel);
	SetPVarInt(playerid,"aduty",1);
	}
	case 5:
	{
	format(string,sizeof(string),"SERVER: {FFFFFF} %s ist nun als Manager im Dienst",getPlayerName(playerid));
	SendClientMessageToAll(COLOR_RED,string);
	TextDrawShowForPlayer(playerid, adutylabel);
	SetPVarInt(playerid,"aduty",1);
	}
	case 6:
	{
	format(string,sizeof(string),"SERVER: {FFFFFF} %s ist nun als ServerOwner im Dienst",getPlayerName(playerid));
	SendClientMessageToAll(COLOR_RED,string);
	TextDrawShowForPlayer(playerid, adutylabel);
	SetPVarInt(playerid,"aduty",1);
 }
 }}
	else if(GetPVarInt(playerid,"aduty")==1)
{
switch(sInfo[playerid][adminlevel])
{
	case 0:
	{
	SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt!");
	}
	case 1:
	{
	SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt!");
	}
	case 2:
	{
	format(string,sizeof(string),"SERVER: {FFFFFF} %s ist nicht mehr als Moderator im Dienst",getPlayerName(playerid));
	SendClientMessageToAll(COLOR_RED,string);
	TextDrawHideForPlayer(playerid,adutylabel);
	SetPVarInt(playerid,"aduty",0);
	}
	case 3:
	{
	format(string,sizeof(string),"SERVER: {FFFFFF} %s ist nicht mehr als Administrator im Dienst",getPlayerName(playerid));
	SendClientMessageToAll(COLOR_RED,string);
	TextDrawHideForPlayer(playerid,adutylabel);
	SetPVarInt(playerid,"aduty",0);
	}
	case 4:
	{
	format(string,sizeof(string),"SERVER: {FFFFFF} %s ist nicht mehr als Super Administrator im Dienst",getPlayerName(playerid));
	SendClientMessageToAll(COLOR_RED,string);
	TextDrawHideForPlayer(playerid,adutylabel);
	SetPVarInt(playerid,"aduty",0);
	}
	case 5:
	{
	format(string,sizeof(string),"SERVER: {FFFFFF} %s ist nicht mehr als Manager im Dienst",getPlayerName(playerid));
	SendClientMessageToAll(COLOR_RED,string);
	TextDrawHideForPlayer(playerid,adutylabel);
	SetPVarInt(playerid,"aduty",0);
	}
	case 6:
	{
	format(string,sizeof(string),"SERVER: {FFFFFF} %s ist nicht mehr als ServerOwner im Dienst",getPlayerName(playerid));
	SendClientMessageToAll(COLOR_RED,string);
	TextDrawHideForPlayer(playerid,adutylabel);
	SetPVarInt(playerid,"aduty",0);
 }}
}
return 1;
}
CMD:use(playerid,params[])
{
	new item[64],string[256],Float:health;
	if(GetPVarInt(playerid,"inv_fraktion") == -1)return SendClientMessage(playerid,COLOR_GREY,"FEHLER: Du darfst nichts nutzen!");
	if(sscanf(params,"s[64]",item))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /use [lsd|green|gold|donut]");
	//donut
	if(!strcmp(item, "donut", false))
	{
    new Float:x, Float:y, Float:z;
    GetPlayerHealth(playerid,health);
    if(health > 80){
	SendClientMessage(playerid,COLOR_GREY,"Du hast genug gegessen!");
	return 1;
		}

    GetPlayerPos(playerid, x,y,z);
    SendClientMessage(playerid,COLOR_GREY,"Du hast einen Donut gegessen (+80hp)!");
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) //GetPlayerPoolSize ist die h�chste online playerid   | i repr�sentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
   	format(string,sizeof(string),"* %s hat einen Donut gegessen.",getPlayerName(playerid));
	SendClientMessage(i,COLOR_LILA,string);
	}}

	SetPlayerHealth(playerid,health+80);
	return 1;
	}
	//lsd
 	if(!strcmp(item, "lsd", true))
	{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x,y,z);
    GetPlayerHealth(playerid,health);
    if(health > 80)return SendClientMessage(playerid,COLOR_GREY,"Du kannst Hawaiian Green erst ab 80HP nutzen.");
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) //GetPlayerPoolSize ist die h�chste online playerid   | i repr�sentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
   	format(string,sizeof(string),"* %s hat LSD benutzt.",getPlayerName(playerid));
//	SendClientMessage(playerid,COLOR_LILA,string);
	}}
	GetPlayerHealth(playerid,health);
	SendClientMessage(playerid,COLOR_RED,"FEHLER: Befehl deaktiviert");
	//SetPlayerHealth(playerid,health+195);
	return 1;
	}
 	if(!strcmp(item, "green", true))
	{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x,y,z);
    GetPlayerHealth(playerid,health);
    if(health > 80)return SendClientMessage(playerid,COLOR_GREY,"Du kannst Hawaiian Green erst ab 80HP nutzen.");
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) //GetPlayerPoolSize ist die h�chste online playerid   | i repr�sentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
   	format(string,sizeof(string),"* %s hat Hawaiian Green benutzt.",getPlayerName(playerid));
	SendClientMessage(playerid,COLOR_LILA,string);
	}}
	GetPlayerHealth(playerid,health);
	SetPlayerHealth(playerid,health+35);
	return 1;
	}

	if(!strcmp(item,"gold",false))
	{
 	new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x,y,z);
    GetPlayerHealth(playerid,health);
    if(health > 100)return SendClientMessage(playerid,COLOR_GREY,"Du kannst keine Drogen nehmen, da du 100HP hast.");
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) //GetPlayerPoolSize ist die h�chste online playerid   | i repr�sentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
   	format(string,sizeof(string),"* %s hat Acapulco Gold benutzt.",getPlayerName(playerid));
//	SendClientMessage(playerid,COLOR_HRED,string);
	}}
	GetPlayerHealth(playerid,health);
//	SetPlayerHealth(playerid,health+35);
	SendClientMessage(playerid,COLOR_RED,"FEHLER: Befehl deaktiviert");
	return 1;
	}
	return 1;
}

CMD:givegun(playerid,params[])
{
	new pID,gun,ammo;
	if(sscanf(params,"uii",pID,gun,ammo))return SendClientMessage(playerid,COLOR_GREY,"/givegun [playerid] [WaffenID] [Munition]");
    GivePlayerWeapon(pID, gun, ammo);
    return 1;
}

CMD:gethere(playerid,params[])
{
new pID, Float:x, Float:y, Float:z, name[MAX_PLAYER_NAME],nachricht[128],sint,sworld;
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"/gethere [playerid]");
GetPlayerPos(playerid, x, y, z);
sint = GetPlayerInterior(playerid);
sworld = GetPlayerVirtualWorld(playerid);
SetPlayerPos(pID, x, y, z);
GetPlayerName(pID, name, sizeof(name));
SetPlayerVirtualWorld(pID,sworld);
SetPlayerInterior(pID,sint);
format(nachricht,sizeof(nachricht),"ADMIN:{FFFFFF} Du hast %s zu dir teleportiert",name);
SendClientMessage(playerid,COLOR_RED,nachricht);
return 1;
}

CMD:getherecar(playerid,params[])
{
if(!isAdmin(playerid,2))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
new vID, Float:x, Float:y, Float:z, Float:px, Float:py, Float:pz, nachricht[128];
if(sscanf(params,"i",vID))return SendClientMessage(playerid,COLOR_GREY,"/getherevehicle [vID]");
format(nachricht,sizeof(nachricht),"Du hast den/die %s (%i) zu dir teleportiert",getVehicleName(GetVehicleModel(vID)), vID);
SendClientMessage(playerid,COLOR_YELLOW,nachricht);
GetVehiclePos(vID, x, y, z);
GetPlayerPos(playerid, px, py, pz);
SetVehiclePos(vID, px, py, pz);
return 1;
}

CMD:setskin(playerid,params[])
{
new pID,sID;
if(sscanf(params,"ui",pID,sID))return SendClientMessage(playerid,COLOR_GREY,"/setskin [playerid] [skinid]");
SetPlayerSkin(pID,sID);
sInfo[pID][skin]=sID;
return 1;
}
CMD:skin(playerid,params[])
{
new sID;
if(sscanf(params,"i",sID))return SendClientMessage(playerid,COLOR_GREY,"/setskin [playerid] [skinid]");
SetPlayerSkin(playerid,sID);
sInfo[playerid][skin]=sID;
return 1;
}
CMD:kick(playerid,params[])
{
	new pID, Grund[256],string[128];
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
	if(sscanf(params,"rs[128]",pID,Grund))return SendClientMessage(playerid,COLOR_GREY,"/kick [playerid] [Grund]");

	format(string,sizeof(string),"AdmCMD: %s wurde von %s vom Server gekickt. Grund: %s",getPlayerName(pID),getPlayerName(playerid),Grund);
   	SendClientMessage(pID,COLOR_HRED,string);
	SendClientMessageToAll(COLOR_HRED,string);
	format(string,sizeof(string),"AdmCMD: %s wurde von %s vom Server gekickt. Grund: %s",getPlayerName(pID),getPlayerName(playerid),Grund);
	printf(string);
	Kick(pID);
	return 1;
}
CMD:eveh(playerid,params[])
{
	new item[64];
	if(sscanf(params,"s[64]",item))return SendClientMessage(playerid, COLOR_GREY, "INFO: /eveh [add|del|delmy|lock|lockmy]");
	if(!strcmp(item, "add", false))
 	{
  	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
	ShowPlayerDialog(playerid,DIALOG_VSPAWN,DIALOG_STYLE_LIST,"Eventsystem","Autos/Motorr�der\nBoote\nFlugzeuge/Helis\nsonstige","Weiter","Abbrechen");
	return 1;
	}
	return 1;
}

CMD:delveh(playerid,params[])
{
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
new vID;
if(sscanf(params,"i",vID))return SendClientMessage(playerid,COLOR_GREY,"/delveh [vID]");
DestroyVehicle(vID);
return 1;
}
CMD:v(playerid,params[])
{
new vID, Float:x,Float:y,Float:z;
if(sscanf(params,"i",vID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /v [modelID]");
GetPlayerPos(playerid,x,y,z);
CreateVehicle(vID,x,y,z,0,-1,-1,false,false);
return 1;
}
CMD:sethp(playerid,params[])
{
	new ahp,pID;
	if(sscanf(params,"ui",pID,ahp))return SendClientMessage(playerid,COLOR_GREY,"INFO: /sethp [playerid] [HP]");
	SetPlayerHealth(pID, ahp);
	return 1;

}

CMD:spec(playerid,params[])
{
new pID,string[128];
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"/spec [playerid]");
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
TogglePlayerSpectating(playerid, true);
PlayerSpectatePlayer(playerid,pID);
new vID = GetPlayerVirtualWorld(pID);
new iID = GetPlayerInterior(pID);
SetPlayerInterior(playerid, iID);
SetPlayerVirtualWorld(playerid,vID);
format(string,sizeof(string),"ADMIN: %s beobachtet nun %s .",getPlayerName(playerid),getPlayerName(pID));
SendAdminMessage(sInfo[playerid][adminlevel],COLOR_YELLOW,string);
return 1;
}
CMD:specoff(playerid,params[])
{
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
TogglePlayerSpectating(playerid,false);
return 1;
}

CMD:setarmour(playerid,params[])
{
	new aarmour, pID;
   	if(sscanf(params,"ui",pID,aarmour))return SendClientMessage(playerid,COLOR_GREY,"INFO: /sethp [playerid] [Armour]");
	SetPlayerArmour(pID, aarmour);
	return 1;
 }
CMD:settime(playerid,params[])
{
	new time,string[128];
	if(sscanf(params,"i",time))return SendClientMessage(playerid,COLOR_GREY,"INFO: /settime [Uhrzeit]");
	SetWorldTime(time);
	format(string,sizeof(string),"ADMIN:{FFFFFF} ServerOwner %s hat die Uhrzeit auf %i:00 Uhr gesetzt",getPlayerName(playerid),time);
	SendClientMessageToAll(COLOR_RED,string);
	return 1;
}

CMD:suicide(playerid,params[])
{
	SetPlayerHealth(playerid,0.0);
	SetPlayerArmour(playerid,0.0);
	return 1;
}
CMD:givelevel(playerid,params[])
{
	new pID;
	if(!isAdmin(playerid,6))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
	if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /givelevel [playerid]");
	SetPlayerScore(pID, GetPlayerScore(pID) + 1);
	SendClientMessage(pID,COLOR_RED,"ADMIN: {FFFFFF}Dir wurde ein Level geschenkt.");
	return 1;
}
CMD:makeadmin(playerid,params[])
{
	if(!isAdmin(playerid,6))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
	new pID,a_level;
	if(sscanf(params,"ui",pID,a_level))return SendClientMessage(playerid,COLOR_GREY,"INFO: /makeadmin [playerid] [Adminlevel]");
	if(a_level > 3 && strcmp(getPlayerName(playerid),"Ioannis_Gutenberg"))return SendClientMessage(playerid,COLOR_WHITE,"FEHLER: du bist nicht befugt!");
	sInfo[pID][adminlevel]=a_level;
	savePlayer(pID);
	SendClientMessage(pID,COLOR_YELLOW,"Dein Adminrang wurde ge�ndert.");
	SendClientMessage(playerid,COLOR_YELLOW,"Du hast den Adminrang ge�ndert.");
	savePlayer(pID);
	return 1;
}
CMD:tc(playerid,params[])
{
if(!isAdmin(playerid,0))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
new string[256],nachricht[256],arang[256];
if(sscanf(params,"s[256]",nachricht))return SendClientMessage(playerid,COLOR_GREY,"/a [nachricht]");
if(isAlevel(playerid,1)){arang = "Clanmember";}
if(isAlevel(playerid,2)){arang = "Moderator";}
if(isAlevel(playerid,3)){arang = "Administrator";}
if(isAlevel(playerid,4)){arang = "Super Administrator";}
if(isAlevel(playerid,5)){arang = "Manager";}
if(isAlevel(playerid,6)){arang = "ServerOwner";}
format(string,sizeof(string),"%s %s: %s",arang,getPlayerName(playerid),nachricht);
SendAdminMessage(1,COLOR_HBLUE,string);
return 1;
}

CMD:o(playerid,params[])
{
new nachricht[256],string[256];
if(sscanf(params,"s[256]",nachricht))return SendClientMessage(playerid,COLOR_GREY,"/o [nachricht]");
format(string,sizeof(string),"(( %s: %s ))",getPlayerName(playerid),nachricht);
SendClientMessageToAll(COLOR_OCHAT,string);
return 1;
}
CMD:slap(playerid,params[])
{
new pID,Float:health, Float:x, Float:y, Float:z;
if(!isAdmin(playerid,2))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /slap [playerid]");
GetPlayerPos(pID, x, y, z);
GetPlayerHealth(pID,health);
SetPlayerHealth(pID,health-5);
SetPlayerPos(pID, x, y, z+2);
PlayerPlaySound(pID,1190,0,0,0);
return 1;
}

CMD:kill(playerid,params[])
{
	if(!isAdmin(playerid,3))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
	new pID;
	if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"Testnachricht");
	SetPlayerHealth(pID,0.0);
	SetPlayerArmour(pID,0.0);
	return 1;
}
CMD:addschirmex(playerid,params[])
{
    //if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!.");
    if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x,y,z);
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) //GetPlayerPoolSize ist die h�chste online playerid   | i repr�sentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
            GivePlayerWeapon(i, 46, 0);
            SetPlayerArmour(i,100);
            SetPlayerHealth(i,100);
       }
    }
    return 1;
}
CMD:addschirm(playerid,params[])
{
new pID;
    //if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!.");
if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /addschirm [playerid]");
GivePlayerWeapon(pID, 46, 0);
SetPlayerArmour(pID,100);
SetPlayerHealth(pID,100);
return 1;
}
CMD:checkstats(playerid,params[])
{
new string[128];
format(string,sizeof(string),"INFO: Fraktion:%i, Duell:%i, Entry:%i",GetPVarInt(playerid,"inv_fraktion"),GetPVarInt(playerid,"inv_duel"),GetPVarInt(playerid,"inv_duel_entry"));
SendClientMessage(playerid,COLOR_GREY,string);
return 1;
}
CMD:addequipex(playerid,params[])
{
    //if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!.");
    if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x,y,z);
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) //GetPlayerPoolSize ist die h�chste online playerid   | i repr�sentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
            GivePlayerWeapon(i, 24, 350);
            GivePlayerWeapon(i,25,150);
            GivePlayerWeapon(i,29,400);
            GivePlayerWeapon(i,31,400);
            SetPlayerArmour(i,100);
            SetPlayerHealth(i,100);
            SendClientMessage(i,COLOR_YELLOW,"EVENT: Eventausr�stung hinzugef�gt.");
        }
    }
    return 1;
}
CMD:addequip(playerid,params[])
{
new i;
    //if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!.");
if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
if(sscanf(params,"u",i))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /addequip [playerid]");
GivePlayerWeapon(i, 24, 350);
GivePlayerWeapon(i,25,150);
GivePlayerWeapon(i,29,400);
GivePlayerWeapon(i,31,400);
SetPlayerArmour(i,100);
SetPlayerHealth(i,100);
SendClientMessage(i,COLOR_YELLOW,"EVENT: Eventausr�stung hinzugef�gt.");
return 1;
}

CMD:dropguns(playerid,params[])
{
ResetPlayerWeapons(playerid);
new Float:x, Float:y, Float:z,string[256];
GetPlayerPos(playerid, x,y,z);
for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) //GetPlayerPoolSize ist die h�chste online playerid   | i repr�sentiert die aktuelle id die gecheckt wird
 {
	    if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
        format(string,sizeof(string),"%s l�sst seine Waffen fallen.",getPlayerName(playerid));
		SendClientMessage(playerid,COLOR_HRED,string);
       }
}
return 1;
}


CMD:fixveh(playerid,params[])
{	new vID;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!.");
	if(IsPlayerInAnyVehicle(playerid)){
	RepairVehicle(GetPlayerVehicleID(playerid));
	return 1;
	}
	if(sscanf(params,"i",vID)){SendClientMessage(playerid, COLOR_GREY,"/fixveh [Fahrzeug ID]");}
	RepairVehicle(vID);

	return 1;
}

CMD:go(playerid,params[])
{
	new item[128];
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: Du bist kein Admin/Dein Adminrang ist zu niedrig.");
	if(sscanf(params,"s[128]",item))return SendClientMessage(playerid,COLOR_GREY,"INFO: /go [LS | SF | LV]");
	if(!strcmp(item,"ls",false))
	{
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	SetPlayerPos(playerid, 1129.4788,-1457.1837,15.7969);
 	SendClientMessage(playerid, COLOR_RED, "ADMIN: {FFFFFF}Du hast dich erfolgreich nach Los Santos teleportiert.");
	return 1;
	}
	if(!strcmp(item,"sf",false))
	{
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	SetPlayerPos(playerid, -2028.7434,137.7347,28.8359);
    SendClientMessage(playerid, COLOR_RED, "ADMIN: {FFFFFF}Du hast dich erfolgreich nach San Fierro teleportiert.");
	return 1;
	}
	if(!strcmp(item,"airls",false))
	{
    SetPlayerVirtualWorld(playerid,0);
	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid,1958.0535,-2182.1360,13.5469);
    SendClientMessage(playerid, COLOR_RED, "ADMIN: {FFFFFF}Du hast dich erfolgreich zum LS Airport teleportiert.");
	return 1;
	}
	return 0;
}
//f fchat
CMD:f(playerid,params[])
{
	new string[256];
	if(isPlayerInFrak(playerid,0) ||isPlayerInFrak(playerid,1)||isPlayerInFrak(playerid,2)||isPlayerInFrak(playerid,3)||isPlayerInFrak(playerid,4))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du darfst diesen Befehl nicht nutzen.");
	if(sscanf(params,"s[128]",string))return SendClientMessage(playerid,COLOR_GREY, "INFO: /f [nachricht]");
	new fID = GetPVarInt(playerid, "fraktion");
	format(string,sizeof(string),"** %s: %s.))**",getPlayerName(playerid),string);
	for(new i =0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i))continue;
		if(!isPlayerInFrak(i,fID))continue;
		SendClientMessage(i,COLOR_FCHAT,string);
		PlayerPlaySound(i, 3401, 0.0, 0.0, 10.0);

	}
	return 1;
}
//eigene Funktionen
stock restart(){
	saveallplayers();
 	SendClientMessageToAll(COLOR_HRED, "SERVER: Server wird neugestartet.");
	SendRconCommand("gmx");

	return 1;
}
getPlayerName(playerid)
{
new name[MAX_PLAYER_NAME];
GetPlayerName(playerid,name,sizeof(name));
return name;
}

SetPlayerMoney(playerid,money)
{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,money);
	return 1;
}

resetPlayer(playerid)
{	for(new i=0; i<sizeof(sInfo[]); i++)
	{
 	sInfo[playerid][playerInfo:i]=0;
	}
	sInfo[playerid][adminlevel] = 0;
	sInfo[playerid][eingeloggt] = 0;
	sInfo[playerid][skin] = 0;

	return 1;

}

stock isPlayerInFrak(playerid,f_id){
	if(GetPVarInt(playerid, "fraktion")==f_id)return 1;
	return 0;
}

savePlayer(playerid)
{
	if(sInfo[playerid][eingeloggt]==0)return 1;
	//speichern level,money
	new query[2048];
	format(query,sizeof(query),"UPDATE user SET level='%i',money='%i',adminlevel='%i',skin='%i',deaths='%i',kills='%i' WHERE id='%i'",
	GetPlayerScore(playerid),GetPlayerMoney(playerid),sInfo[playerid][adminlevel],GetPlayerSkin(playerid),sInfo[playerid][tode],sInfo[playerid][kills],sInfo[playerid][db_id]);
	mysql_function_query(dbhandle,query,false,"","");
	return 1;
}
CMD:skininfo(playerid,params[])
{
	new sID,string[128];
	sID = GetPlayerSkin(playerid);
	format(string, sizeof(string),"SkinID:%i",sID);
	SendClientMessage(playerid,COLOR_GREY,string);
	return 1;
}
CMD:freeze(playerid,params[])
{
new pID;
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: Du bist kein Admin/Dein Adminrang ist zu niedrig.");
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /freeze [playerid]");
TogglePlayerControllable(pID,false);
return 1;
}
CMD:unfreeze(playerid,params[])
{
new pID;
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: Du bist kein Admin/Dein Adminrang ist zu niedrig.");
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /unfreeze [playerid]");
TogglePlayerControllable(pID,true);
return 1;
}
CMD:gotoxyz(playerid,params[])
{
new Float:x,Float:y,Float:z;
if(sscanf(params,"fff",x,y,z))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /gotoxyz [x-pos] [y-pos] [zpos]");
SetPlayerPos(playerid,x,y,z);
return 1;
}
CMD:help(playerid,params[])
{
	SendClientMessage(playerid, COLOR_RED,"================[Befehle]===================");
	SendClientMessage(playerid,COLOR_WHITE," /server /changepas /accname /q /help /admins /report /ports /afk /cash /credits");
	SendClientMessage(playerid,COLOR_WHITE,"EVENTS: /rennen /start /top3 /rennexit /mission /missionstop /derby /derbyexit /derbyhilfe /rennhilfe");
	SendClientMessage(playerid,COLOR_WHITE,"GANG: /gerstellen /geinladen /gverlassen /gannehmen /gchat");
	SendClientMessage(playerid,COLOR_WHITE,"FAHRZEUG: /autos /autoverkauf /autokauf /auto /autofarbe /nos");
	SendClientMessage(playerid,COLOR_WHITE,"HAUS: /optionen /verlassen /haus");
	SendClientMessage(playerid,COLOR_WHITE,"BIZ: /optionen /immobilien");
	SendClientMessage(playerid,COLOR_WHITE,"DEATHMATCH: /dm1 /dm2 /dm3 /clandm /dmeinladen /dmexit");
	SendClientMessage(playerid,COLOR_RED,"==========================================");
	return true;
}
CMD:ahelp(playerid,params[])
{
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin/Dein Adminrang ist zu niedrig.");
SendClientMessage(playerid,COLOR_WHITE,":__________________ {4a9edf}Befehle f�r Moderatoren{FFFFFF} __________________");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** SUPPORT ***{FFFFFF} /w(hisper) /areport /showreport /cancelhelp /aredirect /respawnplayer /reviveme /fuelcar /weather");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** SUPPORT ***{FFFFFF} /cleartext /respawn /lvlcheck /respawncar /getvehicles /gethp /check /respawnhelp /schnorrer");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** SUPPORT ***{FFFFFF} /checkweapons /o(oc) /spec /specoff /freeze /ban /unfreeze /slap /warn /mute /checkmute /kick");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** SUPPORT ***{FFFFFF} /cpjail /flip /mwarn /tban /adlock /gunlock /getcarowner /getlastdriver /getdrivers /forceafk");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** SUPPORT ***{FFFFFF} /setint /setplayerint /fixveh /checkbl /stvo /aopen /getrobber /roblock /delrb /conwarn /addcodexwarn");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** CHEATER ***{FFFFFF} /getwcheater /dcheckaim /checkaim /checklsd /checkspeed /specmark /suspects");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** CHEATER ***{FFFFFF} /shotmark /showdamage /checkacs /acinfo /checkmod /blockskin /gblockskin");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** TELEPORT ***{FFFFFF} /go /mark /gethere /ptp /tele /skydive /getherecar");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** GRUPPIERUNGEN ***{FFFFFF} /agroupspawn /getgroup");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** SYSTEM ***{FFFFFF} /saveall /economy /delfire /delmusik /joblock /getip /unbanip /reloadbans /apark /freesell /afkwarn");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** SYSTEM ***{FFFFFF} /fixatm /fixallatm /fixtz /fixalltz /fillallatm /lockcmd /locked /plocked /reloadbets /atakelicense");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** FURNITURESYSTEM ***{FFFFFF} /addfurniture /delfurniture /deliraum /reloadfurniture /deloutdoor /addtexture /deltexture");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** EVENT ***{FFFFFF} /event /flip /addschirm /addschirmex (Alle im Umkreis) /eveh /eventkasse /eventwithdraw");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** EVENT ***{FFFFFF} /addequipex /cancel event /funlock /stage");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** RACE EVENT ***{FFFFFF} /newracetrack /stoprace /selectrace /deleterace /inviterace /kickrace /startrace");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** RACE EVENT ***{FFFFFF} /cp /cpsize 5-30 /cpheal 0/1 /cpnitro 0/1 /cpsave /savetrack /cpdel");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** RACE EVENT ***{FFFFFF} /keinekollisionenmehrbitte /wiederkollisionenbitte");
if(!isAdmin(playerid,3))return 0;
SendClientMessage(playerid,COLOR_WHITE,"__________________ {df4a4a}Befehle f�r Administratoren{FFFFFF} __________________");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** SUPPORT ***{FFFFFF} /skasse /respawnallveh /setage /removeptv /reviveplayer /setsex /sethp /setarmor");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** SUPPORT ***{FFFFFF} /setwarns /addperso /setstat (Ziviskin und Fraktionssperre) /jail /removespec");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** FRAKTIONEN ***{FFFFFF} /ainvite /makeleader /auninvite /agiverank /aseturank");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** SYSTEM ***{FFFFFF} /lockairport /allowregi /allowvpn /forcenick /switchpayday /delafkwarn /stoptut");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** SYSTEM ***{FFFFFF} /reloadproxys /verifybets /reloadcheats /blockacs /blockkick /plockcmd");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** CHEATER ***{FFFFFF} /blockmods");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** FRAKTIONSBESTRAFUNGEN ***{FFFFFF} /factionlocks");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** EVENT ***{FFFFFF} /accept event /fourdive /hyperdive");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** H�USER ***{FFFFFF} /edit /asellhouse /setarchitect");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** NEULINGSCHAT ***{FFFFFF} /setnc (zum Erlauben des Neulingschats f�r andere Spieler)");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** BUSLINIEN ***{FFFFFF} /editroutes /addstop /stoplineedit /addbusstop /delbusstop");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** GANGWAR ***{FFFFFF} /agangwar /gwmark");
if(!isAdmin(playerid,4))return 0;
SendClientMessage(playerid,COLOR_WHITE,"__________________ {D5E809}Befehle f�r Super Administratoren{FFFFFF} __________________");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** SYSTEM ***{FFFFFF} /awplayer /agivelicense /allow(sf/bs) /block(sf/bs) /extend(sf/bs) /setmail /adelplant /adellsd");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** SYSTEM ***{FFFFFF} /asellmbiz /aeditmbiz /enablebizattack");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** GRUPPIERUNGEN ***{FFFFFF} /renamegroup /freegroupbank");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** CHEATER ***{FFFFFF} /aspecplayer");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** FAHRZEUGVERMIETUNG ***{FFFFFF} /addrental /delrental /reloadrental");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** CLANMEMBER ***{FFFFFF} /settc (Ernennt/Entfernt einen Clanmember)");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** GAMEDESIGN ***{FFFFFF} /setgd (Ernennt/Entfernt einen Konzepter)");
return 1;
}
CMD:regeln(playerid,params[])
{
	SendClientMessage(playerid,COLOR_RED,"================[Regeln]=====================");
	SendClientMessage(playerid,COLOR_WHITE,"1.Flamen und das benutzen von Cheats ist verboten.");
	SendClientMessage(playerid,COLOR_WHITE,"2.Das schiessen am Rennstart ist verboten.");
	SendClientMessage(playerid,COLOR_WHITE,"3.Das benutzen von Bugs ausgenommen CBug und 2Shot ist verboten.");
	SendClientMessage(playerid,COLOR_WHITE,"4.Cheater die man findet sind zu melden mit '/melden'.");
	SendClientMessage(playerid,COLOR_WHITE,"Halte dich an die Regeln oder du musst mit den Konsequenzen klarkommen.");
	SendClientMessage(playerid,COLOR_RED,"==========================================");
	return true;
}
CMD:stats(playerid,params[]){
new string[256];
format(string,sizeof(string),"Level: %i\nMoney:%i\alevel:%i\nskin:%i\ntode:%i\nkills:%i",sInfo[playerid][level],sInfo[playerid][smoney],sInfo[playerid][adminlevel],sInfo[playerid][skin],sInfo[playerid][tode],sInfo[playerid][kills]);
SendClientMessage(playerid,COLOR_WHITE,string);
return 1;
}
stock saveallplayers(){
	for(new i = 0 ; i < MAX_PLAYERS ; i++)
	{
	if(sInfo[i][eingeloggt] == 1){
	savePlayer(i);
	}
	}
}

public sekunde()
{
	new hour,minute,second,string[64];
	gettime(hour,minute,second);
	format(string,sizeof(string),"%02d:%02d",hour,minute);
	TextDrawSetString(uhrzeitlabel,string);
	if(minute==00){
	SetWorldTime(hour);
	}
	if(minute == 30)
	{
		weatherdone=0;
		return 0;
	}
	if(minute==10 && weatherdone==0)
	{
	changeweather();
	weatherdone=1;
	return 1;
	}
	return 0;
}
CMD:weatherall(playerid,params[])
{
if(!isAdmin(playerid,3))return 0;
changeweather();
return 1;
}

stock giveequip(playerid){
GivePlayerWeapon(playerid,24,400);//Deagle
GivePlayerWeapon(playerid,25,400);//Shotgun
GivePlayerWeapon(playerid,29,400);//mp5
GivePlayerWeapon(playerid,30,400);//mp5
GivePlayerWeapon(playerid,33,400);//Rifle
return 1;
}
stock changeweather(){
	SendClientMessageToAll(COLOR_ORANGE,"NR Bot: Es liegt eine Wetter�nderung in ganz San Andreas vor.");
	SetWeather(random(sizeof(weatherids)));
	return 0;
}
stock SendAdminMessage(adminlvl,color, string[])
{
	for(new i = 0 ; i < MAX_PLAYERS ; i++)
	{
	    if(IsPlayerConnected(i) && sInfo[i][eingeloggt] == 1)
	    {
	        if(sInfo[i][adminlevel] >= adminlvl)
	        {
	            SendClientMessage(i, color, string);
			}
	    }
	}
	return 1;
}

public OnPlayerRegister(playerid)
{
sInfo[playerid][eingeloggt] = 1;
sInfo[playerid][db_id] = cache_insert_id(dbhandle);
return 1;
}

getVehicleName(v_model)
{
    new carNames[212][] = {"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Feuerwehr","Trashmaster","Stretch","Manana","Infernus",
    "Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
    "Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
    "Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
    "Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
    "Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR-350","Walton","Regina",
    "Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI","Virgo","Greenwood",
    "Jetmax","Hotring","Sandking","Blista Compact","Polizei Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B",
    "Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain",
    "Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
    "Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
    "Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
    "Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
    "Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
    "Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Polizei","Polizei",
    "Polizei","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
    "Stair Trailer","Boxville","Farm Plow","Utility Trailer"};

    new string[60];
    format(string, sizeof(string), "%s", carNames[v_model-400]);
    return string;
}
