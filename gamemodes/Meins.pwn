//Includes
#include <a_samp>
#include <ocmd>
#include <sscanf2>
#include <a_mysql>

//enums
enum playerInfo{
	eingeloggt,
	level,
 	db_id,
 	adminlevel,
 	fschein
}

enum buildingsenum{
	Float:b_x,
	Float:b_y,
	Float:b_z,
	Float:b_ix,
	Float:b_iy,
	Float:b_iz,
	b_interior,
	b_shopname[15]

}

enum carenum{
	model,
	id_x,
	besitzer,
	Float:c_x,
	Float:c_y,
	Float:c_z,
	Float:c_r,
 	db_id

}


enum autohausenum{
	Float:s_x,
	Float:s_y,
	Float:s_z,
	Float:s_r
}

enum autohauscarenum{
	model,
  	Float:c_x,
	Float:c_y,
  	Float:c_z,
  	Float:c_r,
  	c_preis,
	autohaus_id,
	id_x
}

//Globale Variablen
new dbhandle;
new sInfo[MAX_PLAYERS][playerInfo];
new bInfo[][buildingsenum] ={
{243.0825,-178.3224,1.5822,285.3642,-41.5576,1001.5156,1,"AMMUN1"},//Ammu Nation 1
{212.1142,-202.1886,1.5781,372.4523,-133.5244,1001.4922,5,"FDPIZA"}//Pizza
};

new cInfo[50][carenum];
new aHinfo[][autohausenum]={
{249.1584,33.0845,2.1068,92.5649},//ID 0  1.Autohaus
{189.8954,-264.5032,1.3052,179.3357}//Autohaus 1  2.Autohaus
};

new ahCars [] [autohauscarenum]= {
{411,220.5418,9.1059,2.1784,256.2599,280000,0},
{560,220.4326,3.2825,2.1747,239.3723,50000,0},
{422,215.4584,-267.1372,1.3052,4.5562,20000,1}

};

#pragma tabsize 0
//Farben
#define COLOR_RED 0xC00000FF
#define COLOR_YELLOW 0xFFC800FF
#define COLOR_GREY 0x828282FF
#define COLOR_DARK_RED 0x6A0000FF
#define COLOR_GREEN 0x00FF00FF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_HGREEN 0x9ACD32FF

//Dialoge
#define DIALOG_TP 1
#define DIALOG_REGISTER 2
#define DIALOG_LOGIN 3
#define DIALOG_ADMIN 4
#define DIALOG_STREAM 5
#define DIALOG_AUTOHAUS 6


//MySQL
#define DB_HOST "127.0.0.1"
#define DB_USER "samp"
#define DB_PAS "samp"
#define DB_DB "samp"

//Forwards
forward OnUserCheck(playerid);
forward OnPasswordResponse(playerid);
forward CarSavedToDB(carid);
forward OnPlayerCarsLoad(playerid);

main()
{

}

ocmd:delveh(playerid,params[])
{
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	new vID;
	if(sscanf(params,"i",vID))return SendClientMessage(playerid,COLOR_GREY,"/delveh [vID]");
	DestroyVehicle(vID);
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
	return 1;
}

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Testscript");
	AddPlayerClass(1,199.0846,-150.0331,1.5781,359.1443,WEAPON_MP5,500,0,0,0,0);
	AddPlayerClass(189,199.0846,-150.0331,1.5781,359.1443,WEAPON_DEAGLE,500,0,0,0,0);
	AddPlayerClass(3,199.0846,-150.0331,1.5781,359.1443,WEAPON_MP5,500,0,0,0,0);
	AddPlayerClass(45,1199.0801,-919.2095,43.1990,359.1443,WEAPON_MP5,500,0,0,0,0);
    EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();



	//Gebäude laden
	for(new i=0; i<sizeof(bInfo); i++)
	{
 	CreatePickup(1239,1,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z],0);
 	Create3DTextLabel("Zum betreten /enter",COLOR_WHITE,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z],10,0,0);
	}

	//Autohaus laden
	for(new i=0; i<sizeof(ahCars); i++)
	{
	ahCars[i][id_x]=AddStaticVehicle(ahCars[i][model],ahCars[i][c_x],ahCars[i][c_y],ahCars[i][c_z],ahCars[i][c_r],-1,-1);
	}

	//Autos erstellen
	AddStaticVehicle(560,201.9496,-139.9986,1.1860,358.9294,-1,-1); // Sultan



	//MySQL
	dbhandle=mysql_connect(DB_HOST,DB_USER,DB_DB,DB_PAS);

	return 1;
}

public OnGameModeExit()
{
	mysql_close(dbhandle);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid,199.0846,-150.0331,1.5781);
	SetPlayerCameraPos(playerid, 199.2307,-143.8328,1.5781);
	SetPlayerCameraLookAt(playerid, 199.0846,-150.0331,1.5781);
	SetPlayerFacingAngle(playerid,359.1443);
	return 1;
}

public OnUserCheck(playerid)
{
	new num_rows,num_fields;
	cache_get_data(num_rows,num_fields,dbhandle);
	if(num_rows==0)
	{
	    //Registrierung
	    ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_INPUT,"Registrierung","Gib bitte dein gewÃ¼nschtes Passwort an:","Okay","Abbrechen");
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
    PlayAudioStreamForPlayer(playerid, "http://127.0.0.1/musik/musik.mp3",0.0,0.0,0.0, 1);
	new nachricht[128];
	format(nachricht,sizeof(nachricht),"Du bist mit der ID %i verbunden.",playerid);
	SendClientMessage(playerid,COLOR_RED,nachricht);


	//login/Register
	new name[MAX_PLAYER_NAME],query[128];
	GetPlayerName(playerid,name,sizeof(name));
	format(query,sizeof(query),"SELECT id FROM user WHERE username='%s'",name);
	mysql_function_query(dbhandle,query,true,"OnUserCheck","i",playerid);
	return 1;
}

savePlayer(playerid)
{
	if(sInfo[playerid][eingeloggt]==0)return 1;
	//speichern level,money
	new query[128];
	format(query,sizeof(query),"UPDATE user SET level='%i',money='%i'WHERE id='%i',adminlevel='%i'",sInfo[playerid][level],GetPlayerMoney(playerid),sInfo[playerid][db_id],sInfo[playerid][adminlevel]);
	mysql_function_query(dbhandle,query,false,"","");
	return 1;
}

resetPlayer(playerid)
{	for(new i=0; i<sizeof(sInfo[]); i++)
	{
 	sInfo[playerid][playerInfo:i]=0;
	}return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	for(new i=0; i<sizeof(cInfo); i++)
	{
	    if(cInfo[i][id_x]==0)continue;
	    if(cInfo[i][besitzer]!=sInfo[playerid][db_id])continue;
	    GetVehiclePos(cInfo[i][id_x],cInfo[i][c_x],cInfo[i][c_y],cInfo[i][c_z]);
	    GetVehicleZAngle(cInfo[i][id_x],cInfo[i][c_r]);
	    new query[128];
	    format(query,sizeof(query),"UPDATE autos SET x='%f',y='%f',z='%f',r='%f'WHERE id='%i'",cInfo[i][c_x],cInfo[i][c_y],cInfo[i][c_z],cInfo[i][c_r],cInfo[i][db_id]);
	    mysql_function_query(dbhandle,query,false,"","");
	    DestroyVehicle(cInfo[i][id_x]);
	    cInfo[i][id_x]=0;
	}
	savePlayer(playerid);
	resetPlayer(playerid);
	StopAudioStreamForPlayer(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	StopAudioStreamForPlayer(playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
 // Declare 3 float variables to store the X, Y and Z coordinates in
    new Float:x, Float:y, Float:z;

    // Use GetPlayerPos, passing the 3 float variables we just created
    GetPlayerPos(playerid, x, y, z);

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
public CarSavedToDB(carid)
{
	cInfo[carid][db_id]=cache_insert_id(dbhandle);
	return 1;
}
/*saveCarToDB(playerid,carid)
{
	new query[128];
 	format(query,sizeof(query),"INSERT INTO autos (besitzer,model,x,y,z,r) VALUES ('%i','%i','%f','%f','%f','%f')",sInfo[playerid][db_id],cInfo[carid][model],cInfo[carid][c_x],cInfo[carid][c_y],cInfo[carid][c_z],cInfo[carid][c_r]);
	mysql_function_query(dbhandle,query,true,"CarSavedToDB","i",carid);
	return 1;
}*/


createCar(playerid,modelid,Float:x,Float:y,Float:z,Float:r)
{
	for(new i=0; i<sizeof(cInfo); i++)
	{
	    if(cInfo[i][id_x]!=0)continue;
	    GetPlayerName(playerid,cInfo[i][besitzer],MAX_PLAYER_NAME);
		cInfo[i][besitzer]=sInfo[playerid][db_id];
		cInfo[i][c_x]=x;
	    cInfo[i][c_y]=y;
	    cInfo[i][c_z]=z;
	    cInfo[i][c_r]=r;
	    cInfo[i][model]=modelid;
	    cInfo[i][id_x] = CreateVehicle(modelid,x,y,z,r,-1,-1,-1);
	    new string[128];
	    format(string,sizeof(string),"Das Auto cInfo[%i] wurde erstellt.",cInfo[i][model]);
	    SendClientMessage(playerid,COLOR_RED,string);

	    return 1;
	}
	return 1;
}

//Befehle
ocmd:vcam(playerid,params[])
{
	new pID;
   	if(sscanf(params,"i",pID))return SendClientMessage(playerid,COLOR_GREY,"/vcam [playerid]");
    new Float:vehx, Float:vehy, Float:vehz;
	GetVehiclePos(pID, vehx, vehy,vehz);
	CreateObject(367, vehx, vehy, vehz, 0.0, 0.0, 96.0);
	GetObjectPos(367, vehx, vehy, vehz);
return 1;
}
ocmd:stopvcam(playerid,params[])
{
TogglePlayerSpectating(playerid,0);
return 1;
}

ocmd:setskin(playerid,params[])
{
 new pID,sID;
if(sscanf(params,"ii",pID,sID))return SendClientMessage(playerid,COLOR_GREY,"/setskin [playerid] [skinid]");
SetPlayerSkin(pID,sID);
return 1;
}

ocmd:exit(playerid,params[])
{
	for(new i=0; i<sizeof(bInfo); i++)
	{
	    if(GetPlayerVirtualWorld(playerid)!=i)continue;
	    if(!IsPlayerInRangeOfPoint(playerid,2,bInfo[i][b_ix],bInfo[i][b_iy],bInfo[i][b_iz]))continue;
	    SetPlayerPos(playerid,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z]);
	    SetPlayerInterior(playerid,0);
	    SetPlayerVirtualWorld(playerid,0);
    	return 1;
	}
	return 1;
}

ocmd:givegun(playerid,params[])
{
	new pID,gun,ammo;
	if(sscanf(params,"iii",pID,gun,ammo))return SendClientMessage(playerid,COLOR_GREY,"/givegun [playerid] [WaffenID] [Munition]");
    GivePlayerWeapon(pID, gun, ammo);
    return 1;
}


ocmd:enter(playerid,params[])
{
	for(new i=0; i<sizeof(bInfo); i++)
	{
	if(!IsPlayerInRangeOfPoint(playerid,2,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z]))continue;
	SetPlayerPos(playerid,bInfo[i][b_ix],bInfo[i][b_iy],bInfo[i][b_iz]);
	SetPlayerInterior(playerid,bInfo[i][b_interior]);
	SetPlayerVirtualWorld(playerid,i);
	SetPlayerShopName(playerid,bInfo[i][b_shopname]);
	return 1;
	}
	return 1;
}
//ADMINSYSTEM
ocmd:tpmenu(playerid,params[])
{
    if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	ShowPlayerDialog(playerid,DIALOG_TP,DIALOG_STYLE_LIST,"TP-Menü","spawn\nBSN\n","Weiter","Abbrechen");
	return 1;
}

/*if(strcmp(cmdtext, "/gettuev", true) == 0)
{
	if(!IsPlayerInRangeOfPoint(playerid,2,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z]))return SendClientMessage(playerid,COLOR_GREY,"Du bist nicht am TÃœV-Punkt in SF")
    new Float:health;
    new veh = GetPlayerVehicleID(playerid);
    GetVehicleHealth(veh, health);
    if(health < 650) return SendClientMessage(playerid, COLOR_GREY, "Dein Fahrzeug ist zu sehr beschÃ¤digt um TÃœV zu bekommen.");

}
*/


ocmd:stream(playerid,params[])
{
	ShowPlayerDialog(playerid,DIALOG_STREAM,DIALOG_STYLE_LIST,"Streamliste","Stream stoppen\nBreakzFM\nHoptek","Play","Abbrechen");

	return 1;

}

ocmd:aheal(playerid,params[])
{
	SetPlayerHealth(playerid,200.0);
	return 1;

}
ocmd:aarmour(playerid,params[])
{
	SetPlayerArmour(playerid,100.0);
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

isAdmin(playerid,a_level)
{
	if(sInfo[playerid][adminlevel]>=a_level)return 1;
	return 0;
}


	ocmd:restart(playerid,params[]){
	if(!isAdmin(playerid,3))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	SendClientMessageToAll(COLOR_DARK_RED, "RESTART ERFOLGT JETZT!!!");
	SendRconCommand("gmx");
	return 1;
	}
	ocmd:test(playerid,params[])
	{
	    SendClientMessage(playerid,COLOR_RED,"Du hast /test eingegeben.");
	    return 1;
	}
	ocmd:serverstop(playerid,params[])
	{
	SendClientMessageToAll(COLOR_DARK_RED, "DER SERVER GEHT JETZT OFFLINE!!!");
	SendRconCommand("exit");
	return 1;
}
	ocmd:stopserver(playerid,params[])
	{
	SendClientMessageToAll(COLOR_DARK_RED, "DER SERVER GEHT JETZT OFFLINE!!!");
	SendRconCommand("exit");
	return 1;
}


public OnPlayerCommandText(playerid, cmdtext[])
{

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
	if(newstate==PLAYER_STATE_DRIVER)
 	{
 	new vID=GetPlayerVehicleID(playerid);
 	for(new i=0; i<sizeof(ahCars); i++)
 	{
	if(ahCars[i][id_x]!=vID)continue;
	//verkaufsprozess
	SetPVarInt(playerid,"buyCarID",i);
	new string[256];
	format(string,sizeof(string),"Möchten sie das Fahrzeug für %i$ kaufen?",ahCars[i][c_preis]);
	ShowPlayerDialog(playerid,DIALOG_AUTOHAUS,DIALOG_STYLE_MSGBOX,"Autohändler",string,"Ja","Nein");
	break;
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
	if(newkeys & KEY_NO)
	{
	//Enterbefehl
	ocmd_enter(playerid,"");
	return 1;
	}
	if(newkeys & KEY_YES)
	{
	//exitbefehl
	ocmd_exit(playerid,"");
	return 1;
	}
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

SetPlayerMoney(playerid,money)
{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,money);
	return 1;
}
getFreeCarID()
{
	for(new i=0; i<sizeof(cInfo); i++)
	{
	    if(cInfo[i][id_x]==0)return i;
	}
	return 0;
}

public OnPlayerCarsLoad(playerid)
{
	new num_fields,num_rows;
	cache_get_data(num_rows,num_fields,dbhandle);
	if(!num_rows)return 1;
	for(new i=0; i<num_rows; i++)
	{
		new id=getFreeCarID();
		cInfo[id][model]=cache_get_field_content_int(i,"model",dbhandle);
		cInfo[id][besitzer]=cache_get_field_content_int(i,"besitzer",dbhandle);
		cInfo[id][c_x]=cache_get_field_content_float(i,"x",dbhandle);
		cInfo[id][c_y]=cache_get_field_content_float(i,"y",dbhandle);
		cInfo[id][c_z]=cache_get_field_content_float(i,"z",dbhandle);
		cInfo[id][c_r]=cache_get_field_content_float(i,"r",dbhandle);
		cInfo[id][db_id]=cache_get_field_content_int(i,"id",dbhandle);
		cInfo[id][id_x]=CreateVehicle(cInfo[id][model],cInfo[id][c_x],cInfo[id][c_y],cInfo[id][c_z],cInfo[id][c_r],-1,-1,-1);
	}
	return 1;
}

loadPlayerCars(playerid)
{
	new query[128];
	format(query,sizeof(query),"SELECT * FROM autos WHERE besitzer='%i'",sInfo[playerid][db_id]);
	mysql_function_query(dbhandle,query,true,"OnPlayerCarsLoad","i",playerid);
	return 1;
}


public OnPasswordResponse(playerid)
{
	new num_fields,num_rows;
	cache_get_data(num_rows,num_fields,dbhandle);
	if(num_rows==1)
	{
	    //Passwort richtig
	    sInfo[playerid][eingeloggt] = 1;
	    sInfo[playerid][level] = cache_get_field_content_int(0,"level",dbhandle);
	    SetPlayerScore(playerid,sInfo[playerid][level]);
	    sInfo[playerid][db_id] = cache_get_field_content_int(0,"id",dbhandle);
	    SetPlayerMoney(playerid,cache_get_field_content_int(0,"money",dbhandle));
	    sInfo[playerid][adminlevel] = cache_get_field_content_int(0,"adminlevel",dbhandle);
	    loadPlayerCars(playerid);
	}
	else
	{
	    //Passwort falsch
	    SendClientMessage(playerid,COLOR_RED,"Das eingegebene Passwort ist falsch.");
	    ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,"Login","Gibt bitte dein Passwort ein:","Okay","Abbrechen");
	}
}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid==DIALOG_AUTOHAUS)
	{
	if(response)
	{
	//Autoverkauf
	new id=GetPVarInt(playerid,"buyCarID");
	if(GetPlayerMoney(playerid)<ahCars[id][c_preis])
	{
        SendClientMessage(playerid,COLOR_GREY,"Du hast nicht genug Geld bei dir.");
        RemovePlayerFromVehicle(playerid);
        return 1;
	}
	GivePlayerMoney(playerid,-ahCars[id][c_preis]);
	createCar(playerid,ahCars[id][model],aHinfo[ahCars[id][autohaus_id]][s_x],aHinfo[ahCars[id][autohaus_id]][s_y],aHinfo[ahCars[id][autohaus_id]][s_z],aHinfo[ahCars[id][autohaus_id]][s_r]);
	SendClientMessage(playerid,COLOR_YELLOW,"Du hast ein Auto erfolgreich gekauft");
	RemovePlayerFromVehicle(playerid);
	}
	else
	{
	RemovePlayerFromVehicle(playerid);
	SendClientMessage(playerid,COLOR_GREY,"Dann eben nicht...");
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
	            format(query,sizeof(query),"SELECT * FROM user WHERE username='%s' AND passwort=MD5('%s')",name,passwort);
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
	            mysql_function_query(dbhandle,query,false,"","");
	        }
	        else
	        {
	            //Kleiner als 4 Zeichen
	            SendClientMessage(playerid,COLOR_RED,"Dein Passwort muss mindestens 4 Zeichen lang sein.");
	            ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_INPUT,"Registrierung","Gib bitte dein gewÃ¼nschtes Passwort an:","Okay","Abbrechen");
	        }
	    }
	    else
	    {
	        Kick(playerid);
	    }
	    return 1;
	}


	if(dialogid==DIALOG_STREAM)
	{
		if (response)
		{
			if(listitem==0)
			{
				StopAudioStreamForPlayer(playerid);
				SendClientMessage(playerid,COLOR_HGREEN,"Stream beendet");
				return 1;
			}
			if(listitem==2)
			{
			PlayAudioStreamForPlayer(playerid, "http://127.0.0.1/musik/musik.mp3",0.0,0.0,0.0, 1);
			SendClientMessage(playerid,COLOR_HGREEN,"Du hast das Radio angeschaltet. Viel Spaß beim Hören!");
			return 1;
			}
			if(listitem==1)
			{
			PlayAudioStreamForPlayer(playerid,"http://radio.breakz.fm/listen.pls",0.0,0.0,0.0, 1);
			SendClientMessage(playerid,COLOR_HGREEN,"Du hast das Radio angeschaltet. Viel Spaß beim Hören!");
			return 1;
			}
			else
			{
				SendClientMessage(playerid,COLOR_GREY,"Vorgang abgebrochen.");
			}
		}
	}
	if(dialogid==DIALOG_TP)
	{
	    if(response)
	    {
			if(listitem==0)
			{
			    //Spawn
			    SetPlayerPos(playerid,199.0846,-150.0331,1.5781);
			}
			if(listitem==1)
			{
			    //Farm
			    SetPlayerPos(playerid,1199.0903,-901.1480,48.0625);

			}

			if(listitem==2)
			{
			    //LSPD
			    SetPlayerPos(playerid,1539.6733,-1657.0175,13.5491);
			}
			if(listitem==3)
			{
			//Noot
			SetPlayerPos(playerid,212.1142,-202.1886,1.5781);
			}
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_RED,"Vorgang abgebrochen.");
	    }
	 return 1;
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
