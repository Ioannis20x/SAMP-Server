//Erstellt mit Pawnfox!
#define FILTERSCRIPT

#include <a_samp>
#include <zCMD>
#include <streamer>

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Dilemma");
	print("--------------------------------------\n");
	SendClientMessageToAll(0xCC210AFF,"Dilemma da!");
	return 1;
}
new xobject[14];
new xvehicle;
new xtrailer[14];
new truck;
new trucktrailer;
new pvar;
new Float:x,Float:y,Float:z;
#define COLOR_RED 0xCC210AFF
new present;
new Text:dilemmatime;
new Text:dilemmacounter;

new oldpresent[5];
new string[128];
new deliveredpresents = 0;
new tID;
enum dilemmaData
{
    Float:dilemmaX,
    Float:dilemmaY,
    Float:dilemmaZ
};
/*TextDraws:



OnGameModeInit
	dilemmatime = TextDrawCreate(550, 260, "00:00");
	TextDrawBackgroundColor(dilemmatime, 255);
	TextDrawFont(dilemmatime, 1);
	TextDrawLetterSize(dilemmatime, 0.4, 1.5);
	TextDrawColor(dilemmatime, -1);
	TextDrawSetOutline(dilemmatime, 1);
	TextDrawSetProportional(dilemmatime, true);

	dilemmacounter = TextDrawCreate(500, 150, "Uebrige Geschenke: 5/5");
	TextDrawBackgroundColor(dilemmacounter, 255);
	TextDrawFont(dilemmacounter, 1);
	TextDrawLetterSize(dilemmacounter, 0.2, 1);
	TextDrawColor(dilemmacounter, -1);
	TextDrawSetOutline(dilemmacounter, 1);
	TextDrawSetProportional(dilemmacounter, true);


Bei Eventstart:
TextDrawShowForPlayer(playerid, dilemmatime);
TextDrawShowForPlayer(playerid, dilemmacounter);

*/


new DilemmaCPs[14][dilemmaData] = {
{2067.0305, -2201.8218, 13.5469},
{2080.4153, -2282.9958, 13.5469},
{2151.2759, -2382.1665, 13.5469},
{2119.1035, -2368.2285, 13.5469},
{1873.9524, -2349.6313, 13.5469},
{1686.2140, -2434.7964, 13.5547},
{1564.3180, -2409.1033, 13.5547},
{1393.0366, -2557.4568, 13.5469},
{1569.0914, -2656.2102, 13.5469},
{1653.1473, -2538.4839, 13.5469},
{1883.4901, -2548.0393, 13.5469},
{2025.7032, -2655.8313, 13.5469},
{1718.5382, -2664.1956, 13.5469},
{1392.4674, -2409.0315, 13.5547}
};

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	pvar = GetPVarInt(playerid, "dilemma");
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

CMD:startxmas(playerid, params[])
{

SetPVarInt(playerid, "dilemma", 0);

xobject[0] = CreateObject(19054, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //XmasBox1
xobject[1] = CreateObject(19055, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //XmasBox2
xobject[2] = CreateObject(19057, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //XmasBox4
xobject[3] = CreateObject(19058, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //XmasBox5
xobject[4] = CreateObject(19056, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //XmasBox3
xobject[5] = CreateObject(19054, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //XmasBox1
xobject[6] = CreateObject(19055, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //XmasBox2
xobject[7] = CreateObject(19057, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //XmasBox4
xobject[8] = CreateObject(19058, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //XmasBox5
xobject[9] = CreateObject(19056, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //XmasBox3
xobject[10] = CreateObject(19054, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //XmasBox1
xobject[11] = CreateObject(19055, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //XmasBox2
xobject[12] = CreateObject(19057, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //XmasBox4
xobject[13] = CreateObject(19058, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //XmasBox5

xtrailer[0] = CreateVehicle(607, 2067.0305, -2201.8218, 13.5469, 358.5770, 108, 217, -1); //Luggage Trailer B
xtrailer[1] = CreateVehicle(607, 2080.4153, -2282.9958, 13.5469, 86.6225, 108, 217, -1); //Luggage Trailer B
xtrailer[2] = CreateVehicle(607, 2151.2759, -2382.1665, 13.5469, 184.2498, 56, 102, -1); //Luggage Trailer B
xtrailer[3] = CreateVehicle(607, 2119.1035, -2368.2285, 13.5469, 0.4378, 56, 102, -1); //Luggage Trailer B
xtrailer[4] = CreateVehicle(607, 1873.9524, -2349.6313, 13.5469 ,90.0273, 56, 102, -1); //Luggage Trailer B
xtrailer[5] = CreateVehicle(607, 1686.2140, -2434.7964, 13.5547, 91.8718, 56, 102, -1); //Luggage Trailer B
xtrailer[6] = CreateVehicle(607, 1564.3180, -2409.1033, 13.5547, 0.2240, 56, 102, -1); //Luggage Trailer B
xtrailer[7] = CreateVehicle(607, 1393.0366, -2557.4568, 13.5469, 91.6820, 56, 102, -1); //Luggage Trailer B
xtrailer[8] = CreateVehicle(607, 1569.0914, -2656.2102, 13.5469, 270.9319, 56, 102, -1); //Luggage Trailer B
xtrailer[9] = CreateVehicle(607, 1653.1473, -2538.4839, 13.5469, 270.8076, 56, 102, -1); //Luggage Trailer B
xtrailer[10] = CreateVehicle(607, 1883.4901, -2548.0393, 13.5469, 270.3340, 56, 102, -1); //Luggage Trailer B
xtrailer[11] = CreateVehicle(607, 2025.7032, -2655.8313, 13.5469, 269.3908, 56, 102, -1); //Luggage Trailer B
xtrailer[12] = CreateVehicle(607, 1718.5382, -2664.1956, 13.5469, 181.7273, 56, 102, -1); //Luggage Trailer B
xtrailer[13] = CreateVehicle(607, 1392.4674, -2409.0315, 13.5547, 90.8071, 56, 102, -1); //Luggage Trailer B

xvehicle = CreateVehicle(485,1961.1663,-2216.9915,13.5469,178.8737,1,78,-1); // baggage
trucktrailer = CreateVehicle(435, 1963.275, -2196.786, 14.182, 358.2242 ,1, 78, -1);//Truck Trailer
truck = CreateVehicle(514, 1961.5969, -2184.9358 ,13.5469, 359.7849,1,10,1);

AttachObjectToVehicle(xobject[0], xtrailer[0], 0.0000, 0.0000, 0.3499, 0.0000, 0.0000, 0.0000);
AttachObjectToVehicle(xobject[1], xtrailer[1], 0.0000, 0.0000, 0.3499, 0.0000, 0.0000, 0.0000);
AttachObjectToVehicle(xobject[2], xtrailer[2], 0.0000, 0.0000, 0.3499, 0.0000, 0.0000, 0.0000);
AttachObjectToVehicle(xobject[3], xtrailer[3], 0.0000, 0.0000, 0.3499, 0.0000, 0.0000, 0.0000);
AttachObjectToVehicle(xobject[4], xtrailer[4], 0.0000, 0.0000, 0.3499, 0.0000, 0.0000, 0.0000);
AttachObjectToVehicle(xobject[5], xtrailer[5], 0.0000, 0.0000, 0.3499, 0.0000, 0.0000, 0.0000);
AttachObjectToVehicle(xobject[6], xtrailer[6], 0.0000, 0.0000, 0.3499, 0.0000, 0.0000, 0.0000);
AttachObjectToVehicle(xobject[7], xtrailer[7], 0.0000, 0.0000, 0.3499, 0.0000, 0.0000, 0.0000);
AttachObjectToVehicle(xobject[8], xtrailer[8], 0.0000, 0.0000, 0.3499, 0.0000, 0.0000, 0.0000);
AttachObjectToVehicle(xobject[9], xtrailer[9], 0.0000, 0.0000, 0.3499, 0.0000, 0.0000, 0.0000);
AttachObjectToVehicle(xobject[10], xtrailer[10], 0.0000, 0.0000, 0.3499, 0.0000, 0.0000, 0.0000);
AttachObjectToVehicle(xobject[11], xtrailer[11], 0.0000, 0.0000, 0.3499, 0.0000, 0.0000, 0.0000);
AttachObjectToVehicle(xobject[12], xtrailer[12], 0.0000, 0.0000, 0.3499, 0.0000, 0.0000, 0.0000);
AttachObjectToVehicle(xobject[13], xtrailer[13], 0.0000, 0.0000, 0.3499, 0.0000, 0.0000, 0.0000);

//Truck CP 1961.5112, -2200.1958, 13.5469
if(xvehicle){
PutPlayerInVehicle(playerid, xvehicle, 0);
GetVehiclePos(xtrailer[pvar],x,y,z);
present = random(14);
CreateDynamicCP(DilemmaCPs[present][dilemmaX], DilemmaCPs[present][dilemmaY], DilemmaCPs[present][dilemmaZ], 10, 0, 0, playerid, 10000.0);


dilemmatime = TextDrawCreate(550, 260, "00:00");
TextDrawBackgroundColor(dilemmatime, 255);
TextDrawFont(dilemmatime, 1);
TextDrawLetterSize(dilemmatime, 0.4, 1.5);
TextDrawColor(dilemmatime, -1);
TextDrawSetOutline(dilemmatime, 1);
TextDrawSetProportional(dilemmatime, true);

dilemmacounter = TextDrawCreate(500, 150, "Uebrige Geschenke: 5/5");
TextDrawBackgroundColor(dilemmacounter, 255);
TextDrawFont(dilemmacounter, 1);
TextDrawLetterSize(dilemmacounter, 0.2, 1);
TextDrawColor(dilemmacounter, -1);
TextDrawSetOutline(dilemmacounter, 1);
TextDrawSetProportional(dilemmacounter, true);
return SendClientMessage(playerid,COLOR_RED,"SNENS");
}
return 1;
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

stock IsPlayerNearPresent(playerid){

if(IsPlayerInRangeOfPoint(playerid, 20, DilemmaCPs[present][dilemmaX], DilemmaCPs[present][dilemmaY], DilemmaCPs[present][dilemmaZ])&& GetVehicleTrailer(xvehicle)==0)return 1;
return 0;
}

stock LoadPresent(playerid){

	AttachTrailerToVehicle(xtrailer[present],xvehicle);
	SendClientMessage(playerid,COLOR_RED,"DILEMMA: Super! Du hast ein Geschenk aufgenommen!");
	SendClientMessage(playerid,COLOR_RED,"DILEMMA: Bringe dieses zum LKW, der am Eingang des Airports steht.");
	CreateDynamicCP(1961.5112, -2200.1958, 13.5469, 10, 0, 0, playerid, -1);
	deliveredpresents++;
	return 1;
}


stock DestroyTrailer(playerid){
	DestroyObject(xobject[present]);
	DestroyVehicle(xtrailer[present]);
	return SendClientMessage(playerid,COLOR_RED,"Trailer put");
}


stock DeliverTrailer(playerid){
	format(string,sizeof(string),"DILEMMA: Du hast %i Trailer entladen. Es sind noch %i Trailer übrig!",deliveredpresents,5-deliveredpresents);
	SendClientMessage(playerid,COLOR_RED,string);
    format(string,sizeof(string),"tID: %i Present:%i",tID,present);
    SendClientMessage(playerid,COLOR_RED,string);
	DestroyTrailer(playerid);
	present = random(14);
	return 1;
}


stock checkpresent(){
	for(new i=0; i<sizeof(oldpresent);i++){
		if(oldpresent[i]==present){
			present = random(14);
			return 1;
		}
	}

	return 0;
}


public OnPlayerEnterCheckpoint(playerid)
{
tID = GetVehicleTrailer(xvehicle);
format(string,sizeof(string),"%f %f %f / %i",DilemmaCPs[present][dilemmaX], DilemmaCPs[present][dilemmaY], DilemmaCPs[present][dilemmaZ],GetVehicleTrailer(xvehicle));
SendClientMessage(playerid,COLOR_RED,string);

if(IsPlayerNearPresent(playerid)){
	LoadPresent(playerid);
	return 1;
}

if(IsPlayerInRangeOfPoint(playerid, 10, 1961.5112, -2200.1958, 13.5469)){
	if(GetVehicleTrailer(xvehicle) > 0 && deliveredpresents < 5){
	DeliverTrailer(playerid);
    checkpresent();
	CreateDynamicCP(DilemmaCPs[present][dilemmaX], DilemmaCPs[present][dilemmaY], DilemmaCPs[present][dilemmaZ], 10, 0, 0, playerid, -1);
	oldpresent[deliveredpresents] = oldpresent[deliveredpresents]+=present;
	return 1;

	}else{
        DestroyTrailer(playerid);
        DestroyVehicle(xvehicle);
		SendClientMessage(playerid,COLOR_RED,"ERFOLG: Du hast das Minigame gemeistert!");
		SendClientMessage(playerid,COLOR_RED,"INFO: Für das Abschliessen des Minigames bekommst du X Lebkuchen");
		deliveredpresents = 0;
		return 1;
	}

}

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
if(truck && trucktrailer){
if(GetVehicleModel(vehicleid) == 514){
AttachTrailerToVehicle(trucktrailer,truck);
return 1;
}
}

return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 0;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
