//Projekt by Ioannis20x(Ioannis_Gutenberg)
//Alle Rechte bei Ioannis20x

//includes
#include <a_samp>
#include <zCMD>
#include <sscanf2>
#include <a_mysql>
#include <streamer>


/*Fraktionen
0: Zivilisten
1: SAPD
2: FBI
3: San Andreas Army
4: San Andreas Rettungsdienst
5: LCN
6: Yaki
7: Regierung
8: Hitman
9: San Andreas Media AG
10: Ironbutts
11: Scarfo
12: Nicht inviten!
13: Ballas Family
14: Grove Street
15: Ordnunsamt alt(nicht inviten!)
16: Terrors
17: Triaden
18: Korsakow
19: LV
20: DMV
*/

// Players Move Speed
#define MOVE_SPEED              100.0
#define ACCEL_RATE              0.03

// Players Mode
#define CAMERA_MODE_NONE    	0
#define CAMERA_MODE_FLY     	1

// Key state definitions
#define MOVE_FORWARD    		1
#define MOVE_BACK       		2
#define MOVE_LEFT       		3
#define MOVE_RIGHT      		4
#define MOVE_FORWARD_LEFT       5
#define MOVE_FORWARD_RIGHT      6
#define MOVE_BACK_LEFT          7
#define MOVE_BACK_RIGHT         8

//Farben
#define COLOR_RED 0xFF0000FF
#define COLOR_HRED 0xFF6347FF
#define COLOR_YELLOW 0xFFFA00FF
#define COLOR_GREY 0x828282FF
#define COLOR_DARK_RED 0x6A0000FF
#define COLOR_GREEN 0x4BB400FF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_HGREEN 0x9ACD32FF
#define COLOR_BLACK 0x000000FF
#define COLOR_BLUE 0x0000FFFF
#define COLOR_HBLUE 0x51CCFFFF
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
#define SERVERTAG  Testserver
//#define Weihnachten
//#define SERVERPAS
#define SERVEROWNER Ioannis

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
#define DIALOG_SEIGABE 13
#define DIALOG_KICK 14

//MySQL
#define DB_HOST "localhost"
#define DB_USER "samp"
#define DB_PAS "samp"
#define DB_DB "samp"

//Limits
#define CHAT_RADIUS 40
#define CHAT_FADES 5
#define MAX_FRAKS 21



//enums
enum playerInfo{
	pName,
	eingeloggt,
	level,
 	db_id,
 	adminlevel,
 	fschein,
 	skin,
 	sx,
 	sy,
 	sz,
 	fSkin,
 	fraktion,
 	frang,
 	spawnchange,
 	pdonut,
 	pgreen,
 	pgold,
 	plsd,
 	deaths,
 	oldname[MAX_PLAYER_NAME],
 	pOL,
 	tazer
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

enum noclipenum
{
	cameramode,
	flyobject,
	mode,
	lrold,
	udold,
	lastmove,
	Float:accelmul
}

enum buildingsenum{
	Float:b_x,
	Float:b_y,
	Float:b_z,
	Float:b_ix,
	Float:b_iy,
	Float:b_iz,
	b_interior,
	b_shopname[64],
	EnterArea,
	ExitArea
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
 	farbe2,
 	kennzeichen

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
	f_green,
	f_gold,
	f_lsd,
	f_kasse,
	fmotd[64]
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
new Text:Tachobox;
new cInfo[50][carenum];
new p1,p2,p3;
new Float:dx,Float:dy,Float:dz;
new stream[512];
new noclipdata[MAX_PLAYERS][noclipenum];


//Fraktionen
new fInfo[MAX_FRAKS][frakEnum] = {
{0,"Zivilisten",0.0,0.0,0.0,0.0,0,0,COLOR_WHITE,0.0,0.0,0.0},
{1,"San Andreas Police Department",197.2779,165.4692,1003.0234,0.0,3,0,COLOR_BLUE,197.875259,166.845626,1003.023437,1554.9139,-1675.6171,16.1953,288.7386,167.5315,1007.1719},
{2,"FBI",254.222976,77.299613,1003.640625,180.0,6,6,COLOR_BLUE,254.431732,77.014465,1003.640625,1035.4070,1015.9806,11.0000,246.7729,62.8960,1003.6406},
{3,"San Andreas Army",247.729263,1859.122802,14.084012,0.0,0,0,COLOR_GREEN,247.729263,1859.122802,14.084012,},
{4,"San Andreas Rettungsdienst",2026.812133,-1403.623168,17.224706,0.0,0,0,COLOR_PINK,2026.812133,-1403.623168,17.224706},
{5,"La Cosa Nostra",1710.433715,-1669.379272,20.225049,270.0,18,0,COLOR_WHITE,0.0,0.0,0.0,2196.9661,1677.1620,12.3672,1701.3983,-1667.8174,20.2188},
{6,"Yakuza",-2634.278320,1405.830688,906.460937,90.0,3,0,COLOR_WHITE,0.0,0.0,0.0,2634.7559,1824.1881,11.0161,-2636.7302,1402.5090,906.4609},
{7,"Regierung",1235.781127,-808.214904,1084.007812,180.0,5,0,COLOR_BROWN,1235.781127,-808.214904,1084.007812,1123.0101,-2037.0333,69.8938,1260.9401,-785.3860,1091.9063},
{8,"Hitman Agency",1541.9044,-1365.1841,326.2109,266.5415,0,0,COLOR_WHITE,0.0,0.0,0.0},
{9,"San Andreas Media AG",1821.5050,-1313.0146,120.2656,0.0,0,0,COLOR_ORANGE,1821.5050,-1313.0146,120.2656,-1943.1633,457.1358,35.1719,1786.5927,-1300.1877,120.2656},
{10,"Ironbutts MC",-795.062072,489.650573,1376.195312,0.0,1,0,COLOR_WHITE,0.0,0.0,0.0,1223.7313,246.7464,19.5469,-794.9636,489.4679,1376.1953},
{11,"Scarfo Family",1056.047851,2087.745605,10.820312,270.0,0,0,COLOR_WHITE,0.0,0.0,0.0,1751.5009,-2054.3950,14.0731,1056.0479,2087.7456,10.8203},
{12,"Hier bitte nicht inviten!",01.0,02.0,0.03,0.04,0,0,COLOR_WHITE,0.0,0.0,0.0},
{13,"Ballas Family",2451.4604,-1690.4203,1013.5078,0.0,2,1,COLOR_WHITE,0.0,0.0,0.0,2333.3357,-1883.0869,15.0000,2466.4543,-1698.2504,1013.5078},
{14,"Grove Street Family",2495.541503,-1712.026489,1014.742187,0.0,3,0,COLOR_WHITE,0.0,0.0,0.0,2495.3901,-1690.7659,14.7656,2495.9937,-1692.2738,1014.7422},
{15,"Ordnungsamt(Nicht betreten!)",0.0,0.0,0.0,0.0,0,0,COLOR_WHITE,0.0,0.0,0.0},
{16,"Al Sajaf",-1685.636474,1035.476196,45.210937,0.0,0,0,COLOR_WHITE,0.0,0.0,0.0,-1849.0645,-1604.7258,21.7578,-1694.5588,1035.6222,45.2109},
{17,"Triaden",2016.2699,1017.7790,996.8750,0.0,10,0,COLOR_WHITE,0.0,0.0,0.0,1923.7427,959.9255,10.8203,2019.0720,1017.9080,996.8750},
{18,"Korsakow Familie",1133.326049,-15.521119,1000.679687,0.0,12,0,COLOR_WHITE,0.0,0.0,0.0,2127.4836,2379.3384,10.8203,1133.3260,-15.5211,1000.6797},
{19,"Los Vagos",493.390991,-22.722799,1000.679687,0.0,17,0,COLOR_WHITE,0.0,0.0,0.0,2259.6399,-1019.1033,59.2969,493.5826,-24.1817,1000.6797},
{20,"DMV",1494.583251,1309.183227,1093.283447,180.0,3,0,COLOR_HBLUE,1494.583251,1309.183227,1093.283447,1419.6180,-1623.7090,13.5469,1494.3961,1303.7765,1093.2891}
};



//Läden
new bInfo[][buildingsenum] ={
{243.0825,-178.3224,1.5822,285.3642,-41.5576,1001.5156,1,"Ammu Nation Blueberry"},//Ammu Nation 1
{212.1142,-202.1886,1.5781,372.4523,-133.5244,1001.4922,5,"Pizza Stack Blueberry"},//Pizza
{2351.604980,-1412.101928,23.992372,-2240.964355,128.358978,1035.414062,6,"IKEA Möbelhaus"},//IKEA
{2244.4851,-1665.1661,15.4766,207.737991,-109.019996,1005.132812,15,"BINCO GS"}//Binco GS
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
forward savefraks();
forward OnFraksLoad();
forward loadfraks();

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
	if(GetPVarInt(playerid,"aduty")==1)return 1;
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
public OnFraksLoad()
{
	new num_fields,num_rows;
	cache_get_data(num_rows,num_fields,dbhandle);
	if(!num_rows)return 1;
	for(new i=0; i<num_rows; i++)
	{
	    cache_get_field_content(i, "Name", fInfo[i][f_name]);
		fInfo[i][f_kasse]=cache_get_field_content_int(i,"Bank",dbhandle);
		fInfo[i][f_gold]=cache_get_field_content_int(i,"Gold",dbhandle);
		fInfo[i][f_lsd]=cache_get_field_content_int(i,"LSD",dbhandle);
		fInfo[i][f_green]=cache_get_field_content_int(i,"Green",dbhandle);
		cache_get_field_content(i,"fmotd",fInfo[i][fmotd],dbhandle);
	}

return 1;
}

public loadfraks()
{
new string[256],query[256];
for(new i=0;i<sizeof(fInfo);i++){
	format(query,sizeof(query),"SELECT * FROM fraktionen WHERE id='%i'",i);
	format(string,sizeof(string),"Fraktion: %s wurde Geladen",fInfo[i][f_name]);
	mysql_function_query(dbhandle,query,true,"OnFraksLoad","");
 	CreatePickup(1239,1,fInfo[i][f_dx],fInfo[i][f_dy],fInfo[i][f_dz],0);
    CreatePickup(19198,1,fInfo[i][f_enx],fInfo[i][f_eny],fInfo[i][f_enz],0);
    CreatePickup(19198,1,fInfo[i][f_exx],fInfo[i][f_exy],fInfo[i][f_exz],0);
	printf(string);
}}
public savefraks()
{
	for(new i = 0; i<19;i++)
	{
  	new query[2048];
	format(query,sizeof(query),"UPDATE fraktionen SET Name='%s[64]', Bank='%i',Green='%i',Gold='%i, LSD='%i', fmotd='%s[64]' WHERE id='%i'",fInfo[i][f_name],fInfo[i][f_kasse],fInfo[i][f_green],fInfo[i][f_gold],fInfo[i][f_lsd],fInfo[i][fmotd],fInfo[i][f_ID]);
	mysql_function_query(dbhandle,query,true,"","");
	}
	return 1;
}

public OnGameModeInit()
{
 #if defined SERVERPAS
 SendRconCommand("password  Ioannis");
 #endif
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
	Textdraw0 = TextDrawCreate(575.000000, 55.000000, "Admindienst");
	TextDrawBackgroundColor(Textdraw0, 255);
	TextDrawFont(Textdraw0, 1);
	TextDrawLetterSize(Textdraw0, 0.280000, 1.000000);
	TextDrawColor(Textdraw0, -16776961);
	TextDrawSetOutline(Textdraw0, 1);
	TextDrawSetProportional(Textdraw0, 1);
	//TachoTD
	Tacho = TextDrawCreate(483.000000, 430.000000, "0");
	//KMHTD
	kmhtd = TextDrawCreate(508.000000, 429.000000, "KM/H");
	TextDrawAlignment(Textdraw0, 2);
	TextDrawBackgroundColor(kmhtd, 255);
	TextDrawFont(kmhtd, 1);
	TextDrawLetterSize(kmhtd, 0.500000, 1.000000);
	TextDrawColor(kmhtd, -1);
	TextDrawSetOutline(kmhtd, 0);
	TextDrawSetProportional(kmhtd, 1);
	TextDrawSetShadow(kmhtd, 1);
	TextDrawUseBox(kmhtd, 0);

	Tachobox = TextDrawCreate(455.000000,455.000000, "_");//tachometer box
	TextDrawUseBox(Tachobox,1);
	TextDrawBoxColor(Tachobox,0x00000067);
	TextDrawBackgroundColor(Tachobox,0x00000067);
	TextDrawTextSize(Tachobox,640,480);
	TextDrawLetterSize(Tachobox,1.000000,-5.000000);
	TextDrawAlignment(Tachobox,1);
		lift1 =  CreateObject(3115,390.9899900,-1942.3500000,6.5000000,0.0000000,0.0000000,0.0000000); //object(carrier_lift1_sfse) (1)
	lift2 = CreateObject(6933,391.7999900,-2003.5000000,-60.0000000,0.0000000,0.0000000,0.0000000); //object(vegasplant0 (1)

	//MySQL
	dbhandle=mysql_connect(DB_HOST,DB_USER,DB_DB,DB_PAS);

	//Gebäude laden
	for(new i=0; i<sizeof(bInfo); i++)
	{
	new string[32];
 	CreatePickup(1239,1,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z],0);
 	format(string,sizeof(string),"Geschäft: %s",bInfo[i][b_shopname]);
    Create3DTextLabel(string,COLOR_ORANGE,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z]+0.25,10,0,0);
 	Create3DTextLabel("Zum betreten /enter",COLOR_WHITE,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z],10,0,0);
 	bInfo[i][EnterArea] = CreateDynamicSphere(bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z],1);
 	bInfo[i][ExitArea] = CreateDynamicSphere(bInfo[i][b_ix],bInfo[i][b_iy],bInfo[i][b_iz],0);
	}

	//Autohaus laden
	for(new i=0; i<sizeof(ahCars); i++)
	{
	ahCars[i][id_x]=AddStaticVehicle(ahCars[i][model],ahCars[i][c_x],ahCars[i][c_y],ahCars[i][c_z],ahCars[i][c_r],-1,-1);
	}

p1 = CreateObject(1215, 371.16800, -2038.30005, 7.24000,   0.00000, 0.00000, 0.00000);
p2 = CreateObject(1215, 369.82370, -2038.30005, 7.24000,   0.00000, 0.00000, 0.00000);
p3 = CreateObject(1215, 368.36111, -2038.30005, 7.24000,   0.00000, 0.00000, 0.00000);
CreateObject(19529, 1470.13696, -1655.02759, 12.32920,   0.00000, 0.00000, 0.00000);
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

	loadfraks();
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
AddStaticVehicle(437,1421.9589,-2339.6245,13.7036,358.5345,47,74); // av4
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
		hInfo[id][h_text]=Create3DTextLabel(string, COLOR_RED, hInfo[id][h_x], hInfo[id][h_y], hInfo[id][h_z], 10, 0, 1);
	}
	else
	{
		hInfo[id][h_pickup]=CreatePickup(1239, 1, hInfo[id][h_x], hInfo[id][h_y], hInfo[id][h_z], -1);
		format(string,sizeof(string), "Besitzer: %s\n/enter", hInfo[id][h_besitzer]);
		hInfo[id][h_text]=Create3DTextLabel(string, COLOR_HGREEN, hInfo[id][h_x], hInfo[id][h_y], hInfo[id][h_z], 10, 0, 1);
	}
	return 1;
}

public OnGameModeExit()
{
	savefraks();
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
		format(string, sizeof(string), "Tank: %i%%~n~%s", tank[vID],getVehicleName(GetVehicleModel(vID)));
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
SetCameraBehindPlayer(playerid);
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
	    ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,"Login","Bitte gebe dein Passwort ein:","Okay","Abbrechen");
	}
	return 1;
}
//Textdraws
public OnPlayerConnect(playerid)
{
for(new i = 0; i < 35; i++) SendClientMessage(playerid,COLOR_GREY," ");
#if defined Weihnachten
loadxmas();
stream = "http://localhost/musik/xmas.mp3";
#else
stream = "http://localhost/musik/musik.mp3";
#endif
DisablePlayerCheckpoint(playerid);
	new nachricht[128],Float:x,Float:y,Float:z;
	SetPlayerCameraPos(playerid,1481.3153,-1722.0088,17.9948);
	SetPlayerCameraLookAt(playerid,1481.5920,-1766.3236,18.7958);
	GetPlayerPos(playerid, x, y, z);
	PlayAudioStreamForPlayer(playerid, stream);
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
	
	noclipdata[playerid][cameramode] 	= CAMERA_MODE_NONE;
	noclipdata[playerid][lrold]	   	 	= 0;
	noclipdata[playerid][udold]   		= 0;
	noclipdata[playerid][mode]   		= 0;
	noclipdata[playerid][lastmove]   	= 0;
	noclipdata[playerid][accelmul]   	= 0.0;
	
	return 1;
}
saveSkin(pID)
{
	new query[1024];
	format(query,sizeof(query),"UPDATE user SET skin='%i'WHERE id='%i'",GetPlayerSkin(pID),sInfo[pID][db_id]);
	mysql_function_query(dbhandle,query,false,"","");
	return 1;
}
savePlayer(playerid)
{
	if(sInfo[playerid][eingeloggt]==0)return 1;
	//speichern level,money
	new query[1024], Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x,y,z);
	format(query,sizeof(query),"UPDATE user SET level='%i',money='%i',adminlevel='%i',fraktion='%i',rang='%i',fskin='%i',spawnchange='%i',x='%i',y='%i',z='%i',donut='%i', deaths='%i', orangelist='%i' WHERE id='%i'",
	sInfo[playerid][level],GetPlayerMoney(playerid),sInfo[playerid][adminlevel],sInfo[playerid][fraktion],sInfo[playerid][frang],sInfo[playerid][fSkin],sInfo[playerid][spawnchange],sInfo[playerid][sx],sInfo[playerid][sy],sInfo[playerid][sz],sInfo[playerid][pdonut],sInfo[playerid][deaths],sInfo[playerid][pOL],sInfo[playerid][db_id]);
	mysql_function_query(dbhandle,query,false,"","");
//	format(query,sizeof(query),"UPDATE user SET spawnchange='%i',x='%i',y='%i',z='%i',fraktion='%i' ,rang='%i'WHERE id='%i'",sInfo[playerid][spawnchange],sInfo[playerid][sx],sInfo[playerid][sy],sInfo[playerid][sz],sInfo[playerid][fraktion],sInfo[playerid][frang],sInfo[playerid][db_id]);
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
stock SendFrakMessage(fraktid,color,string[])
{

	for(new i = 0 ; i < MAX_PLAYERS ; i++)
	{
	    if(IsPlayerConnected(i) && sInfo[i][eingeloggt] == 1)
	    {
	        if(sInfo[i][fraktion] == fraktid)
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
	PlayerTextDrawDestroy(playerid, tankLabel[playerid]);
	return 1;
}
	saveCarToDB(playerid,carid);
	isPlayerInFrak(playerid,f_id){
	if(sInfo[playerid][fraktion]==f_id)return 1;
		for(new x; x<MAX_PLAYERS; x++)
	{
		if(noclipdata[x][cameramode] == CAMERA_MODE_FLY) CancelFlyMode(x);
	}
	return 0;
}


public OnPlayerSpawn(playerid)
{
    SetPlayerColor(playerid, 0xFFFFFFFF);
	StopAudioStreamForPlayer(playerid);
	if(!isPlayerInFrak(playerid,0)){
	//Fraktion
	if(sInfo[playerid][spawnchange]==1){
	new fID;
	fID = sInfo[playerid][fraktion];
		SetPlayerPos(playerid,fInfo[fID][f_x],fInfo[fID][f_y],fInfo[fID][f_z]);
		SetPlayerFacingAngle(playerid,fInfo[fID][f_r]);
		SetPlayerInterior(playerid,fInfo[fID][f_inter]);
		SetPlayerVirtualWorld(playerid,fInfo[fID][f_world]);
	}
	else
	//Haus
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
			SetPlayerPos(playerid,hInfo[i][ih_x],hInfo[i][ih_y],hInfo[i][ih_z]);
   			SetPlayerInterior(playerid,0);
   		 	SetPlayerVirtualWorld(playerid,0);
			
		}
		//Noobspawn
	if(sInfo[playerid][spawnchange]==2){
	SetPlayerPos(playerid, 1481.59,-1766.32,18.7958);
	SetPlayerFacingAngle(playerid,3.2137);
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	}}
	}
		}
  //Letzte Position
	if(sInfo[playerid][spawnchange]==3){
	new Float:x,Float:y,Float:z;
	x = sInfo[playerid][sx];
	y = sInfo[playerid][sy];
	z = sInfo[playerid][sz];
	SetPlayerPos(playerid,x,y,z);

	return 1;
	}
	if(sInfo[playerid][eingeloggt]==0){
		new string[128],fdt[256],fID;
		fID = sInfo[playerid][fraktion];
	format(string,sizeof(string),"SERVER: {FFFFFF}Willkommen %s.",getPlayerName(playerid));
	SendClientMessage(playerid,COLOR_RED,string);
	format(fdt,sizeof(fdt),"FMOTD: %s",fInfo[fID][fmotd]);
	SendClientMessage(playerid,COLOR_YELLOW,fdt);
	
	}
 #if defined Weihnachten
	if(sInfo[playerid][eingeloggt]==0){
		new string[128];
	format(string,sizeof(string),"SERVER: {FFFFFF}Der "#SERVERTAG" wünscht dir frohe Weihnachten.",getPlayerName(playerid));
	SendClientMessage(playerid,COLOR_RED,string);
	}
#endif
SetPlayerSkin(playerid,sInfo[playerid][skin]);
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
SetPVarInt(playerid,"fduty",0);
 // Declare 3 float variables to store the X, Y and Z coordinates in
 //   new Float:x, Float:y, Float:z;

    // Use GetPlayerPos, passing the 3 float variables we just created
    GetPlayerPos(playerid,dx,dy,dz);
	new string[64];
	sInfo[playerid][deaths]++;
	format(string,sizeof(string),"SERVER: {FFFFFF}Du bist zum %i. Mal gestorben.",sInfo[playerid][deaths]);
	SendClientMessage(playerid,COLOR_RED,string);
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

saveCarToDB(playerid,carid)
{
	new query[128];
 	format(query,sizeof(query),"INSERT INTO autos (besitzer,model,x,y,z,r) VALUES ('%i','%i','%f','%f','%f','%f')",sInfo[playerid][db_id],cInfo[carid][model],cInfo[carid][c_x],cInfo[carid][c_y],cInfo[carid][c_z],cInfo[carid][c_r]);
	mysql_function_query(dbhandle,query,true,"CarSavedToDB","i",carid);
	return 1;
}
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



stock loadxmas()
{
	CreateObject(2226, 1480.4094, -1698.8457, 15.3203, 0.0000, 0.0000, 0.0000); //LOW_HI_FI_3
	CreateDynamicObject(19055, 1366.43, -1265.32, 13.13, 0.00, 0.00, 0.00);
	CreateDynamicObject(19056, 1365.28, -1266.57, 13.13, 0.00, 0.00, 0.00);
	CreateDynamicObject(19057, 1364.10, -1265.35, 13.13, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 1365.26, -1264.12, 13.13, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 1365.26, -1265.31, 12.45, 0.00, 0.00, 0.00);
	CreateDynamicObject(19056, 1010.46, -1122.47, 23.44, 0.00, 0.00, 0.00);
	CreateDynamicObject(19057, 1011.65, -1123.68, 23.44, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 1009.25, -1123.73, 23.44, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, 1010.46, -1124.96, 23.44, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 1010.43, -1123.73, 22.76, 0.00, 0.00, 0.00);
	CreateDynamicObject(19056, 1033.85, -1122.48, 23.44, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, 1035.02, -1123.63, 23.44, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 1032.62, -1123.63, 23.44, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, 1033.84, -1124.85, 23.44, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 1033.88, -1123.69, 22.78, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, 1183.13, -922.74, 42.79, 0.00, 0.00, 8.00);
	CreateDynamicObject(19056, 1184.47, -923.74, 42.79, 0.00, 0.00, 9.00);
	CreateDynamicObject(19057, 1182.19, -924.11, 42.79, 0.00, 0.00, 8.00);
	CreateDynamicObject(19058, 1183.52, -925.16, 42.79, 0.00, 0.00, 8.00);
	CreateDynamicObject(19076, 1183.36, -923.87, 42.11, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 928.15, -1235.95, 16.84, 0.00, 0.00, 0.00);
	CreateDynamicObject(19056, 928.33, -1234.94, 17.53, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 928.89, -1236.89, 17.53, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, 926.84, -1236.10, 17.53, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 927.86, -1201.55, 17.79, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 928.89, -1201.47, 18.48, 0.00, 0.00, -0.06);
	CreateDynamicObject(19054, 927.72, -1202.80, 18.48, 0.00, 0.00, -0.06);
	CreateDynamicObject(19057, 926.78, -1201.09, 18.48, 0.00, 0.00, -47.00);
	CreateDynamicObject(19055, 806.52, -1336.56, 13.14, 0.00, 0.00, 40.00);
	CreateDynamicObject(19056, 804.79, -1336.44, 13.14, 0.00, 0.00, -50.00);
	CreateDynamicObject(19058, 806.67, -1334.88, 13.14, 0.00, 0.00, 40.00);
	CreateDynamicObject(19057, 804.92, -1334.66, 13.14, 0.00, 0.00, 40.00);
	CreateDynamicObject(19076, 805.76, -1335.62, 12.45, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, 828.99, -1368.51, -0.92, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 828.22, -1366.91, -0.92, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, 827.31, -1368.33, -0.92, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, 806.88, -1386.04, 13.16, 0.00, 0.00, 47.00);
	CreateDynamicObject(19054, 806.91, -1387.65, 13.16, 0.00, 0.00, -43.63);
	CreateDynamicObject(19058, 805.20, -1386.06, 13.16, 0.00, 0.00, -43.00);
	CreateDynamicObject(19056, 805.23, -1387.69, 13.16, 0.00, 0.00, -43.00);
	CreateDynamicObject(19076, 806.03, -1386.89, 12.47, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 1657.59, -1884.51, 12.44, 0.00, 0.00, -2.88);
	CreateDynamicObject(19056, 1658.56, -1884.50, 13.14, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, 1656.59, -1884.49, 13.14, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, 1657.58, -1883.23, 13.14, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 1657.55, -1885.73, 13.14, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, 1812.66, -1880.46, 13.17, 0.00, 0.00, -0.12);
	CreateDynamicObject(19056, 1814.94, -1880.40, 13.17, 0.00, 0.00, -0.06);
	CreateDynamicObject(19058, 1813.80, -1881.66, 13.17, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, 1813.78, -1879.22, 13.17, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 1813.78, -1880.47, 12.48, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, 1812.66, -1898.74, 13.17, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, 1814.97, -1898.77, 13.17, 0.00, 0.00, 0.00);
	CreateDynamicObject(19057, 1813.81, -1900.00, 13.17, 0.00, 0.00, 0.00);
	CreateDynamicObject(19056, 1813.82, -1897.54, 13.17, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 1813.82, -1898.72, 12.48, 0.00, 0.00, -0.12);
	CreateDynamicObject(19055, 1128.51, -1448.68, 15.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(19056, 1127.28, -1449.84, 15.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 1129.69, -1449.86, 15.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, 1128.51, -1451.05, 15.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 1128.47, -1449.87, 14.70, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, 1249.31, -1425.88, 13.12, 0.00, 0.00, -45.90);
	CreateDynamicObject(19058, 1250.97, -1425.87, 13.12, 0.00, 0.00, -44.49);
	CreateDynamicObject(19054, 1250.96, -1424.22, 13.12, 0.00, 0.00, -45.06);
	CreateDynamicObject(19057, 1249.30, -1424.19, 13.12, 0.00, 0.00, 44.00);
	CreateDynamicObject(19076, 1250.12, -1425.03, 12.39, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, 489.33, -1794.05, 5.64, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 490.50, -1792.89, 5.64, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, 488.13, -1792.87, 5.64, 0.00, 0.00, 0.00);
	CreateDynamicObject(19057, 489.34, -1791.67, 5.64, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 489.38, -1792.82, 4.96, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, 1451.31, -1025.35, 23.41, 0.00, 0.00, -0.06);
	CreateDynamicObject(19054, 1451.34, -1027.73, 23.41, 0.00, 0.00, 0.00);
	CreateDynamicObject(19057, 1452.54, -1026.60, 23.41, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 1450.12, -1026.55, 23.41, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 1451.35, -1026.57, 22.73, 0.00, 0.00, 0.00);
	CreateDynamicObject(19057, 1472.80, -1025.25, 23.41, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, 1471.63, -1026.47, 23.41, 0.00, 0.00, 0.00);
	CreateDynamicObject(19056, 1473.99, -1026.49, 23.41, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 1472.79, -1027.69, 23.41, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 1472.78, -1026.46, 22.73, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, 1372.38, -938.58, 33.77, 0.00, 0.00, -7.49);
	CreateDynamicObject(19056, 1371.05, -939.64, 33.77, 0.00, 0.00, -7.30);
	CreateDynamicObject(19058, 1373.43, -939.96, 33.77, 0.00, 0.00, -8.24);
	CreateDynamicObject(19054, 1372.13, -941.05, 33.77, 0.00, 0.00, -7.49);
	CreateDynamicObject(19076, 1372.28, -939.81, 33.09, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, 1489.40, -1583.99, 13.13, 0.00, 0.00, -0.18);
	CreateDynamicObject(19054, 1490.58, -1585.17, 13.13, 0.00, 0.00, -0.06);
	CreateDynamicObject(19056, 1489.34, -1586.35, 13.13, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 1488.17, -1585.18, 13.13, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 1489.36, -1585.18, 12.45, 0.00, 0.00, -0.06);
	CreateDynamicObject(19058, 1507.52, -1586.33, 13.13, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, 1508.74, -1585.12, 13.13, 0.00, 0.00, 0.00);
	CreateDynamicObject(19056, 1506.31, -1585.10, 13.13, 0.00, 0.00, 0.00);
	CreateDynamicObject(19057, 1507.54, -1583.94, 13.13, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 1507.46, -1585.14, 12.45, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, 2060.36, -1911.81, 13.14, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, 2061.60, -1913.01, 13.14, 0.00, 0.00, 0.12);
	CreateDynamicObject(19058, 2062.47, -1911.02, 13.14, 0.00, 0.00, 47.00);
	CreateDynamicObject(19076, 2061.68, -1911.77, 12.45, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 2496.41, -1751.67, 12.94, 0.00, 0.00, -0.06);
	CreateDynamicObject(19054, 2497.59, -1750.44, 12.94, 0.00, 0.00, 0.00);
	CreateDynamicObject(19057, 2496.37, -1749.29, 12.94, 0.00, 0.00, -0.06);
	CreateDynamicObject(19055, 2495.22, -1750.56, 12.94, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 2496.40, -1750.52, 12.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, 1970.44, -2183.09, 13.14, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, 1969.23, -2184.30, 13.14, 0.00, 0.00, -0.12);
	CreateDynamicObject(19056, 1969.22, -2181.87, 13.14, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 1967.99, -2183.11, 13.14, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 1969.04, -2183.11, 12.45, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 1295.97, -2064.38, 58.19, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, 1297.14, -2063.20, 58.19, 0.00, 0.00, 0.00);
	CreateDynamicObject(19057, 1297.14, -2065.59, 58.19, 0.00, 0.00, 0.00);
	CreateDynamicObject(19056, 1298.33, -2064.40, 58.19, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 1297.13, -2064.32, 57.51, 0.00, 0.00, 0.00);
	CreateDynamicObject(19056, 1296.35, -2049.28, 58.21, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, 1297.52, -2048.09, 58.19, 0.00, 0.00, 0.00);
	CreateDynamicObject(19057, 1297.57, -2050.48, 58.19, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, 1298.70, -2049.27, 58.19, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 1297.48, -2049.26, 57.50, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, -1986.12, 268.23, 34.74, 0.00, 0.00, 0.00);
	CreateDynamicObject(19054, -1986.11, 265.89, 34.74, 0.00, 0.00, 0.00);
	CreateDynamicObject(19056, -1987.30, 267.06, 34.74, 0.00, 0.00, 0.00);
	CreateDynamicObject(19058, -1984.95, 267.07, 34.74, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, -1986.15, 267.03, 34.07, 0.00, 0.00, 0.00);
	CreateDynamicObject(19055, 1082.93, -1750.26, 13.43, 0.00, 0.00, 0.00);
	CreateDynamicObject(19056, 1084.09, -1751.44, 13.36, 6.00, 0.00, 0.00);
	CreateDynamicObject(19057, 1084.13, -1749.00, 13.29, -6.00, 0.00, 0.00);
	CreateDynamicObject(19054, 1085.31, -1750.25, 13.40, 0.00, 0.00, 0.00);
	CreateDynamicObject(19076, 1084.04, -1750.26, 12.77, 0.00, 0.00, -91.00);
	CreateDynamicObject(1290, 1078.44, -1750.42, 18.00, 0.00, 0.00, 91.00);

	CreateDynamicObject(19076, 1296.26843, -1864.18225, 12.03050,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19055, 1297.79333, -1863.48572, 13.19369,   0.00000, 0.00000, -25.74001);
	CreateDynamicObject(19056, 1296.22925, -1862.40515, 13.19370,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19058, 1294.52087, -1863.65271, 13.19370,   0.00000, 0.00000, 46.50001);
	CreateDynamicObject(19076, 24.25068, -1526.70190, 3.65259,   0.00000, -3.00000, 0.00000);
	CreateDynamicObject(19055, 23.02610, -1527.99219, 4.23558,   0.00000, -3.00000, 18.24000);
	CreateDynamicObject(19056, 22.19514, -1526.15845, 4.23560,   0.00000, -3.00000, -10.50000);
	CreateDynamicObject(19058, 24.27813, -1525.07764, 4.35559,   0.00000, -3.00000, 40.20001);
	CreateDynamicObject(19058, 25.37913, -1528.31885, 4.51559,   0.00000, -3.00000, -33.53999);
	CreateDynamicObject(19055, 26.22678, -1527.11841, 4.46174,   0.00000, -3.00000, -17.27999);
	CreateDynamicObject(19056, 25.93559, -1525.47766, 4.50865,   0.00000, -3.00000, -27.84001);
	CreateDynamicObject(19076, 1461.62793, -1744.76599, 12.59407,   0.00000, 0.00000, -2.22000);
	CreateDynamicObject(19055, 1461.49097, -1743.54407, 13.18603,   0.00000, 0.00000, -4.43999);
	CreateDynamicObject(19056, 1462.83667, -1744.66064, 13.15639,   0.00000, 0.00000, -39.96001);
	CreateDynamicObject(19058, 1460.38196, -1744.78625, 13.17384,   0.00000, 0.00000, 39.66002);
	CreateDynamicObject(19076, 1500.49988, -1744.76501, 12.59407,   0.00000, 0.00000, -2.22000);
	CreateDynamicObject(19056, 1500.55688, -1743.55640, 13.15639,   0.00000, 0.00000, -1.74001);
	CreateDynamicObject(19055, 1499.28979, -1744.82507, 13.18603,   0.00000, 0.00000, -49.49998);
	CreateDynamicObject(19058, 1501.88208, -1744.63989, 13.19542,   0.00000, 0.00000, -44.82000);

    new xmas[282];
	xmas[0] = CreateDynamicObject(19565, 1359.1606, -1070.6876, 27.5809, 0.0000, 90.0000, 0.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[0], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[1] = CreateDynamicObject(19845, 1301.2491, -1521.7274, 14.9679, 90.0000, 90.0000, 60.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[1], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[2] = CreateDynamicObject(19845, 1135.4648, -1045.0155, 33.6921, 90.0000, -90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[2], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[3] = CreateDynamicObject(19845, 1135.4748, -1045.0155, 34.1823, 90.0000, -90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[3], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[4] = CreateDynamicObject(19565, 1135.4553, -1045.1573, 33.1370, 0.0000, 90.0000, 90.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[4], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[5] = CreateDynamicObject(19565, 1359.1606, -1070.9078, 27.5809, 0.0000, 90.0000, 0.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[5], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[6] = CreateDynamicObject(19845, 1359.2976, -1070.6805, 28.1256, 90.0000, 90.0000, 90.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[6], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[7] = CreateDynamicObject(19845, 1359.2976, -1070.9510, 28.1256, 90.0000, 90.0000, 90.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[7], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[8] = CreateDynamicObject(19845, 1359.2976, -1070.6805, 28.5555, 90.0000, 90.0000, 90.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[8], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[9] = CreateDynamicObject(19845, 1359.2976, -1070.9310, 28.5555, 90.0000, 90.0000, 90.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[9], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[10] = CreateDynamicObject(19565, 469.0805, -1173.6561, 65.7011, 0.0000, 90.0000, 90.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[10], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[11] = CreateDynamicObject(19845, 469.0718, -1173.5128, 66.1763, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[11], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[12] = CreateDynamicObject(19845, 1301.2491, -1521.7274, 15.3779, 90.0000, 90.0000, 60.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[12], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[13] = CreateDynamicObject(19327, 1402.0705, -1732.3122, 20.4363, 0.0000, 0.0000, -90.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[13], 0, "Christ", 90, "Arial", 100, 1, 0xFFFFFFFF, 0x0, 0);
	xmas[14] = CreateDynamicObject(19565, 1301.1295, -1521.6623, 14.4588, 0.0000, 90.0000, -30.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[14], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[15] = CreateDynamicObject(18761, 1402.1865, -1732.4271, 17.5337, 0.0000, 0.0000, 90.0000); //RaceFinishLine1
	SetDynamicObjectMaterial(xmas[15], 0, 10765, "airportgnd_sfse", "white", 0xFF840410);
	SetDynamicObjectMaterial(xmas[15], 1, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[15], 2, 11100, "bendytunnel_sfse", "blackmetal", 0xFFFFFFFF);
	xmas[16] = CreateDynamicObject(19327, 1402.0705, -1729.9023, 20.4363, 0.0000, 0.0000, -90.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[16], 0,"Merry", 90, "Arial", 100, 1, 0xFFFFFFFF, 0x0, 0);
	xmas[17] = CreateDynamicObject(19327, 1402.0705, -1734.6628, 20.4363, 0.0000, 0.0000, -90.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[17], 0, "mas!", 90, "Arial", 100, 1, 0xFFFFFFFF, 0x0, 0);
	xmas[18] = CreateDynamicObject(19845, 1401.9930, -1739.3824, 21.1779, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[18], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[19] = CreateDynamicObject(19845, 1401.9930, -1739.3824, 21.6079, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[19], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[20] = CreateDynamicObject(19565, 1402.1064, -1739.5614, 20.6578, 0.0000, 90.0000, 90.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[20], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[21] = CreateDynamicObject(19565, 1402.8465, -1725.6623, 20.5678, 0.0000, 90.0000, 90.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[21], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[22] = CreateDynamicObject(19845, 1402.8453, -1725.5019, 21.4577, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[22], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[23] = CreateDynamicObject(19845, 1402.8453, -1725.5019, 21.0379, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[23], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[24] = CreateDynamicObject(19327, 1402.2108, -1734.6926, 20.4363, 0.0000, 0.0000, 90.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[24], 0, "Merry", 90, "Arial", 100, 1, 0xFFFFFFFF, 0x0, 0);
	xmas[25] = CreateDynamicObject(19327, 1402.2303, -1732.3122, 20.4363, 0.0000, 0.0000, 90.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[25], 0, "Christ", 90, "Arial", 100, 1, 0xFFFFFFFF, 0x0, 0);
	xmas[26] = CreateDynamicObject(19327, 1402.2004, -1729.9925, 20.4363, 0.0000, 0.0000, 90.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[26], 0,"mas!", 90, "Arial", 100, 1, 0xFFFFFFFF, 0x0, 0);
	xmas[27] = CreateDynamicObject(19565, 1722.2064, -1703.3266, 14.7089, 0.0000, 90.0000, 0.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[27], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[28] = CreateDynamicObject(19845, 1722.3242, -1703.3298, 15.5200, 90.0000, 0.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[28], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[29] = CreateDynamicObject(19845, 1722.3242, -1703.3298, 15.1597, 90.0000, 0.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[29], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[30] = CreateDynamicObject(19845, 1628.5428, -1726.5356, 15.0789, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[30], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[31] = CreateDynamicObject(19845, 1628.5428, -1726.5356, 15.4889, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[31], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[32] = CreateDynamicObject(19565, 1628.5268, -1726.6699, 14.6358, 0.0000, 90.0000, 90.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[32], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[33] = CreateDynamicObject(19565, 1900.9188, -1757.7873, 14.1878, 0.0000, 90.0000, 90.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[33], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[34] = CreateDynamicObject(19845, 1900.8365, -1757.6523, 14.6576, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[34], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[35] = CreateDynamicObject(19845, 1900.8365, -1757.6523, 15.0775, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[35], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[36] = CreateDynamicObject(19845, 2094.9802, -1762.4493, 15.2557, 90.0000, 0.0000, 90.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[36], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[37] = CreateDynamicObject(19845, 2094.9802, -1762.4493, 15.6555, 90.0000, 0.0000, 90.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[37], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[38] = CreateDynamicObject(19565, 2095.0266, -1762.5786, 14.7833, 0.0000, 90.0000, 90.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[38], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[39] = CreateDynamicObject(19565, 1979.3188, -1747.1623, 14.4252, 0.0000, 90.0000, 90.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[39], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[40] = CreateDynamicObject(19845, 1979.3402, -1747.0362, 14.8829, 90.0000, 0.0000, 90.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[40], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[41] = CreateDynamicObject(19845, 1979.3402, -1747.0362, 15.2826, 90.0000, 0.0000, 90.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[41], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[42] = CreateDynamicObject(19845, 1827.0052, -1666.9870, 14.6279, 90.0000, 0.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[42], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[43] = CreateDynamicObject(19845, 1827.0052, -1666.9870, 14.9476, 90.0000, 0.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[43], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[44] = CreateDynamicObject(19565, 1826.8536, -1666.9814, 14.1583, 0.0000, 90.0000, 0.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[44], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[45] = CreateDynamicObject(19845, 1319.5882, -1551.4941, 14.8927, 90.0000, 0.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[45], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[46] = CreateDynamicObject(19565, 1319.4487, -1551.4842, 14.0825, 0.0000, 90.0000, 0.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[46], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[47] = CreateDynamicObject(19845, 1319.5882, -1551.4941, 14.5326, 90.0000, 0.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[47], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[48] = CreateDynamicObject(19845, 1363.5572, -1337.8824, 14.7079, 90.0000, 0.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[48], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[49] = CreateDynamicObject(19845, 1363.5572, -1337.8824, 15.0479, 90.0000, 0.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[49], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[50] = CreateDynamicObject(19565, 1363.4111, -1337.8824, 14.2370, 0.0000, 90.0000, 0.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[50], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[51] = CreateDynamicObject(19845, 469.0718, -1173.5128, 66.5165, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[51], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[52] = CreateDynamicObject(19845, 279.8937, -1403.4410, 15.2707, 90.0000, 0.0000, 90.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[52], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[53] = CreateDynamicObject(19845, 279.8937, -1403.4410, 15.6208, 90.0000, 0.0000, 90.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[53], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[54] = CreateDynamicObject(19565, 279.8963, -1403.5731, 14.8184, 0.0000, 90.0000, 90.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[54], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[55] = CreateDynamicObject(19327, 1555.3913, -1734.6926, 20.4363, 0.0000, 0.0000, 90.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[55], 0,"Merry", 90, "Arial", 100, 1, 0xFFFFFFFF, 0x0, 0);
	xmas[56] = CreateDynamicObject(19327, 1555.3797, -1732.3122, 20.4363, 0.0000, 0.0000, 90.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[56], 0,"Christ", 90, "Arial", 100, 1, 0xFFFFFFFF, 0x0, 0);
	xmas[57] = CreateDynamicObject(19327, 1555.3708, -1729.9925, 20.4363, 0.0000, 0.0000, 90.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[57], 0,"mas!", 90, "Arial", 100, 1, 0xFFFFFFFF, 0x0, 0);
	xmas[58] = CreateDynamicObject(19845, 1555.4156, -1725.5019, 21.5477, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[58], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[59] = CreateDynamicObject(19845, 1555.4156, -1725.5019, 21.0576, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[59], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[60] = CreateDynamicObject(19565, 1555.4062, -1725.6623, 20.5277, 0.0000, 90.0000, 90.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[60], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[61] = CreateDynamicObject(19327, 1555.2994, -1729.9023, 20.4363, 0.0000, 0.0000, -90.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[61], 0,"Merry", 90, "Arial", 100, 1, 0xFFFFFFFF, 0x0, 0);
	xmas[62] = CreateDynamicObject(19327, 1555.3205, -1732.3122, 20.4363, 0.0000, 0.0000, -90.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[62], 0,"Christ", 90, "Arial", 100, 1, 0xFFFFFFFF, 0x0, 0);
	xmas[63] = CreateDynamicObject(19327, 1555.3496, -1734.6628, 20.4363, 0.0000, 0.0000, -90.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[63], 0,"mas!", 90, "Arial", 100, 1, 0xFFFFFFFF, 0x0, 0);
	xmas[64] = CreateDynamicObject(19845, 1555.2629, -1739.3824, 21.6277, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[64], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[65] = CreateDynamicObject(654, 1479.0620, -1677.5168, 12.1716, 0.0000, 0.0000, 0.0000); //pinetree08
	xmas[66] = CreateDynamicObject(19059, 1476.2495, -1678.4930, 18.3220, 0.0000, 0.0000, 0.0000); //XmasOrb1
	xmas[67] = CreateDynamicObject(19059, 1483.0395, -1678.4930, 19.3619, 0.0000, 0.0000, 0.0000); //XmasOrb1
	xmas[68] = CreateDynamicObject(19059, 1481.5897, -1678.7331, 24.9619, 0.0000, 0.0000, 0.0000); //XmasOrb1
	xmas[69] = CreateDynamicObject(19060, 1476.2701, -1679.1131, 27.6819, 0.0000, 0.0000, 0.0000); //XmasOrb2
	xmas[70] = CreateDynamicObject(19060, 1478.1003, -1679.1429, 17.5118, 0.0000, 0.0000, 0.0000); //XmasOrb2
	xmas[71] = CreateDynamicObject(19061, 1476.5312, -1678.5655, 21.8220, 0.0000, 0.0000, 0.0000); //XmasOrb3
	xmas[72] = CreateDynamicObject(19076, 1549.3254, -1681.4344, 12.4877, 0.0000, 0.0000, 90.0000); //XmasTree1
	xmas[73] = CreateDynamicObject(19062, 1474.9488, -1680.0002, 24.3220, 0.0000, 0.0000, 0.0000); //XmasOrb4
	xmas[74] = CreateDynamicObject(19062, 1481.2989, -1679.0404, 28.6019, 0.0000, 0.0000, 0.0000); //XmasOrb4
	xmas[75] = CreateDynamicObject(3038, 1479.2641, -1680.9001, 20.3020, 0.0000, 0.0000, 90.0000); //ct_lanterns
	xmas[76] = CreateDynamicObject(3038, 1479.3028, -1679.2971, 23.4120, 0.0000, 0.0000, 99.2995); //ct_lanterns
	xmas[77] = CreateDynamicObject(3038, 1479.2641, -1680.1810, 26.6119, 0.0000, 0.0000, 90.0000); //ct_lanterns
	xmas[78] = CreateDynamicObject(19076, 1479.1695, -1677.4763, 22.9120, 0.0000, 0.0000, 0.0000); //XmasTree1
	SetDynamicObjectMaterial(xmas[78], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[78], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	xmas[79] = CreateDynamicObject(19076, 928.9143, -1208.0017, 15.9715, 0.0000, 0.0000, 16.3999); //XmasTree1
	xmas[80] = CreateDynamicObject(19055, 927.7498, -1208.8293, 16.6142, 0.0000, 0.0000, 0.0000); //XmasBox2
	xmas[81] = CreateDynamicObject(19055, 930.4196, -1206.9941, 16.7488, 4.1999, 0.0000, 0.0000); //XmasBox2
	xmas[82] = CreateDynamicObject(19054, 929.7174, -1209.2683, 16.6541, 0.0000, -2.6998, -13.8000); //XmasBox1
	xmas[83] = CreateDynamicObject(19054, 1547.6971, -1682.0047, 13.1878, 0.0000, 0.0000, 0.0000); //XmasBox1
	xmas[84] = CreateDynamicObject(19054, 1548.7174, -1680.3148, 13.1878, 0.0000, 0.0000, -39.2999); //XmasBox1
	xmas[85] = CreateDynamicObject(19057, 1547.0699, -1680.5506, 13.2152, 0.0000, 0.0000, 0.0000); //XmasBox4
	xmas[86] = CreateDynamicObject(3861, 1469.5721, -1688.0638, 14.1955, 0.0000, 0.0000, 90.0000); //marketstall01_SFXRF
	xmas[87] = CreateDynamicObject(3861, 1469.5721, -1698.5041, 14.1955, 0.0000, 0.0000, 90.0000); //marketstall01_SFXRF
	SetDynamicObjectMaterial(xmas[87], 0, 3860, "hashmarket_sfsx", "ws_tarp2", 0xFFFFFFFF);
	xmas[88] = CreateDynamicObject(3861, 1488.0633, -1698.5041, 14.1955, 0.0000, 0.0000, -90.0000); //marketstall01_SFXRF
	SetDynamicObjectMaterial(xmas[88], 0, 3860, "hashmarket_sfsx", "ws_tarp2", 0xFFFFFFFF);
	xmas[89] = CreateDynamicObject(3861, 1488.1219, -1688.0638, 14.1955, 0.0000, 0.0000, -90.0000); //marketstall01_SFXRF
	xmas[90] = CreateDynamicObject(3861, 1488.1219, -1709.1842, 14.1955, 0.0000, 0.0000, -90.0000); //marketstall01_SFXRF
	xmas[91] = CreateDynamicObject(3861, 1469.0915, -1709.1842, 14.1955, 0.0000, 0.0000, 90.0000); //marketstall01_SFXRF
	xmas[92] = CreateDynamicObject(19054, 1479.9062, -1703.4327, 13.7159, 0.0000, 0.0000, 25.0998); //XmasBox1
	xmas[93] = CreateDynamicObject(19055, 1479.5815, -1698.3708, 13.7159, 0.0000, 0.0000, 7.7999); //XmasBox2
	xmas[94] = CreateDynamicObject(19056, 1481.0643, -1698.2663, 13.7362, 0.0000, 0.0000, 12.5999); //XmasBox3
	xmas[95] = CreateDynamicObject(19058, 1480.4311, -1699.0411, 14.8479, 0.0000, 0.0000, 0.0000); //XmasBox5
	xmas[96] = CreateDynamicObject(19057, 1480.4272, -1699.6622, 13.6843, 0.0000, 0.0000, 0.0000); //XmasBox4
	xmas[97] = CreateDynamicObject(18761, 1555.3663, -1732.2269, 17.5337, 0.0000, 0.0000, 90.0000); //RaceFinishLine1
	SetDynamicObjectMaterial(xmas[97], 0, 10765, "airportgnd_sfse", "white", 0xFF840410);
	SetDynamicObjectMaterial(xmas[97], 1, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[97], 2, 11100, "bendytunnel_sfse", "blackmetal", 0xFFFFFFFF);
	xmas[98] = CreateDynamicObject(19845, 1555.2629, -1739.3824, 21.1779, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[98], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[99] = CreateDynamicObject(19565, 1555.3260, -1739.5223, 20.6177, 0.0000, 90.0000, 90.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[99], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[100] = CreateDynamicObject(19076, 1472.8841, -1023.5817, 22.4120, 0.0000, 0.0000, 0.0000); //XmasTree1
	xmas[101] = CreateDynamicObject(19845, 1422.0887, -1028.4803, 26.0354, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[101], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[102] = CreateDynamicObject(19845, 1422.0887, -1028.4803, 25.6452, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[102], 0, 10765, "airportgnd_sfse", "white", 0xFF335F3F);
	xmas[103] = CreateDynamicObject(19565, 1422.0769, -1028.6009, 25.1149, 0.0000, 90.0000, 90.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[103], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[104] = CreateDynamicObject(3287, 1472.4543, -1666.8664, 15.3429, 90.0000, 0.0000, 0.0000); //cxrf_oiltank
	SetDynamicObjectMaterial(xmas[104], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[104], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[104], 2, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[104], 3, 2811, "gb_ornaments01", "beigehotel_128", 0xFF730E1A);
	xmas[105] = CreateDynamicObject(3287, 1477.4542, -1666.8664, 14.6028, 90.0000, 0.0000, 0.0000); //cxrf_oiltank
	SetDynamicObjectMaterial(xmas[105], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[105], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[105], 2, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[105], 3, 2811, "gb_ornaments01", "beigehotel_128", 0xFF730E1A);
	xmas[106] = CreateDynamicObject(19845, 803.4785, -1346.8570, 15.1014, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[106], 0, 10765, "airportgnd_sfse", "white", 0xFF2E5B20);
	xmas[107] = CreateDynamicObject(19845, 803.4785, -1346.8570, 15.4813, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[107], 0, 10765, "airportgnd_sfse", "white", 0xFF2E5B20);
	xmas[108] = CreateDynamicObject(19565, 803.4713, -1346.9853, 14.5677, 0.0000, 90.0000, 90.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[108], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[109] = CreateDynamicObject(3287, 1486.9840, -1666.8664, 15.3429, 90.0000, 0.0000, 0.0000); //cxrf_oiltank
	SetDynamicObjectMaterial(xmas[109], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[109], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[109], 2, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[109], 3, 2811, "gb_ornaments01", "beigehotel_128", 0xFF730E1A);
	xmas[110] = CreateDynamicObject(19076, 804.1817, -1338.1877, 12.4743, 0.0000, 0.0000, 0.0000); //XmasTree1
	xmas[111] = CreateDynamicObject(3287, 1482.0434, -1666.8664, 15.0029, 90.0000, 0.0000, 0.0000); //cxrf_oiltank
	SetDynamicObjectMaterial(xmas[111], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[111], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[111], 2, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[111], 3, 2811, "gb_ornaments01", "beigehotel_128", 0xFF730E1A);
	xmas[112] = CreateDynamicObject(19088, 1486.9471, -1666.4625, 15.0551, 180.0000, 0.0000, 0.0000); //Rope2
	SetDynamicObjectMaterial(xmas[112], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
	xmas[113] = CreateDynamicObject(19088, 1481.9975, -1666.4625, 14.7152, 180.0000, 0.0000, 0.0000); //Rope2
	SetDynamicObjectMaterial(xmas[113], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
	xmas[114] = CreateDynamicObject(19088, 1472.5173, -1666.2224, 15.1049, 180.0000, 0.0000, 0.0000); //Rope2
	SetDynamicObjectMaterial(xmas[114], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
	xmas[115] = CreateDynamicObject(19088, 1477.5671, -1666.2923, 14.3752, 180.0000, 0.0000, 0.0000); //Rope2
	SetDynamicObjectMaterial(xmas[115], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
	xmas[116] = CreateDynamicObject(18692, 1477.3785, -1666.5666, 14.0698, 0.0000, 0.0000, 0.0000); //fire_med
	xmas[117] = CreateDynamicObject(18692, 1472.5185, -1666.5666, 14.2995, 0.0000, 0.0000, 0.0000); //fire_med
	xmas[118] = CreateDynamicObject(18692, 1486.9886, -1666.5666, 14.2995, 0.0000, 0.0000, 0.0000); //fire_med
	xmas[119] = CreateDynamicObject(18692, 1482.0183, -1666.5666, 13.8795, 0.0000, 0.0000, 0.0000); //fire_med
	xmas[120] = CreateDynamicObject(19377, 1484.6059, -1665.9781, 13.4722, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[120], 0, 14581, "ab_mafiasuitea", "cof_wood2", 0xFFFFFFFF);
	xmas[121] = CreateDynamicObject(19377, 1474.1252, -1665.9781, 13.4722, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[121], 0, 14581, "ab_mafiasuitea", "cof_wood2", 0xFFFFFFFF);
	xmas[122] = CreateDynamicObject(889, 1475.9200, -1667.5002, 5.9821, 0.0000, 0.0000, 0.0000); //Pinebg_PO
	SetDynamicObjectMaterial(xmas[122], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	xmas[123] = CreateDynamicObject(889, 1471.2696, -1667.8000, 6.8421, 0.0000, 0.0000, 0.0000); //Pinebg_PO
	SetDynamicObjectMaterial(xmas[123], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	xmas[124] = CreateDynamicObject(889, 1480.8000, -1667.4101, 5.9821, 0.0000, 0.0000, 0.0000); //Pinebg_PO
	SetDynamicObjectMaterial(xmas[124], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	xmas[125] = CreateDynamicObject(889, 1485.6394, -1667.8000, 6.8421, 0.0000, 0.0000, 0.0000); //Pinebg_PO
	SetDynamicObjectMaterial(xmas[125], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	xmas[126] = CreateDynamicObject(19315, 1474.5312, -1668.8465, 14.0045, 0.0000, 0.0000, -30.2999); //deer01
	xmas[127] = CreateDynamicObject(19315, 1483.9986, -1668.0377, 14.0045, 0.0000, 0.0000, -102.6996); //deer01
	xmas[128] = CreateDynamicObject(19066, 1483.9305, -1668.3198, 14.4104, 0.0000, 4.3997, -101.3999); //SantaHat3
	xmas[129] = CreateDynamicObject(19066, 1474.8016, -1669.0041, 14.4111, 0.0000, 4.3997, -32.2000); //SantaHat3
	xmas[130] = CreateDynamicObject(18864, 1479.3623, -1668.9449, 15.9370, 0.0000, 0.0000, 0.0000); //FakeSnow1
	xmas[131] = CreateDynamicObject(18864, 1479.3623, -1803.0537, 15.9370, 0.0000, 0.0000, 0.0000); //FakeSnow1
	xmas[132] = CreateDynamicObject(19076, 1481.1544, -1765.9477, 12.4111, 0.0000, 0.0000, 0.0000); //XmasTree1
	xmas[133] = CreateDynamicObject(19054, 1476.2281, -1766.3625, 13.2173, 0.0000, 0.0000, 0.0000); //XmasBox1
	xmas[134] = CreateDynamicObject(19055, 1473.5028, -1767.9964, 13.1344, 0.0000, 0.0000, -34.0998); //XmasBox2
	xmas[135] = CreateDynamicObject(19058, 1486.2091, -1766.4055, 13.1927, 0.0000, 0.0000, -76.8000); //XmasBox5
	xmas[136] = CreateDynamicObject(19057, 1488.1711, -1767.4521, 13.2040, 0.0000, 0.0000, 0.0000); //XmasBox4
	xmas[137] = CreateDynamicObject(1974, 1491.9455, -1717.4957, 14.6595, 0.0000, 0.0000, 0.0000); //kb_golfball
	SetDynamicObjectMaterial(xmas[137], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[138] = CreateDynamicObject(19342, 1491.9979, -1717.2181, 14.4033, 0.0000, 0.0000, 0.0000); //easter_egg02
	SetDynamicObjectMaterial(xmas[138], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[139] = CreateDynamicObject(19341, 1492.0144, -1717.2220, 13.5699, 0.0000, 0.0000, 0.0000); //easter_egg01
	SetDynamicObjectMaterial(xmas[139], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[140] = CreateDynamicObject(1974, 1491.7652, -1717.3856, 14.6595, 0.0000, 0.0000, 0.0000); //kb_golfball
	SetDynamicObjectMaterial(xmas[140], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[141] = CreateDynamicObject(1974, 1491.7204, -1717.6866, 13.5692, 0.0000, 0.0000, -31.6998); //kb_golfball
	SetDynamicObjectMaterial(xmas[141], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[142] = CreateDynamicObject(1974, 1491.7612, -1717.5826, 13.9294, 0.0000, 0.0000, -31.6998); //kb_golfball
	SetDynamicObjectMaterial(xmas[142], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[143] = CreateDynamicObject(19578, 1491.8072, -1717.5124, 14.5171, 94.4999, 0.0000, -115.2996); //Banana1
	SetDynamicObjectMaterial(xmas[143], 0, 6985, "vgnfremnt2", "striplightsorange_256", 0xFFFFFFFF);
	xmas[144] = CreateDynamicObject(1974, 1491.7381, -1717.6390, 13.7693, 0.0000, 0.0000, -31.6998); //kb_golfball
	SetDynamicObjectMaterial(xmas[144], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[145] = CreateDynamicObject(18639, 1491.9726, -1717.2309, 14.9118, 0.0000, -90.0000, -32.2000); //BlackHat1
	xmas[146] = CreateDynamicObject(19578, 1491.7884, -1717.5417, 14.3238, 94.4999, 0.0000, -33.0998); //Banana1
	SetDynamicObjectMaterial(xmas[146], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[147] = CreateDynamicObject(18634, 1491.3409, -1717.0067, 13.9776, -39.7000, 0.0000, -110.1996); //GTASACrowbar1
	SetDynamicObjectMaterial(xmas[147], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[148] = CreateDynamicObject(18634, 1492.3884, -1717.7082, 14.0649, -39.7000, 0.0000, 22.9999); //GTASACrowbar1
	SetDynamicObjectMaterial(xmas[148], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[149] = CreateDynamicObject(19622, 1492.4111, -1717.8032, 13.7763, 0.0000, 0.0000, 0.0000); //Broom1
	xmas[150] = CreateDynamicObject(19315, 1495.3547, -1717.4934, 13.5341, 0.0000, 0.0000, -53.4998); //deer01
	xmas[151] = CreateDynamicObject(19066, 1495.5122, -1717.7248, 13.9399, 0.0000, 7.7999, -55.0000); //SantaHat3
	xmas[152] = CreateDynamicObject(19054, 1497.6229, -1716.6234, 13.6555, 0.0000, 0.0000, 13.9996); //XmasBox1
	xmas[153] = CreateDynamicObject(19057, 1499.0124, -1716.7209, 13.6927, 0.0000, 0.0000, 0.0000); //XmasBox4
	xmas[154] = CreateDynamicObject(19058, 1498.1798, -1715.0240, 14.1927, 0.0000, 0.0000, 25.0998); //XmasBox5
	xmas[155] = CreateDynamicObject(1342, 1462.4399, -1717.9653, 14.0600, 0.0000, 0.0000, -91.3000); //noodlecart_prop
	xmas[156] = CreateDynamicObject(19076, 1350.0781, -1128.9256, 22.7252, 0.0000, 0.0000, 0.0000); //XmasTree1
	xmas[157] = CreateDynamicObject(19076, 1229.2263, -922.4785, 41.8801, 0.0000, 0.0000, 90.0000); //XmasTree1
	xmas[158] = CreateDynamicObject(19845, 1034.5810, -948.9821, 45.0665, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[158], 0, 10765, "airportgnd_sfse", "white", 0xFF2E5B20);
	xmas[159] = CreateDynamicObject(19845, 1034.5810, -948.9821, 44.7065, 90.0000, 90.0000, 0.0000); //MetalPanel3
	SetDynamicObjectMaterial(xmas[159], 0, 10765, "airportgnd_sfse", "white", 0xFF2E5B20);
	xmas[160] = CreateDynamicObject(19565, 1034.5849, -949.1126, 44.2093, 0.0000, 90.0000, 90.0000); //IceCreamBarsBox1
	SetDynamicObjectMaterial(xmas[160], 0, 10765, "airportgnd_sfse", "white", 0xFF221918);
	xmas[161] = CreateDynamicObject(19076, 978.6508, -939.9495, 39.9193, 0.0000, 0.0000, 90.0000); //XmasTree1
	xmas[162] = CreateDynamicObject(19076, 648.1444, -1530.2822, 13.6556, 0.0000, 0.0000, 6.3997); //XmasTree1
	xmas[163] = CreateDynamicObject(19076, 1237.6910, -1812.0515, 12.3211, 0.0000, 0.0000, 76.6998); //XmasTree1
	xmas[164] = CreateDynamicObject(19054, 1237.1114, -1813.5500, 13.0555, 0.0000, 0.0000, 0.0000); //XmasBox1
	xmas[165] = CreateDynamicObject(19054, 1239.2215, -1812.0400, 13.0555, 0.0000, 0.0000, -15.5999); //XmasBox1
	xmas[166] = CreateDynamicObject(19058, 1238.4918, -1813.4100, 13.0452, 0.0000, 0.0000, 12.5000); //XmasBox5
	xmas[167] = CreateDynamicObject(1280, 1240.1877, -1808.2790, 12.9910, 0.0000, 0.0000, 112.2997); //parkbench1
	xmas[168] = CreateDynamicObject(1280, 1244.9980, -1806.1981, 12.9910, 0.0000, 0.0000, 115.8999); //parkbench1
	xmas[169] = CreateDynamicObject(19377, 1472.2070, -1686.3347, 12.9801, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[169], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[170] = CreateDynamicObject(19377, 1472.2070, -1676.7148, 12.9801, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[170], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[171] = CreateDynamicObject(19377, 1472.2070, -1695.9544, 12.9801, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[171], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[172] = CreateDynamicObject(19377, 1472.2070, -1705.5738, 12.9801, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[172], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[173] = CreateDynamicObject(19377, 1472.2070, -1714.1253, 12.9820, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[173], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[174] = CreateDynamicObject(19377, 1482.6975, -1714.1253, 12.9820, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[174], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[175] = CreateDynamicObject(19377, 1493.1770, -1714.1253, 12.9820, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[175], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[176] = CreateDynamicObject(19377, 1498.8972, -1714.1253, 12.9720, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[176], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[177] = CreateDynamicObject(19377, 1482.6975, -1704.5058, 12.9820, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[177], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[178] = CreateDynamicObject(19377, 1482.6975, -1694.8763, 12.9820, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[178], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[179] = CreateDynamicObject(19377, 1482.6975, -1685.2666, 12.9820, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[179], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[180] = CreateDynamicObject(19377, 1482.6975, -1675.6467, 12.9820, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[180], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[181] = CreateDynamicObject(19377, 1493.1770, -1704.5368, 12.9820, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[181], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[182] = CreateDynamicObject(19377, 1493.1770, -1694.9089, 12.9820, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[182], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[183] = CreateDynamicObject(19377, 1493.1770, -1685.2895, 12.9820, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[183], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[184] = CreateDynamicObject(19377, 1486.5058, -1675.6584, 12.9799, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[184], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[185] = CreateDynamicObject(19377, 1461.7175, -1714.1253, 12.9820, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[185], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[186] = CreateDynamicObject(19377, 1458.1361, -1714.1253, 12.9799, 0.0000, 90.0000, 0.0000); //wall025
	SetDynamicObjectMaterial(xmas[186], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[187] = CreateDynamicObject(19076, 1369.7246, -958.0922, 33.1431, 0.0000, 0.0000, 0.0000); //XmasTree1
	xmas[188] = CreateDynamicObject(968, 1336.4459, -1132.2418, 22.2266, 0.0000, 0.0000, 0.0000); //barrierturn
	SetDynamicObjectMaterial(xmas[188], 1, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[189] = CreateDynamicObject(968, 1383.4852, -955.6154, 32.7103, 0.0000, 0.0000, 0.0000); //barrierturn
	SetDynamicObjectMaterial(xmas[189], 1, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[190] = CreateDynamicObject(968, 1356.5953, -955.6154, 32.7103, 0.0000, 0.0000, 0.0000); //barrierturn
	SetDynamicObjectMaterial(xmas[190], 1, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[191] = CreateDynamicObject(3038, 1360.8374, -955.7280, 39.3912, 0.0000, 0.0000, 90.0000); //ct_lanterns
	SetDynamicObjectMaterial(xmas[191], 0, 10839, "aircarpkbarier_sfse", "redband_64Ha", 0xFFFFFFFF);
	xmas[192] = CreateDynamicObject(3038, 1379.4565, -955.6179, 39.4612, 0.0000, 0.0000, 90.0000); //ct_lanterns
	SetDynamicObjectMaterial(xmas[192], 0, 10839, "aircarpkbarier_sfse", "redband_64Ha", 0xFFFFFFFF);
	xmas[193] = CreateDynamicObject(19089, 1375.3819, -955.5192, 39.7224, 0.0000, 90.0000, 0.0000); //Rope3
	SetDynamicObjectMaterial(xmas[193], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[194] = CreateDynamicObject(19089, 1372.3105, -955.5192, 39.7224, 0.0000, 90.0000, 0.0000); //Rope3
	SetDynamicObjectMaterial(xmas[194], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[195] = CreateDynamicObject(18647, 1369.8562, -957.9179, 37.0931, 0.0000, 0.0000, 90.0000); //RedNeonTube1
	xmas[196] = CreateDynamicObject(18649, 1350.1031, -1129.9333, 27.3036, 0.0000, 0.0000, 90.0000); //GreenNeonTube1
	xmas[197] = CreateDynamicObject(968, 1363.6561, -1132.2418, 22.2266, 0.0000, 0.0000, 0.0000); //barrierturn
	SetDynamicObjectMaterial(xmas[197], 1, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[198] = CreateDynamicObject(3038, 1359.4654, -1132.3186, 28.8812, 0.0000, 0.0000, 90.0000); //ct_lanterns
	SetDynamicObjectMaterial(xmas[198], 0, 10839, "aircarpkbarier_sfse", "redband_64Ha", 0xFFFFFFFF);
	xmas[199] = CreateDynamicObject(3038, 1340.7049, -1132.3186, 28.8812, 0.0000, 0.0000, 90.0000); //ct_lanterns
	SetDynamicObjectMaterial(xmas[199], 0, 10839, "aircarpkbarier_sfse", "redband_64Ha", 0xFFFFFFFF);
	xmas[200] = CreateDynamicObject(19089, 1355.6512, -1132.2292, 29.0426, 0.0000, 90.0000, 0.0000); //Rope3
	SetDynamicObjectMaterial(xmas[200], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[201] = CreateDynamicObject(19089, 1351.7032, -1132.2292, 29.0426, 0.0000, 90.0000, 0.0000); //Rope3
	SetDynamicObjectMaterial(xmas[201], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	xmas[202] = CreateDynamicObject(19377, 1478.0871, -1610.8851, 12.9947, 0.0000, 90.0000, 90.0000); //wall025
	SetDynamicObjectMaterial(xmas[202], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[203] = CreateDynamicObject(19443, 1474.7563, -1615.3586, 18.2520, 0.0000, 0.0000, 0.0000); //wall083
	SetDynamicObjectMaterial(xmas[203], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	xmas[204] = CreateDynamicObject(19377, 1487.7165, -1610.8851, 12.9947, 0.0000, 90.0000, 90.0000); //wall025
	SetDynamicObjectMaterial(xmas[204], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[205] = CreateDynamicObject(19377, 1490.6978, -1610.8851, 12.9968, 0.0000, 90.0000, 90.0000); //wall025
	SetDynamicObjectMaterial(xmas[205], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[206] = CreateDynamicObject(19377, 1479.5166, -1616.0750, 18.2247, 0.0000, 0.0000, 90.0000); //wall025
	SetDynamicObjectMaterial(xmas[206], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	xmas[207] = CreateDynamicObject(19443, 1474.7563, -1615.3586, 14.7621, 0.0000, 0.0000, 0.0000); //wall083
	SetDynamicObjectMaterial(xmas[207], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	xmas[208] = CreateDynamicObject(19443, 1484.2462, -1615.3586, 21.7220, 0.0000, 0.0000, 0.0000); //wall083
	SetDynamicObjectMaterial(xmas[208], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	xmas[209] = CreateDynamicObject(19443, 1474.7563, -1615.3586, 21.7220, 0.0000, 0.0000, 0.0000); //wall083
	SetDynamicObjectMaterial(xmas[209], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	xmas[210] = CreateDynamicObject(19377, 1479.5166, -1614.6358, 18.2247, 0.0000, 0.0000, 90.0000); //wall025
	SetDynamicObjectMaterial(xmas[210], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF730E1A);
	xmas[211] = CreateDynamicObject(19443, 1484.2462, -1615.3586, 18.2320, 0.0000, 0.0000, 0.0000); //wall083
	SetDynamicObjectMaterial(xmas[211], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	xmas[212] = CreateDynamicObject(19443, 1484.2462, -1615.3586, 14.7320, 0.0000, 0.0000, 0.0000); //wall083
	SetDynamicObjectMaterial(xmas[212], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	xmas[213] = CreateDynamicObject(2258, 1482.6783, -1614.5163, 20.3857, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[213], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[213], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[214] = CreateDynamicObject(2258, 1482.6783, -1614.5163, 21.8458, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[214], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[214], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[215] = CreateDynamicObject(2258, 1482.6783, -1614.5163, 18.9157, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[215], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[215], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[216] = CreateDynamicObject(2258, 1482.6783, -1614.5163, 17.4356, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[216], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[216], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[217] = CreateDynamicObject(2258, 1482.6783, -1614.5163, 15.9156, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[217], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[217], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[218] = CreateDynamicObject(2258, 1481.0283, -1614.5163, 15.9156, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[218], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[218], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[219] = CreateDynamicObject(2258, 1479.3775, -1614.5163, 15.9156, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[219], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(xmas[219], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[220] = CreateDynamicObject(2258, 1479.3775, -1614.5163, 17.3356, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[220], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF335F3F);
	SetDynamicObjectMaterial(xmas[220], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[221] = CreateDynamicObject(2258, 1479.3775, -1614.5163, 18.6956, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[221], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF335F3F);
	SetDynamicObjectMaterial(xmas[221], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[222] = CreateDynamicObject(2258, 1480.8177, -1614.5163, 20.7157, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[222], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF335F3F);
	SetDynamicObjectMaterial(xmas[222], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[223] = CreateDynamicObject(2258, 1480.8177, -1614.5163, 19.4256, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[223], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF335F3F);
	SetDynamicObjectMaterial(xmas[223], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[224] = CreateDynamicObject(2258, 1480.8177, -1614.5163, 21.9857, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[224], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF335F3F);
	SetDynamicObjectMaterial(xmas[224], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[225] = CreateDynamicObject(2258, 1477.9278, -1614.5163, 19.4256, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[225], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF335F3F);
	SetDynamicObjectMaterial(xmas[225], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[226] = CreateDynamicObject(2258, 1477.9272, -1614.5163, 20.7157, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[226], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF335F3F);
	SetDynamicObjectMaterial(xmas[226], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[227] = CreateDynamicObject(2258, 1477.9381, -1614.5163, 21.9857, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[227], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF335F3F);
	SetDynamicObjectMaterial(xmas[227], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[228] = CreateDynamicObject(2258, 1476.3575, -1614.5163, 17.5256, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[228], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF0F6A89);
	SetDynamicObjectMaterial(xmas[228], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[229] = CreateDynamicObject(2258, 1477.8779, -1614.5163, 17.5256, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[229], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF0F6A89);
	SetDynamicObjectMaterial(xmas[229], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[230] = CreateDynamicObject(2258, 1477.8779, -1614.5163, 16.2957, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[230], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF0F6A89);
	SetDynamicObjectMaterial(xmas[230], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[231] = CreateDynamicObject(2258, 1477.8779, -1614.5163, 15.1256, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[231], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF0F6A89);
	SetDynamicObjectMaterial(xmas[231], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[232] = CreateDynamicObject(2258, 1477.8779, -1614.5163, 13.8556, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[232], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF0F6A89);
	SetDynamicObjectMaterial(xmas[232], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[233] = CreateDynamicObject(2258, 1475.7280, -1614.5163, 16.3057, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[233], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF0F6A89);
	SetDynamicObjectMaterial(xmas[233], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[234] = CreateDynamicObject(2258, 1475.7280, -1614.5163, 15.0756, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[234], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF0F6A89);
	SetDynamicObjectMaterial(xmas[234], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[235] = CreateDynamicObject(2258, 1476.3376, -1614.5163, 13.8556, 0.0000, 0.0000, 180.0000); //Frame_Clip_5
	SetDynamicObjectMaterial(xmas[235], 0, 2811, "gb_ornaments01", "beigehotel_128", 0xFF0F6A89);
	SetDynamicObjectMaterial(xmas[235], 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	xmas[236] = CreateDynamicObject(19377, 1468.4576, -1610.8851, 12.9947, 0.0000, 90.0000, 90.0000); //wall025
	SetDynamicObjectMaterial(xmas[236], 0, 3922, "bistro", "mp_snow", 0xFFFFFFFF);
	xmas[237] = CreateDynamicObject(19327, 1480.1090, -1614.4090, 15.9235, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[237], 0, "1",90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[238] = CreateDynamicObject(19327, 1474.8282, -1614.4090, 16.3136, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[238], 0, "2",90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[239] = CreateDynamicObject(19327, 1478.4384, -1614.4090, 17.3635, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[239], 0, "3",90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[240] = CreateDynamicObject(19327, 1477.0183, -1614.4090, 21.9936, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[240], 0,"4", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[241] = CreateDynamicObject(19327, 1481.7486, -1614.4090, 20.4036, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[241], 0,"5", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[242] = CreateDynamicObject(19327, 1476.9980, -1614.4090, 13.8936, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[242], 0, "6",90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[243] = CreateDynamicObject(19327, 1476.9980, -1614.4090, 19.4335, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[243], 0, "7",90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[244] = CreateDynamicObject(19327, 1481.8083, -1614.4090, 17.4535, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[244], 0,"8", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[245] = CreateDynamicObject(19327, 1479.8880, -1614.4090, 22.0135, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[245], 0, "9", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[246] = CreateDynamicObject(19327, 1477.3676, -1614.4090, 20.7136, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[246], 0, "10", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[247] = CreateDynamicObject(19327, 1477.2977, -1614.4090, 15.1436, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[247], 0, "11", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[248] = CreateDynamicObject(19327, 1482.1080, -1614.4090, 15.9135, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[248], 0, "12", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[249] = CreateDynamicObject(19327, 1478.8280, -1614.4090, 18.6935, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[249], 0, "13", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[250] = CreateDynamicObject(19327, 1475.1176, -1614.4090, 15.1035, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[250], 0, "14", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[251] = CreateDynamicObject(19327, 1478.7690, -1614.4090, 15.8836, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[251], 0, "15", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[252] = CreateDynamicObject(19327, 1480.2695, -1614.4090, 20.7236, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[252], 0,"16", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[253] = CreateDynamicObject(19327, 1477.2691, -1614.4090, 16.3236, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[253], 0, "17",90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[254] = CreateDynamicObject(19327, 1482.0594, -1614.4090, 21.8335, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[254], 0,"18", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[255] = CreateDynamicObject(19327, 1475.7381, -1614.4090, 13.8635, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[255], 0,"19", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[256] = CreateDynamicObject(19327, 1477.1384, -1614.4090, 17.5335, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[256], 0,"21", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[257] = CreateDynamicObject(19327, 1482.0290, -1614.4090, 18.9136, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[257], 0,"20", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[258] = CreateDynamicObject(19327, 1480.2186, -1614.4090, 19.4136, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[258], 0,"22", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[259] = CreateDynamicObject(19327, 1475.7686, -1614.4090, 17.5536, 0.0000, 0.0000, 180.0000); //7_11_sign02
	SetDynamicObjectMaterialText(xmas[259], 0,"23", 90, "Arial", 130, 1, 0xFF840410, 0x0, 0);
	xmas[260] = CreateDynamicObject(889, 1489.1053, -1614.4376, 12.9504, 0.0000, 0.0000, 0.0000); //Pinebg_PO
	xmas[261] = CreateDynamicObject(889, 1474.5759, -1614.1474, 6.3804, 0.0000, 0.0000, 180.0000); //Pinebg_PO
	SetDynamicObjectMaterial(xmas[261], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	xmas[262] = CreateDynamicObject(889, 1484.4853, -1614.1474, 7.5103, 0.0000, 0.0000, 0.0000); //Pinebg_PO
	SetDynamicObjectMaterial(xmas[262], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
	xmas[263] = CreateDynamicObject(19076, 1468.0981, -1612.1405, 12.9777, 0.0000, 0.0000, 0.0000); //XmasTree1
	xmas[264] = CreateDynamicObject(19865, 1463.6368, -1608.1228, 12.3270, 0.0000, 0.0000, 0.0000); //MIFenceWood1
	xmas[265] = CreateDynamicObject(19865, 1463.6368, -1613.1427, 12.3270, 0.0000, 0.0000, 0.0000); //MIFenceWood1
	xmas[266] = CreateDynamicObject(19865, 1463.6568, -1613.6330, 12.3270, 0.0000, 0.0000, 0.0000); //MIFenceWood1
	xmas[267] = CreateDynamicObject(19865, 1466.1372, -1616.1330, 12.3270, 0.0000, 0.0000, 90.0000); //MIFenceWood1
	xmas[268] = CreateDynamicObject(19865, 1471.1469, -1616.1330, 12.3270, 0.0000, 0.0000, 90.0000); //MIFenceWood1
	xmas[269] = CreateDynamicObject(19865, 1476.2069, -1616.1330, 12.3270, 0.0000, 0.0000, 90.0000); //MIFenceWood1
	xmas[270] = CreateDynamicObject(19865, 1493.0080, -1616.1330, 12.3270, 0.0000, 0.0000, 90.0000); //MIFenceWood1
	xmas[271] = CreateDynamicObject(19865, 1487.9885, -1616.1330, 12.3270, 0.0000, 0.0000, 90.0000); //MIFenceWood1
	xmas[272] = CreateDynamicObject(19865, 1482.9886, -1616.1330, 12.3270, 0.0000, 0.0000, 90.0000); //MIFenceWood1
	xmas[273] = CreateDynamicObject(19865, 1495.5085, -1608.1319, 12.3270, 0.0000, 0.0000, 0.0000); //MIFenceWood1
	xmas[274] = CreateDynamicObject(19865, 1495.5085, -1613.1422, 12.3270, 0.0000, 0.0000, 0.0000); //MIFenceWood1
	xmas[275] = CreateDynamicObject(19865, 1495.4985, -1613.6427, 12.3270, 0.0000, 0.0000, 0.0000); //MIFenceWood1
	xmas[276] = CreateDynamicObject(3861, 1467.4752, -1607.7485, 14.2375, 0.0000, 0.0000, 90.0000); //marketstall01_SFXRF
	SetDynamicObjectMaterial(xmas[276], 0, 3860, "hashmarket_sfsx", "ws_tarp2", 0xFFFFFFFF);
	xmas[277] = CreateDynamicObject(3861, 1493.5156, -1610.2187, 14.2375, 0.0000, 0.0000, -90.0000); //marketstall01_SFXRF
	SetDynamicObjectMaterial(xmas[277], 0, 3860, "hashmarket_sfsx", "ws_tarp2", 0xFFFFFFFF);
	xmas[278] = CreateDynamicObject(19054, 1470.0898, -1612.4515, 13.7613, 0.0000, 0.0000, 0.0000); //XmasBox1
	xmas[279] = CreateDynamicObject(19058, 1488.1092, -1614.6439, 13.7173, 0.0000, 0.0000, 0.0000); //XmasBox5
	xmas[280] = CreateDynamicObject(19055, 1468.6372, -1610.9715, 13.7299, 0.0000, 0.0000, -11.1000); //XmasBox2
	xmas[281] = CreateDynamicObject(19057, 1488.7224, -1612.8797, 13.7361, 0.0000, 0.0000, 17.8999); //XmasBox4*/de
return 1;
}
//Adminbefehle
CMD:intinfo(playerid,params[])
{
new vID,iID,wstring[128],istring[128];
vID = GetPlayerVirtualWorld(playerid);
iID= GetPlayerInterior(playerid);
format(istring,sizeof(istring),"Interior Schlüssel: %i",iID);
format(wstring,sizeof(wstring),"Virtuelle Welt: %i",vID);
SendClientMessage(playerid,COLOR_GREY,istring);
SendClientMessage(playerid,COLOR_GREY,wstring);
return 1;
}

CMD:fly(playerid,params[])
{
if(IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid,COLOR_RED,"FEHLER:{FFFFFF} Du kannst diesen Befehl nicht im Fahrzeug nutzen!");
if(GetPVarType(playerid, "FlyMode")) CancelFlyMode(playerid);
else FlyMode(playerid);
return 1;
}

CMD:respawnplayer(playerid,params[])
{
new pID;
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF} Du bist nicht befugt diesen Befehl zu nutzen.");
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /respawnplayer [playerid]");
SpawnPlayer(pID);
SendClientMessage(pID,COLOR_YELLOW,"Du wurdest respawned.");
return 1;
}

CMD:play(playerid,params[])
{
ShowPlayerDialog(playerid,DIALOG_SEIGABE,DIALOG_STYLE_INPUT,"Stream","Gebe die URL des streams ein:","Okay","Abbrechen");
return 1;
}

CMD:finfo(playerid,params[])
{
new string[1024],fID;
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt diesen Befehl zu nutzen.");
if(sscanf(params,"i",fID))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /finfo [Fraktions-ID]");
format(string,sizeof(string),"Fraktion: %s  Kasse:%i  Green:%i  Gold:%i  LSD:%i",fInfo[fID][f_name],fInfo[fID][f_kasse],fInfo[fID][f_green],fInfo[fID][f_gold],fInfo[fID][f_lsd]);
SendClientMessage(playerid,COLOR_GREEN,"[___________________________Fraktionsinfo___________________________]");
SendClientMessage(playerid,COLOR_GREY,string);
return 1;
}

CMD:allfinfo(playerid,params[])
{
new fID,string[256];
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt diesen Befehl zu nutzen.");
if(sscanf(params,"i",fID)){
for(new i=0; i<sizeof(fInfo); i++){
format(string,sizeof(string),"Fraktion: %s  Kasse:%i  Green:%i  Gold:%i  LSD:%i",fInfo[i][f_name],fInfo[i][f_kasse],fInfo[i][f_green],fInfo[i][f_gold],fInfo[i][f_lsd]);
SendClientMessage(playerid,COLOR_GREY,string);
}}
return 1;
}

CMD:setint(playerid,params[])
{
new intid;
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF} Du bist nicht befugt diesen Befehl zu benutzen.");
if(sscanf(params,"i",intid))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /setint [interiorid]");
SetPlayerInterior(playerid,intid);
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
CMD:setfill(playerid,params[])
{
new vID,size;
if(sscanf(params,"ii",vID,size))return SendClientMessage(playerid,COLOR_GREY, "INFO: /setfill [vID] [Menge]");
tank[vID]=size;
return 1;
}
CMD:showfill(playerid,params[])
{
new string[64],vID;
if(sscanf(params,"i",vID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /showfill [vID]");
format(string,sizeof(string),"Deine Tankfüllung entspricht %i%",tank[vID]);
SendClientMessage(playerid, COLOR_YELLOW,string);
return 1;
}
CMD:arefill(playerid,params[])
{
new vID;
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt diesen Befehl zu nutzen.");
if(sscanf(params,"i",vID))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /arefill [vID]");
	tank[vID]=100;
	return 1;
}

CMD:set(playerid,params[])
{
if(!isAdmin(playerid,5))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt diesen Befehl zu nutzen.");
if(!isaduty(playerid))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt diesen Befehl zu nutzen.");
new pID,thing[256],anzahl,string[265];
if(sscanf(params,"us[256]i",pID,thing,anzahl))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /set [playerid] [Donut|Green|Gold|LSD|Level|Money|Skin] [Anzahl]");
if(!strcmp(thing, "Donut", true))
{
	sInfo[pID][pdonut] = anzahl;
	format(string,sizeof(string),"Du hast dem Spieler %s (ID %i) %i %s gesetzt",getPlayerName(playerid),pID,anzahl,thing);
	SendClientMessage(playerid,COLOR_YELLOW,string);
	return 1;
}
if(!strcmp(thing,"Green",true))
{
	sInfo[pID][pgreen] = anzahl;
	format(string,sizeof(string),"Du hast dem Spieler %s (ID %i) %i %s gesetzt",getPlayerName(playerid),pID,anzahl,thing);
	SendClientMessage(playerid,COLOR_YELLOW,string);
return 1;
}
return 0;
}

CMD:gotoxyz(playerid,params[])
{
new Float:x,Float:y,Float:z;
if(sscanf(params,"fff",x,y,z))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /gotoxyz [x-pos] [y-pos] [zpos]");
SetPlayerPos(playerid,x,y,z);
return 1;
}

CMD:wlicht(playerid,params[])
{
 	new vID=GetPlayerVehicleID(playerid),
	 tmp_engine=1,
	 tmp_lights=1,
	 tmp_alarm,
	 tmp_doors,
	 tmp_bonnet,
	 tmp_boot,
	 tmp_objective;
	 	GetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	 	SetVehicleParamsEx(vID,1,1,1,1,0,0,1);

return 1;
}
CMD:alarm(playerid,params[])
{
 	new vID=GetPlayerVehicleID(playerid),
	 tmp_engine,
	 tmp_lights,
	 tmp_alarm,
	 tmp_doors,
	 tmp_bonnet,
	 tmp_boot,
	 tmp_objective;
	 	GetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	 	SetVehicleParamsEx(vID, tmp_engine, tmp_lights,0,0,0,1,0);
	 	SendClientMessage(playerid,COLOR_YELLOW,"ALARM: aktiviert");
return 1;
}
CMD:supveh(playerid,params[])
{
new Float:x,Float:y,Float:z,Float:r;
	if(!isAdmin(playerid,1))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,r);
	new vID = CreateVehicle(457,x,y,z,r,-1,-1,0,1);
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
	if(!isAdmin(playerid,4))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
	new pID,fID,string[128];
	if(sscanf(params,"ui",pID,fID))return SendClientMessage(playerid, COLOR_GREY, "INFO: /makeleader [playerid] [frakID]");
	if(fID > sizeof(fInfo)) return SendClientMessage(playerid, COLOR_GREY,"Diese Fraktion existiert nicht.");
	sInfo[pID][fraktion] = fID;
	sInfo[pID][frang] = 6;
	SetPVarInt(pID,"fduty",0);
	format(string,sizeof(string),"INFO: %s hat dich zum Leader der Fraktion %s ernannt.",getPlayerName(playerid),fInfo[fID][f_name]);
	SendClientMessage(pID, COLOR_YELLOW, string);
	SendClientMessage(playerid,COLOR_RED,"Du hast einen Spieler zum Leader ernannt.");
	return 1;
}
CMD:vcolor(playerid,params[])
{
new vID,c1,c2;
if(sscanf(params,"iii",vID,c1,c2))return SendClientMessage(playerid,COLOR_GREY,"INFO: /vcolor [vID] [c1] [C2]");
ChangeVehicleColor(vID, c1, c2);
cInfo[vID][farbe1] = c1;
cInfo[vID][farbe2] = c2;
return 1;
}
CMD:minigun(playerid,params[])
{
new string[256];
if(!isAdmin(playerid,6))return 0;
GivePlayerWeapon(playerid,38,1999);
format(string,sizeof(string),"ACHTUNG:{FFFFFF} %s hat sich eine Minigun gespawned!",getPlayerName(playerid));
SendTeamMessage(COLOR_RED,string);
return 1;
}

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
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"/spec [playerid]");
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
TogglePlayerSpectating(playerid, 1);
PlayerSpectatePlayer(playerid,pID);
return 1;
}
CMD:specoff(playerid,params[])
{
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
TogglePlayerSpectating(playerid,0);
SetPlayerPos(playerid,specx,specy,specz);
return 1;
}
CMD:stopserver(playerid,params[])
{
if(!isAdmin(playerid,6))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF} Du bist nicht befugt diesen Befehl zu nutzen!");
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
 	GameTextForAll("~r~"#SERVERTAG"~w~ wird heruntergefahren!",6000,0);
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
CMD:stopanim(playerid,params[])
{
ClearAnimations(playerid);
return 1;
}
CMD:smoke(playerid,params[])
{
ClearAnimations(playerid);
ApplyAnimation(playerid,"bd_fire","M_smklean_loop",4.1,1,0,0,1,0,1);
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
	if(!isAdmin(playerid,6))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
	SetPlayerScore(playerid, GetPlayerScore(playerid) + 1);
	SendClientMessage(playerid,COLOR_RED,"ADMIN: {FFFFFF}Du hast dir ein Level geschenkt.");
	return 1;
}
CMD:makeadmin(playerid,params[])
{
	if(!isAdmin(playerid,6))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
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
CMD:addequipex(playerid,params[])
{
    //if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!.");
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
            SendClientMessage(i,COLOR_YELLOW,"EVENT: Eventausrüstung hinzugefügt.");
    return 1;
}
CMD:dropguns(playerid,params[])
{
ResetPlayerWeapons(playerid);
new Float:x, Float:y, Float:z,string[256];
    GetPlayerPos(playerid, x,y,z);
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) //GetPlayerPoolSize ist die höchste online playerid   | i repräsentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
        format(string,sizeof(string),"%s lässt seine Waffen fallen",getPlayerName(playerid));
SendClientMessage(playerid,COLOR_ORANGE,string);
       }
}
return 1;
}


CMD:fixveh(playerid,params[])
{	new vID;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!.");
	if(sscanf(params,"i",vID)){SendClientMessage(playerid, COLOR_GREY,"/fixveh [Fahrzeug ID]");}
	RepairVehicle(vID);

	return 1;
}

CMD:go(playerid,params[])
{
	new item[128],hID;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: Du bist kein Admin/Dein Adminrang ist zu niedrig.");
	if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
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
	if(!strcmp(item,"house",false))
	{
	new Float:x,Float:y,Float:z;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: Du bist kein Admin/Dein Adminrang ist zu niedrig.");
	if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	x = hInfo[hID][h_x];
	y = hInfo[hID][h_y];
	z = hInfo[hID][h_z];
	SetPlayerPos(playerid,x,y,z);
	SetPlayerVirtualWorld(playerid,0);
    SetPlayerInterior(playerid,0);
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
	new pID, Float:x,Float:y,Float:z, adminstring[128], string[128],str[256];
    if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
    if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
    if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /goto [playerid]");
	if(!IsPlayerConnected(pID)) return SendClientMessage(playerid, COLOR_GREY, "Diese Person ist nicht online/du kannst dich nicht zu dir selber teleportieren.");
	GetPlayerPos(pID, x, y, z);
	SetPlayerPos(playerid, x, y, z);
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	format(adminstring,sizeof(adminstring),"ADMIN: {FFFA00}Du hast dich zu %s teleportiert.",getPlayerName(pID));
	SendClientMessage(playerid, COLOR_RED, adminstring);
	format(string,sizeof(string),"* %s hat sich zu dir teleportiert.",getPlayerName(playerid));
	SendClientMessage(pID, COLOR_YELLOW, str);
	return 1;
}


CMD:ptp(playerid,params[])
{
new pID,si,sw,sID,Float:x,Float:y,Float:z,pname,name,string[256],string2[256],string3[256],aname;
if(sscanf(params,"ud",pID,sID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /ptp [spieler1] [spieler2]");
GetPlayerName(pID,"pname",128);
GetPlayerName(sID,"name",128);
GetPlayerName(playerid,"aname",256);
GetPlayerPos(sID,x,y,z);
SetPlayerPos(pID,x,y+2,z);
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
SendClientMessage(playerid,COLOR_RED,"INFO: Der Chat wurde von einem Admin geleert! ");
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
 SetPlayerVirtualWorld(playerid,0);
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
	format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als Manager im Dienst.", name);
	SendClientMessageToAll(COLOR_RED, string);
	SetPVarInt(playerid,"aduty",1);
	TextDrawShowForPlayer(playerid,Textdraw0);

return 1;
}
else if(isAlevel(playerid, 6)&& !isaduty(playerid)){
	SetPlayerColor(playerid, COLOR_RED);
	GetPlayerName(playerid, name, sizeof(name));
	format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als ServerOwner im Dienst.", name);
	SendClientMessageToAll(COLOR_RED, string);
	SetPVarInt(playerid,"aduty",1);
	TextDrawShowForPlayer(playerid,Textdraw0);
return 1;
}

else{
SetPlayerColor(playerid, 0xFFFFFFFF);
GetPlayerName(playerid, name, sizeof(name));
format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun nicht mehr im Dienst.", name);
SendClientMessageToAll(COLOR_RED, string);
SetPVarInt(playerid,"aduty",0);
TextDrawHideForPlayer(playerid,Textdraw0);
return 1;
}
}

CMD:saduty(playerid,params[])
{
if(isaduty(playerid)){
TextDrawHideForPlayer(playerid,Textdraw0);
SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nun nicht mehr silent Aduty.");
SetPVarInt(playerid,"aduty",0);
return 1;
}
else
{	SetPVarInt(playerid,"aduty",1);
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
	if(!isAdmin(playerid,6)) return SendClientMessage(playerid, COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!.");
	if(sscanf(params,"i",vID))return SendClientMessage(playerid,COLOR_GREY,"/setbitro [vehicleid]");
	AddVehicleComponent(vID, 1010);

	return 1;
}

CMD:givecam(playerid,params[])
{
	new pID,ammo;
	if(sscanf(params,"ui",pID,ammo))return SendClientMessage(playerid,COLOR_GREY,"/givecam [playerid] [Munition]");
    GivePlayerWeapon(pID, 43, ammo);
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
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
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
saveSkin(pID);
return 1;
}


CMD:eveh(playerid,params[])
{
	new item[64];
	if(sscanf(params,"s[64]",item))return SendClientMessage(playerid, COLOR_GREY, "INFO: /eveh [add|del|delmy|lock|lockmy]");
	if(!strcmp(item, "add", false))
 	{
  	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
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

CMD:showpos(playerid,params[])
{
new pID, Float:x, Float:y, Float:z, string[200];
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"/showpos [playerid]");
GetPlayerPos(playerid, x, y, z);
format(string,sizeof(string),"POSITION: Deine Koordinaten: %f,%f,%f", x,y,z);
SendClientMessage(playerid, COLOR_GREY,string);
printf(string);
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

/*CMD:ban(playerid,params[])
{
	new pID, Grund[MAX_PLAYER_NAME], string[128], kname[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
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

CMD:kickbox(playerid,params[])
{
	new pID, Grund[64], dstring[128], kname[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
	if(sscanf(params,"us[64]",pID,Grund))return SendClientMessage(playerid,COLOR_GREY,"/kick [playerid] [Grund]");
	name = getPlayerName(pID);
	kname = getPlayerName(playerid);
format(dstring,sizeof(dstring),"Adminsystem\nDu wurdest von %s vom Server gekickt.\nGrund dafür: %s",kname,Grund);
ShowPlayerDialog(pID, DIALOG_KICK, DIALOG_STYLE_MSGBOX, "Adminsystem", dstring, "OK", "");
return 1;
}
CMD:kick(playerid,params[])
{
	new pID, Grund[64], dstring[128], string[128], kname[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
	if(sscanf(params,"us[64]",pID,Grund))return SendClientMessage(playerid,COLOR_GREY,"/kick [playerid] [Grund]");
	name = getPlayerName(pID);
	kname = getPlayerName(playerid);
	format(string,sizeof(string),"AdmCMD: %s wurde von %s vom Server gekickt. Grund: %s",name,kname,Grund);
	SendClientMessageToAll(COLOR_HRED,string);
	printf(string);
	format(dstring,sizeof(dstring),"{FF0000FF}Adminsystem\n\tDu wurdest von %s vom Server gekickt.\nGrund dafür: %s",kname,Grund);
	ShowPlayerDialog(pID, DIALOG_KICK, DIALOG_STYLE_MSGBOX, "Adminsystem", dstring, "Button 1", "");
    Kick(pID);
	return 0;
}

CMD:gmx(playerid,params[]){
	if(!isAdmin(playerid,6))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!");
	if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
   	GameTextForAll("~r~"#SERVERTAG"~w~ startet neu!",6000,0);
 	SendClientMessageToAll(COLOR_HRED, "RESTART ERFOLGT JETZT!!!");
	SendRconCommand("gmx");
	return 1;
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
staatsequip(playerid)
{
GivePlayerWeapon(playerid,24,150);
GivePlayerWeapon(playerid,25,50);
GivePlayerWeapon(playerid,29,250);
GivePlayerWeapon(playerid,31,200);
SetPlayerSkin(playerid,sInfo[playerid][fSkin]);
return 1;
}
//Befehle
CMD:duty(playerid,params[])
{
new fID;
fID = sInfo[playerid][fraktion];
if(!IsPlayerInRangeOfPoint(playerid,3.0,fInfo[fID][f_dx],fInfo[fID][f_dy],fInfo[fID][f_dz]))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht am Dutypunkt deiner Fraktion.");
{
if(GetPVarInt(playerid,"fduty")==1){
	SetPVarInt(playerid,"fduty",0);
	SetPlayerSkin(playerid,sInfo[playerid][skin]);
	SendClientMessage(playerid,fInfo[fID][f_color],"DIENST: {FFFFFF}Du bist nun nicht mehr im Dienst.");
	}
	else
	//SAPD Duty
	if(isPlayerInFrak(playerid,1) && GetPVarInt(playerid,"fduty")==0){
	SendClientMessage(playerid,fInfo[fID][f_color],"SAPD: {FFFFFF}Du bist nun als Polizist im Dienst.");
	GivePlayerWeapon(playerid,41,500);
	GivePlayerWeapon(playerid,3,1);
	staatsequip(playerid);
	SetPVarInt(playerid,"fduty",1);
	return 1;
	}
	else
	//FBI Duty
	if(isPlayerInFrak(playerid,2) && GetPVarInt(playerid,"fduty")==0)
	{
	staatsequip(playerid);
	SendClientMessage(playerid,COLOR_BLUE,"FBI:{FFFFFF} Du bist nun als Agent im Dienst.");
	SetPVarInt(playerid,"fduty",1);
	return 1;
	}
	else
	//Army Duty
	if(isPlayerInFrak(playerid,3) && GetPVarInt(playerid,"fduty")==0)
	{
	staatsequip(playerid);
	SendClientMessage(playerid,COLOR_GREEN,"ARMY:{FFFFFF} Du bist nun als Soldat im Dienst");
	SetPVarInt(playerid,"fduty",1);
	}
	else if(isPlayerInFrak(playerid,4) && GetPVarInt(playerid,"fduty")==0)
	{
	//MEIDCS Duty
	GivePlayerWeapon(playerid,41,500);
	sInfo[playerid][tazer]=10;
	SendClientMessage(playerid,COLOR_RED,"SARD: {FFFFFF}Du bist nun als Arzt im Dienst.");
	SetPVarInt(playerid,"fduty",1);
	SetPlayerSkin(playerid,sInfo[playerid][fSkin]);
	}
	else if(isPlayerInFrak(playerid,7) && GetPVarInt(playerid,"fduty")==0)
	{
	//REGIERUNG Duty
	SetPlayerSkin(playerid,sInfo[playerid][fSkin]);
	GivePlayerWeapon(playerid,41,500);
	SendClientMessage(playerid,COLOR_YELLOW,"REGIERUNG: {FFFFFF}Du bist nun als Beamter der Regierung im Dienst.");
	SetPVarInt(playerid,"fduty",1);
	}
	else if(isPlayerInFrak(playerid,9) && GetPVarInt(playerid,"fduty")==0)
	{
	//SAM AG Duty
	SetPlayerSkin(playerid,sInfo[playerid][fSkin]);
	SendClientMessage(playerid,COLOR_ORANGE,"SAM AG:{FFFFFF} Du bist nun als Reporter der SAM:AG verfügbar.");
	GivePlayerWeapon(playerid,5,1);
	GivePlayerWeapon(playerid,43,100);
	sInfo[playerid][tazer]=10;
	SetPVarInt(playerid,"fduty",1);
	}
	else if(isPlayerInFrak(playerid,20) && GetPVarInt(playerid,"fduty")==0)
	{
	//DMV Duty
	SetPlayerSkin(playerid,sInfo[playerid][fSkin]);
	SendClientMessage(playerid,COLOR_YELLOW,"REGIERUNG: {FFFFFF}Du bist nun als Fahrlehrer im Dienst.");
	GivePlayerWeapon(playerid,41,500);
	SetPVarInt(playerid,"fduty",1);
	sInfo[playerid][tazer]=10;
	}

}
return 1;
}
CMD:dutyinfo(playerid,params[])
{
new string[64];
format(string,sizeof(string),"Dein Dutystatus: %i",GetPVarInt(playerid,"fduty"));
SendClientMessage(playerid,COLOR_GREY,string);
return 1;
}
CMD:setfskin(playerid,params[])
{
new pID,skinID;
if(sscanf(params,"ui",pID,skinID))return SendClientMessage(playerid,COLOR_GREY,"/setfskin [playerid] [skin-ID]");
sInfo[pID][fSkin]=skinID;
SetPlayerSkin(pID,skinID);
return 1;
}
CMD:setol(playerid,params[])
{
new pID,string[128],smstring[128];
if(!isPlayerInFrak(playerid,9))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Newsreporter.");
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"/setol [playerid]");
if(isPlayerInFrak(pID,9))return SendClientMessage(playerid,COLOR_GREY,"Fraktionsmitglieder können nicht auf die schwarze Liste gesetzt werden.");
sInfo[pID][pOL]=1;
format(string,sizeof(string),"%s hat dich auf die Orangelist gesetzt.",getPlayerName(playerid));
format(smstring,sizeof(smstring),"%s hat %s auf die Orangelist gesetzt.",getPlayerName(playerid),getPlayerName(pID));
SendFrakMessage(sInfo[playerid][fraktion],COLOR_YELLOW,smstring);
SendClientMessage(pID,COLOR_YELLOW,string);
return 1;
}
CMD:showbl(playerid,params[])
{
return 1;
}
CMD:orangelist(playerid,params[])
{
if(!isPlayerInFrak(playerid,9))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Newsreporter.");

new string[128];
SendClientMessage(playerid,COLOR_HBLUE,"Übersicht Orangelist:");
	for(new i = 0 ; i < MAX_PLAYERS ; i++)
	{
	    if(IsPlayerConnected(i) && sInfo[i][eingeloggt] == 1)
	    {
	        if(sInfo[i][pOL] == 1)
	        {
	        format(string,sizeof(string),"%s",getPlayerName(i));
         	SendClientMessage(playerid, COLOR_YELLOW, string);
			}
	    }
	}
	return 1;
}

CMD:delol(playerid,params[])
{
new pID, string[128],smstring[128];
if(!isPlayerInFrak(playerid,9))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Newsreporter.");
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"/setol [playerid]");
if(!isPlayerOnOrangelist(pID))return SendClientMessage(playerid,COLOR_GREY,"Die Person befindet sich nicht auf der Orangelist.");
sInfo[pID][pOL]=0;
format(smstring,sizeof(smstring),"%s hat %s von der Orangelist gelöscht.",getPlayerName(playerid),getPlayerName(pID));
SendFrakMessage(sInfo[playerid][fraktion],COLOR_YELLOW,smstring);
format(string,sizeof(string),"%s hat dich von der Orangelist gelöscht.",getPlayerName(playerid));
SendClientMessage(pID,COLOR_YELLOW,string);
return 1;
}


CMD:mv(playerid,params[])
{
new Float:z,Float:y,Float:x;
if(!IsPlayerInRangeOfPoint(playerid, 10.0, 371.16800, -2038.30005, 6.2000)) {
}
else{
GetObjectPos(p1, x, y, z);
if(z !=6.200){
MoveObject(p1, 371.16800, -2038.30005, 6.2000,1.000, 0.0000, 0.0000, 10);
MoveObject(p2, 369.82370, -2038.30005, 6.2000,1.0000, 0.0000, 0.0000, 10);
MoveObject(p3, 368.36111, -2038.30005, 6.2000,1.0000, 0.0000, 0.0000, 10);
}
else{
MoveObject(p1, 371.16800, -2038.30005, 7.24000,1.000, 0.0000, 0.0000, 10);
MoveObject(p2, 369.82370, -2038.30005, 7.2400,1.0000, 0.0000, 0.0000, 10);
MoveObject(p3, 368.36111, -2038.30005, 7.2400,1.0000, 0.0000, 0.0000, 10);
}}
return 1;
}
CMD:hduty(playerid,params[])
{
//if(!isAdmin(playerid,5))return 1;
if(sInfo[playerid][fraktion] != 8)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt diesen Befehl zu nutzen");
new string[128];
GivePlayerWeapon(playerid, 34, 90);
GivePlayerWeapon(playerid, 23, 90);
SetPlayerHealth(playerid,100);
SetPlayerArmour(playerid,100);
format(string,sizeof(string),"HITMAN: %s ist nun als Hitman im Dienst",getPlayerName(playerid));

	for(new i = 0 ; i < MAX_PLAYERS ; i++)
	{
	    if(IsPlayerConnected(i) && sInfo[i][eingeloggt] == 1)
	    {
	        if(sInfo[i][fraktion] == 8)
	        {
	            SendClientMessage(i, COLOR_YELLOW, string);
			}
	    }
	}
return 1;
}

CMD:help(playerid,params[])
{
SendClientMessage(playerid,COLOR_WHITE,"Bei Fragen bitte bei "#SERVEROWNER" melden.");
return 1;
}
CMD:showfmotd(playerid,params[])
{
new string[128];
format(string,sizeof(string),"fmotd: %s",fInfo[sInfo[playerid][fraktion]][fmotd]);
SendClientMessage(playerid,COLOR_WHITE,string);
return 1;
}
CMD:fmotd(playerid,params[])
{


new string[128];
new fID = sInfo[playerid][fraktion];
if(sscanf(params,"s[64]",fInfo[fID][fmotd]))SendClientMessage(playerid,COLOR_GREY,"/fmotd [text]");
if(sInfo[playerid][frang]<5)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Leader einer Fraktion");
format(string,sizeof(string),"LEADER: Du hast die fmotd auf %s geändert",fInfo[fID][fmotd]);
SendClientMessage(playerid,COLOR_YELLOW,string);

return 1;
}

CMD:id(playerid,params[])
{
new Float:health,Float:arm,ping,string[256],plevel,name[256],pID;
if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"/id [playerid]");
GetPlayerHealth(playerid,health);
GetPlayerArmour(pID,arm);
ping = GetPlayerPing(pID);
name = getPlayerName(pID);
plevel = GetPlayerScore(pID);
format(string,sizeof(string),"Name: %s  Level: %i  Ping:%i  HP:%f  Armour:%f",name,plevel,ping,health,arm);
SendClientMessage(playerid,COLOR_WHITE,string);
return 1;
}

CMD:credits(playerid,params[])
{
SendClientMessage(playerid,COLOR_HGREEN,"[__________ Testserver __________]");
SendClientMessage(playerid,COLOR_HRED,"Gegründet von: "#SERVEROWNER".");
SendClientMessage(playerid,COLOR_HRED,"Entwickler: "#SERVEROWNER".");
SendClientMessage(playerid,COLOR_HRED," ");
SendClientMessage(playerid,COLOR_GREY,"* Danke an alle Tester und Helfer.");
return 1;
}

CMD:stopstream(playerid,params[])
{
StopAudioStreamForPlayer(playerid);
return 1;
}
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

CMD:get(playerid,params[])
{
new anzahl,preis,string[256],item[64];
if(sscanf(params,"s[64]i",item,anzahl))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /get [donut|green|gold|LSD]");
if(!strcmp(item, "donut", false))
{
if(IsPlayerInRangeOfPoint(playerid,10.0,1038.0804,-1339.8496,13.7343))
{
	sInfo[playerid][pdonut] = sInfo[playerid][pdonut]+anzahl;
	preis = anzahl*7;
	    if(GetPlayerMoney(playerid)< preis)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du hast nicht genug Geld dabei.");
	 format(string,sizeof(string),"* Du hast %i Donut(s) für $%i gekauft. (Donuts im Inventar: %i)",anzahl,preis,sInfo[playerid][pdonut]);
	SendClientMessage(playerid,COLOR_YELLOW,string);
	SetPlayerMoney(playerid,GetPlayerMoney(playerid)-preis);
		}
	}
return 1;
}

CMD:use(playerid,params[])
{
	new item[64],string[256],Float:health;
	if(sscanf(params,"s[64]",item))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /use [lsd|green|gold|donut]");

	if(!strcmp(item, "donut", false))
	{
	if(sInfo[playerid][pdonut] <= 0)return SendClientMessage(playerid, COLOR_RED,"FEHLER: {FFFFFF}Du besitzt keine Donuts.");
	    new Float:x, Float:y, Float:z;
	    GetPlayerHealth(playerid,health);
	    if(health > 80){
		SendClientMessage(playerid,COLOR_GREY,"Du hast genug gegessen!");
		return 1;
		}
    GetPlayerPos(playerid, x,y,z);
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) //GetPlayerPoolSize ist die höchste online playerid   | i repräsentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
   	format(string,sizeof(string),"* %s hat einen Donut gegessen",getPlayerName(playerid));
	SendClientMessage(playerid,COLOR_LILA,string);
	}}
	SetPlayerHealth(playerid,health+80);
	sInfo[playerid][pdonut]--;
	return 1;
	}
 	if(!strcmp(item, "green", false))
	{
	if(sInfo[playerid][pgreen] <= 1)return SendClientMessage(playerid, COLOR_RED,"FEHLER: {FFFFFF}Du benötigst mindestens 2g Green.");
	    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x,y,z);
     GetPlayerHealth(playerid,health);
	    if(health > 80){
		SendClientMessage(playerid,COLOR_GREY,"Du kannst Hawaiian Green erst ab 80HP nutzen.");
		return 1;
		}
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) //GetPlayerPoolSize ist die höchste online playerid   | i repräsentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
   	format(string,sizeof(string),"* %s hat Hawaiian Green benutzt.",getPlayerName(playerid));
	SendClientMessage(playerid,COLOR_LILA,string);
	}}
	GetPlayerHealth(playerid,health);
	SetPlayerHealth(playerid,health+35);
 	sInfo[playerid][pgreen]--;
 	sInfo[playerid][pgreen]--;
	return 1;
	}
	return 0;
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


CMD:invite(playerid,params[])
{
	if(isPlayerInFrak(playerid, 0))return SendClientMessage(playerid, COLOR_RED, "Du bist in keiner Fraktion.");
	if(sInfo[playerid][frang] < 5)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Leader einer Fraktion.");
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
		sInfo[playerid][frang] = 1;
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
	if(sInfo[playerid][frang] < 5)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Leader einer Fraktion.");
	new pID;
	if(sscanf(params,"u",pID))return SendClientMessage(playerid, COLOR_GREY, "INFO: /uninvite [playerid]");
	if(!isPlayerInFrak(pID,sInfo[playerid][fraktion]))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Der Spieler ist nicht in deiner Fraktion");
	sInfo[pID][fraktion] =0;
	sInfo[pID][frang] =0;
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
CMD:houses(playerid,params[])
{

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
	    SendClientMessage(playerid, COLOR_RED, "Alle deine Hausslots sind belegt!");
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
			SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Dein Level ist zu niedrig um dieses Haus zu erwerben.");
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

CMD:motor(playerid,params[])
{
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
	if(!strcmp(item,"kraum",false))
	{
	new vID=GetPlayerVehicleID(playerid),
	 tmp_engine,
	 tmp_lights,
	 tmp_alarm,
	 tmp_doors,
	 tmp_bonnet,
	 tmp_boot,
	 tmp_objective;
	if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)return
 	SendClientMessage(playerid,COLOR_GREY, "Du bist nicht Fahrer eines Fahrzeuges.");
 	
	 GetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);

	 if(tmp_boot == 0){
	 tmp_boot=1;
	 	SetVehicleParamsEx(vID, tmp_engine, tmp_lights,tmp_alarm,tmp_doors,tmp_bonnet,tmp_boot,tmp_objective);
   		SendClientMessage(playerid,COLOR_GREY,"Kofferraum geöffnet.");}
	else{
	if(tmp_boot == 1){
	tmp_boot = 1;
	 	SetVehicleParamsEx(vID, tmp_engine, tmp_lights,tmp_alarm,tmp_doors,tmp_bonnet,tmp_boot,tmp_objective);
		SendClientMessage(playerid,COLOR_GREY,"Kofferraum geschlossen.");
		 }
	return 1;
	}}
	
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
	
	for(new i=0; i<sizeof(fInfo);i++)
	{
	if(!IsPlayerInRangeOfPoint(playerid,10,fInfo[i][f_exx],fInfo[i][f_exy],fInfo[i][f_exz]))continue;
	SetPlayerPos(playerid,fInfo[i][f_enx],fInfo[i][f_eny],fInfo[i][f_enz]);
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	}
	
	for(new i=0; i<sizeof(hInfo); i++)
	{
		if(GetPlayerVirtualWorld(playerid) !=i)continue;
		if(!IsPlayerInRangeOfPoint(playerid,10,hInfo[i][ih_x],hInfo[i][ih_y],hInfo[i][ih_z]))continue;
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
	
	for(new i=0; i<sizeof(fInfo);i++)
	{
	if(!IsPlayerInRangeOfPoint(playerid,10,fInfo[i][f_enx],fInfo[i][f_eny],fInfo[i][f_enz]))continue;
	SetPlayerInterior(playerid,fInfo[i][f_inter]);
	SetPlayerVirtualWorld(playerid,fInfo[i][f_world]);
	SetPlayerPos(playerid,fInfo[i][f_exx],fInfo[i][f_exy],fInfo[i][f_exz]);
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
				SendClientMessage(playerid,COLOR_HGREEN,"Stream beendet.");
				SetPVarInt(playerid,"streamon",0);
				return 1;
}
else
{
	ShowPlayerDialog(playerid,DIALOG_STREAM,DIALOG_STYLE_LIST,"Streamliste","Stream stoppen\nBreakzFM\nLogin\nRadio Bollerwagen\n1 Live\n Weihnachtsmusik","Play","Abbrechen");

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
 	TextDrawHideForPlayer(playerid, Tachobox);
	PlayerTextDrawHide(playerid, tankLabel[playerid]);
	}
	if(newstate==PLAYER_STATE_EXIT_VEHICLE)
	{
    TextDrawHideForPlayer(playerid, Tacho);
 	TextDrawHideForPlayer(playerid, kmhtd);
 	TextDrawHideForPlayer(playerid, Tachobox);
	PlayerTextDrawHide(playerid, tankLabel[playerid]);
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
  	    TextDrawShowForPlayer(playerid, Tachobox);
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


stock isPlayerOnOrangelist(playerid)
{
	if(sInfo[playerid][pOL]==1)return 1;
	return 0;
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




//noclip
if(noclipdata[playerid][cameramode] == CAMERA_MODE_FLY)
	{
		new keys,ud,lr;
		GetPlayerKeys(playerid,keys,ud,lr);

		if(noclipdata[playerid][mode] && (GetTickCount() - noclipdata[playerid][lastmove] > 100))
		{
		    // If the last move was > 100ms ago, process moving the object the players camera is attached to
		    MoveCamera(playerid);
		}

		// Is the players current key state different than their last keystate?
		if(noclipdata[playerid][udold] != ud || noclipdata[playerid][lrold] != lr)
		{
			if((noclipdata[playerid][udold] != 0 || noclipdata[playerid][lrold] != 0) && ud == 0 && lr == 0)
			{   // All keys have been released, stop the object the camera is attached to and reset the acceleration multiplier
				StopPlayerObject(playerid, noclipdata[playerid][flyobject]);
				noclipdata[playerid][mode]      = 0;
				noclipdata[playerid][accelmul]  = 0.0;
			}
			else
			{   // Indicates a new key has been pressed

			    // Get the direction the player wants to move as indicated by the keys
				noclipdata[playerid][mode] = GetMoveDirectionFromKeys(ud, lr);

				// Process moving the object the players camera is attached to
				MoveCamera(playerid);
			}
		}
		noclipdata[playerid][udold] = ud; noclipdata[playerid][lrold] = lr; // Store current keys pressed for comparison next update
		return 0;
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

stock GetMoveDirectionFromKeys(ud, lr)
{
	new direction = 0;

    if(lr < 0)
	{
		if(ud < 0) 		direction = MOVE_FORWARD_LEFT; 	// Up & Left key pressed
		else if(ud > 0) direction = MOVE_BACK_LEFT; 	// Back & Left key pressed
		else            direction = MOVE_LEFT;          // Left key pressed
	}
	else if(lr > 0) 	// Right pressed
	{
		if(ud < 0)      direction = MOVE_FORWARD_RIGHT;  // Up & Right key pressed
		else if(ud > 0) direction = MOVE_BACK_RIGHT;     // Back & Right key pressed
		else			direction = MOVE_RIGHT;          // Right key pressed
	}
	else if(ud < 0) 	direction = MOVE_FORWARD; 	// Up key pressed
	else if(ud > 0) 	direction = MOVE_BACK;		// Down key pressed

	return direction;
}
stock MoveCamera(playerid)
{
	new Float:FV[3], Float:CP[3];
	GetPlayerCameraPos(playerid, CP[0], CP[1], CP[2]);          // 	Cameras position in space
    GetPlayerCameraFrontVector(playerid, FV[0], FV[1], FV[2]);  //  Where the camera is looking at

	// Increases the acceleration multiplier the longer the key is held
	if(noclipdata[playerid][accelmul] <= 1) noclipdata[playerid][accelmul] += ACCEL_RATE;

	// Determine the speed to move the camera based on the acceleration multiplier
	new Float:speed = MOVE_SPEED * noclipdata[playerid][accelmul];

	// Calculate the cameras next position based on their current position and the direction their camera is facing
	new Float:X, Float:Y, Float:Z;
	GetNextCameraPosition(noclipdata[playerid][mode], CP, FV, X, Y, Z);
	MovePlayerObject(playerid, noclipdata[playerid][flyobject], X, Y, Z, speed);

	// Store the last time the camera was moved as now
	noclipdata[playerid][lastmove] = GetTickCount();
	return 1;
}
stock GetNextCameraPosition(move_mode, Float:CP[3], Float:FV[3], &Float:X, &Float:Y, &Float:Z)
{
    // Calculate the cameras next position based on their current position and the direction their camera is facing
    #define OFFSET_X (FV[0]*6000.0)
	#define OFFSET_Y (FV[1]*6000.0)
	#define OFFSET_Z (FV[2]*6000.0)
	switch(move_mode)
	{
		case MOVE_FORWARD:
		{
			X = CP[0]+OFFSET_X;
			Y = CP[1]+OFFSET_Y;
			Z = CP[2]+OFFSET_Z;
		}
		case MOVE_BACK:
		{
			X = CP[0]-OFFSET_X;
			Y = CP[1]-OFFSET_Y;
			Z = CP[2]-OFFSET_Z;
		}
		case MOVE_LEFT:
		{
			X = CP[0]-OFFSET_Y;
			Y = CP[1]+OFFSET_X;
			Z = CP[2];
		}
		case MOVE_RIGHT:
		{
			X = CP[0]+OFFSET_Y;
			Y = CP[1]-OFFSET_X;
			Z = CP[2];
		}
		case MOVE_BACK_LEFT:
		{
			X = CP[0]+(-OFFSET_X - OFFSET_Y);
 			Y = CP[1]+(-OFFSET_Y + OFFSET_X);
		 	Z = CP[2]-OFFSET_Z;
		}
		case MOVE_BACK_RIGHT:
		{
			X = CP[0]+(-OFFSET_X + OFFSET_Y);
 			Y = CP[1]+(-OFFSET_Y - OFFSET_X);
		 	Z = CP[2]-OFFSET_Z;
		}
		case MOVE_FORWARD_LEFT:
		{
			X = CP[0]+(OFFSET_X  - OFFSET_Y);
			Y = CP[1]+(OFFSET_Y  + OFFSET_X);
			Z = CP[2]+OFFSET_Z;
		}
		case MOVE_FORWARD_RIGHT:
		{
			X = CP[0]+(OFFSET_X  + OFFSET_Y);
			Y = CP[1]+(OFFSET_Y  - OFFSET_X);
			Z = CP[2]+OFFSET_Z;
		}
	}
}
//--------------------------------------------------

stock CancelFlyMode(playerid)
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	DeletePVar(playerid, "FlyMode");
	CancelEdit(playerid);
	TogglePlayerSpectating(playerid, false);

//	DestroyPlayerObject(playerid, noclipdata[playerid][flyobject]);
	noclipdata[playerid][cameramode] = CAMERA_MODE_NONE;
	SetPlayerPos(playerid,x,y,z);
	return 1;
}

//--------------------------------------------------

stock FlyMode(playerid)
{
	// Create an invisible object for the players camera to be attached to
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	noclipdata[playerid][flyobject] = CreatePlayerObject(playerid, 19300, X, Y, Z, 0.0, 0.0, 0.0);

	// Place the player in spectating mode so objects will be streamed based on camera location
	TogglePlayerSpectating(playerid, true);
	// Attach the players camera to the created object
	AttachCameraToPlayerObject(playerid, noclipdata[playerid][flyobject]);

	SetPVarInt(playerid, "FlyMode", 1);
	noclipdata[playerid][cameramode] = CAMERA_MODE_FLY;
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
		cache_get_field_content(i,"Kennzeichen",cInfo[id][kennzeichen],dbhandle);
		cInfo[id][id_x]=CreateVehicle(cInfo[id][model],cInfo[id][c_x],cInfo[id][c_y],cInfo[id][c_z],cInfo[id][c_r],cInfo[id][farbe1],cInfo[id][farbe2],-1);
        tank[id]=cache_get_field_content_int(i,"tank",dbhandle);
        SetVehicleNumberPlate(id,cInfo[id][kennzeichen]);
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
	    sInfo[playerid][frang] = cache_get_field_content_int(0,"rang",dbhandle);
	    sInfo[playerid][fSkin] = cache_get_field_content_int(0,"fskin",dbhandle);
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
		sInfo[playerid][deaths]=cache_get_field_content_int(0,"deaths",dbhandle);
		sInfo[playerid][pOL]=cache_get_field_content_int(0,"orangelist",dbhandle);
		
		

	/*	if(isAdmin(playerid,1)){
   		new name[128],string[128];
		GetPlayerName(playerid,name,sizeof(name));
		GetPlayerName(playerid,sInfo[playerid][oldname],sizeof(name));
		format(string, sizeof(string),"[NeS]%s",name);
		SetPlayerName(playerid,string);
		return 1;
}
*/
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
	if(dialogid==DIALOG_SEIGABE)
	{
	if(response)
	{
		if(strlen(inputtext)>0)
		{
        PlayAudioStreamForPlayer(playerid,inputtext);
		}
	}
	}
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
			SetPVarInt(playerid,"aduty",1);
			TextDrawShowForPlayer(playerid,Textdraw0);
			}
			else{
			format(string2, sizeof(string), "SERVER: %s {FFFFFF}ist nicht mehr im Dienst.", name);
			SendClientMessageToAll(COLOR_RED,string2);
			SetPVarInt(playerid,"aduty",0);
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
			SetPVarInt(playerid,"aduty",1);
			TextDrawShowForPlayer(playerid,Textdraw0);
			}
			else{
			format(string2, sizeof(string), "SERVER: %s {FFFFFF}ist nicht mehr im Dienst.", name);
			SendClientMessageToAll(COLOR_RED,string2);
			SetPVarInt(playerid,"aduty",0);
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
			SetPVarInt(playerid,"aduty",1);
			TextDrawShowForPlayer(playerid,Textdraw0);
			}
			else{
			format(string2, sizeof(string), "SERVER: %s {FFFFFF}ist nicht mehr im Dienst.", name);
			SendClientMessageToAll(COLOR_RED,string2);
			SetPVarInt(playerid,"aduty",0);
			TextDrawHideForPlayer(playerid,Textdraw0);
			return 1;
			}
		}
			if(listitem==3){
			if(!isaduty(playerid)){
 			SetPlayerColor(playerid, COLOR_RED);
 			SendClientMessage(playerid, COLOR_WHITE, "Du bist nun silent Aduty");
			SetPVarInt(playerid,"aduty",1);
			}
			else{
 			SetPlayerColor(playerid, COLOR_WHITE);
 			SendClientMessage(playerid, COLOR_WHITE, "Du bist nun nicht mehr silent Aduty");
			SetPVarInt(playerid,"aduty",0);
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
	            format(query,sizeof(query),"INSERT INTO user (username,passwort,hausslots) VALUES ('%s','%s','%i') ",name,passwort,1);
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
				SendClientMessage(playerid,COLOR_HGREEN,"Stream beendet.");
				return 1;
			}
			if(listitem==2)
			{
			PlayAudioStreamForPlayer(playerid, stream,0.0,0.0,0.0, 1);
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
			PlayAudioStreamForPlayer(playerid,"	https://wdr-1live-live.icecastssl.wdr.de/wdr/1live/live/mp3/128/stream.mp3",0.0,0.0,0.0, 1);
			SendClientMessage(playerid,COLOR_HGREEN,"Du hast das Radio angeschaltet. Viel Spaß beim Hören!");
  			SetPVarInt(playerid,"streamon",1);
			return 1;
			}
			if(listitem==5)
			{
			PlayAudioStreamForPlayer(playerid, "https://streams.ilovemusic.de/iloveradio8.mp3",0.0,0.0,0.0, 1);
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
	new Float:x,Float:y,Float:z;
	sInfo[playerid][spawnchange] =3;
	GetPlayerPos(playerid,x,y,z);
	x = sInfo[playerid][sx];
	y = sInfo[playerid][sy];
	z = sInfo[playerid][sz];
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
CMD:nichts(playerid,params[])
{
SendClientMessage(playerid,0x35793BFF,"{35793B}GLÜCKWUNSCH: {FFFFFF}Dieser Befehl macht garnichts!");
return 1;
}
CMD:dieserbefehlistunsichbar(playerid,params[])
{
if(!isAdmin(playerid,7))return 0;
saveCarToDB(playerid,1);
SendClientMessage(playerid,0x35793BFF,"Dieser Befehl macht garnichts!");
return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
