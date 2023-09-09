//includes
#include <a_samp>
#include <zCMD>
#include <sscanf2>
#include <a_mysql>
#include <streamer>

//Farben
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
#define COLOR_LILA 0x9600FFFF

//Dialoge
#define DIALOG_TP 1
#define DIALOG_REGISTER 2
#define DIALOG_LOGIN 3
#define DIALOG_ADMIN 4
#define DIALOG_STREAM 5
#define DIALOG_AUTOHAUS 6
#define DIALOG_ADUTY 7
#define DIALOG_VSPAWN 8
#define DIALOG_ASPAWN 9
#define DIALOG_BSPAWN 10
#define DIALOG_FSPAWN 11
#define DIALOG_SPAWNCHANGE 12

//MySQL
#define DB_HOST "127.0.0.1"
#define DB_USER "samp"
#define DB_PAS "samp"
#define DB_DB "samp"

//Limits
#define CHAT_RADIUS 40
#define CHAT_FADES 5



//enums
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
 	aduty,
 	fraktion,
 	rang,
 	spawnchange,
 	pdonut,
 	pgreen,
 	pgold,
 	plsd
}

enum hausEnum{
	Float:h_x,
	Float:h_y,
	Float:h_z,
	Float:ih_x,
	Float:ih_y,
	Float:ih_z,
	h_interior,
	h_besitzer[MAX_PLAYER_NAME],
	h_preis,
	h_level,
	h_id,
	h_pickup,
	Text3D:h_text
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
 	db_id,
 	farbe1,
 	farbe2

}
enum frakEnum{
	f_name[128],
	Float:f_x,
	Float:f_y,
	Float:f_z,
	Float:f_r,
	f_inter,
	f_world,
	f_color
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
enum trashEnum{
	Float:t_x,
	Float:t_y,
	Float:t_z
}
enum busEnum{
	Float:bj_x,
	Float:bj_y,
	Float:bj_z
}
enum jobEnum{
	jobname[128],
	Float:j_x,
	Float:j_y,
	Float:j_z
}



//Globale Variablen
new dbhandle;
new sInfo[MAX_PLAYERS][playerInfo];
new hInfo[100] [hausEnum];
new pSkin;
new pVCam[MAX_PLAYERS] = {-1, ...};
#pragma tabsize 0
new autosOhneMotor[] = {509,510,481};
new Text:uhrzeitlabel;
new PlayerText:tankLabel[MAX_PLAYERS];
new tank[2000];
new Schranke;
new lift1;
new lift2;
new Text:Textdraw0;
new Text:Tacho;
new Text:kmhtd;
new cInfo[50][carenum];
new Float:dx,Float:dy,Float:dz;

//Fraktionen
new fInfo[][frakEnum] = {
{"Zivilist",0.0,0.0,0.0,0.0,0,0,COLOR_WHITE},
{"SAPD",197.2779,165.4692,1003.0234,0.0,3,0,COLOR_BLUE},
{"SARD",1886.0059,702.2399,11.3417,0.0,0,0,COLOR_PINK}
};


//Läden
new bInfo[][buildingsenum] ={
{243.0825,-178.3224,1.5822,285.3642,-41.5576,1001.5156,1,"AMMUN1"},//Ammu Nation 1
{212.1142,-202.1886,1.5781,372.4523,-133.5244,1001.4922,5,"FDPIZA"}//Pizza
};



//Autohäuser
new aHinfo[][autohausenum]={
{249.1584,33.0845,2.1068,92.5649},//ID 0  1.Autohaus
{189.8954,-264.5032,1.3052,179.3357}//Autohaus 1  2.Autohaus
};


//Autohausautos
new ahCars [] [autohauscarenum]= {
{411,220.5418,9.1059,2.1784,256.2599,280000,0},
{494,220.4326,3.2825,2.1747,239.3723,50000,0},
{422,215.4584,-267.1372,1.3052,4.5562,20000,1}
};


//Jobpointenum
new JPs[][jobEnum] = {
{"Müllmann",1448.9958,-1847.5634,13.5469},
{"Busfahrer",1080.3252,-1741.1746,13.4900}
};


//TrashCPs
new tCPs[][trashEnum] = {
{1501.5718,-1734.2002,13.3461},
{1895.4915,-1756.0924,13.3509},
{1945.1288,-1681.0978,13.3464},
{1835.5559,-1608.9244,13.3485},
{1536.8174,-1588.7954,13.3478},
{1425.6224,-1633.9657,13.3445},
{1500.9349,-1735.0754,13.3500}
};


//BusCPs
new bCPs[][busEnum] = {
{1501.5718,-1734.2002,13.3461},
{1895.4915,-1756.0924,13.3509},
{1945.1288,-1681.0978,13.3464},
{1835.5559,-1608.9244,13.3485},
{1536.8174,-1588.7954,13.3478},
{1425.6224,-1633.9657,13.3445},
{1500.9349,-1735.0754,13.3500}
};


//forwards
forward OnUserCheck(playerid);
forward OnPasswordResponse(playerid);
forward CarSavedToDB(carid);
forward sekunde();
forward OnPlayerCarsLoad(playerid);
forward OnHausesLoad();
forward unfreezePlayer(playerid);
forward OnPlayerRegister(playerid);
forward OnHausCreated(id);

main()
{

}

//Abfragen

isAdmin(playerid,a_level)
{
	if(sInfo[playerid][adminlevel]>=a_level)return 1;
	return 0;
}

//isManagement(playerid)
//{
//	if(sInfo[playerid][adminlevel]==6)return 1;
//	return 0;
//}

isAlevel(playerid, a_level)
{
	if(sInfo[playerid][adminlevel]==a_level)return 1;
	return 0;
}

isaduty(playerid)
{
	if(GetPVarInt(playerid,"aduty")>0)return 1;
	return 0;
}

loadJobs()
{
for(new i=0; i<sizeof(JPs); i++)
	{
	new string[256];
	format(string,sizeof(string), "Job: %s",JPs[i][jobname]);
 	CreatePickup(1239,1,JPs[i][j_x],JPs[i][j_y],JPs[i][j_z],0);
    Create3DTextLabel(string,COLOR_ORANGE,JPs[i][j_x],JPs[i][j_y],JPs[i][j_z]+0.25,10,0,0);
 	Create3DTextLabel("Zum starten /startjob",COLOR_WHITE,JPs[i][j_x],JPs[i][j_y],JPs[i][j_z],10,0,0);
 	}
	return 1;
}

public OnGameModeInit()
{
    CreatePickup(1239,1,1038.0804,-1339.8496,13.7343,0);
	loadJobs();
	SetTimer ("sekunde",1000,1);
	SetTimer("FPS", 251, true);
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	UsePlayerPedAnims();
	SetGameModeText("Testscript");
    EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	ManualVehicleEngineAndLights();
	LoadAdminCars();
	
	//adutyTD
	Textdraw0 = TextDrawCreate(547.000000, 55.000000, "Admindienst");
	TextDrawBackgroundColor(Textdraw0, 255);
	TextDrawFont(Textdraw0, 1);
	TextDrawLetterSize(Textdraw0, 0.280000, 1.000000);
	TextDrawColor(Textdraw0, -16776961);
	TextDrawSetOutline(Textdraw0, 1);
	TextDrawSetProportional(Textdraw0, 1);
	//TachoTD
	Tacho = TextDrawCreate(460.000000, 430.000000, "0");
	//KMHTD
	kmhtd = TextDrawCreate(500.000000, 430.000000, "KM/H");
	TextDrawBackgroundColor(kmhtd, 255);
	TextDrawFont(kmhtd, 1);
	TextDrawLetterSize(kmhtd, 0.500000, 1.000000);
	TextDrawColor(kmhtd, -1);
	TextDrawSetOutline(kmhtd, 0);
	TextDrawSetProportional(kmhtd, 1);
	TextDrawSetShadow(kmhtd, 1);
	TextDrawUseBox(kmhtd, 1);
	TextDrawBoxColor(kmhtd, 255);
	TextDrawTextSize(kmhtd, 640.000000, -479.000000);
	lift1 =  CreateObject(3115,390.9899900,-1942.3500000,6.5000000,0.0000000,0.0000000,0.0000000); //object(carrier_lift1_sfse) (1)
	lift2 = CreateObject(6933,391.7999900,-2003.5000000,-60.0000000,0.0000000,0.0000000,0.0000000); //object(vegasplant0 (1)
	//MySQL
	dbhandle=mysql_connect(DB_HOST,DB_USER,DB_DB,DB_PAS);

	//Gebäude laden
	for(new i=0; i<sizeof(bInfo); i++)
	{
 	CreatePickup(1239,1,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z],0);
    Create3DTextLabel("Zum betreten /enter",COLOR_ORANGE,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z]+0.25,10,0,0);
 	Create3DTextLabel("Zum betreten /enter",COLOR_WHITE,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z],10,0,0);
	}

	//Autohaus laden
	for(new i=0; i<sizeof(ahCars); i++)
	{
	ahCars[i][id_x]=AddStaticVehicle(ahCars[i][model],ahCars[i][c_x],ahCars[i][c_y],ahCars[i][c_z],ahCars[i][c_r],-1,-1);
	}
	
	//Häuser laden
	new query[128];
	format(query,sizeof(query), "SELECT * FROM haus");
	mysql_function_query(dbhandle,query,true,"OnHausesLoad","");

	//Autos erstellen
	AddStaticVehicle(560,201.9496,-139.9986,1.1860,358.9294,-1,-1); // Sultan

	uhrzeitlabel = TextDrawCreate(549.0000, 14.0000, "00:00");
	TextDrawBackgroundColor(uhrzeitlabel, 255);
	TextDrawFont(uhrzeitlabel, 3);
	TextDrawLetterSize(uhrzeitlabel, 0.580000, 2.399999);
	TextDrawColor(uhrzeitlabel, -1);
	TextDrawSetOutline(uhrzeitlabel, 1);
	TextDrawSetProportional(uhrzeitlabel, 1);

	for(new i=0; i<sizeof(tank); i++)
	{
		tank[i]=100;
	}
	
	printf("====================================================================");
	printf("Der Server wurde erfolgreich gestartet");
	printf("====================================================================");
	return 1;
}



public OnHausesLoad()
{
    new num_fields,num_rows;
	cache_get_data(num_rows,num_fields,dbhandle);
	if(!num_rows)return 1;
	for(new i=0; i<num_rows; i++)
	{
		new id=getFreeHausID();
		hInfo[id][h_x]=cache_get_field_content_float(i, "h_x", dbhandle);
		hInfo[id][h_y]=cache_get_field_content_float(i, "h_y", dbhandle);
		hInfo[id][h_z]=cache_get_field_content_float(i, "h_z", dbhandle);
		hInfo[id][ih_x]=cache_get_field_content_float(i, "ih_x", dbhandle);
		hInfo[id][ih_y]=cache_get_field_content_float(i, "ih_y", dbhandle);
		hInfo[id][ih_z]=cache_get_field_content_float(i, "ih_z", dbhandle);
		hInfo[id][h_interior]=cache_get_field_content_int(i, "h_interior", dbhandle);
		new tmp_name[MAX_PLAYER_NAME];
		cache_get_field_content(i, "besitzer", tmp_name, dbhandle);
		strmid(hInfo[id][h_besitzer], tmp_name, 0, sizeof(tmp_name), sizeof(tmp_name));
		hInfo[id][h_id]=cache_get_field_content_int(i, "id", dbhandle);
		hInfo[id][h_preis]=cache_get_field_content_int(i, "h_preis", dbhandle);
		hInfo[id][h_level]=cache_get_field_content_int(i, "h_level", dbhandle);
		updateHaus(id);
	}
	return 1;
}

LoadAdminCars()
{
AddStaticVehicle(503,1411.2550,-2330.7727,13.4718,0.0601,36,117); // av1
AddStaticVehicle(439,1411.1832,-2313.7393,13.3505,179.5772,65,79); // av2
AddStaticVehicle(477,1404.5852,-2330.7622,13.3368,0.2907,36,1); // av3
AddStaticVehicle(431,1421.9589,-2339.6245,13.7036,358.5345,47,74); // av4
}

updateHaus(id)
{
    new string[128];
	if(hInfo[id][h_pickup])
	{
	    DestroyPickup(hInfo[id][h_pickup]);
	}
	if(hInfo[id][h_text])
	{
	    Delete3DTextLabel(hInfo[id][h_text]);
	}
    if(!strlen(hInfo[id][h_besitzer]))
	{
		hInfo[id][h_pickup]=CreatePickup(1273, 1, hInfo[id][h_x], hInfo[id][h_y], hInfo[id][h_z], -1);
		format(string,sizeof(string), "Zum Verkauf\nKosten: %i$\nLevel:%i\n/buyhouse", hInfo[id][h_preis],hInfo[id][h_level]);
		hInfo[id][h_text]=Create3DTextLabel(string,0xFF0000BE, hInfo[id][h_x], hInfo[id][h_y], hInfo[id][h_z], 10, 0, 1);
	}
	else
	{
		hInfo[id][h_pickup]=CreatePickup(1239, 1, hInfo[id][h_x], hInfo[id][h_y], hInfo[id][h_z], -1);
		format(string,sizeof(string), "Besitzer: %s\n/enter", hInfo[id][h_besitzer]);
		hInfo[id][h_text]=Create3DTextLabel(string, COLOR_BLUE, hInfo[id][h_x], hInfo[id][h_y], hInfo[id][h_z], 10, 0, 1);
	}
	return 1;
}

public OnGameModeExit()
{
	mysql_close(dbhandle);
	return 1;
}



public OnPlayerRegister(playerid)
{
sInfo[playerid][eingeloggt] = 1;
sInfo[playerid][db_id] = cache_insert_id(dbhandle);
return 1;
}
isMotorOn(vID)
{
	new tmp_engine, tmp_light, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective;
	GetVehicleParamsEx(vID, tmp_engine, tmp_light, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);

	if(tmp_engine == 1)return 1;
	return 0;
}
stopMotor(vID)
{
    new tmp_engine, tmp_light, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective;
	GetVehicleParamsEx(vID, tmp_engine, tmp_light, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	SetVehicleParamsEx(vID, 0, tmp_light, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	return 1;
}
hatAutoMotor(vID)
{
	new vModel = GetVehicleModel(vID);

    for(new i=0; i<sizeof(autosOhneMotor); i++)
    {
   		if(autosOhneMotor[i]!=vModel)continue;
   		return 0;
	}
	return 1;
}

getVehicleName(v_model)
{
    new carNames[212][] = {"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Feuerwehr","Trashmaster","Stretch","Manana","Infernus",
    "Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
    "Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
    "Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
    "Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
    "Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina",
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

new tanktimer = 0;
public sekunde()
{

	new string[128];
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i))continue;
		if(!IsPlayerInAnyVehicle(i))continue;
		format(string,sizeof(string),"%i", getPlayerSpeed(i));
		  TextDrawSetString(Tacho, string);
		new vID = GetPlayerVehicleID(i);
		format(string, sizeof(string), "Tank: %i%%~n~%s", tank[vID], getVehicleName(GetVehicleModel(vID)));
		PlayerTextDrawSetString(i, tankLabel[i], string);
	}

	tanktimer++;
	if(tanktimer == 15)
	{
	    tanktimer = 0;
		//Tanks reduzieren
		for(new i=1; i<sizeof(tank); i++)
		{
		    if(!hatAutoMotor(i))continue;
		    if(!isMotorOn(i))continue;
		    tank[i]--;
		    if(tank[i]>0)continue;
			stopMotor(i);
		}
 }

 new hour,minute,second;
	gettime(hour,minute,second);
	format(string,sizeof(string),"%02d:%02d",hour,minute);
	TextDrawSetString(uhrzeitlabel,string);
}

public OnPlayerRequestClass(playerid, classid)
{
SetPlayerVirtualWorld(playerid, 3);
return 1;
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
//Textdraws
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
	pVCam[playerid] = -1;
	
	//login/Register
	new name[MAX_PLAYER_NAME],query[128];
	GetPlayerName(playerid,name,sizeof(name));
	format(query,sizeof(query),"SELECT id FROM user WHERE username='%s'",name);
	mysql_function_query(dbhandle,query,true,"OnUserCheck","i",playerid);

	GetPlayerName(playerid,name,sizeof(name));
	format(query,sizeof(query),"SELECT skin FROM user WHERE username='%s'",name);
	mysql_function_query(dbhandle,query,true,"OnUserCheck","i",playerid);
	SetPlayerScore(playerid,sInfo[playerid][level]);
		//Uhrzeit
	TextDrawShowForPlayer(playerid, uhrzeitlabel);
	SetPlayerColor(playerid, COLOR_WHITE);
	
	//Textdraw Erstellen
		tankLabel[playerid] = CreatePlayerTextDraw(playerid,547.000000, 418.000000, "Tank:100%");
	PlayerTextDrawBackgroundColor(playerid, tankLabel[playerid], 255);
	PlayerTextDrawFont(playerid, tankLabel[playerid], 1);
	PlayerTextDrawLetterSize(playerid, tankLabel[playerid], 0.380000, 1.200000);
	PlayerTextDrawColor(playerid, tankLabel[playerid], -1);
	PlayerTextDrawSetOutline(playerid, tankLabel[playerid], 0);
	PlayerTextDrawSetProportional(playerid, tankLabel[playerid], 1);
	PlayerTextDrawSetShadow(playerid, tankLabel[playerid], 1);
	PlayerTextDrawHide(playerid, tankLabel[playerid]);
	return 1;
}

savePlayer(playerid)
{
	if(sInfo[playerid][eingeloggt]==0)return 1;
	//speichern level,money
	new query[1024], Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x,y,z);
	format(query,sizeof(query),"UPDATE user SET level='%i',money='%i',adminlevel='%i',skin='%i',fraktion='%i',rang='%i',spawnchange='%i',x='%i',y='%i',z='%i',donut='%i'WHERE id='%i'",sInfo[playerid][level],GetPlayerMoney(playerid),sInfo[playerid][adminlevel],GetPlayerSkin(playerid),sInfo[playerid][fraktion],sInfo[playerid][rang],sInfo[playerid][spawnchange],sInfo[playerid][sx],sInfo[playerid][sy],sInfo[playerid][sz],sInfo[playerid][pdonut],sInfo[playerid][db_id]);
	mysql_function_query(dbhandle,query,false,"","");
//	format(query,sizeof(query),"UPDATE user SET spawnchange='%i',x='%i',y='%i',z='%i',fraktion='%i' ,rang='%i'WHERE id='%i'",sInfo[playerid][spawnchange],sInfo[playerid][sx],sInfo[playerid][sy],sInfo[playerid][sz],sInfo[playerid][fraktion],sInfo[playerid][rang],sInfo[playerid][db_id]);
//	mysql_function_query(dbhandle,query,false,"","");


	return 1;
}

resetPlayer(playerid)
{	for(new i=0; i<sizeof(sInfo[]); i++)
	{
 	sInfo[playerid][playerInfo:i]=0;
	}
	sInfo[playerid][adminlevel] = 0;
	sInfo[playerid][eingeloggt] = false;
	sInfo[playerid][skin] = 0;

	return 1;

}

stock SendAdminMessage(color, string[])
{
	for(new i = 0 ; i < MAX_PLAYERS ; i++)
	{
	    if(IsPlayerConnected(i) && sInfo[i][eingeloggt] == 1)
	    {
	        if(sInfo[i][adminlevel] >= 2)
	        {
	            SendClientMessage(i, color, string);
			}
	    }
	}
	return 1;
}

stock SendTeamMessage(color, string[])
{
	for(new i = 0 ; i < MAX_PLAYERS ; i++)
	{
	    if(IsPlayerConnected(i) && sInfo[i][eingeloggt] == 1)
	    {
	        if(sInfo[i][adminlevel] >= 1)
	        {
	            SendClientMessage(i, color, string);
			}
	    }
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
 savePlayer(playerid);
	for(new i=0; i<sizeof(cInfo); i++)
	{
	    if(cInfo[i][id_x]==0)continue;
	    if(cInfo[i][besitzer]!=sInfo[playerid][db_id])continue;
	    GetVehiclePos(cInfo[i][id_x],cInfo[i][c_x],cInfo[i][c_y],cInfo[i][c_z]);
	    GetVehicleZAngle(cInfo[i][id_x],cInfo[i][c_r]);
	    new query[128];
	    format(query,sizeof(query),"UPDATE autos SET x='%f',y='%f',z='%f',r='%f', tank='%i',f1='%i',f2='%i'WHERE id='%i'",cInfo[i][c_x],cInfo[i][c_y],cInfo[i][c_z],cInfo[i][c_r],tank[i],cInfo[i][farbe1],cInfo[i][farbe2],cInfo[i][db_id]);
	    mysql_function_query(dbhandle,query,false,"","");
	    DestroyVehicle(cInfo[i][id_x]);
	    cInfo[i][id_x]=0;
	}
	resetPlayer(playerid);
	StopAudioStreamForPlayer(playerid);
	pSkin = GetPlayerSkin(playerid);
		new query[128];
	format(query,sizeof(query),"UPDATE user SET skin='%i'",pSkin);
	mysql_function_query(dbhandle,query,false,"","");
	PlayerTextDrawDestroy(playerid, tankLabel[playerid]);
	return 1;
}

	isPlayerInFrak(playerid,f_id){
	if(sInfo[playerid][fraktion]==f_id)return 1;
	return 0;
}


public OnPlayerSpawn(playerid)
{
	StopAudioStreamForPlayer(playerid);
	if(!isPlayerInFrak(playerid,0)){
	if(sInfo[playerid][spawnchange]==1){
	new fID;
	fID = sInfo[playerid][fraktion];
		SetPlayerPos(playerid,fInfo[fID][f_x],fInfo[fID][f_y],fInfo[fID][f_z]);
		SetPlayerFacingAngle(playerid,fInfo[fID][f_r]);
		SetPlayerInterior(playerid,fInfo[fID][f_inter]);
		SetPlayerVirtualWorld(playerid,fInfo[fID][f_world]);
	}
	else
	if(sInfo[playerid][spawnchange]==0){
	for(new i=0; i<sizeof(hInfo);i++)
	{
	    if(!hInfo[i][h_id])continue;
		if(!strlen(hInfo[i][h_besitzer]))continue;
		if(strcmp(hInfo[i][h_besitzer],getPlayerName(playerid),true))continue;
		//Ist Haus von Spieler
		if(hInfo[i][h_interior] != 0)
		{
        SetPlayerPos(playerid,hInfo[i][ih_x],hInfo[i][ih_y],hInfo[i][ih_z]);
        SetPlayerInterior(playerid,hInfo[i][h_interior]);
        SetPlayerVirtualWorld(playerid,i);
		}
		else
		{
			//Vor dem Haus spawnen
			SetPlayerPos(playerid,hInfo[i][h_x],hInfo[i][h_y],hInfo[i][h_z]);
   			SetPlayerInterior(playerid,0);
   		 	SetPlayerVirtualWorld(playerid,0);
			
		}
	if(sInfo[playerid][spawnchange]==2){
	SetPlayerPos(playerid, 1481.59,-1766.32,18.7958);
	SetPlayerFacingAngle(playerid,3.2137);
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	}}
	if(sInfo[playerid][eingeloggt]==0){
		new string[128];
	format(string,sizeof(string),"SERVER: {FFFFFF}Willkommen %s",getPlayerName(playerid));
	SendClientMessage(playerid,COLOR_RED,string);
	}}
		}
	if(sInfo[playerid][spawnchange]==3){
	new Float:x,Float:y,Float:z;
	x = sInfo[playerid][sx];
	y = sInfo[playerid][sy];
	z = sInfo[playerid][sz];
	SetPlayerPos(playerid,x,y,z);

	return 1;
	}
	
	//aduty setzen
	if(sInfo[playerid][adminlevel]>4){
	SetPVarInt(playerid,"aduty",2);
	return 1;
	}
	sInfo[playerid][eingeloggt] = 1;
	return 1;
}
getPlayerSpeed(playerid)
{
	new Float:x, Float:y, Float:z, Float:rtn;
	if(IsPlayerInAnyVehicle(playerid))
	{
	    GetVehicleVelocity(GetPlayerVehicleID(playerid), x, y, z);
 	}
 	else
 	{
		GetPlayerVelocity(playerid, x, y, z);
 	}
 	//rtn = wurzel(x*x + y*y + z*z);
rtn = floatsqroot(x*x + y*y + z*z); //Betroffene zeile (840)
return floatround(rtn * 100 * 1.61); //Betroffene zeile (841)
}

public OnPlayerDeath(playerid, killerid, reason)
{
 // Declare 3 float variables to store the X, Y and Z coordinates in
 //   new Float:x, Float:y, Float:z;

    // Use GetPlayerPos, passing the 3 float variables we just created
    GetPlayerPos(playerid,dx,dy,dz);
   //SetPlayerPos(playerid, x, y, z);
  //  SetPlayerSkin(playerid,sInfo[playerid][skin] );
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
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	new string[128];
 	format(string,sizeof(string), "%s sagt: %s",
			getPlayerName(playerid), text);

	new chat_color;

	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(!IsPlayerConnected(i))continue;
	    if(!IsPlayerInRangeOfPoint(i, CHAT_RADIUS, x, y, z))continue;
	    new Float:distance = GetPlayerDistanceFromPoint(i, x, y, z);
	    if(distance < CHAT_RADIUS / CHAT_FADES)
	    {
			chat_color = COLOR_CHAT;
	    }
		else if(distance < CHAT_RADIUS / CHAT_FADES * 2)
		{
		    chat_color = COLOR_FADE1;
	    }
	    else if(distance < CHAT_RADIUS / CHAT_FADES * 3)
		{
		    chat_color = COLOR_FADE2;
	    }
	    else if(distance < CHAT_RADIUS / CHAT_FADES * 4)
		{
		    chat_color = COLOR_FADE3;
	    }
	    else if(distance <= CHAT_RADIUS / CHAT_FADES * 5)
		{
		    chat_color = COLOR_FADE4;
	    }
	    SendClientMessage(i, chat_color, string);
	}
	return 0;
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
getFreeHausID()
{
	for(new i=0; i<sizeof(hInfo); i++)
	{
	    if(hInfo[i][h_id]==0)return i;
	}
	return 0;
}


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
	    cInfo[i][model]= modelid;
	    cInfo[i][id_x] = CreateVehicle(modelid,x,y,z,r,-1,-1,-1);
	    tank[cInfo[i][id_x]] = 100;
	    new string[128];
	    format(string,sizeof(string),"Das Auto cInfo[%i] wurde erstellt.",modelid);
	    SendClientMessage(playerid,COLOR_RED,string);

	    return 1;
	}
	return 1;
}

public unfreezePlayer(playerid)
{
	TogglePlayerControllable(playerid,true);
	return 1;
}




//Adminbefehle
CMD:supportveh(playerid,params[])
{
new Float:x,Float:y,Float:z,Float:r;
	if(!isAdmin(playerid,1))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,r);
	new vID = CreateVehicle(457,x,y,z,r,-1,-1,0,0);
	PutPlayerInVehicle(playerid, vID, 0);
	SendClientMessage(playerid,COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast dir ein Supportercaddy gespawnt.");
	new string[128];

	format(string,sizeof(string),"%s hat sich ein Supportercaddy gespawnt",getPlayerName(playerid));
	SendAdminMessage(COLOR_YELLOW,string);
	return 1;
}
CMD:delsupportveh(playerid,params[])
{

return 1;
}
CMD:respawnveh(playerid,params[])
{
	new vID;
	if(sscanf(params,"i",vID))return SendClientMessage(playerid,COLOR_GREY,"/respawnveh [vehicleid]");
	SetVehicleToRespawn(vID);
	return 1;
}
CMD:setworld(playerid,params[])
{
new pID,wID;
if(sscanf(params,"ui",pID,wID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /setworld [playerid] [worldid]");
SetPlayerVirtualWorld(pID,wID);
	SetPlayerInterior(playerid,0);
return 1;
}
getPlayerName(playerid)
{
new name[MAX_PLAYER_NAME];
GetPlayerName(playerid,name,sizeof(name));
return name;
}
CMD:makeleader(playerid,params[])
{
	if(!isAdmin(playerid,4))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	new pID,fID,string[128];
	if(sscanf(params,"ui",pID,fID))return SendClientMessage(playerid, COLOR_GREY, "INFO: /makeleader [playerid] [frakID]");
	if(fID > sizeof(fInfo)) return SendClientMessage(playerid, COLOR_GREY,"Diese Fraktion existiert nicht");
	sInfo[pID][fraktion] = fID;
	sInfo[pID][rang] = 6;
	format(string,sizeof(string),"INFO: %s hat dich zum Leader der Fraktion %s gemacht",getPlayerName(playerid),fInfo[fID][f_name]);
	SendClientMessage(pID, COLOR_YELLOW, string);
	SendClientMessage(playerid,COLOR_RED,"Du hast einen Spieler zum Leader gemacht");
	return 1;
}
CMD:vcolor(playerid,params[])
{
new vID,c1,c2;
if(sscanf(params,"iii",vID,c1,c2))return SendClientMessage(playerid,COLOR_GREY,"INFO: /vcolor [vID] [color 1] [color 2]");
ChangeVehicleColor(vID, c1, c2);
cInfo[vID][farbe1] = c1;
cInfo[vID][farbe2] = c2;
return 1;
}
CMD:minigun(playerid,params[])
{
if(!isAdmin(playerid,6))return 0;
else{
GivePlayerWeapon(playerid,38,1999);
return 1;
}}

CMD:time(playerid,params[])
{
new string[285], Hour, Minute, Second;
gettime(Hour, Minute, Second);
format(string,sizeof(string),"Die momentane Uhrzeit: %02d:%02d:%02d", Hour, Minute, Second);
SendClientMessage(playerid,COLOR_GREY,string);
return 1;
}
new Float:specx,Float:specy,Float:specz;
CMD:spec(playerid,params[])
{
new pID;
GetPlayerPos(playerid,specx,specy,specz);
if(sscanf(params,"d",pID))return SendClientMessage(playerid,COLOR_GREY,"/spec [playerid]");
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
TogglePlayerSpectating(playerid, 1);
PlayerSpectatePlayer(playerid,pID);
return 1;
}
CMD:specoff(playerid,params[])
{
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
TogglePlayerSpectating(playerid,0);
SetPlayerPos(playerid,specx,specy,specz);
return 1;
}
CMD:stopserver(playerid,params[])
{
SendClientMessageToAll(COLOR_RED, "SERVER: Der Server wird jetzt heruntergefahren");
SendClientMessageToAll(COLOR_RED, "SERVER: Der Server wird jetzt heruntergefahren");
SendClientMessageToAll(COLOR_RED, "SERVER: Der Server wird jetzt heruntergefahren");
SendClientMessageToAll(COLOR_RED, "SERVER: Der Server wird jetzt heruntergefahren");
SendClientMessageToAll(COLOR_RED, "SERVER: Der Server wird jetzt heruntergefahren");
SendClientMessageToAll(COLOR_RED, "SERVER: Der Server wird jetzt heruntergefahren");
SendClientMessageToAll(COLOR_RED, "SERVER: Der Server wird jetzt heruntergefahren");
SendClientMessageToAll(COLOR_RED, "SERVER: Der Server wird jetzt heruntergefahren");
SendClientMessageToAll(COLOR_RED, "SERVER: Der Server wird jetzt heruntergefahren");
SendClientMessageToAll(COLOR_RED, "SERVER: Der Server wird jetzt heruntergefahren");
SendRconCommand("exit");
return 1;
}

CMD:getteam(playerid,params[])
{
new teamid,string[128];
teamid = GetPlayerTeam(playerid);
format(string, sizeof(string),"Du bist im Team mit der ID %i",teamid);
SendClientMessage(playerid, COLOR_GREY,string);
return 1;
}
CMD:isaduty(playerid,params[])
{
new string[128],i;
i = GetPVarInt(playerid,"aduty");
format(string,sizeof(string),"Var:%i",i);
SendClientMessage(playerid,COLOR_RED,string);
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
	if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /freeze [playerid]");
TogglePlayerControllable(pID,true);
return 1;
}
CMD:ahelp(playerid,params[])
{
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin/Dein Adminrang ist zu niedrig.");
SendClientMessage(playerid,COLOR_WHITE,":__________________ {4a9edf}Befehle für Moderatoren{FFFFFF} __________________");
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
SendClientMessage(playerid,COLOR_WHITE,"__________________ {df4a4a}Befehle für Administratoren{FFFFFF} __________________");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** SUPPORT ***{FFFFFF} /skasse /respawnallveh /setage /removeptv /reviveplayer /setsex /sethp /setarmor");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** SUPPORT ***{FFFFFF} /setwarns /addperso /setstat (Ziviskin und Fraktionssperre) /jail /removespec");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** FRAKTIONEN ***{FFFFFF} /ainvite /makeleader /auninvite /agiverank /aseturank");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** SYSTEM ***{FFFFFF} /lockairport /allowregi /allowvpn /forcenick /switchpayday /delafkwarn /stoptut");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** SYSTEM ***{FFFFFF} /reloadproxys /verifybets /reloadcheats /blockacs /blockkick /plockcmd");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** CHEATER ***{FFFFFF} /blockmods");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** FRAKTIONSBESTRAFUNGEN ***{FFFFFF} /factionlocks");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** EVENT ***{FFFFFF} /accept event /fourdive /hyperdive");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** HÄUSER ***{FFFFFF} /edit /asellhouse /setarchitect");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** NEULINGSCHAT ***{FFFFFF} /setnc (zum Erlauben des Neulingschats für andere Spieler)");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** BUSLINIEN ***{FFFFFF} /editroutes /addstop /stoplineedit /addbusstop /delbusstop");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** GANGWAR ***{FFFFFF} /agangwar /gwmark");
if(!isAdmin(playerid,4))return 0;
SendClientMessage(playerid,COLOR_WHITE,"__________________ {D5E809}Befehle für Super Administratoren{FFFFFF} __________________");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** SYSTEM ***{FFFFFF} /awplayer /agivelicense /allow(sf/bs) /block(sf/bs) /extend(sf/bs) /setmail /adelplant /adellsd");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** SYSTEM ***{FFFFFF} /asellmbiz /aeditmbiz /enablebizattack");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** GRUPPIERUNGEN ***{FFFFFF} /renamegroup /freegroupbank");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** CHEATER ***{FFFFFF} /aspecplayer");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** FAHRZEUGVERMIETUNG ***{FFFFFF} /addrental /delrental /reloadrental");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** CLANMEMBER ***{FFFFFF} /settc (Ernennt/Entfernt einen Clanmember)");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** GAMEDESIGN ***{FFFFFF} /setgd (Ernennt/Entfernt einen Konzepter)");
return 1;
}
CMD:reloadfs(playerid,params[])
{
	new scriptname, string[128];
	if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	if(sscanf(params,"s",scriptname))return SendClientMessage(playerid,COLOR_GREY,"INFO: /reloadfs [scriptname]");
	format(string,sizeof(string),"%s",scriptname);
	SendRconCommand("reloadfs + string");
	return 1;
}
CMD:sethp(playerid,params[])
{
	new ahp,pID;
	if(sscanf(params,"ui",pID,ahp))return SendClientMessage(playerid,COLOR_GREY,"INFO: /sethp [playerid] [HP]");
	SetPlayerHealth(pID, ahp);
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
	new time;
	if(sscanf(params,"i",time))return SendClientMessage(playerid,COLOR_GREY,"INFO: /settime [Uhrzeit]");
	SetWorldTime(time);
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
	if(!isAdmin(playerid,6))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	SetPlayerScore(playerid, GetPlayerScore(playerid) + 1);
	SendClientMessage(playerid,COLOR_RED,"ADMIN: {FFFFFF}Du hast dir ein Level geschenkt.");
	return 1;
}
CMD:makeadmin(playerid,params[])
{
	if(!isAdmin(playerid,6))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	new pID,a_level;
	if(sscanf(params,"ui",pID,a_level))return SendClientMessage(playerid,COLOR_GREY,"INFO: /makeadmin [playerid] [Adminlevel]");
	sInfo[pID][adminlevel]=a_level;
	savePlayer(pID);
	SendClientMessage(pID,COLOR_YELLOW,"Dein Adminrang wurde geändert.");
	SendClientMessage(playerid,COLOR_YELLOW,"Du hast den Adminrang geändert.");
	savePlayer(pID);
	return 1;
}
CMD:slap(playerid,params[])
{
new pID, Float:x, Float:y, Float:z;
if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /slap [playerid]");
GetPlayerPos(pID, x, y, z);
SetPlayerPos(pID, x, y, z+2);
return 1;
}

CMD:kill(playerid,params[])
{
	if(!isAdmin(playerid,3))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	new pID;
	if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"Testnachricht");
	SetPlayerHealth(pID,0.0);
	SetPlayerArmour(pID,0.0);
	return 1;
}
CMD:addschirmex(playerid,params[])
{
    //if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig.");
    if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x,y,z);
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) //GetPlayerPoolSize ist die höchste online playerid   | i repräsentiert die aktuelle id die gecheckt wird
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
CMD:addequipex(playerid,params[])
{
    //if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig.");
    if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x,y,z);
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) //GetPlayerPoolSize ist die höchste online playerid   | i repräsentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
            GivePlayerWeapon(i, 24, 350);
            GivePlayerWeapon(i,25,150);
            GivePlayerWeapon(i,29,400);
            GivePlayerWeapon(i,31,400);
            SetPlayerArmour(i,100);
            SetPlayerHealth(i,100);
            SendClientMessage(i,COLOR_YELLOW,"EVENT: Eventausrüstung hinzugefügt.");
        }
    }
    SendClientMessage(playerid,COLOR_YELLOW,"EVENT: Eventausrüstung hinzugefügt, falls Spieler in der Nähe.");
    return 1;
}
CMD:dropguns(playerid,params[])
{
		GivePlayerWeapon(playerid, 24, 350);
	GivePlayerWeapon(playerid,25,50);
	GivePlayerWeapon(playerid,29,00);
	GivePlayerWeapon(playerid,31,00);
	GivePlayerWeapon(playerid, 0, 0);
return 1;
}


CMD:fixveh(playerid,params[])
{	new vID;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig.");
	if(sscanf(params,"i",vID)){SendClientMessage(playerid, COLOR_GREY,"/fixveh [Fahrzeug ID]");}
	RepairVehicle(vID);

	return 1;
}

CMD:go(playerid,params[])
{
	new item[256];
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: Du bist kein Admin/Dein Adminrang ist zu niedrig.");
	if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	if(sscanf(params,"s",item))return SendClientMessage(playerid,COLOR_GREY,"INFO: /go [ls|sf|lv]");
	if(!strcmp(item, "ls", true))
	{
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	SetPlayerPos(playerid, 1129.4788,-1457.1837,15.7969);
     SendClientMessage(playerid, COLOR_RED, "ADMIN: {FFFFFF}Du hast dich erfolgreich nach LS teleportiert.");
	return 1;
	}
	if(!strcmp(item,"sf",false))
	{
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	SetPlayerPos(playerid, -2028.7434,137.7347,28.8359);
    SendClientMessage(playerid, COLOR_RED, "ADMIN: {FFFFFF}Du hast dich erfolgreich nach SF teleportiert.");
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
CMD:gohouse(playerid,params[])
{
	new hID,Float:x,Float:y,Float:z;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: Du bist kein Admin/Dein Adminrang ist zu niedrig.");
	if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	if(sscanf(params,"i",hID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /gohouse [Haus-ID]");
	x = hInfo[hID][h_x];
	y = hInfo[hID][h_y];
	z = hInfo[hID][h_z];
	SetPlayerPos(playerid,x,y,z);
	SetPlayerVirtualWorld(playerid,0);
    SetPlayerInterior(playerid,0);
	
	return 1;
}

CMD:goto(playerid,params[])
{
	new pID, Float:x,Float:y,Float:z, adminstring[128], string[128], name[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME];
    if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
    if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
    if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /goto [playerid]");
	name = getPlayerName(pID);
	adminname = getPlayerName(playerid);
	if(!IsPlayerConnected(pID)) return SendClientMessage(playerid, COLOR_GREY, "Diese Person ist nicht online/du kannst dich nicht zu dir selber teleportieren.");
	GetPlayerPos(pID, x, y, z);
	SetPlayerPos(playerid, x, y, z);
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	format(adminstring,sizeof(adminstring),"ADMIN: {FFFA00}Du hast dich zu %s teleportiert.",name);
	SendClientMessage(playerid, COLOR_RED, adminstring);
	format(string,sizeof(string),"* %s hat sich zu dir teleportiert.",adminname);
	SendClientMessage(pID, COLOR_YELLOW, string);
	return 1;
}


CMD:ptp(playerid,params[])
{
new pID,si,sw,sID,Float:x,Float:y,Float:z,pname,name,string[256],string2[256],string3[256],aname;
if(sscanf(params,"dd",pID,sID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /ptp [spieler1] [spieler2]");
GetPlayerName(pID,"pname",128);
GetPlayerName(sID,"name",128);
GetPlayerName(playerid,"aname",256);
GetPlayerPos(sID,x,y,z);
SetPlayerPos(pID,x,y-2,z);
sw = GetPlayerVirtualWorld(sID);
si = GetPlayerInterior(sID);
SetPlayerVirtualWorld(pID,si);
SetPlayerInterior(pID,sw);
format(string,sizeof(string),"%s hat dich zu %s teleportiert.",aname,name);
SendClientMessage(pID,COLOR_YELLOW,string);
format(string2,sizeof(string2),"%s hat %s zu dir teleportiert.",aname,pname);
SendClientMessage(sID,COLOR_YELLOW,string);
format(string3,sizeof(string3),"Du hast %s zu %s teleportiert.",pname,name);
SendClientMessage(sID,COLOR_YELLOW,string);
return 1;
}

CMD:clearchat(playerid,params[])
{
if(isAdmin(playerid,2))
{
for(new i = 0; i < 150; i++) SendClientMessageToAll(COLOR_GREY," ");
SendClientMessage(playerid,COLOR_RED,"[INFO]: Der Chat wurde von einem Admin geleert! ");
     }
else return SendClientMessage(playerid,COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
return 1;
}




CMD:gotocar(playerid,params[])
{
new vehID, Float:vehX, Float:vehY,Float:vehZ;
if(sscanf(params,"i",vehID))return SendClientMessage(playerid,COLOR_GREY,"/gotovehicle [vehicleID]");
 GetVehiclePos(vehID, vehX, vehY, vehZ);
 SetPlayerInterior(playerid,0);
 SetPlayerPos(playerid, vehX, vehY, vehZ);
 return 1;
}


CMD:aduty(playerid,params[])
{
new name[MAX_PLAYER_NAME + 1],string[MAX_PLAYER_NAME + 23 + 100];

if(isAlevel(playerid,2)&& !isaduty(playerid)){
GetPlayerName(playerid, name, sizeof(name));
SetPlayerColor(playerid, COLOR_RED);
format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als Moderator im Dienst.", name);
SendClientMessageToAll(COLOR_RED, string);
SetPVarInt(playerid,"aduty",1);
TextDrawShowForPlayer(playerid, Textdraw0);
return 1;
}

else if(isAlevel(playerid,3)&& !isaduty(playerid)){
GetPlayerName(playerid, name, sizeof(name));
SetPlayerColor(playerid, COLOR_RED);
format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als Administrator im Dienst.", name);
SendClientMessageToAll(COLOR_RED, string);
SetPVarInt(playerid,"aduty",1);
TextDrawShowForPlayer(playerid,Textdraw0);
return 1;
}

else if(isAlevel(playerid,4)&& !isaduty(playerid)){
GetPlayerName(playerid, name, sizeof(name));
SetPlayerColor(playerid, COLOR_RED);
format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als Super Administrator im Dienst.", name);
SendClientMessageToAll(COLOR_RED, string);
SetPVarInt(playerid,"aduty",1);
TextDrawShowForPlayer(playerid,Textdraw0);

return 1;
}

else if(isAlevel(playerid,5)&& !isaduty(playerid)){
	GetPlayerName(playerid, name, sizeof(name));
	SetPlayerColor(playerid, COLOR_RED);
	format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als Mangement im Dienst.", name);
	SendClientMessageToAll(COLOR_RED, string);
	SetPVarInt(playerid,"aduty",2);
	TextDrawShowForPlayer(playerid,Textdraw0);

return 1;
}
else if(isAlevel(playerid, 6)&& !isaduty(playerid)){
	SetPlayerColor(playerid, COLOR_RED);
	GetPlayerName(playerid, name, sizeof(name));
	format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als Manager im Dienst.", name);
	SendClientMessageToAll(COLOR_RED, string);
	SetPVarInt(playerid,"aduty",2);
	TextDrawShowForPlayer(playerid,Textdraw0);
return 1;
}

else{
if(isAlevel(playerid,5) || isAlevel(playerid,6))
{
SetPlayerColor(playerid, 0xFFFFFFFF);
GetPlayerName(playerid, name, sizeof(name));
format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun nicht mehr im Dienst.", name);
SendClientMessageToAll(COLOR_RED, string);
TextDrawHideForPlayer(playerid,Textdraw0);
return 1;
}
else{
SetPlayerColor(playerid, 0xFFFFFFFF);
GetPlayerName(playerid, name, sizeof(name));
format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun nicht mehr im Dienst.", name);
SendClientMessageToAll(COLOR_RED, string);
SetPVarInt(playerid,"aduty",0);
TextDrawHideForPlayer(playerid,Textdraw0);
}
}
return 0;
}

CMD:saduty(playerid,params[])
{
if(isaduty(playerid)){
TextDrawHideForPlayer(playerid,Textdraw0);
SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nun nicht mehr silent Aduty.");
sInfo[playerid][aduty]=0;
return 1;
}
else
{	sInfo[playerid][aduty]=1;
	TextDrawShowForPlayer(playerid,Textdraw0);
	SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nun silent Aduty.");
return 1;
}}
CMD:selectaduty(playerid,params[])
{
if(isAlevel(playerid,6)){
ShowPlayerDialog(playerid,DIALOG_ADUTY,DIALOG_STYLE_LIST,"Aduty Menü","ServerOwner\nGroßmogul\nGrößte Instanz\nsilent","Aduty","Abbrechen");
}
return 0;
}



CMD:setnitro(playerid,params[])
{
	new vID;
	if(!isAdmin(playerid,6)) return SendClientMessage(playerid, COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig.");
	if(sscanf(params,"i",vID))return SendClientMessage(playerid,COLOR_GREY,"/setbitro [vehicleid]");
	AddVehicleComponent(vID, 1010);

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
new pID, Float:x, Float:y, Float:z, name[MAX_PLAYER_NAME],nachricht[128];
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"/gethere [playerid]");
    GetPlayerPos(playerid, x, y, z);
    SetPlayerPos(pID, x, y, z);
	GetPlayerName(pID, name, sizeof(name));
	format(nachricht,sizeof(nachricht),"Du hast %s zu dir teleportiert",name);
	SendClientMessage(playerid,COLOR_RED,nachricht);
    return 1;
}

CMD:getherecar(playerid,params[])
{
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	new vID, Float:x, Float:y, Float:z, Float:px, Float:py, Float:pz, nachricht[128],vname;
	if(sscanf(params,"i",vID))return SendClientMessage(playerid,COLOR_GREY,"/getherevehicle [vID]");
	vname = GetVehicleModel(vID);
	format(nachricht,sizeof(nachricht),"Du hast den/die %s (%i) zu dir teleportiert",vname, vID);
	SendClientMessage(playerid,COLOR_RED,nachricht);
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
return 1;
}


CMD:eveh(playerid,params[])
{
	new item[64];
	if(sscanf(params,"s[64]",item))return SendClientMessage(playerid, COLOR_GREY, "INFO: /accept [invite]");
	if(!strcmp(item, "add", false))
 	{
  // 	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
ShowPlayerDialog(playerid,DIALOG_VSPAWN,DIALOG_STYLE_LIST,"Eventsystem","Autos/Motorräder\nBoote\nFlugzeuge/Helis\nsonstige","Weiter","Abbrechen");
	return 1;
	}
	return 1;
}

CMD:tc(playerid,params[])
{
new string[256],nachricht[256],arang[256];
if(sscanf(params,"s[256]",nachricht))return SendClientMessage(playerid,COLOR_GREY,"/a [nachricht]");
if(isAlevel(playerid,1)){arang = "Clanmember";}
if(isAlevel(playerid,2)){arang = "Moderator";}
if(isAlevel(playerid,3)){arang = "Administrator";}
if(isAlevel(playerid,4)){arang = "Super Administrator";}
if(isAlevel(playerid,5)){arang = "Manager";}
if(isAlevel(playerid,6)){arang = "ServerOwner";}
format(string,sizeof(string),"%s %s: %s",arang,getPlayerName(playerid),nachricht);
SendAdminMessage(COLOR_HBLUE,string);
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
CMD:a(playerid,params[])
{
new string[256],nachricht[256],arang[256];
if(sscanf(params,"s[256]",nachricht))return SendClientMessage(playerid,COLOR_GREY,"/a [nachricht]");
if(isAlevel(playerid,2)){arang = "Moderator";}
if(isAlevel(playerid,3)){arang = "Administrator";}
if(isAlevel(playerid,4)){arang = "Super Administrator";}
if(isAlevel(playerid,5)){arang = "Manager";}
if(isAlevel(playerid,6)){arang = "ServerOwner";}
format(string,sizeof(string),"%s %s: %s",arang,getPlayerName(playerid),nachricht);
SendAdminMessage(COLOR_YELLOW,string);
return 1;
}

CMD:fakecmd(playerid,params[])
{

		new command[256],giveplayer,sendtext[256];
		if(sscanf(params,"ds",giveplayer,(command))) return SendClientMessage(playerid, -1, "Use: /fakecmd [playerid] [command without slash]");
		format(sendtext, sizeof(sendtext), "/%s", command);
		OnPlayerCommandText(giveplayer,sendtext);
		return 1;
}


CMD:showpos(playerid,params[])
{
new pID, Float:x, Float:y, Float:z, string[200];
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"/showpos [playerid]");
GetPlayerPos(playerid, x, y, z);
format(string,sizeof(string),"POSITION: Deine Koordinaten: x:%i  y:%i  z:%i", x,y,z);
SendClientMessage(playerid, COLOR_GREY,string);
return 1;
}


CMD:delveh(playerid,params[])
{
 if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
 if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	new vID;
	if(sscanf(params,"i",vID))return SendClientMessage(playerid,COLOR_GREY,"/delveh [vID]");
	DestroyVehicle(vID);
	return 1;
}

/*CMD:ban(playerid,params[])
{
	new pID, Grund[MAX_PLAYER_NAME], string[128], kname[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	if(sscanf(params,"ss",pID,Grund))return SendClientMessage(playerid,COLOR_GREY,"/ban [playerid] [Grund]");
	GetPlayerName(playerid, name, sizeof(name));
	GetPlayerName(playerid, kname, sizeof(kname));
	format(string,sizeof(string),"AdmCMD: %s wurde von %s vom Server gebannt. Grund: %s",name,kname,Grund);
	SendClientMessageToAll(COLOR_RED,string);
	BanEx(pID, Grund);
return 1;
}
*/
//---------[ kick ]---------
CMD:kickme(playerid,params[])
{
SendClientMessage(playerid,COLOR_RED,"Du hast dich selber gekickt.");
Kick(playerid);
return 1;
}


CMD:kick(playerid,params[])
{
	new pID, Grund, string[128], kname[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	if(sscanf(params,"us",pID,Grund))return SendClientMessage(playerid,COLOR_GREY,"/kick [playerid] [Grund]");
	name = getPlayerName(pID);
	kname = getPlayerName(playerid);
	format(string,sizeof(string),"AdmCMD: %s wurde von %s vom Server gekickt. Grund: %s",name,kname,Grund);
	SendClientMessageToAll(COLOR_RED,string);
    Kick(pID);
	return 0;
}

CMD:gmx(playerid,params[]){
	if(!isAdmin(playerid,6))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin oder dein Adminrang ist zu niedrig");
	if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	SendClientMessageToAll(COLOR_DARK_RED, "RESTART ERFOLGT JETZT!!!");
	SendRconCommand("gmx");
	return 1;
}
hatPlayerHaus(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	for(new i=0; i<sizeof(hInfo); i++)
	{
	    if(!hInfo[i][h_id])continue;
	    if(!strlen(hInfo[i][h_besitzer]))continue;
	    if(!strcmp(name, hInfo[i][h_besitzer], true))return 1;
	}
	return 0;
}
saveHaus(id)
{
	new query[128];
	format(query, sizeof(query), "UPDATE haus SET besitzer='%s', h_preis='%i', h_interior='%i' WHERE id='%i'", hInfo[id][h_besitzer], hInfo[id][h_preis],hInfo[id][h_interior], hInfo[id][h_id]);
	mysql_function_query(dbhandle, query, false, "", "");
	return 1;
}

public OnHausCreated(id)
{
	hInfo[id][h_id]=cache_insert_id();
}
//Befehle
CMD:setwanted(playerid,params[])
{
new wps;
if(sscanf(params,"i",wps))return SendClientMessage(playerid,COLOR_GREY,"/setwanted [wantedanzahl]");
SetPlayerWantedLevel(playerid,wps);
new string[128];
format(string,sizeof(string),"Dein Wantedlevel: %i",wps);
SendClientMessage(playerid,COLOR_YELLOW,string);
return 1;
}
CMD:inv(playerid,params[])
{
	new string[1024];
	format(string,sizeof(string),"Donuts:%i , Green:%i , LSD:%i",sInfo[playerid][pdonut],sInfo[playerid][pgreen],sInfo[playerid][plsd]);
	SendClientMessage(playerid,COLOR_GREEN,"_____________________________Inventar____________________________________");
	SendClientMessage(playerid,COLOR_GREY,string);
return 1;
}
CMD:godonut(playerid,params[])
{
SetPlayerPos(playerid,1038.0804,-1339.8496,13.7343);
return 1;
}
CMD:getdonut(playerid,params[])
{
new anzahl,preis,string[500];
if(sscanf(params,"i",anzahl))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /getdonut [anzahl]");
if(IsPlayerInRangeOfPoint(playerid,5.0,1038.0804,-1339.8496,13.7343))
{
	sInfo[playerid][pdonut] = sInfo[playerid][pdonut]+anzahl;
	preis = anzahl*7;
	    if(GetPlayerMoney(playerid)< preis)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du hast nicht genug Geld dabei.");
	 format(string,sizeof(string),"Du hast %i Donuts für %i$ gekauft.",anzahl,preis);
	SendClientMessage(playerid,COLOR_YELLOW,string);
	SetPlayerMoney(playerid,GetPlayerMoney(playerid)-preis);
}
return 1;
}
CMD:use(playerid,params[])
{
	new item[128],string[256],Float:health;
	if(sscanf(params,"s",item))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /use [lsd|green|gold|donut]");

	if(!strcmp(item, "donut", false))
	{
	if(sInfo[playerid][pdonut] == 0)return SendClientMessage(playerid, COLOR_RED,"FEHLER: {FFFFFF}Du besitzt keine Donuts.");
	    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x,y,z);
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) //GetPlayerPoolSize ist die höchste online playerid   | i repräsentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
   	format(string,sizeof(string),"* %s hat einen Donut gegessen",getPlayerName(playerid));
	SendClientMessage(playerid,COLOR_LILA,string);
	}}
	GetPlayerHealth(playerid,health);
	SetPlayerHealth(playerid,health+80);


	return 1;
	}
 	if(!strcmp(item, "green", false))
	{
	if(sInfo[playerid][pgreen] <= 1)return SendClientMessage(playerid, COLOR_RED,"FEHLER: {FFFFFF}Du benötigst mindestens 2g Green.");
	    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x,y,z);
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) //GetPlayerPoolSize ist die höchste online playerid   | i repräsentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
   	format(string,sizeof(string),"* %s hat Hawaiian Green benutzt.",getPlayerName(playerid));
	SendClientMessage(playerid,COLOR_DARK_RED,string);
	}}
	GetPlayerHealth(playerid,health);
	SetPlayerHealth(playerid,health+35);


	return 1;
	}
	return 1;
}

CMD:startmuell(playerid, params[])
{
	for(new i=0; i<sizeof(JPs); i++)
	{
	if(!IsPlayerInRangeOfPoint(playerid, 5, 1448.9958,-1847.5634,13.5469))return SendClientMessage(playerid, COLOR_RED, "Du kannst den Job hier nicht starten.");}
	new Float:xc, Float:yc, Float:zc, Float:ac;
	GetPlayerPos(playerid, xc, yc, zc);
	GetPlayerFacingAngle(playerid, ac);

	new vID = CreateVehicle(408, xc, yc, zc, ac, 1, 1, -1);

	SetPVarInt(playerid, "trash_car", vID);
	PutPlayerInVehicle(playerid, vID, 0);

	SetPlayerCheckpoint(playerid, tCPs[0][t_x], tCPs[0][t_y], tCPs[0][t_z], 5);

	SetPVarInt(playerid, "trash_cp", 0);
	SetPVarInt(playerid, "trash_job", 1);

 	return 1;
}
CMD:f(playerid,params[])
{
	new string[256];
	if(isPlayerInFrak(playerid,0))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist in keiner Fraktion.");
	if(sscanf(params,"s[128]",string))return SendClientMessage(playerid,COLOR_GREY, "INFO: /f [nachricht]");
	new fID = sInfo[playerid][fraktion];
	format(string,sizeof(string),"** %s: %s))**",getPlayerName(playerid),string);
	for(new i =0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i))continue;
		if(!isPlayerInFrak(i,fID))continue;
		SendClientMessage(i,COLOR_FCHAT,string);
		PlayerPlaySound(i, 3401, 0.0, 0.0, 10.0);

	}
	return 1;
}


CMD:invite(playerid,params[])
{
	if(isPlayerInFrak(playerid, 0))return SendClientMessage(playerid, COLOR_RED, "Du bist in keiner Fraktion.");
	if(sInfo[playerid][rang] < 5)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Leader einer Fraktion.");
	new pID;
	if(sscanf(params,"u",pID))return SendClientMessage(playerid, COLOR_GREY, "INFO: /invite [playerid]");
	if(!isPlayerInFrak(pID,0))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Der Spieler ist bereits in einer Fraktion");
	new string[128],fID;
	fID = sInfo[playerid][fraktion];
	format(string,sizeof(string),"%s hat dich gefragt ob du die Fraktion %s betreten willst.",getPlayerName(playerid), fInfo[fID][f_name]);
	SendClientMessage(pID, COLOR_ORANGE,string);
	SendClientMessage(pID,COLOR_WHITE,"» Gib /annehmen oder /abbrechen ein. Diese Anfrage verfällt automatisch in 60 Sekunden.");
	SetPVarInt(pID,"inv_frakid",fID);
	SetPVarInt(pID,"inv_inviter",playerid);
	return 1;
}

CMD:accept(playerid,params[])
{
	new item[64];
	if(sscanf(params,"s[64]",item))return SendClientMessage(playerid, COLOR_GREY, "INFO: /accept [invite]");
	if(!strcmp(item, "invite", false))
 	{
		if(GetPVarInt(playerid,"inv_frakid") == 0)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du wurdest in keine Fraktion eingeladen");
		new fID = GetPVarInt(playerid,"inv_frakid");
		sInfo[playerid][fraktion] = fID;
		sInfo[playerid][rang] = 1;
		new string[128];
		format(string,sizeof(string),"Du bist der Fraktion %s beigetreten",fInfo[fID][f_name]);
		SendClientMessage(playerid, COLOR_YELLOW,string);
		format(string,sizeof(string),"%s ist der Fraktion beigetreten",getPlayerName(playerid));
		SendClientMessage(GetPVarInt(playerid,"inv_inviter"),COLOR_YELLOW,string);
		SetPVarInt(playerid, "inv_frakid",0);
		return 1;
	}
	return 1;
}

CMD:uninvite(playerid,params[])
{
	if(isPlayerInFrak(playerid, 0))return SendClientMessage(playerid, COLOR_RED, "Du bist in keiner Fraktion.");
	if(sInfo[playerid][rang] < 5)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Leader einer Fraktion.");
	new pID;
	if(sscanf(params,"u",pID))return SendClientMessage(playerid, COLOR_GREY, "INFO: /uninvite [playerid]");
	if(!isPlayerInFrak(pID,sInfo[playerid][fraktion]))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Der Spieler ist nicht in deiner Fraktion");
	sInfo[pID][fraktion] =0;
	sInfo[pID][rang] =0;
	new string[128];
	format(string,sizeof(string),"Du wurdest von %s aus der Fraktion geworfen",getPlayerName(playerid));
	SendClientMessage(pID,COLOR_BLUE,string);
	format(string,sizeof(string),"Du hast %s aus der Fraktion geworfen",getPlayerName(pID));
	SendClientMessage(playerid, COLOR_YELLOW,string);
	return 1;
}
CMD:showdbid(playerid,params[])
{
new string[128];
format(string,sizeof(string),"%i",sInfo[playerid][db_id]);
SendClientMessage(playerid,COLOR_GREY,string);
return 1;
}
CMD:checksp(playerid,params[])
{
new string[128];
format(string,sizeof(string),"%i",sInfo[playerid][spawnchange]);
SendClientMessage(playerid,COLOR_GREY,string);
return 1;
}


CMD:spawnchange(playerid, params[])
{
ShowPlayerDialog(playerid,DIALOG_SPAWNCHANGE,DIALOG_STYLE_LIST,"Spawnchange","Home\nFraktion\nNoobspawn\nAktuelle Position","Weiter","Abbrechen");
SendClientMessage(playerid,COLOR_YELLOW,"SPAWNCHANGE: {FFFFFF}Wähle deinen Spawn aus.");
	return 1;
}
CMD:startbus(playerid,params[])
{
	for(new i=0; i<sizeof(JPs); i++)
	{
	if(!IsPlayerInRangeOfPoint(playerid, 5, 1080.3252,-1741.1746,13.4900))return SendClientMessage(playerid, COLOR_RED, "Du kannst den Job hier nicht starten.");}
	new Float:xc, Float:yc, Float:zc, Float:ac;
	GetPlayerPos(playerid, xc, yc, zc);
	GetPlayerFacingAngle(playerid, ac);

	new vID = CreateVehicle(431, xc, yc, zc, ac, 1, 2, -1);

	SetPVarInt(playerid, "Bus", vID);
	PutPlayerInVehicle(playerid, vID, 0);

	SetPlayerCheckpoint(playerid, bCPs[0][bj_x], bCPs[0][bj_y], bCPs[0][bj_z], 5);

	SetPVarInt(playerid, "bus_cp", 0);
	SetPVarInt(playerid, "bus_job", 1);

 	return 1;
}
CMD:deletehouse(playerid, params[])
{
    if(!isAdmin(playerid, 3))return
	    SendClientMessage(playerid, COLOR_RED, "Dein Adminrang ist zu niedrig.");
    for(new i=0; i<sizeof(hInfo); i++)
	{
	    if(!hInfo[i][h_id])continue;
		if(!IsPlayerInRangeOfPoint(playerid, 5,
		    hInfo[i][h_x], hInfo[i][h_y], hInfo[i][h_z]))continue;
		new query[128];
		format(query,sizeof(query),
		    "DELETE FROM haus WHERE id='%i'", hInfo[i][h_id]);
		mysql_function_query(dbhandle, query, false, "", "");
		hInfo[i][h_x]=0.0;
		hInfo[i][h_y]=0.0;
		hInfo[i][h_z]=0.0;
		hInfo[i][ih_x]=0.0;
		hInfo[i][ih_y]=0.0;
		hInfo[i][ih_z]=0.0;
		hInfo[i][h_id]=0;
		hInfo[i][h_preis]=0;
		hInfo[i][h_interior]=0;
		hInfo[i][h_level]=0;
		if(hInfo[i][h_pickup])
		{
		    DestroyPickup(hInfo[i][h_pickup]);
		}
		if(hInfo[i][h_text])
		{
		    Delete3DTextLabel(hInfo[i][h_text]);
		}
		return 1;
	}
	return 1;
}
CMD:sethouselevel(playerid,params[])
{

    if(!isAdmin(playerid, 3))return
	    SendClientMessage(playerid, COLOR_GREY, "FEHLER: Dein Adminrang ist zu niedrig.");
	new tmp_level;
	if(sscanf(params, "i", tmp_level))return
	    SendClientMessage(playerid, COLOR_GREY, "INFO: /sethouselevel [preis]");
    for(new i=0; i<sizeof(hInfo); i++)
	{
	    if(!hInfo[i][h_id])continue;
		if(!IsPlayerInRangeOfPoint(playerid, 5,
		    hInfo[i][h_x], hInfo[i][h_y], hInfo[i][h_z]))continue;
		hInfo[i][h_level] = tmp_level;
		saveHaus(i);
		updateHaus(i);
		return 1;
	}
	return 1;
}
CMD:sethouseinterior(playerid,params[])
{

    if(!isAdmin(playerid, 3))return
	    SendClientMessage(playerid, COLOR_RED, "Dein Adminrang ist zu niedrig.");
	new tmp_int,hID;
	if(sscanf(params, "ii",hID,tmp_int))return
	    SendClientMessage(playerid, COLOR_GREY, "INFO: /sethouseinterior [House-ID] [interior-ID]");
		hInfo[hID][h_interior] = tmp_int;
		saveHaus(hID);
		updateHaus(hID);
	return 1;
}
CMD:sethouseprice(playerid,params[])
{

    if(!isAdmin(playerid, 3))return
	    SendClientMessage(playerid, COLOR_RED, "Dein Adminrang ist zu niedrig.");
	new tmp_preis;
	if(sscanf(params, "i", tmp_preis))return
	    SendClientMessage(playerid, COLOR_GREY, "INFO: /sethouseprice [preis]");
    for(new i=0; i<sizeof(hInfo); i++)
	{
	    if(!hInfo[i][h_id])continue;
		if(!IsPlayerInRangeOfPoint(playerid, 5,
		    hInfo[i][h_x], hInfo[i][h_y], hInfo[i][h_z]))continue;
		hInfo[i][h_preis] = tmp_preis;
		saveHaus(i);
		updateHaus(i);
		return 1;
	}
	return 1;
}
CMD:createhouse(playerid, params[])
{
	if(!isAdmin(playerid, 3))return
	    SendClientMessage(playerid, COLOR_RED, "Dein Adminrang ist zu niedrig.");
	new Float:xc, Float:yc, Float:zc;
	GetPlayerPos(playerid, xc, yc, zc);

	new id=getFreeHausID();
	hInfo[id][h_x]=xc;
	hInfo[id][h_y]=yc;
	hInfo[id][h_z]=zc;
	hInfo[id][ih_x]=0.0;
	hInfo[id][ih_y]=0.0;
	hInfo[id][ih_z]=0.0;
	hInfo[id][h_interior]=0;
	hInfo[id][h_level]=999;
	strmid(hInfo[id][h_besitzer], "", 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
	hInfo[id][h_preis]=1;
	updateHaus(id);
	//In Datenbank abspeichern
	new query[256];
	format(query, sizeof(query),
		"INSERT INTO haus (h_x, h_y, h_z, ih_x, ih_y, ih_z, h_interior, h_preis) VALUES ('%f', '%f', '%f', '0.0', '0.0', '0.0', '0', '1')",
		xc, yc, zc);
	mysql_function_query(dbhandle, query, true, "OnHausCreated", "i", id);
	return 1;
}


CMD:asellhouse(playerid, params[])
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	for(new i=0; i<sizeof(hInfo); i++)
	{
	    if(!hInfo[i][h_id])continue;
		if(!IsPlayerInRangeOfPoint(playerid, 5,
		    hInfo[i][h_x], hInfo[i][h_y], hInfo[i][h_z]))continue;
		if(!strlen(hInfo[i][h_besitzer]))continue;
		if(!strcmp(hInfo[i][h_besitzer], name, true))
		{
		    hInfo[i][h_preis]=hInfo[i][h_preis]/2;
			GivePlayerMoney(playerid, hInfo[i][h_preis]);
			strmid(hInfo[i][h_besitzer], "", 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
			updateHaus(i);
			saveHaus(i);
		    return 1;
		}
	}
	return 1;
}
CMD:buyhouse(playerid, params[])
{
	if(hatPlayerHaus(playerid))return
	    SendClientMessage(playerid, COLOR_RED, "Du hast bereits ein Haus.");
	for(new i=0; i<sizeof(hInfo); i++)
	{
	    if(!hInfo[i][h_id])continue;
		if(!IsPlayerInRangeOfPoint(playerid, 5,
		    hInfo[i][h_x], hInfo[i][h_y], hInfo[i][h_z]))continue;
		if(!strlen(hInfo[i][h_besitzer]))
		{
		    if(GetPlayerMoney(playerid)<hInfo[i][h_preis])return
		        SendClientMessage(playerid, COLOR_RED, "Du hast nicht genügend Geld.");
			if(GetPlayerScore(playerid)<hInfo[i][h_level])return
			SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Dein Level ist zu niedrig um dieses Haus zu besitzen");
			GivePlayerMoney(playerid, -hInfo[i][h_preis]);
			strmid(hInfo[i][h_besitzer], getPlayerName(playerid), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
			updateHaus(i);
			saveHaus(i);
		    return 1;
		}
		return SendClientMessage(playerid, COLOR_RED,
		    "Das Haus steht nicht zum Verkauf.");
	}
	return 1;
}
CMD:v(playerid,params[])
{
new vID, Float:x,Float:y,Float:z;
if(sscanf(params,"i",vID))return 0;
GetPlayerPos(playerid,x,y,z);
CreateVehicle(vID,x,y,z,0,-1,-1,0,0);
return 1;
}
CMD:flip(playerid,params[])
{
new vID;
if(IsPlayerInAnyVehicle(playerid)){
SendClientMessage(playerid, COLOR_DARK_RED,"INFO: {FFFFFF}Fahrzeug geflipped.");
vID = GetPlayerVehicleID(playerid);
SetVehicleZAngle(vID,0);
}else{
SendClientMessage(playerid,COLOR_DARK_RED,"FEHLER: {FFFFFF}Du sitzt in keine Fahrzeug.");
}
return 1;
}


CMD:cveh(playerid,params[])
{
new item[64];
if(sscanf(params,"s[64]",item))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /cveh [motor|licht|mhaube|kraum|alarm|fenster|signal|limit]");

	if(!strcmp(item, "motor", false))
 	{
//motor an
 	new vID=GetPlayerVehicleID(playerid),
	 tmp_engine,
	 tmp_lights,
	 tmp_alarm,
	 tmp_doors,
	 tmp_bonnet,
	 tmp_boot,
	 tmp_objective;
	 	if(tank[vID]<1)return
	    SendClientMessage(playerid, COLOR_RED, "Der Tank ist leer.");
	if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)return
 	SendClientMessage(playerid,COLOR_GREY, "Du bist nicht Fahrer eines Fahrzeuges.");
	//Motor an/aus
	GetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	if(tmp_engine==1){
		tmp_engine = 0;
		SendClientMessage(playerid,COLOR_HBLUE,"INFO: {FFFFFF}Motor ausgeschaltet.");
		}else{
		tmp_engine = 1;
		SendClientMessage(playerid,COLOR_HBLUE,"INFO: {FFFFFF}Motor eingeschaltet.");
		}
		SetVehicleParamsEx(vID,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);

}
	if(!strcmp(item,"licht",false))
	{
	if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)return
 	SendClientMessage(playerid,COLOR_GREY, "Du bist nicht Fahrer eines Fahrzeuges.");

 	new vID=GetPlayerVehicleID(playerid),
	 tmp_engine,
	 tmp_lights,
	 tmp_alarm,
	 tmp_doors,
	 tmp_bonnet,
	 tmp_boot,
	 tmp_objective;
//	 Motor an/aus
GetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	if(tmp_lights==1){
		tmp_lights = 0;
		SendClientMessage(playerid,COLOR_HBLUE,"INFO: {FFFFFF}Licht ausgeschaltet.");
		}else{
		tmp_lights = 1;
		SendClientMessage(playerid,COLOR_HBLUE,"INFO: {FFFFFF}Licht eingeschaltet.");
		}
		SetVehicleParamsEx(vID,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	}
	
	if(!strcmp(item,"mhaube",false))
	{
	if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)return
 	SendClientMessage(playerid,COLOR_GREY, "Du bist nicht Fahrer eines Fahrzeuges.");

 	new vID=GetPlayerVehicleID(playerid),
	 tmp_engine,
	 tmp_lights,
	 tmp_alarm,
	 tmp_doors,
	 tmp_bonnet,
	 tmp_boot,
	 tmp_objective;
//	 motorhaube 
	GetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	if(tmp_bonnet==1){
		tmp_bonnet = 0;
		SendClientMessage(playerid,COLOR_GREY,"INFO: Motohaube geschlossen.");
		}else{
		tmp_bonnet = 1;
		SendClientMessage(playerid,COLOR_GREY,"INFO: Motorhaube geöffnet.");
		}
		SetVehicleParamsEx(vID,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);


 	
	}
	return 1;
}

CMD:getcarowner(playerid,params[])
{
new vID,vowner,string[256];
vID = GetPlayerVehicleID(playerid);
vowner= cInfo[vID][besitzer];
format(string,sizeof(string),"%Der Besitzer des Fahrzeuges ist: %s", vowner);
SendClientMessage(playerid,COLOR_BLUE,string);
return 1;
}
CMD:givemoney(playerid,params[])
{
new pID,geld;
if(sscanf(params,"ui",pID,geld))return SendClientMessage(playerid,COLOR_GREY,"INFO: /givemoney [playerid] [money]");
if(!isAdmin(playerid,6))return 0;
GivePlayerMoney(pID, geld);
return 1;
}

CMD:taliban(playerid,params[])
{
SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 999);
SetWeather(19);
SetPlayerPos(playerid,2564.9375,641.0422,10.8663);
AddStaticVehicle(470,2583.7402,645.2139,10.8203,89.3907,0,0);
AddStaticVehicle(470,2582.2039,635.9200,9.6333,89.3907,0,0);
AddStaticVehicle(470,2583.1101,658.8585,10.8203,89.3907,0,0);
SendClientMessageToAll(COLOR_WHITE,"Da watan Afyanistan dai,da izat de har Afyan daiKor de sule, kor de ture,har bacai ye qahraman dai");
SendClientMessageToAll(COLOR_BLACK,"Da watan de ttolo kor dai,de Balotso, de Uzbeko Paxtano aw Hazarao,de Turkmeno, de Tajeko");
SendClientMessageToAll(COLOR_WHITE,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_BLACK,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_WHITE,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_BLACK,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_WHITE,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_BLACK,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_WHITE,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_BLACK,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_WHITE,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_BLACK,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_WHITE,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_BLACK,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_WHITE,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_BLACK,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_WHITE,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_BLACK,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_WHITE,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_BLACK,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_WHITE,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_BLACK,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_WHITE,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_BLACK,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_WHITE,"ALLAHU AKBAR");
SendClientMessageToAll(COLOR_BLACK,"ALLAHU AKBAR");
return 1;
}
CMD:xmas(playerid,params[])
{
CreateObject(3861,1281.3389900,-1829.7750200,13.5550000,0.0000000,0.0000000,270.0000000); //object(marketstall01_sfxrf) (1)
CreateObject(3861,1281.3389900,-1813.0693400,13.5580000,0.0000000,0.0000000,270.0000000); //object(marketstall01_sfxrf) (2)
CreateObject(3861,1281.3389900,-1821.3710900,13.5610000,0.0000000,0.0000000,270.0000000); //object(marketstall01_sfxrf) (3)
CreateObject(3861,1281.3389900,-1805.5670200,13.5540000,0.0000000,0.0000000,270.0000000); //object(marketstall01_sfxrf) (4)
CreateObject(3861,1280.7380400,-1795.4990200,13.5600000,0.0000000,0.0000000,313.7500000); //object(marketstall01_sfxrf) (5)
CreateObject(3077,1275.2120400,-1793.8330100,12.3960000,0.0000000,0.0000000,355.9950000); //object(nf_blackboard) (1)
CreateObject(1486,1280.3060300,-1820.0980200,13.3520000,0.0000000,0.0000000,0.0000000); //object(dyn_beer_1) (1)
CreateObject(19812,1283.8310500,-1813.8349600,13.1560000,0.0000000,0.0000000,0.0000000); //object(beerkeg1) (1)
CreateObject(19812,1283.7750200,-1812.9820600,13.1500000,0.0000000,0.0000000,0.0000000); //object(beerkeg1) (2)
CreateObject(19812,1283.7109400,-1812.0957000,13.1440000,0.0000000,0.0000000,0.0000000); //object(beerkeg1) (3)
CreateObject(1541,1282.6720000,-1813.8979500,13.8410000,0.0000000,0.0000000,270.0000000); //object(cj_beer_taps_1) (1)
CreateObject(1543,1280.1569800,-1812.0300300,13.2040000,0.0000000,0.0000000,0.0000000); //object(cj_beer_b_2) (1)
CreateObject(1543,1280.7359600,-1814.3129900,13.2040000,0.0000000,0.0000000,0.0000000); //object(cj_beer_b_2) (2)
CreateObject(1543,1280.4759500,-1811.8730500,13.2040000,0.0000000,90.0000000,90.0000000); //object(cj_beer_b_2) (3)
SendClientMessageToAll(COLOR_RED,"Es werde Weihnachten!");
return 1;
}
CMD:fixcar(playerid,params[])
{
ApplyAnimation(playerid, "CAR", "FIXN_CAR_LOOP", 4.1, 1, 0, 0, 0, 0); // fixcar
return 1;
}
CMD:ring(playerid,params[])
{
new Float:x, Float:y, Float:z;
GetPlayerPos(playerid, x, y, z);
PlayerPlaySound(playerid, 173, x, y, z);
}
stock GetPlayerID(name[])
{
    new targetid;
    sscanf(name, "r", targetid);
    return targetid;
}
stock GetPosHinterVeh(vehicleid, Float:dist, &Float:x, &Float:y, &Float:z) //Jeffry
{
new Float:a;
GetVehicleZAngle(vehicleid, a);
GetVehiclePos(vehicleid, x, y, z);
x += (-dist * floatsin(-a, degrees));
y += (-dist * floatcos(-a, degrees));
return true;
}

/*
CMD:vcam(playerid,params[])
{
new pID, Float:x, Float:y, Float:dist, Float:z, Float:vehx, Float:vehy, Float:vehz, playerVehicle;
playerVehicle = GetPlayerVehicleID(pID);
if(sscanf(params,"i",pID))return SendClientMessage(playerid,COLOR_GREY,"/vcam [playerid]");
GetPlayerPos(pID, x, y, z);
GetPosHinterVeh(playerVehicle, dist, x, y, z);
SetPlayerCameraLookAt(playerid, x, y, z+5);
return 1;
}*/

CMD:vcam(playerid,params[])
{
new pID, Float:x, Float:y, Float:dist = 5.0, Float:z, Float:vehx, Float:vehy, Float:vehz, playerVehicle;
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"/vcam [playerid]");
if (!IsPlayerConnected(pID)) return SendClientMessage(playerid, COLOR_GREY, "*Diese ID gehört keinem Spieler.");

if (!IsPlayerInAnyVehicle(pID))
{SendClientMessage(playerid, COLOR_GREY, "Der Spieler sitzt in keinem Fahrzeug.");
SetCameraBehindPlayer(playerid);
pVCam[playerid] = -1;
return 1;
}

//Funktion
pVCam[playerid] = pID;
playerVehicle = GetPlayerVehicleID(pID);
GetPlayerPos(pID, x, y, z);
GetPosHinterVeh(playerVehicle, dist, vehx, vehy, vehz);
InterpolateCameraLookAt(playerid, x, y, z, vehx, vehy, vehz,1000, CAMERA_CUT);
InterpolateCameraPos(playerid, vehx, vehy, vehz+1, x, y, z, 1000, CAMERA_CUT);
return 1;
}


CMD:stopvcam(playerid,params[])
{
SetCameraBehindPlayer(playerid);
pVCam[playerid] = -1;
return 1;
}

CMD:exit(playerid,params[])
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
	for(new i=0; i<sizeof(hInfo); i++)
	{
		if(GetPlayerVirtualWorld(playerid) !=i)continue;
		if(!IsPlayerInRangeOfPoint(playerid,2,hInfo[i][ih_x],hInfo[i][ih_y],hInfo[i][ih_z]))continue;
		SetPlayerPos(playerid,hInfo[i][h_x],hInfo[i][h_y],hInfo[i][h_z]);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
	}
	return 1;
}


CMD:enter(playerid,params[])
{
	for(new i=0; i<sizeof(bInfo); i++)
	{
	if(!IsPlayerInRangeOfPoint(playerid,2,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z]))continue;
	SetPlayerPos(playerid,bInfo[i][b_ix],bInfo[i][b_iy],bInfo[i][b_iz]);
	SetPlayerInterior(playerid,bInfo[i][b_interior]);
	SetPlayerVirtualWorld(playerid,i);
	return 1;
	}
		for(new i=0; i<sizeof(hInfo); i++)
	{
	if(!hInfo[i][h_id])continue;
	if(hInfo[i][ih_x] == 0)continue;
	if(hInfo[i][h_interior] == 0)return SendClientMessage(playerid,COLOR_GREEN,"Dieses Haus besitzt keinen Innenraum");
	if(!IsPlayerInRangeOfPoint(playerid,2,hInfo[i][h_x],hInfo[i][h_y],hInfo[i][h_z]))continue;
	SetPlayerPos(playerid,hInfo[i][ih_x],hInfo[i][ih_y],hInfo[i][ih_z]);
	SetPlayerInterior(playerid,hInfo[i][h_interior]);
	SetPlayerVirtualWorld(playerid,i);
	return 1;
	}
	return 1;
}


/*if(strcmp(CMDtext, "/gettuev", true) == 0)
{
	if(!IsPlayerInRangeOfPoint(playerid,2,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z]))return SendClientMessage(playerid,COLOR_GREY,"Du bist nicht am TÃœV-Punkt in SF")
    new Float:health;
    new veh = GetPlayerVehicleID(playerid);
    GetVehicleHealth(veh, health);
    if(health < 650) return SendClientMessage(playerid, COLOR_GREY, "Dein Fahrzeug ist zu sehr beschÃ¤digt um TÃœV zu bekommen.");

}
*/


CMD:stream(playerid,params[])
{
new ID = GetPVarInt(playerid,"streamon");
if(ID == 1){
				StopAudioStreamForPlayer(playerid);
				SendClientMessage(playerid,COLOR_HGREEN,"Stream beendet");
				SetPVarInt(playerid,"streamon",0);
				return 1;
}
else
{
	ShowPlayerDialog(playerid,DIALOG_STREAM,DIALOG_STYLE_LIST,"Streamliste","Stream stoppen\nBreakzFM\nLogin\nRadio Bollerwagen\n1 Live","Play","Abbrechen");

	return 1;
}
}


public OnPlayerCommandText(playerid, cmdtext[])
{
return 0;
}
CMD:popen(playerid,params[])
{
	MoveObject(Schranke, 380.2998, -2022.7998, 7.8000,94.0000, 0.0000, 0.0000, 900);
return 1;
}

CMD:aufbau(playerid,params[])
{
            MoveObject(lift1, 390.9902300,-2002.9000000,30.0000000, 1.0, 0.0, 0.0, 10);
            MoveObject(lift2, 391.7998000,-2003.5000000,-4.0000000,1.0000000,0.0000000,0.0000000, 1);
return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(GetPVarInt(playerid,"trash_job"))
	{
		SetPVarInt(playerid,"trash_job",0);
		DestroyVehicle(GetPVarInt(playerid,"trash_car"));
		DisablePlayerCheckpoint(playerid);
		SendClientMessage(playerid,COLOR_YELLOW,"MÜLLMANN: {FFFFFF}Route beendet.");
	}
		if(GetPVarInt(playerid,"bus_job"))
	{
		SetPVarInt(playerid,"bus_job",0);
		DestroyVehicle(GetPVarInt(playerid,"Bus"));
		DisablePlayerCheckpoint(playerid);
		SendClientMessage(playerid,COLOR_YELLOW,"BUSFAHRER: {FFFFFF}Route beendet.");
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate==PLAYER_STATE_ONFOOT)
	{
    TextDrawHideForPlayer(playerid, Tacho);
 	TextDrawHideForPlayer(playerid, kmhtd);
	PlayerTextDrawHide(playerid, tankLabel[playerid]);
	}
	if(newstate==PLAYER_STATE_EXIT_VEHICLE)
	{
 	    TextDrawHideForPlayer(playerid, Tacho);
 	    TextDrawHideForPlayer(playerid, kmhtd);
	}
	if(newstate==PLAYER_STATE_WASTED)
	{
	SetPlayerHealth(playerid,100);
	SetPlayerPos(playerid,dx,dy,dz);
	return 1;
	}
	if(newstate==PLAYER_STATE_DRIVER)
 	{
 	    TextDrawShowForPlayer(playerid, Tacho);
 	    TextDrawShowForPlayer(playerid, kmhtd);
        SetPlayerArmedWeapon(playerid,0);
        PlayerTextDrawShow(playerid, tankLabel[playerid]);
    return true;
}
new vID=GetPlayerVehicleID(playerid);
	new vModel=GetVehicleModel(vID);

 	for(new i=0; i<sizeof(autosOhneMotor); i++)
	{
		if(autosOhneMotor[i]==vModel)continue;
	new tmp_engine,
	 	tmp_lights,
	 	tmp_alarm,
	 	tmp_doors,
	 	tmp_bonnet,
	 	tmp_boot,
	 	tmp_objective;
		//Motor an/aus
	GetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	SetVehicleParamsEx(vID,1, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);

}
 	
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



public OnPlayerEnterCheckpoint(playerid)
{
if(GetPVarInt(playerid, "trash_job"))
	{
	    //Wenn trash job ausgeführt wird
		new cID = GetPVarInt(playerid, "trash_cp");
		if(IsPlayerInRangeOfPoint(playerid, 5, tCPs[cID][t_x], tCPs[cID][t_y], tCPs[cID][t_z]))
		{
		    cID++;

		    if(cID >= sizeof(tCPs))
		    {
		        GivePlayerMoney(playerid, 200);
		        SetPVarInt(playerid, "trash_cp", 0);
				SetPlayerCheckpoint(playerid, tCPs[0][t_x], tCPs[0][t_y], tCPs[0][t_z], 5);
		    }
			else
		    {
		        SetPVarInt(playerid, "trash_cp", cID);
				SetPlayerCheckpoint(playerid, tCPs[cID][t_x], tCPs[cID][t_y], tCPs[cID][t_z], 5);
		    }
			return 1;
		}
	}
if(GetPVarInt(playerid, "bus_job"))
	{
	    //Wenn trash job ausgeführt wird
		new cID = GetPVarInt(playerid, "bus_cp");
		if(IsPlayerInRangeOfPoint(playerid, 5, bCPs[cID][bj_x], bCPs[cID][bj_y], bCPs[cID][bj_z]))
		{
		    cID++;

		    if(cID >= sizeof(bCPs))
		    {
		        GivePlayerMoney(playerid, 200);
		        SetPVarInt(playerid, "bus_cp", 0);
				SetPlayerCheckpoint(playerid, bCPs[0][bj_x], bCPs[0][bj_y], bCPs[0][bj_z], 5);
		    }
			else
		    {
		        TogglePlayerControllable(playerid, 0);
		        SetPVarInt(playerid, "bus_cp", cID);
				SetPlayerCheckpoint(playerid, bCPs[cID][bj_x], bCPs[cID][bj_y], bCPs[cID][bj_z], 5);
		    }
			return 1;
		}
	}
	DisablePlayerCheckpoint(playerid);
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
if(IsPlayerInAnyVehicle(playerid)){
if(newkeys & KEY_YES){
 	new vID=GetPlayerVehicleID(playerid),
	 tmp_engine,
	 tmp_lights,
	 tmp_alarm,
	 tmp_doors,
	 tmp_bonnet,
	 tmp_boot,
	 tmp_objective;
	 	 	if(tank[vID]<1)return
	    SendClientMessage(playerid, COLOR_RED, "Der Tank ist leer.");
	if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)return
 	SendClientMessage(playerid,COLOR_GREY, "Du bist nicht Fahrer eines Fahrzeuges.");

	//Motor an/aus
	GetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	if(tmp_engine==1){
		tmp_engine = 0;
		SendClientMessage(playerid,COLOR_HBLUE,"INFO: {FFFFFF}Motor ausgeschaltet.");
		}else{
		tmp_engine = 1;
		SendClientMessage(playerid,COLOR_HBLUE,"INFO: {FFFFFF}Motor eingeschaltet.");
		}
		SetVehicleParamsEx(vID,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
return 1;
}
if(newkeys & KEY_ACTION)
{
	if(!IsPlayerInAnyVehicle(playerid))return 1;
	if(GetVehicleModel(GetPlayerVehicleID(playerid))!= 525)return 1;
	//Im Abschlepper
	new vID=GetPlayerVehicleID(playerid);
	if(IsTrailerAttachedToVehicle(vID))
	{
		return 1;
	}
	else
	{
		new carID = INVALID_VEHICLE_ID;
		new Float:abstand = 8;
		new Float:x,Float:y,Float:z;
		GetVehiclePos(vID,x,y,z);
		for(new i=0; i<MAX_VEHICLES; i++)
		{
		if(!IsVehicleStreamedIn(i, playerid))continue;
		if(i==vID)continue;
		if(GetVehicleDistanceFromPoint(i, x,y,z) < abstand)
		{
			abstand = GetVehicleDistanceFromPoint(i,x,y,z);
			carID =i;
		}
		}
		if(carID !=INVALID_VEHICLE_ID)
		{
		AttachTrailerToVehicle(carID,vID);
		}
	}
}
return 1;
}

	if(newkeys & KEY_NO)
	{
	
	//Enterbefehl
	if(GetPlayerInterior(playerid) ==0){
	for(new i=0; i<sizeof(bInfo); i++)
{
	if(!IsPlayerInRangeOfPoint(playerid,2,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z]))continue;
	SetPlayerPos(playerid,bInfo[i][b_ix],bInfo[i][b_iy],bInfo[i][b_iz]);
	SetPlayerInterior(playerid,bInfo[i][b_interior]);
	SetPlayerVirtualWorld(playerid,i);
	return 1;
	}
	return 1;
	}
	else if(GetPlayerInterior(playerid) >0){
	//exitbefehl
		for(new i=0; i<sizeof(bInfo); i++)
	{
	    if(GetPlayerVirtualWorld(playerid)!=i)continue;
	    if(!IsPlayerInRangeOfPoint(playerid,2,bInfo[i][b_ix],bInfo[i][b_iy],bInfo[i][b_iz]))continue;
	    SetPlayerPos(playerid,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z]);
	    SetPlayerInterior(playerid,0);
	    SetPlayerVirtualWorld(playerid,0);
    	return 1;
	}
	}
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
new params[8];
for(new i = 0; i < MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i) && pVCam[i] == playerid) {
        format(params, sizeof(params), "%d", playerid);
        cmd_vcam(i, params); //oder besser in eine Funktion auslagern, die auch vom Befehl aufgerufen wird
    }
}
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
		cInfo[id][farbe1]=cache_get_field_content_int(i,"f1",dbhandle);
		cInfo[id][farbe2]=cache_get_field_content_int(i,"f2",dbhandle);
		cInfo[id][id_x]=CreateVehicle(cInfo[id][model],cInfo[id][c_x],cInfo[id][c_y],cInfo[id][c_z],cInfo[id][c_r],cInfo[id][farbe1],cInfo[id][farbe2],-1);
        tank[id]=cache_get_field_content_int(i,"tank",dbhandle);
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
	    //Passwort richtig Spieler Laden
	    sInfo[playerid][level] = cache_get_field_content_int(0,"level",dbhandle);
	    SetPlayerScore(playerid,sInfo[playerid][level]);
	    sInfo[playerid][db_id] = cache_get_field_content_int(0,"id",dbhandle);
	    SetPlayerMoney(playerid,cache_get_field_content_int(0,"money",dbhandle));
	    sInfo[playerid][adminlevel] = cache_get_field_content_int(0,"adminlevel",dbhandle);
	    sInfo[playerid][skin] = cache_get_field_content_int(0,"skin",dbhandle);
	    sInfo[playerid][fraktion] = cache_get_field_content_int(0,"fraktion",dbhandle);
	    sInfo[playerid][rang] = cache_get_field_content_int(0,"rang",dbhandle);
		sInfo[playerid][spawnchange] = cache_get_field_content_int(0,"spawnchange",dbhandle);
		sInfo[playerid][sx] = cache_get_field_content_int(0,"x",dbhandle);
		sInfo[playerid][sy] = cache_get_field_content_int(0,"y",dbhandle);
		sInfo[playerid][sz] = cache_get_field_content_int(0,"z",dbhandle);
		sInfo[playerid][pgreen] = cache_get_field_content_int(0,"green",dbhandle);
		sInfo[playerid][pgold] = cache_get_field_content_int(0,"gold",dbhandle);
		sInfo[playerid][plsd] = cache_get_field_content_int(0,"lsd",dbhandle);
		sInfo[playerid][pdonut] = cache_get_field_content_int(0,"donut",dbhandle);
        sInfo[playerid][sx] = cache_get_field_content_int(0,"x",dbhandle);
		sInfo[playerid][sy] = cache_get_field_content_int(0,"y",dbhandle);
		sInfo[playerid][sz] = cache_get_field_content_int(0,"z",dbhandle);

		
		

	/*	if(isAdmin(playerid,1)){
   		new name[128],string[128];
		GetPlayerName(playerid,name,sizeof(name));
		format(string, sizeof(string),"[NeS]%s",name);
		SetPlayerName(playerid,string);
		return 1;
}*/

		SetSpawnInfo(playerid, 0, sInfo[playerid][skin], sInfo[playerid][sx],sInfo[playerid][sy], sInfo[playerid][sz],0, 0, 5, 0, 0, 0, 0);
		SpawnPlayer(playerid);
	   	loadPlayerCars(playerid);
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


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	//Aduty Management
	if(dialogid==DIALOG_ADUTY)
	{
	new string2[128],string[128],name[MAX_PLAYER_NAME];
		if(response)
 		{
 			if(listitem==0){
 			SetPlayerColor(playerid, COLOR_RED);
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als ServerOwner im Dienst.", name);
            if(!isaduty(playerid)){
			SendClientMessageToAll(COLOR_RED, string);
			sInfo[playerid][aduty]=1;
			TextDrawShowForPlayer(playerid,Textdraw0);
			}
			else{
			format(string2, sizeof(string), "SERVER: %s {FFFFFF}ist nicht mehr im Dienst.", name);
			SendClientMessageToAll(COLOR_RED,string2);
			sInfo[playerid][aduty]=0;
			TextDrawHideForPlayer(playerid,Textdraw0);
			return 1;
			}
	 	}
		    if(listitem==1){
 			SetPlayerColor(playerid, COLOR_RED);
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als Großmogul im Dienst.", name);
            if(!isaduty(playerid)){
			SendClientMessageToAll(COLOR_RED, string);
			sInfo[playerid][aduty]=1;
			TextDrawShowForPlayer(playerid,Textdraw0);
			}
			else{
			format(string2, sizeof(string), "SERVER: %s {FFFFFF}ist nicht mehr im Dienst.", name);
			SendClientMessageToAll(COLOR_RED,string2);
			sInfo[playerid][aduty]=0;
			TextDrawHideForPlayer(playerid,Textdraw0);
			return 1;
			}
		}
   			if(listitem==2){
 			SetPlayerColor(playerid, COLOR_RED);
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als Größte Instanz des Servers im Dienst.", name);
            if(!isaduty(playerid)){
			SendClientMessageToAll(COLOR_RED, string);
			sInfo[playerid][aduty]=1;
			TextDrawShowForPlayer(playerid,Textdraw0);
			}
			else{
			format(string2, sizeof(string), "SERVER: %s {FFFFFF}ist nicht mehr im Dienst.", name);
			SendClientMessageToAll(COLOR_RED,string2);
			sInfo[playerid][aduty]=0;
			TextDrawHideForPlayer(playerid,Textdraw0);
			return 1;
			}
		}
			if(listitem==3){
			if(!isaduty(playerid)){
 			SetPlayerColor(playerid, COLOR_RED);
 			SendClientMessage(playerid, COLOR_WHITE, "Du bist nun silent Aduty");
			sInfo[playerid][aduty]=1;
			}
			else{
 			SetPlayerColor(playerid, COLOR_WHITE);
 			SendClientMessage(playerid, COLOR_WHITE, "Du bist nun nicht mehr silent Aduty");
			sInfo[playerid][aduty]=0;
			}
			return 1;
	}
	}
}




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
	            format(query,sizeof(query),"SELECT * FROM user WHERE username='%s' AND passwort='%s'",name,passwort);
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
	            format(query,sizeof(query),"INSERT INTO user (username,passwort) VALUES ('%s','%s') ",name,passwort);
	            mysql_function_query(dbhandle,query,true,"OnPlayerRegister","i",playerid);
	            
	        }
	        else
	        {
	            //Kleiner als 4 Zeichen
	            SendClientMessage(playerid,COLOR_RED,"Dein Passwort muss mindestens 4 Zeichen lang sein.");
	            ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_INPUT,"Registrierung","Gib bitte dein gewünschtes Passwort an:","Okay","Abbrechen");
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
			PlayAudioStreamForPlayer(playerid, "http://127.0.0.1/Musik/musik.mp3",0.0,0.0,0.0, 1);
			SendClientMessage(playerid,COLOR_HGREEN,"Du hast das Radio angeschaltet. Viel Spaß beim Hören!");
			SetPVarInt(playerid,"streamon",1);
			return 1;
			}
			if(listitem==1)
			{
			PlayAudioStreamForPlayer(playerid,"http://radio.breakz.fm/listen.pls",0.0,0.0,0.0, 1);
			SendClientMessage(playerid,COLOR_HGREEN,"Du hast das Radio angeschaltet. Viel Spaß beim Hören!");
			SetPVarInt(playerid,"streamon",1);
			return 1;
			}
			if(listitem==3)
			{
			PlayAudioStreamForPlayer(playerid,"http://stream.ffn.de/radiobollerwagen/mp3-192",0.0,0.0,0.0, 1);
			SendClientMessage(playerid,COLOR_HGREEN,"Du hast das Radio angeschaltet. Viel Spaß beim Hören!");
			SetPVarInt(playerid,"streamon",1);
			return 1;
			}
			if(listitem==4)
			{
			PlayAudioStreamForPlayer(playerid,"https://wdr-1live-live.icecastssl.wdr.de/wdr/1live/live/mp3/128/stream.mp3",0.0,0.0,0.0, 1);
			SendClientMessage(playerid,COLOR_HGREEN,"Du hast das Radio angeschaltet. Viel Spaß beim Hören!");
  			SetPVarInt(playerid,"streamon",1);
			return 1;
			}
			else
			{
				SendClientMessage(playerid,COLOR_GREY,"Vorgang abgebrochen.");
			}
		}
	}
	
	
	
	
	
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
		if(dialogid==DIALOG_ASPAWN)
	{
	    if(response)
	    {
			if(listitem==0)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(560,x,y,z,0,-1,-1,0,1);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			}
			if(listitem==1)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(411,x,y,z,0,-1,-1,0,1);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			}

			if(listitem==2)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(494,x,y,z,0,-1,-1,0,1);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			}
			if(listitem==3)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(522,x,y,z,0,-1,-1,0,0);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			}

			if(listitem==4)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(451,x,y,z,0,-1,-1,0,0);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			}

			if(listitem==5)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(480,x,y,z,0,-1,-1,0,0);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			}
			
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_RED,"Vorgang abgebrochen.");
	    }
	 return 1;
	}
	if(dialogid==DIALOG_SPAWNCHANGE)
	{
	if(response)
	{
	if(listitem==0)
	{
	sInfo[playerid][spawnchange] = 0;
	}
	if(listitem==1)
	{
	sInfo[playerid][spawnchange] =1;
	}
	if(listitem==2)
	{
	sInfo[playerid][spawnchange] =2;
	}
	if(listitem==3)
	{
	sInfo[playerid][spawnchange] =3;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x, y, z);
	x = sInfo[playerid][sx];
	y = sInfo[playerid][sy];
	z = sInfo[playerid][sz];
	savePlayer(playerid);
	}
	}
	else{SendClientMessage(playerid,COLOR_RED,"FEHLER: Vorgang abgebrochen!");}
		}
	if(dialogid==DIALOG_TP)
	{
	    if(response)
	    {
			if(listitem==0)
			{
			    //Spawn
	      		SetPlayerVirtualWorld(playerid,0);
			    SetPlayerInterior(playerid,0);
			    SetPlayerPos(playerid,199.0846,-150.0331,1.5781);
			}
			if(listitem==1)
			{
			    //Farm
	      		SetPlayerVirtualWorld(playerid,0);
			    SetPlayerInterior(playerid,0);
			    SetPlayerPos(playerid,1199.0903,-901.1480,48.0625);

			}

			if(listitem==2)
			{
			    //LSPD
			      SetPlayerVirtualWorld(playerid,0);
			    SetPlayerInterior(playerid,0);
			    SetPlayerPos(playerid,1539.6733,-1657.0175,13.5491);
			}
			if(listitem==3)
			{
			//Restaurant Blueberry
			  SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,212.1142,-202.1886,1.5781);
			}
			if(listitem==4)
			{
			//Taxijob
			  SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,1222.1434,-1815.5588,16.5938);
			}
			if(listitem==5)
			{
			//Pier
			  SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,369.6803,-2030.0925,7.6719);
			}
			if(listitem==6)
			{
			    //LS Airport
			    SetPlayerVirtualWorld(playerid,0);
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,1958.0535,-2182.1360,13.5469);
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
