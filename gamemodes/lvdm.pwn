#include <a_samp>
#include <core>
#include <float>


#pragma tabsize 0


#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define PocketMoney 50000 // Amount player recieves on spawn.
#define INACTIVE_PLAYER_ID 255
#define GIVECASH_DELAY 5000 // Time in ms between /givecash commands.

#define NUMVALUES 4

forward MoneyGrubScoreUpdate();
forward Givecashdelaytimer(playerid);
forward SetPlayerRandomSpawn(playerid);
forward SetupPlayerForClassSelection(playerid);
forward GameModeExitFunc();
forward SendPlayerFormattedText(playerid, const str[], define);
forward public SendAllFormattedText(playerid, const str[], define);

//------------------------------------------------------------------------------------------------------

new CashScoreOld;
new iSpawnSet[MAX_PLAYERS];

new Float:gRandomPlayerSpawns[4][3] = {
{2022.3428,1008.1296,10.8203},
{1958.3783,1343.1572,15.3746},
{-2327.3235,-1639.4313,483.7031},
{-1708.6338,-201.1513,14.1440}
};

new Float:gCopPlayerSpawns[2][3] = {
{2297.1064,2452.0115,10.8203},
{2297.0452,2468.6743,10.8203}
};

//Round code stolen from mike's Manhunt :P
//new gRoundTime = 3600000;                   // Round time - 1 hour
//new gRoundTime = 1200000;					// Round time - 20 mins
//new gRoundTime = 900000;					// Round time - 15 mins
//new gRoundTime = 600000;					// Round time - 10 mins
//new gRoundTime = 300000;					// Round time - 5 mins
//new gRoundTime = 120000;					// Round time - 2 mins
//new gRoundTime = 60000;					// Round time - 1 min

new gActivePlayers[MAX_PLAYERS];
new gLastGaveCash[MAX_PLAYERS];

//------------------------------------------------------------------------------------------------------

main()
{
		print("\n----------------------------------");
		print("  Running Greek Ultimate Stuntages\n");
		print("          Coded By");
		print("          Drifter");
		print("----------------------------------\n");
}

//------------------------------------------------------------------------------------------------------

public OnPlayerRequestSpawn(playerid)
{
	//printf("OnPlayerRequestSpawn(%d)",playerid);
	return 1;
}

//------------------------------------------------------------------------------------------------------

public OnPlayerPickUpPickup(playerid, pickupid)
{
	//new s[256];
	//format(s,256,"Picked up %d",pickupid);
	//SendClientMessage(playerid,0xFFFFFFFF,s);
}

//------------------------------------------------------------------------------------------------------

public MoneyGrubScoreUpdate()
{
	new CashScore;
	new name[MAX_PLAYER_NAME];
	//new string[256];
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof(name));
   			CashScore = GetPlayerMoney(i);
			SetPlayerScore(i, CashScore);
			if (CashScore > CashScoreOld)
			{
				CashScoreOld = CashScore;
				//format(string, sizeof(string), "$$$ %s is now in the lead $$$", name);
				//SendClientMessageToAll(COLOR_YELLOW, string);
			}
		}
	}
}

//------------------------------------------------------------------------------------------------------

/*public GrubModeReset()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			SetPlayerScore(i, PocketMoney);
			SetPlayerRandomSpawn(i, classid);
		}
	}

}*/
//------------------------------------------------------------------------------------------------------

public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~w~SA-MP: ~r~Greek ~g~Ultimate ~b~Stuntages",5000,5);
	SendPlayerFormattedText(playerid,"Welcome to Greek Ultimate Stuntages,check out /v /admins /cmds /teles /rules /tips /credits /about /updates", 0);
	gActivePlayers[playerid]++;
	gLastGaveCash[playerid] = GetTickCount();
	return 1;
}

//------------------------------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid)
{
	gActivePlayers[playerid]--;
}
//------------------------------------------------------------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	new playermoney;
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new cmd[256];
	new giveplayerid, moneys, idx;

	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/help", true) == 0) {
		SendPlayerFormattedText(playerid,"..Greek Ultimate Stuntages.,[0.3e]: GUS Coded By Pro_Drfter & ExTrEmE_NiCk_KiLLeR and M_Dominic.",0);
		SendPlayerFormattedText(playerid,"Type: /objective :To see about this gm.",0);
		SendPlayerFormattedText(playerid,"Type: /givecash [playerid] [money-amount] You can send money to someone.",0);
		SendPlayerFormattedText(playerid,"Type: /tips : To see about it.", 0);
    return 1;
	}
	if(strcmp(cmd, "/objective", true) == 0) {
		SendPlayerFormattedText(playerid,"This gamemode is faily open, there's no specific win / endgame conditions to meet.",0);
		SendPlayerFormattedText(playerid,"In Greek Ultimate Stuntages, when you kill a player, you will receive whatever money they have.",0);
		SendPlayerFormattedText(playerid,"Consequently, if you have lots of money, and you die, your killer gets your cash.",0);
		SendPlayerFormattedText(playerid,"However, you're not forced to kill players for money, you can always gamble in the", 0);
		SendPlayerFormattedText(playerid,"Casino's.", 0);
    return 1;
	}
	if(strcmp(cmd, "/tips", true) == 0) {
		SendPlayerFormattedText(playerid,"Spawning with just a desert eagle might sound lame, however the idea of this",0);
		SendPlayerFormattedText(playerid,"gamemode is to get some cash, get better guns, then go after whoever has the",0);
		SendPlayerFormattedText(playerid,"most cash. Once you've got the most cash, the idea is to stay alive(with the",0);
		SendPlayerFormattedText(playerid,"cash intact)until the game ends, simple right?", 0);
    return 1;
	}
if(strcmp(cmdtext,"/cmds",true)==0)
{
ShowPlayerDialog(playerid,COLOR_RED,0,"Commands","General: /houseinfo /updates /tips /objective /help /rules /teles /credits /about /cmds\nVehicle: /lock /unlock /fix /repair /flip /sb /carcolor\nAccount: /register [pass] /login [pass]\nPlayer: /myradio /countdown /Colors /Pm /Afk /Brb /Back /car <id> /givecash [id]\nOther: /para /kill","Okay","Close");
return 1;
}
if(strcmp(cmdtext,"/teles",true)==0)
{
ShowPlayerDialog(playerid,COLOR_RED,0,"Teleport Commands","Drift:Drift1 /Drift2 /Drift3 /Drift4 /Drift5 /Drift6 /Drift7\nAirports:/lv /ls /sf /aa\nOther:/grove /jiggy /skatepark /ammunation\n/Police /inf /chilliad /lsbeach\nDeathMatches:/shipwar /shipwar2 /flame /rocket\nJumps:/jumppara /bigjump /pipe\nSpawns:/base /base2","Okay","Close");
return 1;
}
if(strcmp(cmdtext,"/about",true)==0)
{
ShowPlayerDialog(playerid,COLOR_RED,0,"About","About: Greek Ultimate Stuntages is made by Pro_Drifter, ExTrEmE_NiCk_KiLLeR.\nThe Server clan is [PRO] and everyone can join it for free!\n2.Donate\nAs our server is running on a paid host, you can help us to keep it alive!Go to our forums, and check out the Donate Info!\nThanks for reading!Have fun!","Okay","Close");
return 1;
}
if(strcmp(cmdtext, "/credits",true) == 0)
{
ShowPlayerDialog(playerid,COLOR_RED,0,"Server Credits","Server Hard Scripter: Pro_Drifter\nServer Mapper and Little Scripts:M_Dominic ,ExTrEmE_NiCk_KiLLeR\nThank you for reading credits!\nHave fun on our server!","Okay","Cancel");
return 1;
}
if(strcmp(cmdtext,"/rules", true) ==0 )
{
ShowPlayerDialog(playerid,COLOR_RED,0,"Server Rules","1.Do not use Hacks / Cheats.\n2.Do not spam the chat.\n3.Respect the people in the server, no insulting or swearing or annoying.\n4.Do not ask to be admin.\n5.Do not advertise other servers here.\n6.Don't Use Hydra , Tank , Hunter outside DM-zones!","Okay","Cancel");
return 1;
}
if(strcmp(cmdtext,"/houseinfo", true) ==0 )
{
ShowPlayerDialog(playerid,COLOR_RED,0,"Houses Information","/propertyhelp or /prophelp\n/buyproperty or /buyprop\n/sellproperty or /sellprop\n/myproperties or /myprops\n/register[password] /login[password]=For the houses","Okay","Cancel");
return 1;
}
if(strcmp(cmdtext,"/para",true)==0)
{
GivePlayerWeapon(playerid,46,1);
SendClientMessage(playerid,COLOR_YELLOW,"You took a parachute!");
return 1;
}
if(strcmp(cmdtext,"/myweather", true) ==0 )
{
ShowPlayerDialog(playerid,COLOR_RED,2,"Your Weather","Sunny\nRaining\nFoggy\nStorm\nVery Dark","Okay","Close");
return 1;
}
if(strcmp(cmdtext,"/updates",true)==0)
{
ShowPlayerDialog(playerid,COLOR_RED,0,"New and Updates Here","Updates:-Boost+Bounce added\n-Radio system added\n-LuxAdmin edited added\n-New Maps\n-New Teleports\n-New staff!","Okay","Close");
return 1;
}
//= - =- = - = - = - = - = - = - = VEHICLE COMMANDS = - = - = - = - = - = - =//
	if ( strcmp ( cmdtext , "/lock", true)==0)
	{
	if (IsPlayerInAnyVehicle(playerid))
	{
	new State;
	State=GetPlayerState(playerid);
	if (State!=PLAYER_STATE_DRIVER)
	{
	SendClientMessage(playerid, 0x6ba500ff, "Sorry, only the driver can lock the doors...");
	return 1;
	}
	new i;
	for(i=0;i<MAX_PLAYERS;i++)
	{
	if (i != playerid)
	{
	SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid), i, 0, 1);
	}
	}
	SendClientMessage(playerid, COLOR_RED, "Your vehicle has been locked!");
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	PlayerPlaySound(playerid, 1056, X, Y, Z);
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED, "You aren't in a vehicle!");
	}
	return 1;
	}
	if ( strcmp ( cmdtext , "/unlock", true)==0)
	{
	if (IsPlayerInAnyVehicle(playerid))
	{
	new State;
	State=GetPlayerState(playerid);
	if (State!=PLAYER_STATE_DRIVER)
	{
	SendClientMessage(playerid, 0x6ba500ff, "Only driver can unlock or lock the car doors.");
	return 1;
	}

	new i;
	for(i=0;i<MAX_PLAYERS;i++)
	{
	SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid), i, 0, 0);
	}
	SendClientMessage(playerid, 0x6ba500ff,"Your vehicle has been unlocked.");
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	PlayerPlaySound(playerid, 1057, X, Y, Z);
	}
	else
	{
	SendClientMessage(playerid, 0x6ba500ff, "You are not in a vehicle.");
	}
	return 1;
	}
	if ( strcmp ( cmdtext , "/fix", true)==0)
{
new State=GetPlayerState(playerid);
if (IsPlayerInAnyVehicle(playerid) && State == PLAYER_STATE_DRIVER)
{

RepairVehicle(playerid);
SendClientMessage(playerid,COLOR_GREEN,"Your vehicle has been succesfully repaired!");
}
else
{
SendClientMessage(playerid,COLOR_RED,"You have to be in a vehicle to use this command.");
}
return 1;
}
//-------------------------------------------------------
//= = = = = = = = =  Teleport Commands  = = = = = = = = =
    if (strcmp("/base", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 2022.3428,1008.1296,10.8203);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Base");
	SetPlayerInterior(playerid,0);
	return 1;
	}
    if (strcmp("/base2", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 1958.3783,1343.1572,15.3746);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Base2");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/drift", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, -295.5432,1543.2266,75.5625);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Drift");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/drift2", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, -2539.2822,-596.3240,132.7109);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Drift2");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/drift3", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 2222.9109,1965.0009,31.7797);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Drift3");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/drift4", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 2325.2664,1392.3447,42.8203);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Drift4");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/drift5", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 2597.4138,1889.0505,11.0312);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Drift5");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/drift6", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 2818.8853,-1428.6875,40.0625);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Drift6");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/drift7", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 1154.4952,2176.8240,16.7188);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Drift7");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/drag", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 2103.4568,861.0041,6.8226);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Drag Race");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/lv", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 1279.6046,1268.6472,10.8203);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Las Venturas Airport");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/sf", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, -1708.6338,-201.1513,14.1440);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To San Fierro Airport");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/ls", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 1493.2379,-2442.4470,13.5547);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Lost Santos Airport");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/grove", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 2495.0510,-1687.4971,13.5149);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Grove Street");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/skatepark", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 1861.0389,-1373.6716,13.5625);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To LS Skate Park");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/bigjump2", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, -441.2395,2488.5723,90.0423);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Big Jump 2");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/police", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 1551.1156,-1676.4402,15.7121);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To LS Police Station");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/lsbeach", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 500.5315,-1876.6136,4.4760);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To LS Beach Plaza");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/aa", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 403.6374,2447.7241,16.5000);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Abandon Airfield");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/jiggy", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, -2620.0549,1414.5328,7.0938);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Jiggy Strip Club");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/chilliad", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, -2327.3235,-1639.4313,483.7031);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Chilliad Mountain");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/pipe", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 327.5920,2864.2937,159.4067);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Pipe");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/bigjump", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 1104.7864,2505.7500,354.8968);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Pipe");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/ammunation", cmdtext, true, 10) == 0)
	{
	SetPlayerPos(playerid, 1363.5278,-1279.2346,13.5469);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Ammunation");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/jumppara", cmdtext, true, 10) == 0)
	{
	GivePlayerWeapon(playerid, 46, 1);
	SetPlayerPos(playerid, -2662.5652,1933.9298,225.7578);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Jump Parachute");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/shipwar", cmdtext, true, 10) == 0)
	{
	GivePlayerWeapon(playerid,27, 100);
	GivePlayerWeapon(playerid,28, 100);
	SetPlayerPos(playerid, -2455.4314,1543.6951,23.1481);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Shipwar");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/shipwar2", cmdtext, true, 10) == 0)
	{
	GivePlayerWeapon(playerid,27, 100);
	GivePlayerWeapon(playerid,28, 100);
	SetPlayerPos(playerid, -1365.5989,1489.3728,11.0391);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Shipwar2 Dm.Try to kill them all");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/flame", cmdtext, true, 10) == 0)
	{
	GivePlayerWeapon(playerid, 37, 500);
	SetPlayerPos(playerid, 626.9673,892.9088,-41.1028);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Flame Dm.Try to burn them all");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if (strcmp("/rocket", cmdtext, true, 10) == 0)
	{
	GivePlayerWeapon(playerid, 36, 500);
	SetPlayerPos(playerid, 1167.7864,2830.6477,10.8203);
	SendClientMessage(playerid, COLOR_GREEN,"Welcome To Rocket Dm.Try to explode them all");
	SetPlayerInterior(playerid,0);
	return 1;
	}
	if(strcmp(cmd, "/givecash", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecash [playerid] [amount]");
			return 1;
		}
		giveplayerid = strval(tmp);
		
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecash [playerid] [amount]");
			return 1;
		}
 		moneys = strval(tmp);
		
		//printf("givecash_command: %d %d",giveplayerid,moneys);

		
		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney = GetPlayerMoney(playerid);
			if (moneys > 0 && playermoney >= moneys) {
				GivePlayerMoney(playerid, (0 - moneys));
				GivePlayerMoney(giveplayerid, moneys);
				format(string, sizeof(string), "You have sent %s(player: %d), $%d.", giveplayer,giveplayerid, moneys);
				SendClientMessage(playerid, COLOR_YELLOW, string);
				format(string, sizeof(string), "You have recieved $%d from %s(player: %d).", moneys, sendername, playerid);
				SendClientMessage(giveplayerid, COLOR_YELLOW, string);
				printf("%s(playerid:%d) has transfered %d to %s(playerid:%d)",sendername, playerid, moneys, giveplayer, giveplayerid);
			}
			else {
				SendClientMessage(playerid, COLOR_YELLOW, "Invalid transaction amount.");
			}
		}
		else {
				format(string, sizeof(string), "%d is not an active player.", giveplayerid);
				SendClientMessage(playerid, COLOR_YELLOW, string);
			}
		return 1;
	}
	
	// PROCESS OTHER COMMANDS
	
	
	return 0;
}
//------------------------------------------------------------------------------------------------------

public OnPlayerSpawn(playerid)
{
	GivePlayerMoney(playerid, PocketMoney);
	SetPlayerInterior(playerid,0);
	SetPlayerRandomSpawn(playerid);
	TogglePlayerClock(playerid,1);
	return 1;
}

public SetPlayerRandomSpawn(playerid)
{
	if (iSpawnSet[playerid] == 1)
	{
		new rand = random(sizeof(gCopPlayerSpawns));
		SetPlayerPos(playerid, gCopPlayerSpawns[rand][0], gCopPlayerSpawns[rand][1], gCopPlayerSpawns[rand][2]); // Warp the player
		SetPlayerFacingAngle(playerid, 270.0);
    }
    else if (iSpawnSet[playerid] == 0)
    {
		new rand = random(sizeof(gRandomPlayerSpawns));
		SetPlayerPos(playerid, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]); // Warp the player
	}
	return 1;
}

//------------------------------------------------------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
    new playercash;
	if(killerid == INVALID_PLAYER_ID) {
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
        ResetPlayerMoney(playerid);
	} else {
	    	SendDeathMessage(killerid,playerid,reason);
			SetPlayerScore(killerid,GetPlayerScore(killerid)+2);
			GameTextForPlayer(playerid,"Y~y~O~b~U ~g~A~y~R~w~E ~r~P~b~W~g~N~y~T!!!",4000,3);
			playercash = GetPlayerMoney(playerid);
			if (playercash > 0)  {
				GivePlayerMoney(killerid, playercash);
				ResetPlayerMoney(playerid);
			}
			else
			{
			}
     	}
 	return 1;
}

/* public OnPlayerDeath(playerid, killerid, reason)
{   haxed by teh mike
	new name[MAX_PLAYER_NAME];
	new string[256];
	new deathreason[20];
	new playercash;
	GetPlayerName(playerid, name, sizeof(name));
	GetWeaponName(reason, deathreason, 20);
	if (killerid == INVALID_PLAYER_ID) {
	    switch (reason) {
			case WEAPON_DROWN:
			{
                format(string, sizeof(string), "*** %s drowned.)", name);
			}
			default:
			{
			    if (strlen(deathreason) > 0) {
					format(string, sizeof(string), "*** %s died. (%s)", name, deathreason);
				} else {
				    format(string, sizeof(string), "*** %s died.", name);
				}
			}
		}
	}
	else {
	new killer[MAX_PLAYER_NAME];
	GetPlayerName(killerid, killer, sizeof(killer));
	if (strlen(deathreason) > 0) {
		format(string, sizeof(string), "*** %s killed %s. (%s)", killer, name, deathreason);
		} else {
				format(string, sizeof(string), "*** %s killed %s.", killer, name);
			}
		}
	SendClientMessageToAll(COLOR_RED, string);
		{
		playercash = GetPlayerMoney(playerid);
		if (playercash > 0)
		{
			GivePlayerMoney(killerid, playercash);
			ResetPlayerMoney(playerid);
		}
		else
		{
		}
	}
 	return 1;
}*/

//------------------------------------------------------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	iSpawnSet[playerid] = 0;
	SetupPlayerForClassSelection(playerid);
	return 1;
}
public SetupPlayerForClassSelection(playerid)
{
 	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

public GameModeExitFunc()
{
	GameModeExit();
}

public OnGameModeInit()
{
	SetGameModeText("Greek Stunt/Dm/Race/Parkour");
	
	ShowPlayerMarkers(1);
	ShowNameTags(1);
	EnableStuntBonusForAll(0);

	//= - = - = - = - = - = - = CLASSES = - = - = - = - = - = - = - = - = - = - = //
    AddPlayerClass(217,403.447265,2466.154296,16.506214,115.0000,0,0,0,1,0,0);
	AddPlayerClass(250,403.447265,2466.154296,16.506214,115.0000,0,0,0,1,0,0);
	AddPlayerClass(7,403.447265,2466.154296,16.506214,115.0000,0,0,0,1,0,0);
	AddPlayerClass(101,403.447265,2466.154296,16.506214,115.0000,0,0,0,1,0,0);
	AddPlayerClass(170,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(73,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(180,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(184,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(185,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(188,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(29,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(30,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(66,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(100,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(247,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(248,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(254,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(12,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(172,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(150,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(91,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(93,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(102,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(105,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(108,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(115,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(117,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(112,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(125,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(127,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(64,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(63,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(85,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(152,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(178,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);
	AddPlayerClass(264,403.447265,2466.154296,16.506214,115.0000,24,331,0,1,0,0);

	// Car Spawns

	AddStaticVehicle(451,2040.0520,1319.2799,10.3779,183.2439,16,16);
	AddStaticVehicle(429,2040.5247,1359.2783,10.3516,177.1306,13,13);
	AddStaticVehicle(421,2110.4102,1398.3672,10.7552,359.5964,13,13);
	AddStaticVehicle(411,2074.9624,1479.2120,10.3990,359.6861,64,64);
	AddStaticVehicle(477,2075.6038,1666.9750,10.4252,359.7507,94,94);
	AddStaticVehicle(541,2119.5845,1938.5969,10.2967,181.9064,22,22);
	AddStaticVehicle(541,1843.7881,1216.0122,10.4556,270.8793,60,1);
	AddStaticVehicle(402,1944.1003,1344.7717,8.9411,0.8168,30,30);
	AddStaticVehicle(402,1679.2278,1316.6287,10.6520,180.4150,90,90);
	AddStaticVehicle(415,1685.4872,1751.9667,10.5990,268.1183,25,1);
	AddStaticVehicle(411,2034.5016,1912.5874,11.9048,0.2909,123,1);
	AddStaticVehicle(411,2172.1682,1988.8643,10.5474,89.9151,116,1);
	AddStaticVehicle(429,2245.5759,2042.4166,10.5000,270.7350,14,14);
	AddStaticVehicle(477,2361.1538,1993.9761,10.4260,178.3929,101,1);
	AddStaticVehicle(550,2221.9946,1998.7787,9.6815,92.6188,53,53);
	AddStaticVehicle(558,2243.3833,1952.4221,14.9761,359.4796,116,1);
	AddStaticVehicle(587,2276.7085,1938.7263,31.5046,359.2321,40,1);
	AddStaticVehicle(587,2602.7769,1853.0667,10.5468,91.4813,43,1);
	AddStaticVehicle(603,2610.7600,1694.2588,10.6585,89.3303,69,1);
	AddStaticVehicle(587,2635.2419,1075.7726,10.5472,89.9571,53,1);
	AddStaticVehicle(437,2577.2354,1038.8063,10.4777,181.7069,35,1);
	AddStaticVehicle(535,2039.1257,1545.0879,10.3481,359.6690,123,1);
	AddStaticVehicle(535,2009.8782,2411.7524,10.5828,178.9618,66,1);
	AddStaticVehicle(429,2010.0841,2489.5510,10.5003,268.7720,1,2);
	AddStaticVehicle(415,2076.4033,2468.7947,10.5923,359.9186,36,1);
	AddStaticVehicle(487,2093.2754,2414.9421,74.7556,89.0247,26,57);
	AddStaticVehicle(506,2352.9026,2577.9768,10.5201,0.4091,7,7);
	AddStaticVehicle(506,2166.6963,2741.0413,10.5245,89.7816,52,52);
	AddStaticVehicle(411,1960.9989,2754.9072,10.5473,200.4316,112,1);
	AddStaticVehicle(429,1919.5863,2760.7595,10.5079,100.0753,2,1);
	AddStaticVehicle(415,1673.8038,2693.8044,10.5912,359.7903,40,1);
	AddStaticVehicle(402,1591.0482,2746.3982,10.6519,172.5125,30,30);
	AddStaticVehicle(603,1580.4537,2838.2886,10.6614,181.4573,75,77);
	AddStaticVehicle(550,1555.2734,2750.5261,10.6388,91.7773,62,62);
	AddStaticVehicle(535,1455.9305,2878.5288,10.5837,181.0987,118,1);
	AddStaticVehicle(477,1537.8425,2578.0525,10.5662,0.0650,121,1);
	AddStaticVehicle(451,1433.1594,2607.3762,10.3781,88.0013,16,16);
	AddStaticVehicle(603,2223.5898,1288.1464,10.5104,182.0297,18,1);
	AddStaticVehicle(558,2451.6707,1207.1179,10.4510,179.8960,24,1);
	AddStaticVehicle(550,2461.7253,1357.9705,10.6389,180.2927,62,62);
	AddStaticVehicle(558,2461.8162,1629.2268,10.4496,181.4625,117,1);
	AddStaticVehicle(477,2395.7554,1658.9591,10.5740,359.7374,0,1);
	AddStaticVehicle(404,1553.3696,1020.2884,10.5532,270.6825,119,50);
	AddStaticVehicle(400,1380.8304,1159.1782,10.9128,355.7117,123,1);
	AddStaticVehicle(418,1383.4630,1035.0420,10.9131,91.2515,117,227);
	AddStaticVehicle(404,1445.4526,974.2831,10.5534,1.6213,109,100);
	AddStaticVehicle(400,1704.2365,940.1490,10.9127,91.9048,113,1);
	AddStaticVehicle(404,1658.5463,1028.5432,10.5533,359.8419,101,101);
	AddStaticVehicle(581,1677.6628,1040.1930,10.4136,178.7038,58,1);
	AddStaticVehicle(581,1383.6959,1042.2114,10.4121,85.7269,66,1);
	AddStaticVehicle(581,1064.2332,1215.4158,10.4157,177.2942,72,1);
	AddStaticVehicle(581,1111.4536,1788.3893,10.4158,92.4627,72,1);
	AddStaticVehicle(522,953.2818,1806.1392,8.2188,235.0706,3,8);
	AddStaticVehicle(522,995.5328,1886.6055,10.5359,90.1048,3,8);
	AddStaticVehicle(521,993.7083,2267.4133,11.0315,1.5610,75,13);
	AddStaticVehicle(535,1439.5662,1999.9822,10.5843,0.4194,66,1);
	AddStaticVehicle(522,1430.2354,1999.0144,10.3896,352.0951,6,25);
	AddStaticVehicle(522,2156.3540,2188.6572,10.2414,22.6504,6,25);
	AddStaticVehicle(598,2277.6846,2477.1096,10.5652,180.1090,0,1);
	AddStaticVehicle(598,2268.9888,2443.1697,10.5662,181.8062,0,1);
	AddStaticVehicle(598,2256.2891,2458.5110,10.5680,358.7335,0,1);
	AddStaticVehicle(598,2251.6921,2477.0205,10.5671,179.5244,0,1);
	AddStaticVehicle(523,2294.7305,2441.2651,10.3860,9.3764,0,0);
	AddStaticVehicle(523,2290.7268,2441.3323,10.3944,16.4594,0,0);
	AddStaticVehicle(523,2295.5503,2455.9656,2.8444,272.6913,0,0);
	AddStaticVehicle(522,2476.7900,2532.2222,21.4416,0.5081,8,82);
	AddStaticVehicle(522,2580.5320,2267.9595,10.3917,271.2372,8,82);
	AddStaticVehicle(522,2814.4331,2364.6641,10.3907,89.6752,36,105);
	AddStaticVehicle(535,2827.4143,2345.6953,10.5768,270.0668,97,1);
	AddStaticVehicle(521,1670.1089,1297.8322,10.3864,359.4936,87,118);
	AddStaticVehicle(487,1614.7153,1548.7513,11.2749,347.1516,58,8);
	AddStaticVehicle(487,1647.7902,1538.9934,11.2433,51.8071,0,8);
	AddStaticVehicle(487,1608.3851,1630.7268,11.2840,174.5517,58,8);
	AddStaticVehicle(476,1283.0006,1324.8849,9.5332,275.0468,7,6); //11.5332
	AddStaticVehicle(476,1283.5107,1361.3171,9.5382,271.1684,1,6); //11.5382
	AddStaticVehicle(476,1283.6847,1386.5137,11.5300,272.1003,89,91);
	AddStaticVehicle(476,1288.0499,1403.6605,11.5295,243.5028,119,117);
	AddStaticVehicle(415,1319.1038,1279.1791,10.5931,0.9661,62,1);
	AddStaticVehicle(521,1710.5763,1805.9275,10.3911,176.5028,92,3);
	AddStaticVehicle(521,2805.1650,2027.0028,10.3920,357.5978,92,3);
	AddStaticVehicle(535,2822.3628,2240.3594,10.5812,89.7540,123,1);
	AddStaticVehicle(521,2876.8013,2326.8418,10.3914,267.8946,115,118);
	AddStaticVehicle(429,2842.0554,2637.0105,10.5000,182.2949,1,3);
	AddStaticVehicle(549,2494.4214,2813.9348,10.5172,316.9462,72,39);
	AddStaticVehicle(549,2327.6484,2787.7327,10.5174,179.5639,75,39);
	AddStaticVehicle(549,2142.6970,2806.6758,10.5176,89.8970,79,39);
	AddStaticVehicle(521,2139.7012,2799.2114,10.3917,229.6327,25,118);
	AddStaticVehicle(521,2104.9446,2658.1331,10.3834,82.2700,36,0);
	AddStaticVehicle(521,1914.2322,2148.2590,10.3906,267.7297,36,0);
	AddStaticVehicle(549,1904.7527,2157.4312,10.5175,183.7728,83,36);
	AddStaticVehicle(549,1532.6139,2258.0173,10.5176,359.1516,84,36);
	AddStaticVehicle(521,1534.3204,2202.8970,10.3644,4.9108,118,118);
	AddStaticVehicle(549,1613.1553,2200.2664,10.5176,89.6204,89,35);
	AddStaticVehicle(400,1552.1292,2341.7854,10.9126,274.0815,101,1);
	AddStaticVehicle(404,1637.6285,2329.8774,10.5538,89.6408,101,101);
	AddStaticVehicle(400,1357.4165,2259.7158,10.9126,269.5567,62,1);
	AddStaticVehicle(411,1281.7458,2571.6719,10.5472,270.6128,106,1);
	AddStaticVehicle(522,1305.5295,2528.3076,10.3955,88.7249,3,8);
	AddStaticVehicle(521,993.9020,2159.4194,10.3905,88.8805,74,74);
	AddStaticVehicle(415,1512.7134,787.6931,10.5921,359.5796,75,1);
	AddStaticVehicle(522,2299.5872,1469.7910,10.3815,258.4984,3,8);
	AddStaticVehicle(522,2133.6428,1012.8537,10.3789,87.1290,3,8);
	
	//Monday 13th Additions ~ Pro_Drifter
	AddStaticVehicle(415,2266.7336,648.4756,11.0053,177.8517,0,1); //
	AddStaticVehicle(461,2404.6636,647.9255,10.7919,183.7688,53,1); //
	AddStaticVehicle(506,2628.1047,746.8704,10.5246,352.7574,3,3); //
	AddStaticVehicle(549,2817.6445,928.3469,10.4470,359.5235,72,39); //
	// --- uncommented
	AddStaticVehicle(562,1919.8829,947.1886,10.4715,359.4453,11,1); //
	AddStaticVehicle(562,1881.6346,1006.7653,10.4783,86.9967,11,1); //
	AddStaticVehicle(562,2038.1044,1006.4022,10.4040,179.2641,11,1); //
	AddStaticVehicle(562,2038.1614,1014.8566,10.4057,179.8665,11,1); //
	AddStaticVehicle(562,2038.0966,1026.7987,10.4040,180.6107,11,1); //
	// --- uncommented end

	//Uber haxed
	AddStaticVehicle(422,9.1065,1165.5066,19.5855,2.1281,101,25); //
	AddStaticVehicle(463,19.8059,1163.7103,19.1504,346.3326,11,11); //
	AddStaticVehicle(463,12.5740,1232.2848,18.8822,121.8670,22,22); //
	//AddStaticVehicle(434,-110.8473,1133.7113,19.7091,359.7000,2,2); //hotknife
	AddStaticVehicle(586,69.4633,1217.0189,18.3304,158.9345,10,1); //
	AddStaticVehicle(586,-199.4185,1223.0405,19.2624,176.7001,25,1); //
	//AddStaticVehicle(605,-340.2598,1177.4846,19.5565,182.6176,43,8); // SMASHED UP CAR
	AddStaticVehicle(476,325.4121,2538.5999,17.5184,181.2964,71,77); //
	AddStaticVehicle(476,291.0975,2540.0410,17.5276,182.7206,7,6); //
	AddStaticVehicle(576,384.2365,2602.1763,16.0926,192.4858,72,1); //
	AddStaticVehicle(586,423.8012,2541.6870,15.9708,338.2426,10,1); //
	AddStaticVehicle(586,-244.0047,2724.5439,62.2077,51.5825,10,1); //
	AddStaticVehicle(586,-311.1414,2659.4329,62.4513,310.9601,27,1); //

	//uber haxed x 50
	//AddStaticVehicle(406,547.4633,843.0204,-39.8406,285.2948,1,1); // DUMPER
	//AddStaticVehicle(406,625.1979,828.9873,-41.4497,71.3360,1,1); // DUMPER
	//AddStaticVehicle(486,680.7997,919.0510,-40.4735,105.9145,1,1); // DOZER
	//AddStaticVehicle(486,674.3994,927.7518,-40.6087,128.6116,1,1); // DOZER
	AddStaticVehicle(543,596.8064,866.2578,-43.2617,186.8359,67,8); //
	AddStaticVehicle(543,835.0838,836.8370,11.8739,14.8920,8,90); //
	AddStaticVehicle(549,843.1893,838.8093,12.5177,18.2348,79,39); //
	//AddStaticVehicle(605,319.3803,740.2404,6.7814,271.2593,8,90); // SMASHED UP CAR
	AddStaticVehicle(400,-235.9767,1045.8623,19.8158,180.0806,75,1); //
	AddStaticVehicle(599,-211.5940,998.9857,19.8437,265.4935,0,1); //
	AddStaticVehicle(422,-304.0620,1024.1111,19.5714,94.1812,96,25); //
	AddStaticVehicle(588,-290.2229,1317.0276,54.1871,81.7529,1,1); //
	//AddStaticVehicle(424,-330.2399,1514.3022,75.1388,179.1514,2,2); //BF INJECT
	AddStaticVehicle(451,-290.3145,1567.1534,75.0654,133.1694,61,61); //
	AddStaticVehicle(470,280.4914,1945.6143,17.6317,310.3278,43,0); //
	AddStaticVehicle(470,272.2862,1949.4713,17.6367,285.9714,43,0); //
	AddStaticVehicle(470,271.6122,1961.2386,17.6373,251.9081,43,0); //
	AddStaticVehicle(470,279.8705,1966.2362,17.6436,228.4709,43,0); //
	//AddStaticVehicle(548,292.2317,1923.6440,19.2898,235.3379,1,1); // CARGOBOB
	AddStaticVehicle(433,277.6437,1985.7559,18.0772,270.4079,43,0); //
	AddStaticVehicle(433,277.4477,1994.8329,18.0773,267.7378,43,0); //
	//AddStaticVehicle(432,275.9634,2024.3629,17.6516,270.6823,43,0); // Tank (can cause scary shit to go down)
	AddStaticVehicle(568,-441.3438,2215.7026,42.2489,191.7953,41,29); //
	AddStaticVehicle(568,-422.2956,2225.2612,42.2465,0.0616,41,29); //
	AddStaticVehicle(568,-371.7973,2234.5527,42.3497,285.9481,41,29); //
	AddStaticVehicle(568,-360.1159,2203.4272,42.3039,113.6446,41,29); //
	AddStaticVehicle(468,-660.7385,2315.2642,138.3866,358.7643,6,6); //
	AddStaticVehicle(460,-1029.2648,2237.2217,42.2679,260.5732,1,3); //

	//Uber haxed x 100

    // --- uncommented
	AddStaticVehicle(419,95.0568,1056.5530,13.4068,192.1461,13,76); //
	AddStaticVehicle(429,114.7416,1048.3517,13.2890,174.9752,1,2); //
	//AddStaticVehicle(466,124.2480,1075.1835,13.3512,174.5334,78,76); // exceeds model limit
	AddStaticVehicle(411,-290.0065,1759.4958,42.4154,89.7571,116,1); //
	// --- uncommented end
	AddStaticVehicle(522,-302.5649,1777.7349,42.2514,238.5039,6,25); //
	AddStaticVehicle(522,-302.9650,1776.1152,42.2588,239.9874,8,82); //
	AddStaticVehicle(533,-301.0404,1750.8517,42.3966,268.7585,75,1); //
	AddStaticVehicle(535,-866.1774,1557.2700,23.8319,269.3263,31,1); //
	AddStaticVehicle(550,-799.3062,1518.1556,26.7488,88.5295,53,53); //
	AddStaticVehicle(521,-749.9730,1589.8435,26.5311,125.6508,92,3); //
	AddStaticVehicle(522,-867.8612,1544.5282,22.5419,296.0923,3,3); //
	AddStaticVehicle(554,-904.2978,1553.8269,25.9229,266.6985,34,30); //
	AddStaticVehicle(521,-944.2642,1424.1603,29.6783,148.5582,92,3); //
	// Exceeds model limit, cars need model adjustments
	// --- uncommented
	AddStaticVehicle(429,-237.7157,2594.8804,62.3828,178.6802,1,2); //
	//AddStaticVehicle(431,-160.5815,2693.7185,62.2031,89.4133,47,74); //
	AddStaticVehicle(463,-196.3012,2774.4395,61.4775,303.8402,22,22); //
	//AddStaticVehicle(483,-204.1827,2608.7368,62.6956,179.9914,1,5); //
	//AddStaticVehicle(490,-295.4756,2674.9141,62.7434,359.3378,0,0); //
	//AddStaticVehicle(500,-301.5293,2687.6013,62.7723,87.9509,28,119); //
	//AddStaticVehicle(500,-301.6699,2680.3293,62.7393,89.7925,13,119); //
	AddStaticVehicle(519,-1341.1079,-254.3787,15.0701,321.6338,1,1); //
	AddStaticVehicle(519,-1371.1775,-232.3967,15.0676,315.6091,1,1); //
	//AddStaticVehicle(552,-1396.2028,-196.8298,13.8434,286.2720,56,56); //
	//AddStaticVehicle(552,-1312.4509,-284.4692,13.8417,354.3546,56,56); //
	//AddStaticVehicle(552,-1393.5995,-521.0770,13.8441,187.1324,56,56); //
	//AddStaticVehicle(513,-1355.6632,-488.9562,14.7157,191.2547,48,18); //
	//AddStaticVehicle(513,-1374.4580,-499.1462,14.7482,220.4057,54,34); //
	//AddStaticVehicle(553,-1197.8773,-489.6715,15.4841,0.4029,91,87); //
	//AddStaticVehicle(553,1852.9989,-2385.4009,14.8827,200.0707,102,119); //
	//AddStaticVehicle(583,1879.9594,-2349.1919,13.0875,11.0992,1,1); //
	//AddStaticVehicle(583,1620.9697,-2431.0752,13.0951,126.3341,1,1); //
	//AddStaticVehicle(583,1545.1564,-2409.2114,13.0953,23.5581,1,1); //
	//AddStaticVehicle(583,1656.3702,-2651.7913,13.0874,352.7619,1,1); //
	AddStaticVehicle(519,1642.9850,-2425.2063,14.4744,159.8745,1,1); //
	AddStaticVehicle(519,1734.1311,-2426.7563,14.4734,172.2036,1,1); //
	// --- uncommented end
	
	AddStaticVehicle(415,-680.9882,955.4495,11.9032,84.2754,36,1); //
	AddStaticVehicle(460,-816.3951,2222.7375,43.0045,268.1861,1,3); //
	AddStaticVehicle(460,-94.6885,455.4018,1.5719,250.5473,1,3); //
	AddStaticVehicle(460,1624.5901,565.8568,1.7817,200.5292,1,3); //
	AddStaticVehicle(460,1639.3567,572.2720,1.5311,206.6160,1,3); //
	AddStaticVehicle(460,2293.4219,517.5514,1.7537,270.7889,1,3); //
	AddStaticVehicle(460,2354.4690,518.5284,1.7450,270.2214,1,3); //
	AddStaticVehicle(460,772.4293,2912.5579,1.0753,69.6706,1,3); //

	// 22/4 UPDATE
	AddStaticVehicle(560,2133.0769,1019.2366,10.5259,90.5265,9,39); //
	AddStaticVehicle(560,2142.4023,1408.5675,10.5258,0.3660,17,1); //
	AddStaticVehicle(560,2196.3340,1856.8469,10.5257,179.8070,21,1); //
	AddStaticVehicle(560,2103.4146,2069.1514,10.5249,270.1451,33,0); //
	AddStaticVehicle(560,2361.8042,2210.9951,10.3848,178.7366,37,0); //
	AddStaticVehicle(560,-1993.2465,241.5329,34.8774,310.0117,41,29); //
	AddStaticVehicle(559,-1989.3235,270.1447,34.8321,88.6822,58,8); //
	AddStaticVehicle(559,-1946.2416,273.2482,35.1302,126.4200,60,1); //
	AddStaticVehicle(558,-1956.8257,271.4941,35.0984,71.7499,24,1); //
	AddStaticVehicle(562,-1952.8894,258.8604,40.7082,51.7172,17,1); //
	AddStaticVehicle(411,-1949.8689,266.5759,40.7776,216.4882,112,1); //
	AddStaticVehicle(429,-1988.0347,305.4242,34.8553,87.0725,2,1); //
	AddStaticVehicle(559,-1657.6660,1213.6195,6.9062,282.6953,13,8); //
	AddStaticVehicle(560,-1658.3722,1213.2236,13.3806,37.9052,52,39); //
	AddStaticVehicle(558,-1660.8994,1210.7589,20.7875,317.6098,36,1); //
	AddStaticVehicle(550,-1645.2401,1303.9883,6.8482,133.6013,7,7); //
	AddStaticVehicle(460,-1333.1960,903.7660,1.5568,0.5095,46,32); //
	
	//Base-Cars//
	//= - = - = - = - = - = - = - = -Base= - = - = - = - = - = - = - = - = - =
	AddStaticVehicleEx(522,-1694.40002441,-178.80000305,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1692.40002441,-176.89999390,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1690.00000000,-174.39999390,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1687.50000000,-171.39999390,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(411,-1689.00000000,-179.10000610,13.89999962,316.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1685.50000000,-182.69999695,13.89999962,314.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1681.69995117,-186.69999695,13.89999962,312.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1683.90002441,-174.80000305,13.89999962,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1679.80004883,-170.39999390,13.89999962,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1674.80004883,-165.50000000,13.89999962,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1668.90002441,-159.69999695,13.89999962,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1674.80004883,-185.39999390,13.89999962,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1670.30004883,-181.60000610,13.89999962,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1664.69995117,-177.39999390,13.89999962,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1659.69995117,-172.00000000,13.89999962,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1277.30004883,35.90000153,13.89999962,133.99987793,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1274.90002441,33.29999924,13.89999962,132.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1257.69995117,16.70000076,13.89999962,134.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1254.90002441,14.10000038,13.89999962,130.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(522,-1266.59997559,35.79999924,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1265.30004883,37.29999924,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1263.90002441,38.29999924,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1262.69995117,39.29999924,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1261.30004883,41.40000153,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(451,-1368.30004883,-216.00000000,13.89999962,314.00000000,-1,-1,15); //Turismo
    AddStaticVehicleEx(451,-1371.09997559,-213.10000610,13.89999962,314.00000000,-1,-1,15); //Turismo
    AddStaticVehicleEx(451,-1374.09997559,-209.69999695,13.89999962,314.00000000,-1,-1,15); //Turismo
    AddStaticVehicleEx(411,-1375.19995117,-221.30000305,13.89999962,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1379.09997559,-216.89999390,13.89999962,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1383.09997559,-211.80000305,13.89999962,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1386.69995117,-207.19999695,13.89999962,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(451,-1377.09997559,-206.50000000,13.89999962,314.00000000,-1,-1,15); //Turismo
    AddStaticVehicleEx(451,-1380.69995117,-203.50000000,13.89999962,314.00000000,-1,-1,15); //Turismo
    AddStaticVehicleEx(522,-1339.00000000,-235.69999695,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1341.59997559,-238.10000610,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1344.40002441,-240.80000305,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1347.69995117,-243.69999695,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1342.00000000,-232.39999390,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1344.90002441,-234.89999390,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1347.59997559,-236.80000305,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1351.40002441,-239.89999390,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1345.40002441,-229.10000610,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1348.40002441,-231.30000305,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1350.80004883,-233.10000610,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1354.90002441,-236.00000000,13.80000019,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(556,-1079.09997559,-394.39999390,133.80000305,132.00000000,-1,-1,15); //Monster A
    AddStaticVehicleEx(556,-1091.59997559,-379.50000000,133.30000305,130.00000000,-1,-1,15); //Monster A
    AddStaticVehicleEx(556,-1085.50000000,-386.60000610,133.50000000,132.00000000,-1,-1,15); //Monster A
    AddStaticVehicleEx(495,-1088.59997559,-405.29998779,133.69999695,44.00000000,-1,-1,15); //Sandking
    AddStaticVehicleEx(495,-1081.80004883,-412.29998779,133.69999695,44.00000000,-1,-1,15); //Sandking
    AddStaticVehicleEx(495,-1075.19995117,-419.39999390,133.69999695,44.00000000,-1,-1,15); //Sandking
    AddStaticVehicleEx(495,-1067.80004883,-426.89999390,133.69999695,44.00000000,-1,-1,15); //Sandking
    AddStaticVehicleEx(411,-1041.40002441,-432.50000000,132.69999695,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1045.30004883,-435.60000610,132.80000305,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1049.50000000,-439.10000610,132.69999695,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1054.00000000,-443.50000000,132.80000305,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1058.30004883,-447.39999390,132.69999695,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,-1062.69995117,-451.79998779,132.69999695,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(522,-1087.59997559,-401.79998779,132.60000610,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1085.80004883,-403.89999390,132.60000610,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1083.30004883,-406.39999390,132.60000610,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1081.09997559,-408.79998779,132.60000610,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1079.00000000,-411.10000610,132.60000610,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1076.80004883,-413.60000610,132.60000610,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1074.69995117,-416.00000000,132.60000610,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1072.50000000,-418.29998779,132.60000610,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1070.59997559,-420.60000610,132.60000610,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,-1068.30004883,-422.89999390,132.60000610,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(411,-2645.80004883,1375.00000000,7.00000000,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(405,-2638.03417969,1377.24902344,6.63500309,0.00000000,-1,-1,15); //Sentinel
    AddStaticVehicleEx(411,176.69999695,125.69999695,479.20001221,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,172.30000305,83.09999847,461.60000610,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,2035.59997559,1031.59997559,10.60000038,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,2032.09997559,1031.59997559,10.60000038,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,2035.69995117,1039.59997559,10.60000038,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(411,2032.00000000,1039.59997559,10.60000038,0.00000000,-1,-1,15); //Infernus
    AddStaticVehicleEx(522,2030.09997559,1019.20001221,10.50000000,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,2032.90002441,1019.29998779,10.50000000,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,2035.90002441,1019.29998779,10.50000000,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,2030.09997559,1023.70001221,10.50000000,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,2033.00000000,1023.50000000,10.50000000,0.00000000,-1,-1,15); //NRG-500
    AddStaticVehicleEx(522,2035.90002441,1023.29998779,10.50000000,0.00000000,-1,-1,15); //NRG-500
	
	//AA-Cars//
	//= - = - = - = - = - = - = - = - AA - = - = - = - = - = - = - = - = - = - = -
    AddStaticVehicle(560,423.0288,2444.1753,16.2054,92.5707,78,94); //
    AddStaticVehicle(451,421.9985,2436.8479,16.2069,86.3543,104,105); //
    AddStaticVehicle(522,412.0968,2435.8896,16.0713,353.0256,92,6); //
    AddStaticVehicle(468,409.6525,2435.9021,16.1690,353.8913,62,82); //
    AddStaticVehicle(581,407.1832,2436.0366,16.0979,2.7757,30,65); //
    AddStaticVehicle(504,422.3844,2463.4460,16.2923,86.0307,36,116); //
    AddStaticVehicle(518,387.0022,2437.7019,16.1709,268.8972,101,80); //
    AddStaticVehicle(567,387.1377,2443.7468,16.3678,269.1052,112,26); //
    AddStaticVehicle(444,387.5142,2451.9829,16.8713,269.9064,63,13); //
    AddStaticVehicle(457,386.4349,2465.8608,16.1267,272.7779,114,115); //
    
    //= - = - = - = - = - = - = - = Drift1 = - = - = - = - = - = - = - = - = - =

	AddStaticVehicle(562,-314.8085,1515.3475,75.0552,0.4005,21,63); // drift1
	AddStaticVehicle(562,-317.9107,1515.4402,75.0573,0.0323,21,63); // drift1
	AddStaticVehicle(560,-320.8253,1515.4803,75.0635,358.1215,97,52); // drift1
	AddStaticVehicle(560,-324.0202,1515.3573,75.0647,1.0554,97,52); // drift1
	AddStaticVehicle(411,-327.1777,1515.0216,75.0864,0.2586,76,116); // drift1
	AddStaticVehicle(411,-330.3967,1515.6577,75.0865,0.8246,76,116); // drift1
	AddStaticVehicle(451,-336.5634,1515.6930,75.0658,0.6859,47,59); // drift1
	AddStaticVehicle(451,-339.7101,1515.1934,75.0660,3.0682,47,59); // drift1
	AddStaticVehicle(567,-343.0908,1515.2557,75.2278,0.5762,13,115); // drift1
	AddStaticVehicle(567,-345.9951,1514.8271,75.2275,0.4734,13,115); // drift1
	AddStaticVehicle(567,-265.9650,1542.4081,75.2258,317.0453,13,115); // drift1
	AddStaticVehicle(525,-299.6015,1551.3875,75.2380,222.1306,88,6); // drift1
	AddStaticVehicle(562,-299.6754,1577.3324,75.0568,316.8105,84,75); // drift1
	AddStaticVehicle(562,-297.3412,1575.1957,75.0574,315.9739,84,75); // drift1
	AddStaticVehicle(402,-289.8357,1567.6466,75.1910,314.1659,64,80); // drift1
	AddStaticVehicle(402,-288.0501,1564.7438,75.1910,312.3665,64,80); // drift1
	
	//= - = - = - = - = - = - = -  = - = LVAIR = -  = -  - = - = - = - = - = - = -=//

	AddStaticVehicle(555,1545.8525,1279.9695,10.5429,198.7847,58,1); // lvair
	AddStaticVehicle(562,1555.9055,1276.6128,10.5188,140.2231,84,32); // lvair
	AddStaticVehicle(560,1562.7034,1238.1481,10.5663,43.8187,78,106); // lvair
	AddStaticVehicle(451,1550.5391,1236.5710,10.5640,352.9350,81,69); // lvair
	AddStaticVehicle(411,1568.0648,1267.2999,10.5887,81.2936,98,31); // lvair
	AddStaticVehicle(522,1555.1608,1251.7963,10.4101,151.1115,75,52); // lvair
	AddStaticVehicle(522,1550.0001,1258.5137,10.4241,31.9660,0,7); // lvair
	AddStaticVehicle(429,1566.8311,1247.7180,10.5386,107.6511,72,14); // lvair
	AddStaticVehicle(400,1577.3615,1270.8115,10.9512,56.3328,82,31); // lvair
	AddStaticVehicle(500,1572.7069,1258.0420,10.9744,75.4736,75,57); // lvair
	AddStaticVehicle(592,1548.3582,1468.4407,12.0254,61.1294,1,1); // lvair
	AddStaticVehicle(577,1558.4537,1535.7272,10.7695,294.2584,8,7); // lvair
	AddStaticVehicle(511,1521.3859,1684.5310,12.2009,320.9080,4,90); // lvair
	AddStaticVehicle(519,1393.9277,1230.3252,11.7423,163.8333,1,1); // lvair
	AddStaticVehicle(497,1425.9668,1235.8562,10.9945,9.6130,0,1); // lvair
	AddStaticVehicle(522,1305.8920,1279.5159,10.3887,3.9595,94,5); // lvair
	AddStaticVehicle(522,1309.4117,1279.6000,10.3835,2.5366,87,76); // lvair
	AddStaticVehicle(468,1313.2966,1279.8137,10.4889,7.8633,114,80); // lvair
	AddStaticVehicle(468,1315.7979,1278.8022,10.4887,0.7175,114,80); // lvair
	AddStaticVehicle(471,1318.8672,1280.1680,10.3037,0.2574,118,3); // lvair
	AddStaticVehicle(471,1322.3215,1278.6544,10.3017,348.3136,28,8); // lvair
	AddStaticVehicle(461,1326.2269,1279.1681,10.4095,349.5736,37,1); // lvair
	AddStaticVehicle(461,1329.4777,1279.9113,10.4124,350.3980,37,1); // lvair
	
	//============================San Fierro Airport Map=====================
    // SF ISLAND AIRPORT |/\| MADE BY SEAN_TOWERS (82 OBJECTS, 29 VEHICLES, Map Size: BIG)
    AddStaticVehicleEx(407,-3529.46899414,656.57397461,2.45593739,90.00000000,-1,-1,15); //Firetruck
    AddStaticVehicleEx(407,-3528.63574219,667.06250000,2.45593739,90.00000000,-1,-1,15); //Firetruck
    AddStaticVehicleEx(416,-3531.28320312,674.05413818,2.38551307,88.00000000,-1,-1,15); //Ambulance
    AddStaticVehicleEx(416,-3531.11279297,670.29602051,2.38551307,87.99499512,-1,-1,15); //Ambulance
    AddStaticVehicleEx(407,-3529.25610352,661.76159668,2.45593739,90.00000000,-1,-1,15); //Firetruck
    AddStaticVehicleEx(487,-3538.09082031,565.44604492,2.74937510,0.00000000,-1,-1,15); //Maverick
    AddStaticVehicleEx(487,-3536.59277344,598.90106201,2.74937510,0.00000000,-1,-1,15); //Maverick
    AddStaticVehicleEx(487,-3523.84570312,562.71038818,2.74937510,0.00000000,-1,-1,15); //Maverick
    AddStaticVehicleEx(487,-3545.88183594,584.66796875,2.74937510,0.00000000,-1,-1,15); //Maverick
    AddStaticVehicleEx(563,-3532.99609375,443.03384399,3.36267281,0.00000000,-1,-1,15); //Raindance
    AddStaticVehicleEx(563,-3545.84985352,443.39443970,3.37012482,0.00000000,-1,-1,15); //Raindance
    AddStaticVehicleEx(563,-3519.20312500,441.95285034,3.36267281,0.00000000,-1,-1,15); //Raindance
    AddStaticVehicleEx(519,-3492.18359375,461.46438599,3.08600974,114.00000000,-1,-1,15); //Shamal
    AddStaticVehicleEx(519,-3495.69531250,533.45996094,3.08600974,90.00000000,-1,-1,15); //Shamal
    AddStaticVehicleEx(487,-3525.66992188,582.06152344,2.74937510,0.00000000,-1,-1,15); //Maverick
    AddStaticVehicleEx(487,-3544.74243164,548.82739258,2.74937510,0.00000000,-1,-1,15); //Maverick
    AddStaticVehicleEx(519,-3493.53320312,506.86132812,3.08600974,90.00000000,-1,-1,15); //Shamal
    AddStaticVehicleEx(519,-3492.91577148,440.29699707,3.08600974,120.00000000,-1,-1,15); //Shamal
    AddStaticVehicleEx(593,-3505.27636719,610.33563232,2.63426685,90.00000000,-1,-1,15); //Dodo
    AddStaticVehicleEx(593,-3504.56176758,625.24359131,2.63611984,90.00000000,-1,-1,15); //Dodo
    AddStaticVehicleEx(593,-3505.49121094,596.97949219,2.63426685,90.00000000,-1,-1,15); //Dodo
    AddStaticVehicleEx(513,-3493.55590820,582.80493164,2.87069440,90.00000000,-1,-1,15); //Stunt
    AddStaticVehicleEx(513,-3493.07226562,572.05712891,2.87069440,90.00000000,-1,-1,15); //Stunt
    AddStaticVehicleEx(513,-3492.30664062,551.80615234,2.87069440,90.00000000,-1,-1,15); //Stunt
    AddStaticVehicleEx(513,-3492.64257812,561.78222656,2.87069440,90.00000000,-1,-1,15); //Stunt
    AddStaticVehicleEx(563,-3533.30078125,464.99157715,3.37012482,0.00000000,-1,-1,15); //Raindance
    AddStaticVehicleEx(553,-3534.90942383,343.51220703,4.71937466,0.00000000,-1,-1,15); //Nevada
    AddStaticVehicleEx(553,-3505.50976562,339.50097656,5.55755615,0.00000000,-1,-1,15); //Nevada
    AddStaticVehicleEx(553,-3498.13330078,309.22222900,4.32093716,0.00000000,-1,-1,15); //Nevada
	
	//= - = - = - = - = - = - = - = - - LSAIR = - = - = - = - = - = - = - = - = - =//

	AddStaticVehicle(522,1991.3262,-2619.8123,13.1103,153.1168,108,29); // lsair
	AddStaticVehicle(522,1996.3762,-2615.2332,13.1225,221.3389,121,1); // lsair
	AddStaticVehicle(468,2000.7783,-2618.5313,13.2168,185.4426,110,38); // lsair
	AddStaticVehicle(468,1993.7811,-2626.2231,13.2157,135.6643,30,76); // lsair
	AddStaticVehicle(451,2000.5597,-2628.8347,13.2866,240.5287,68,30); // lsair
	AddStaticVehicle(451,2010.8948,-2619.6362,13.2545,343.8895,88,54); // lsair
	AddStaticVehicle(562,2016.7006,-2615.1633,13.2133,230.1580,121,53); // lsair
	AddStaticVehicle(562,2015.6345,-2631.1377,13.2052,124.0776,42,97); // lsair
	AddStaticVehicle(519,2036.7671,-2627.3669,14.4687,291.0835,1,1); // lsair
	AddStaticVehicle(511,2063.9116,-2625.6165,14.9168,295.2693,7,68); // lsair
	//SFAIR
    AddStaticVehicleEx(522,-1477.4320,-191.4920,13.7136,29.6769,-1,-1,50); //
    AddStaticVehicleEx(522,-1476.0803,-190.3127,13.7189,35.9275,-1,-1,50); //
    AddStaticVehicleEx(522,-1475.1289,-189.2194,13.7199,38.7633,-1,-1,50); //
    AddStaticVehicleEx(411,-1472.2981,-189.6567,13.8755,41.7270,-1,-1,50); //
    AddStaticVehicleEx(411,-1469.5551,-187.1228,13.8755,42.1268,-1,-1,50); //

	
	// 25/4 UPDATE
	AddStaticVehicle(411,113.8611,1068.6182,13.3395,177.1330,116,1); //
	AddStaticVehicle(429,159.5199,1185.1160,14.7324,85.5769,1,2); //
	AddStaticVehicle(411,612.4678,1694.4126,6.7192,302.5539,75,1); //
	AddStaticVehicle(522,661.7609,1720.9894,6.5641,19.1231,6,25); //
	AddStaticVehicle(522,660.0554,1719.1187,6.5642,12.7699,8,82); //
	AddStaticVehicle(567,711.4207,1947.5208,5.4056,179.3810,90,96); //
	AddStaticVehicle(567,1031.8435,1920.3726,11.3369,89.4978,97,96); //
	AddStaticVehicle(567,1112.3754,1747.8737,10.6923,270.9278,102,114); //
	AddStaticVehicle(567,1641.6802,1299.2113,10.6869,271.4891,97,96); //
	AddStaticVehicle(567,2135.8757,1408.4512,10.6867,180.4562,90,96); //
	AddStaticVehicle(567,2262.2639,1469.2202,14.9177,91.1919,99,81); //
	AddStaticVehicle(567,2461.7380,1345.5385,10.6975,0.9317,114,1); //
	AddStaticVehicle(567,2804.4365,1332.5348,10.6283,271.7682,88,64); //
	AddStaticVehicle(560,2805.1685,1361.4004,10.4548,270.2340,17,1); //
	AddStaticVehicle(506,2853.5378,1361.4677,10.5149,269.6648,7,7); //
	AddStaticVehicle(567,2633.9832,2205.7061,10.6868,180.0076,93,64); //
	AddStaticVehicle(567,2119.9751,2049.3127,10.5423,180.1963,93,64); //
	AddStaticVehicle(567,2785.0261,-1835.0374,9.6874,226.9852,93,64); //
	AddStaticVehicle(567,2787.8975,-1876.2583,9.6966,0.5804,99,81); //
	AddStaticVehicle(411,2771.2993,-1841.5620,9.4870,20.7678,116,1); //
	AddStaticVehicle(420,1713.9319,1467.8354,10.5219,342.8006,6,1); // taxi

	AddStaticPickup(371, 15, 1710.3359,1614.3585,10.1191); //para
	AddStaticPickup(371, 15, 1964.4523,1917.0341,130.9375); //para
	AddStaticPickup(371, 15, 2055.7258,2395.8589,150.4766); //para
	AddStaticPickup(371, 15, 2265.0120,1672.3837,94.9219); //para
	AddStaticPickup(371, 15, 2265.9739,1623.4060,94.9219); //para
	
	
CreateObject(4141, -2360.130371, -1617.443359, 490.722839, 0.0000, 0.0000, 337.5006);
CreateObject(1634, -2230.597412, -1739.210083, 480.848785, 0.0000, 0.0000, 213.7500);
CreateObject(1634, -2233.736084, -1741.367065, 480.856537, 0.0000, 0.0000, 213.7500);
CreateObject(1632, -2229.973389, -1747.074707, 485.812164, 20.6265, 0.0000, 213.7500);
CreateObject(1632, -2226.703125, -1744.868408, 485.809479, 20.6265, 0.0000, 213.7500);
CreateObject(5400, -2376.449219, -1646.781616, 487.799500, 0.0000, 0.0000, 123.7499);
CreateObject(5400, -2384.405518, -1652.094238, 487.775635, 0.0000, 0.0000, 123.7499);
CreateObject(5400, -2392.299561, -1657.370605, 487.788940, 0.0000, 0.0000, 123.7499);
CreateObject(5400, -2400.208740, -1662.617310, 487.790070, 0.0000, 0.0000, 123.7499);
CreateObject(5400, -2408.216553, -1667.948608, 487.766205, 0.0000, 0.0000, 123.7499);
CreateObject(5400, -2416.333008, -1673.338135, 487.742340, 0.0000, 0.0000, 123.7499);
CreateObject(5400, -2424.175537, -1678.594238, 487.743469, 0.0000, 0.0000, 123.7499);
CreateObject(5400, -2432.078369, -1683.928345, 487.744598, 0.0000, 0.0000, 123.7499);
CreateObject(5400, -2439.959717, -1689.205933, 487.720734, 0.0000, 0.0000, 123.7499);
CreateObject(5400, -2450.939209, -1696.372803, 487.696869, 0.0000, 0.0000, 130.6255);
CreateObject(5400, -2460.750244, -1704.637817, 487.673004, 0.0000, 0.0000, 136.6416);
CreateObject(5400, -2469.404785, -1713.552368, 487.649139, 0.0000, 0.0000, 142.6577);
CreateObject(5400, -2478.785645, -1725.875854, 487.625275, 0.0000, 0.0000, 153.8305);
CreateObject(5400, -2484.224854, -1736.601929, 487.626404, 0.0000, 0.0000, 158.9871);
CreateObject(5400, -2489.236084, -1749.329468, 487.577545, 0.0000, 0.0000, 166.7221);
CreateObject(5400, -2492.294189, -1761.356079, 487.578674, 0.0000, 0.0000, 171.8787);
CreateObject(5400, -2493.633545, -1770.742432, 487.554810, 0.0000, 0.0000, 171.8787);
CreateObject(5400, -2494.933594, -1779.859619, 487.530945, 0.0000, 0.0000, 171.8787);
CreateObject(5400, -2496.235352, -1789.244141, 487.507080, 0.0000, 0.0000, 171.8787);
CreateObject(5400, -2497.613281, -1798.816284, 487.783142, 354.8434, 0.0000, 171.8787);
CreateObject(5400, -2498.915283, -1808.165771, 486.914276, 354.8434, 0.0000, 171.8787);
CreateObject(5400, -2500.199219, -1817.434937, 485.988098, 354.8434, 0.0000, 171.8787);
CreateObject(5400, -2501.521484, -1826.909302, 485.376770, 349.6868, 0.0000, 171.8787);
CreateObject(5400, -2502.766357, -1835.977539, 483.703796, 349.6868, 0.0000, 171.8787);
CreateObject(5400, -2504.094482, -1844.990479, 481.985931, 349.6868, 0.0000, 171.8787);
CreateObject(5400, -2505.369385, -1854.063354, 480.308746, 349.6868, 0.0000, 171.8787);
CreateObject(5400, -2506.634277, -1862.883057, 478.682404, 349.6868, 0.0000, 171.8787);
CreateObject(5400, -2508.555420, -1875.432251, 477.059631, 349.6868, 0.0000, 177.8949);
CreateObject(5400, -2509.087402, -1886.211304, 475.342834, 349.6868, 0.0000, 180.4732);
CreateObject(5400, -2509.088867, -1900.273804, 473.708435, 349.6868, 0.0000, 189.0676);
CreateObject(5400, -2507.480713, -1911.514526, 472.059875, 349.6868, 0.0000, 192.5054);
CreateObject(10838, -2362.353271, -1680.102173, 498.152344, 0.0000, 0.0000, 33.7500);
CreateObject(5400, -2505.441162, -1920.656494, 470.308716, 349.6868, 0.0000, 192.5054);
CreateObject(5400, -2503.442871, -1929.575806, 468.612366, 349.6868, 0.0000, 192.5054);
CreateObject(5400, -2501.395752, -1938.891968, 466.866577, 349.6868, 0.0000, 192.5054);
CreateObject(5400, -2499.453857, -1947.873291, 465.182404, 349.6868, 0.0000, 192.5054);
CreateObject(5400, -2497.542480, -1956.366455, 463.591095, 349.6868, 0.0000, 192.5054);
CreateObject(5400, -2495.606689, -1965.412964, 461.824371, 349.6868, 0.0000, 192.5054);
CreateObject(5400, -2493.766357, -1973.727783, 460.271057, 349.6868, 0.0000, 192.5054);
CreateObject(5400, -2491.806152, -1982.846924, 458.560211, 349.6868, 0.0000, 192.5054);
CreateObject(5400, -2490.083740, -1989.617676, 456.872711, 349.6868, 0.0000, 188.9904);
CreateObject(5400, -2488.833984, -1995.840454, 455.190582, 349.6868, 0.0000, 184.6932);
CreateObject(5400, -2488.027588, -2002.648804, 453.551514, 349.6868, 0.0000, 181.2554);
CreateObject(5400, -2487.337158, -2007.502441, 451.989166, 349.6868, 0.0000, 175.2393);
CreateObject(5400, -2487.492188, -2013.560669, 450.364410, 349.6868, 0.0000, 170.9421);
CreateObject(5400, -2488.156738, -2019.923950, 448.727600, 349.6868, 0.0000, 166.6449);
CreateObject(5400, -2488.363525, -2023.919067, 447.129944, 349.6868, 0.0000, 158.9099);
CreateObject(5400, -2489.107666, -2027.880859, 445.469025, 349.6868, 0.0000, 151.1749);
CreateObject(5400, -2490.807129, -2032.168823, 443.797974, 349.6868, 0.0000, 144.2994);
CreateObject(5400, -2496.315918, -2039.788330, 442.045593, 349.6868, 0.0000, 144.2994);
CreateObject(5400, -2501.604980, -2047.159424, 440.329010, 349.6868, 0.0000, 144.2994);
CreateObject(5400, -2506.816895, -2054.406738, 438.700714, 349.6868, 0.0000, 144.2994);
CreateObject(5400, -2511.909668, -2061.551758, 437.073273, 349.6868, 0.0000, 144.2994);
CreateObject(5400, -2517.132813, -2068.767090, 435.382874, 349.6868, 0.0000, 144.2994);
CreateObject(1634, -2497.793457, -2102.211914, 429.110382, 347.1084, 0.0000, 146.2500);
CreateObject(1634, -2494.449707, -2104.116943, 429.829742, 347.1084, 19.7670, 158.3594);
CreateObject(1634, -2500.774902, -2099.950195, 429.704010, 347.1084, 341.0924, 135.0000);
CreateObject(11556, -2360.072998, -1655.829468, 488.596924, 0.0000, 0.0000, 33.7500);
CreateObject(11556, -2312.014160, -1594.186768, 488.378845, 0.0000, 0.0000, 45.0000);
CreateObject(13593, -2339.845947, -1630.191895, 483.444702, 0.0000, 0.0000, 334.0623);
CreateObject(13593, -2338.623535, -1627.384521, 485.460571, 24.0642, 0.0000, 334.0623);
CreateObject(13593, -2337.760010, -1625.438354, 488.588593, 44.6907, 0.0000, 334.0623);
CreateObject(13593, -2337.480469, -1624.528809, 492.029083, 66.1766, 0.0000, 334.0623);
CreateObject(3502, -2282.026611, -1616.445190, 483.353729, 0.0000, 0.0000, 281.2500);
CreateObject(11556, -2299.861816, -1600.513184, 481.749207, 0.0000, 0.0000, 315.0000);
CreateObject(3502, -2273.420166, -1614.728027, 483.305878, 0.0000, 0.0000, 281.2500);
CreateObject(3502, -2265.134277, -1613.072998, 483.307953, 0.0000, 0.0000, 281.2500);
CreateObject(3502, -2256.733643, -1611.454346, 483.309631, 0.0000, 0.0000, 281.2500);
CreateObject(3502, -2248.553955, -1609.830688, 482.131744, 344.5301, 0.0000, 281.2500);
CreateObject(3502, -2240.390625, -1608.231934, 479.747284, 344.5301, 0.0000, 281.2500);
CreateObject(3502, -2232.359619, -1606.658081, 477.502869, 344.5301, 0.0000, 281.2500);
CreateObject(3502, -2224.856445, -1605.129272, 475.335846, 344.5301, 0.0000, 281.2500);
CreateObject(3502, -2216.702881, -1603.475220, 473.007416, 344.5301, 0.0000, 281.2500);
CreateObject(3502, -2208.439941, -1601.821533, 470.648315, 344.5301, 0.0000, 281.2500);
CreateObject(3502, -2200.289795, -1600.193481, 467.442627, 334.2169, 0.0000, 281.2500);
CreateObject(3502, -2192.860596, -1598.719238, 463.722809, 334.2169, 0.0000, 281.2500);
CreateObject(3502, -2185.204590, -1597.188232, 459.844849, 334.2169, 0.0000, 281.2500);
CreateObject(3502, -2177.621094, -1595.722534, 456.062866, 334.2169, 0.0000, 281.2500);
CreateObject(3502, -2170.324951, -1593.512939, 452.355835, 334.2169, 0.0000, 292.5000);
CreateObject(3502, -2163.593506, -1589.956299, 448.674652, 334.2169, 0.0000, 303.7500);
CreateObject(3502, -2157.631348, -1585.133179, 444.893585, 334.2169, 0.0000, 315.0000);
CreateObject(3502, -2152.914063, -1579.351929, 441.221252, 334.2169, 0.0000, 326.2500);
CreateObject(3502, -2149.270752, -1572.612671, 437.389221, 334.2169, 0.0000, 337.5000);
CreateObject(3502, -2147.111328, -1565.317383, 433.557251, 334.2169, 0.0000, 348.7500);
CreateObject(2714, -2286.802490, -1611.892090, 484.581024, 0.0000, 0.0000, 281.2500);
CreateObject(2714, -2284.775391, -1622.061646, 484.384338, 0.0000, 0.0000, 281.2500);
CreateObject(3462, -2286.330078, -1619.662354, 483.012146, 0.0000, 0.0000, 348.7500);
CreateObject(3462, -2286.777832, -1614.945190, 482.907227, 0.0000, 0.0000, 22.5000);
CreateObject(3502, -2146.453125, -1557.883545, 429.882172, 334.2169, 0.0000, 0.0000);
CreateObject(3502, -2147.189941, -1550.209229, 426.062622, 334.2169, 0.0000, 11.2500);
CreateObject(3502, -2149.393555, -1542.733276, 422.169128, 334.2169, 0.0000, 22.5000);
CreateObject(3502, -2152.377686, -1535.623779, 419.972992, 355.7028, 0.0000, 22.5000);
CreateObject(3502, -2155.652100, -1527.725464, 419.300995, 355.7028, 0.0000, 22.5000);
CreateObject(3502, -2158.838867, -1520.066406, 418.747772, 355.7028, 0.0000, 22.5000);
CreateObject(3502, -2162.074951, -1512.313354, 418.051147, 355.7028, 0.0000, 22.5000);
CreateObject(3502, -2165.271484, -1504.598999, 417.343842, 355.7028, 0.0000, 22.5000);
CreateObject(3502, -2168.399902, -1497.069336, 416.689667, 355.7028, 0.0000, 22.5000);
CreateObject(3502, -2170.774902, -1489.200073, 416.107513, 355.7028, 0.0000, 11.2500);
CreateObject(3502, -2171.664551, -1480.730225, 415.375916, 355.7028, 0.0000, 0.0000);
CreateObject(3502, -2170.828125, -1472.208496, 414.622620, 355.7028, 0.0000, 348.7500);
CreateObject(3502, -2168.418701, -1464.190918, 413.957642, 355.7028, 0.0000, 337.5000);
CreateObject(3502, -2164.486328, -1456.726440, 413.281067, 355.7028, 0.0000, 326.2500);
CreateObject(3502, -2159.139648, -1450.206543, 412.663940, 355.7028, 0.0000, 315.0000);
CreateObject(3502, -2152.878418, -1445.214722, 412.062775, 355.7028, 0.0000, 303.7500);
CreateObject(3502, -2146.393555, -1440.839111, 410.232605, 339.3735, 0.0000, 303.7500);
CreateObject(3502, -2140.469482, -1436.957642, 406.089874, 322.1848, 0.0000, 303.7500);
CreateObject(3502, -2135.852539, -1433.905273, 399.728760, 300.6989, 0.0000, 303.7500);
CreateObject(3502, -2133.194092, -1432.074951, 391.614716, 282.6508, 0.0000, 303.7500);
CreateObject(3502, -2132.386230, -1431.573486, 383.365387, 270.6186, 0.0000, 315.0000);
CreateObject(3502, -2132.373291, -1431.557983, 375.113373, 270.6186, 0.0000, 315.0000);
CreateObject(11556, -2327.021240, -1699.908081, 487.269867, 0.0000, 0.0000, 146.2501);
CreateObject(8330, -2298.533203, -1591.616089, 492.128601, 0.0000, 0.0000, 326.2500);
CreateObject(8323, -2326.952637, -1708.703979, 499.986267, 0.0000, 0.0000, 67.5000);
CreateObject(7910, -2259.713379, -1734.165771, 489.135864, 0.0000, 0.0000, 135.0000);
CreateObject(3554, -2285.502686, -1617.236084, 490.904358, 0.0000, 0.0000, 101.2500);
CreateObject(1634, -2237.096680, -1743.847046, 480.928589, 0.0000, 0.0000, 213.7500);
CreateObject(1632, -2233.454834, -1749.405151, 485.807831, 20.6265, 0.0000, 213.7500);
CreateObject(645, -2264.101563, -1685.978027, 479.808472, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2258.602295, -1692.309326, 479.595703, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2253.403320, -1697.296631, 479.555786, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2247.557617, -1702.831421, 479.361725, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2241.750000, -1709.016357, 479.085022, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2327.255127, -1599.960571, 491.879089, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2319.240967, -1583.836304, 493.802216, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2310.882324, -1573.094482, 493.180206, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2279.347656, -1575.279541, 485.599731, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2278.167969, -1600.240723, 491.677032, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2252.139648, -1729.457764, 478.535492, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2256.616943, -1724.622070, 478.278320, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2260.731689, -1720.601318, 478.254425, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2265.024902, -1715.652832, 478.187378, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2269.905273, -1710.816040, 478.041138, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2276.039795, -1705.619385, 477.946167, 0.0000, 0.0000, 0.0000);
CreateObject(5275, -2214.081787, -1682.197998, 479.135406, 0.0000, 0.0000, 67.5000);
CreateObject(5679, -2141.008301, -1762.109131, 382.653778, 63.5983, 359.1406, 22.5000);
CreateObject(5679, -2088.633789, -1838.086426, 186.885437, 63.5983, 359.1406, 45.0000);
CreateObject(3426, -2345.762939, -1586.791260, 481.416473, 0.0000, 0.0000, 67.5000);
CreateObject(3472, -2368.675293, -1668.737793, 478.285828, 0.0000, 0.0000, 236.2501);
CreateObject(3472, -2353.295654, -1690.245117, 478.169891, 0.0000, 0.0000, 180.0000);
CreateObject(7073, -2332.894287, -1611.069458, 521.743835, 0.0000, 0.0000, 337.5000);
CreateObject(7392, -2345.179688, -1638.988403, 520.191345, 68.7549, 0.0000, 337.5000);
CreateObject(13667, -2430.913574, -1618.116943, 540.335876, 0.0000, 0.0000, 348.7500);
CreateObject(1633, -2280.420410, -1629.240112, 483.629822, 0.0000, 0.0000, 281.2500);
CreateObject(1633, -2279.642578, -1633.203003, 483.616425, 0.0000, 0.0000, 281.2500);
CreateObject(18450, -2237.474365, -1624.525391, 484.356293, 0.0000, 0.0000, 11.2500);
CreateObject(1633, -2278.866943, -1636.912598, 483.624451, 0.0000, 0.0000, 281.2500);
CreateObject(18450, -2159.544922, -1609.048584, 484.292664, 0.0000, 0.0000, 11.2500);
CreateObject(18450, -2085.863281, -1594.340942, 466.055298, 0.0000, 27.5020, 11.2500);
CreateObject(18450, -2017.283936, -1580.760132, 429.594696, 0.0000, 27.5020, 11.2500);
CreateObject(18450, -1948.144531, -1566.961182, 392.835815, 0.0000, 27.5020, 11.2500);
CreateObject(18450, -1894.046875, -1556.221802, 339.864716, 0.0000, 60.1605, 11.2500);
CreateObject(18450, -1855.666504, -1548.578857, 271.528900, 0.0000, 60.1605, 11.2500);
CreateObject(18450, -1816.814453, -1540.759521, 202.359253, 0.0000, 60.1605, 11.2500);
CreateObject(18450, -1778.687988, -1533.184448, 134.423080, 0.0000, 60.1605, 11.2500);
CreateObject(18450, -1740.288940, -1525.563599, 66.051758, 0.0000, 60.1605, 11.2500);
CreateObject(17310, -1719.812500, -1523.509766, 41.337769, 0.0000, 204.5464, 11.2500);
CreateObject(17310, -1720.633911, -1519.436279, 41.249805, 0.0000, 204.5464, 11.2500);
CreateObject(17310, -1691.009766, -1513.507446, 44.778816, 0.0000, 141.8072, 11.2500);
CreateObject(17310, -1690.075439, -1517.431152, 44.831322, 0.0000, 141.8072, 11.2500);
CreateObject(18450, -2233.491211, -1645.209473, 488.717743, 0.0000, 0.0000, 11.2500);
CreateObject(1655, -2281.823486, -1650.224365, 482.539764, 0.0000, 0.0000, 281.2500);
CreateObject(1655, -2280.271240, -1657.798218, 482.554962, 0.0000, 0.0000, 281.2500);
CreateObject(1655, -2275.937256, -1649.139160, 486.242767, 17.1887, 0.0000, 281.2500);
CreateObject(1655, -2274.455811, -1656.617798, 486.201996, 17.1887, 0.0000, 281.2500);
CreateObject(18450, -2155.521484, -1629.682007, 488.705383, 0.0000, 0.0000, 11.2500);
CreateObject(18450, -2078.244629, -1614.349243, 488.668030, 0.0000, 0.0000, 11.2500);
CreateObject(18450, -2024.597412, -1603.705688, 451.781799, 0.0000, 67.8954, 11.2500);
CreateObject(18450, -1995.415894, -1597.859009, 378.413666, 0.0000, 67.8954, 11.2500);
CreateObject(18450, -1966.132324, -1592.010620, 304.841461, 0.0000, 67.8954, 11.2500);
CreateObject(18450, -1937.133423, -1586.129761, 231.839111, 0.0000, 67.8954, 11.2500);
CreateObject(18450, -1930.925659, -1584.856689, 221.612411, 0.0000, 11.1727, 11.2500);
CreateObject(17310, -1929.048584, -1585.991211, 223.045776, 0.0000, 217.4381, 11.2500);
CreateObject(17310, -1929.525757, -1583.547852, 223.012863, 0.0000, 217.4381, 11.2500);
CreateObject(1655, -1893.255127, -1573.734009, 216.261826, 0.0000, 0.0000, 281.2500);
CreateObject(1655, -1891.871338, -1580.483765, 216.257248, 0.0000, 0.0000, 281.2500);
CreateObject(1634, -1886.987671, -1570.249756, 221.693497, 30.0803, 0.0000, 281.2500);
CreateObject(1634, -1886.121216, -1574.330688, 221.791534, 30.0803, 0.0000, 281.2500);
CreateObject(1634, -1885.334839, -1578.238525, 221.797272, 30.0803, 0.0000, 281.2500);
CreateObject(1634, -1884.681519, -1581.484375, 221.809128, 30.0803, 0.0000, 281.2500);
CreateObject(1634, -2347.271484, -1618.348145, 494.967712, 0.0000, 0.0000, 337.5000);
CreateObject(1634, -2345.135254, -1613.135620, 500.466522, 38.6747, 0.0000, 337.5000);
CreateObject(1634, -2363.724609, -1623.645996, 502.934296, 0.0000, 0.0000, 157.5000);
CreateObject(1634, -2366.012939, -1629.175049, 508.093445, 29.2208, 0.0000, 157.5000);
CreateObject(1634, -2366.671631, -1630.744629, 511.710449, 50.7067, 0.0000, 157.5000);
CreateObject(3458, -2369.716553, -1631.937500, 514.342651, 0.0000, 0.0000, 337.5000);
CreateObject(3458, -2377.419434, -1604.425903, 517.893127, 0.0000, 10.3132, 247.5000);
CreateObject(3458, -2362.233887, -1567.747803, 521.384827, 0.0000, 0.0000, 247.5000);
CreateObject(645, -2282.607178, -1643.139404, 481.901672, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2284.360352, -1625.549316, 482.307251, 0.0000, 0.0000, 225.0000);
CreateObject(645, -2285.019531, -1667.238159, 481.046631, 0.0000, 0.0000, 225.0000);
CreateObject(645, -2283.710693, -1674.330811, 480.941559, 0.0000, 0.0000, 225.0000);
CreateObject(645, -2301.182373, -1725.410156, 475.387177, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2294.795166, -1725.069824, 473.573181, 0.0000, 0.0000, 0.0000);
CreateObject(645, -2288.463379, -1724.434082, 471.628021, 0.0000, 0.0000, 0.0000);
CreateObject(3458, -2346.859619, -1530.779663, 521.381836, 0.0000, 0.0000, 247.5000);
CreateObject(3458, -2331.649170, -1494.006348, 521.253723, 0.0000, 0.0000, 247.5000);
CreateObject(13642, -2226.288818, -1750.128174, 476.716888, 11.1727, 256.0082, 304.6094);
CreateObject(13592, -2327.479004, -1472.435425, 532.526001, 0.0000, 0.0000, 78.7500);
CreateObject(1634, -2329.213623, -1459.000000, 523.139648, 353.9839, 0.0000, 337.5000);
CreateObject(1634, -2326.256348, -1460.249268, 523.147766, 353.9839, 0.0000, 337.5000);
CreateObject(1318, -2366.390137, -1630.409546, 513.919373, 270.6186, 0.0000, 67.5000);

//Drift objects
CreateObject(11479,-308.10000610,1508.19995117,74.40000153,0.00000000,0.00000000,184.00000000); //object(des_nwtfescape) (1)
CreateObject(3279,-292.89999390,1502.19995117,74.40000153,0.00000000,0.00000000,182.00000000); //object(a51_spottower) (1)
CreateObject(16477,-352.20001221,1507.30004883,74.80000305,0.00000000,0.00000000,14.00000000); //object(des_stwngas1) (1)

//Base
CreateObject(1437,-1696.50000000,-195.50000000,-127.19999695,0.00000000,0.00000000,0.00000000); //object(dyn_ladder_2) (1)
CreateObject(4882,-1622.40002441,-177.50000000,18.79999924,0.00000000,0.00000000,316.00000000); //object(lasbrid1_las) (1)
CreateObject(14596,-1598.30004883,-182.30000305,24.20000076,0.00000000,0.00000000,44.00000000); //object(paperchase_stairs) (1)
CreateObject(2918,-1623.30004883,-178.39999390,15.39999962,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (1)
CreateObject(18367,-1605.00000000,-183.50000000,31.00000000,350.00000000,0.00000000,314.00000000); //object(cw2_bikelog) (1)
CreateObject(18367,-1626.19995117,-204.10000610,40.00000000,0.00000000,0.00000000,316.00000000); //object(cw2_bikelog) (2)
CreateObject(7153,-1528.19995117,-39.09999847,-186.19999695,0.00000000,0.00000000,0.00000000); //object(shamheliprt05) (1)
CreateObject(1634,-1648.69995117,-226.60000610,44.29999924,0.00000000,0.00000000,134.00000000); //object(landjump2) (1)
CreateObject(1894,-1643.90002441,-196.19999695,13.10000038,10.00000000,30.00000000,138.00000000); //object(garys_luv_ramp) (1)
CreateObject(3270,-1569.30004883,-194.39999390,13.10000038,0.00000000,0.00000000,52.00000000); //object(bonyrd_block2_) (1)
CreateObject(3625,-1656.69995117,-133.60000610,16.00000000,0.00000000,0.00000000,44.00000000); //object(crgostntrmp) (1)
CreateObject(13636,-1592.19995117,-148.80000305,15.80000019,0.00000000,0.00000000,314.00000000); //object(logramps) (1)
CreateObject(13641,-1627.90002441,-209.10000610,27.20000076,0.00000000,0.00000000,322.00000000); //object(kickramp04) (1)
CreateObject(13641,-1669.00000000,-303.50000000,14.00000000,0.00000000,0.00000000,42.00000000); //object(kickramp04) (2)
CreateObject(13641,-1657.40002441,-292.10000610,18.60000038,0.00000000,0.00000000,42.00000000); //object(kickramp04) (3)
CreateObject(13641,-1644.90002441,-279.89999390,22.39999962,0.00000000,0.00000000,42.00000000); //object(kickramp04) (4)
CreateObject(13641,-1633.50000000,-268.70001221,27.89999962,0.00000000,0.00000000,42.00000000); //object(kickramp04) (5)
CreateObject(13641,-1621.00000000,-256.20001221,31.70000076,0.00000000,0.00000000,42.00000000); //object(kickramp04) (6)
CreateObject(13645,-1687.80004883,-162.10000610,16.70000076,0.00000000,0.00000000,42.00000000); //object(kickramp06) (1)
CreateObject(1634,-1085.69995117,430.89999390,14.69999981,0.00000000,0.00000000,314.00000000); //object(landjump2) (2)
CreateObject(1634,-1082.50000000,434.10000610,18.50000000,25.00000000,0.00000000,314.00000000); //object(landjump2) (3)
CreateObject(1634,-1083.00000000,427.89999390,14.60000038,0.00000000,0.00000000,314.00000000); //object(landjump2) (4)
CreateObject(1634,-1079.80004883,430.89999390,18.50000000,25.00000000,0.00000000,314.00000000); //object(landjump2) (5)
CreateObject(1655,-1079.00000000,423.79998779,14.60000038,0.00000000,0.00000000,314.00000000); //object(waterjumpx2) (1)
CreateObject(1655,-1075.59997559,427.00000000,18.00000000,20.00000000,0.00000000,314.00000000); //object(waterjumpx2) (2)
CreateObject(1655,-1072.19995117,430.39999390,22.10000038,20.00000000,0.00000000,316.00000000); //object(waterjumpx2) (3)
CreateObject(1655,-1072.69995117,417.00000000,14.80000019,0.00000000,0.00000000,314.00000000); //object(waterjumpx2) (4)
CreateObject(1655,-1066.30004883,410.50000000,14.69999981,0.00000000,0.00000000,314.00000000); //object(waterjumpx2) (5)
CreateObject(1655,-1066.00000000,417.60000610,17.89999962,20.00000000,0.00000000,314.00000000); //object(waterjumpx2) (6)
CreateObject(1634,-1454.00000000,-150.69999695,14.39999962,0.00000000,0.00000000,256.00000000); //object(landjump2) (6)
CreateObject(1634,-1449.50000000,-151.69999695,18.00000000,25.00000000,0.00000000,256.00000000); //object(landjump2) (7)
CreateObject(1634,-1455.09997559,-154.50000000,14.39999962,0.00000000,0.00000000,256.00000000); //object(landjump2) (8)
CreateObject(1634,-1450.19995117,-155.69999695,18.29999924,25.00000000,0.00000000,256.00000000); //object(landjump2) (9)
CreateObject(13604,-1636.90002441,-325.00000000,14.89999962,0.00000000,0.00000000,44.00000000); //object(kickramp05) (1)
CreateObject(13604,-1638.90002441,-318.00000000,18.29999924,0.00000000,0.00000000,316.00000000); //object(kickramp05) (2)
CreateObject(13647,-1608.30004883,-283.89999390,13.10000038,0.00000000,0.00000000,48.00000000); //object(wall1) (1)
CreateObject(13647,-1607.90002441,-284.60000610,13.10000038,0.00000000,0.00000000,48.00000000); //object(wall1) (2)
CreateObject(13647,-1607.50000000,-284.89999390,13.10000038,0.00000000,0.00000000,48.00000000); //object(wall1) (3)
CreateObject(16302,-1493.00000000,-220.89999390,19.50000000,0.00000000,0.00000000,0.00000000); //object(des_gravelpile04) (1)
CreateObject(16302,-1542.40002441,-154.00000000,19.50000000,0.00000000,0.00000000,0.00000000); //object(des_gravelpile04) (2)
CreateObject(16302,-1524.30004883,-155.89999390,27.70000076,0.00000000,0.00000000,0.00000000); //object(des_gravelpile04) (3)
CreateObject(16302,-1504.69995117,-170.80000305,34.70000076,0.00000000,0.00000000,0.00000000); //object(des_gravelpile04) (4)
CreateObject(16302,-1489.50000000,-179.69999695,44.40000153,0.00000000,0.00000000,0.00000000); //object(des_gravelpile04) (5)
CreateObject(18262,-1467.59997559,-186.69999695,39.40000153,0.00000000,0.00000000,76.00000000); //object(cw2_phroofstuf) (1)
CreateObject(18609,-1462.59997559,-190.60000610,40.09999847,0.00000000,0.00000000,354.00000000); //object(cs_logs06) (1)
CreateObject(13648,-1449.90002441,-189.10000610,39.40000153,20.00000000,10.00000000,260.00000000); //object(wall2) (1)
CreateObject(8302,-1434.80004883,-192.19999695,47.29999924,0.00000000,0.00000000,272.00000000); //object(jumpbox01_lvs01) (1)
CreateObject(12956,-1512.19995117,-93.80000305,17.00000000,0.00000000,0.00000000,0.00000000); //object(sw_trailerjump) (1)
CreateObject(13590,-1478.69995117,-119.50000000,15.50000000,0.00000000,0.00000000,314.00000000); //object(kickbus04) (1)
CreateObject(6052,-1556.09997559,-16.89999962,15.89999962,0.00000000,0.00000000,144.00000000); //object(artcurve_law) (1)
CreateObject(6052,-1551.69995117,-11.19999981,20.10000038,0.00000000,0.00000000,0.00000000); //object(artcurve_law) (2)
CreateObject(6052,-1540.00000000,-10.89999962,20.00000000,10.00000000,0.00000000,106.00000000); //object(artcurve_law) (3)
CreateObject(1894,-1537.30004883,3.20000005,21.10000038,3.00000000,26.00000000,304.00000000); //object(garys_luv_ramp) (2)
CreateObject(3364,-1568.40002441,-277.79998779,13.10000038,0.00000000,0.00000000,310.00000000); //object(des_ruin3_) (1)
CreateObject(3852,-1440.50000000,-111.00000000,15.00000000,0.00000000,0.00000000,314.00000000); //object(sf_jump) (1)
CreateObject(1225,-1404.90002441,-201.30000305,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (1)
CreateObject(1225,-1404.50000000,-194.50000000,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (2)
CreateObject(1225,-1405.19995117,-196.50000000,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (3)
CreateObject(1225,-1405.90002441,-198.10000610,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (4)
CreateObject(1225,-1407.40002441,-201.89999390,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (5)
CreateObject(1225,-1408.00000000,-203.50000000,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (6)
CreateObject(1225,-1403.69995117,-199.00000000,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (7)
CreateObject(1225,-1402.80004883,-197.19999695,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (8)
CreateObject(1225,-1402.30004883,-195.30000305,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (9)
CreateObject(1225,-1406.69995117,-200.00000000,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (10)
CreateObject(1225,-1405.80004883,-203.19999695,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (11)
CreateObject(1225,-1406.50000000,-204.80000305,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (12)
CreateObject(7073,-1424.69995117,-48.50000000,31.39999962,0.00000000,50.00000000,36.00000000); //object(vegascowboy1) (1)
CreateObject(7073,-1452.30004883,-165.10000610,32.59999847,0.00000000,0.00000000,348.00000000); //object(vegascowboy1) (2)
CreateObject(7073,-1394.09997559,-21.79999924,58.20000076,0.00000000,50.00000000,38.00000000); //object(vegascowboy1) (3)
CreateObject(7073,-1440.59997559,-139.39999390,31.39999962,0.00000000,0.00000000,0.00000000); //object(vegascowboy1) (4)
CreateObject(7073,-1376.30004883,-6.40000010,47.09999847,0.00000000,50.00000000,222.00000000); //object(vegascowboy1) (5)
CreateObject(1634,-1448.50000000,-69.00000000,14.39999962,2.00000000,0.00000000,314.00000000); //object(landjump2) (10)
CreateObject(16401,-1413.19995117,-37.29999924,40.50000000,0.00000000,0.00000000,38.00000000); //object(desn2_peckjump) (1)
CreateObject(12956,-1390.00000000,-72.80000305,17.00000000,0.00000000,0.00000000,34.00000000); //object(sw_trailerjump) (2)
CreateObject(13590,-1358.00000000,-38.59999847,15.50000000,0.00000000,0.00000000,314.00000000); //object(kickbus04) (2)
CreateObject(13638,-1326.30004883,-22.20000076,21.10000038,0.00000000,0.00000000,212.00000000); //object(stunt1) (1)
CreateObject(13638,-1332.59997559,-25.89999962,29.20000076,0.00000000,0.00000000,34.00000000); //object(stunt1) (2)
CreateObject(13638,-1339.50000000,-12.50000000,35.90000153,0.00000000,0.00000000,316.00000000); //object(stunt1) (3)
CreateObject(18367,-1335.90002441,-5.50000000,41.59999847,0.00000000,0.00000000,118.00000000); //object(cw2_bikelog) (3)
CreateObject(18367,-1309.09997559,8.80000019,45.40000153,0.00000000,0.00000000,118.00000000); //object(cw2_bikelog) (4)
CreateObject(18451,-1279.09997559,24.70000076,49.70000076,0.00000000,0.00000000,302.00000000); //object(cs_oldcarjmp) (1)
CreateObject(1634,-1265.40002441,30.20000076,33.20000076,0.00000000,0.00000000,134.00000000); //object(landjump2) (11)
CreateObject(1634,-1262.80004883,27.39999962,33.20000076,0.00000000,0.00000000,134.00000000); //object(landjump2) (12)
CreateObject(2098,-1270.50000000,26.39999962,15.10000038,0.00000000,0.00000000,316.00000000); //object(cj_slotcover1) (1)
CreateObject(2098,-1265.59997559,21.79999924,15.10000038,0.00000000,0.00000000,316.00000000); //object(cj_slotcover1) (2)
CreateObject(3749,-1267.50000000,24.39999962,19.00000000,0.00000000,0.00000000,316.00000000); //object(clubgate01_lax) (1)
CreateObject(8509,-1505.19995117,25.10000038,17.20000076,0.00000000,0.00000000,226.00000000); //object(shop09_lvs) (1)
CreateObject(13590,-1291.90002441,-80.09999847,15.50000000,0.00000000,0.00000000,224.00000000); //object(kickbus04) (3)
CreateObject(13636,-1305.09997559,-95.50000000,15.39999962,0.00000000,0.00000000,314.00000000); //object(logramps) (2)
CreateObject(13643,-1281.59997559,-106.50000000,14.39999962,0.00000000,0.00000000,314.00000000); //object(logramps02) (1)
CreateObject(14608,-1400.80004883,-236.19999695,15.39999962,0.00000000,0.00000000,284.00000000); //object(triad_buddha01) (1)
CreateObject(13637,-1343.50000000,-83.30000305,15.19999981,0.00000000,0.00000000,64.00000000); //object(tuberamp) (1)
CreateObject(13637,-1321.19995117,-120.40000153,15.19999981,0.00000000,0.00000000,0.00000000); //object(tuberamp) (2)
CreateObject(3461,-1377.59997559,-253.50000000,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (1)
CreateObject(3461,-1373.59997559,-249.10000610,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (2)
CreateObject(3461,-1370.40002441,-246.30000305,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (3)
CreateObject(3461,-1366.90002441,-243.30000305,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (4)
CreateObject(3461,-1363.80004883,-240.50000000,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (5)
CreateObject(3461,-1389.00000000,-243.39999390,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (6)
CreateObject(3461,-1383.90002441,-238.30000305,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (7)
CreateObject(3461,-1381.00000000,-235.30000305,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (8)
CreateObject(3461,-1377.90002441,-232.30000305,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (9)
CreateObject(3461,-1375.30004883,-229.69999695,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (10)
CreateObject(3515,-1380.00000000,-253.50000000,15.10000038,0.00000000,0.00000000,0.00000000); //object(vgsfountain) (1)
CreateObject(3515,-1388.80004883,-245.50000000,15.10000038,0.00000000,0.00000000,0.00000000); //object(vgsfountain) (2)
CreateObject(3524,-1366.30004883,-231.19999695,16.00000000,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (1)
CreateObject(3743,-1381.59997559,-250.00000000,17.10000038,0.00000000,0.00000000,316.00000000); //object(escl_singlela) (1)
CreateObject(3743,-1382.80004883,-248.80000305,17.10000038,0.00000000,0.00000000,316.00000000); //object(escl_singlela) (2)
CreateObject(6965,-1355.69995117,-221.69999695,17.79999924,0.00000000,0.00000000,0.00000000); //object(venefountain02) (1)
CreateObject(7392,-1360.80004883,-250.89999390,22.89999962,0.00000000,0.00000000,326.00000000); //object(vegcandysign1) (1)
CreateObject(7392,-1382.00000000,-229.00000000,22.89999962,0.00000000,0.00000000,318.00000000); //object(vegcandysign1) (2)
CreateObject(9833,-1361.09997559,-237.39999390,16.29999924,0.00000000,0.00000000,0.00000000); //object(fountain_sfw) (1)
CreateObject(9833,-1371.19995117,-227.50000000,16.29999924,0.00000000,0.00000000,0.00000000); //object(fountain_sfw) (2)
CreateObject(9833,-1356.00000000,-221.60000610,24.50000000,0.00000000,0.00000000,0.00000000); //object(fountain_sfw) (3)
CreateObject(16135,-1319.40002441,-175.60000610,13.60000038,0.00000000,0.00000000,46.00000000); //object(des_geysrwalk2) (1)
CreateObject(3524,-1319.50000000,-174.30000305,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (2)
CreateObject(3524,-1313.40002441,-175.19999695,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (3)
CreateObject(3524,-1323.30004883,-170.89999390,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (4)
CreateObject(3524,-1324.30004883,-165.19999695,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (5)
CreateObject(3524,-1321.00000000,-160.30000305,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (6)
CreateObject(3524,-1315.80004883,-158.00000000,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (7)
CreateObject(3524,-1311.30004883,-159.00000000,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (8)
CreateObject(3524,-1307.50000000,-162.69999695,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (9)
CreateObject(3524,-1306.30004883,-168.69999695,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (10)
CreateObject(3524,-1309.00000000,-172.89999390,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (11)
CreateObject(6189,-1228.80004883,-248.30000305,27.79999924,335.00000000,0.00000000,42.00000000); //object(gaz_pier1) (1)
CreateObject(6189,-1195.59997559,-284.79998779,50.79999924,335.00000000,0.00000000,42.00000000); //object(gaz_pier1) (2)
CreateObject(6189,-1138.90002441,-347.89999390,90.69999695,335.00000000,0.00000000,42.00000000); //object(gaz_pier1) (3)
CreateObject(8040,-1077.50000000,-416.70001221,132.69999695,0.00000000,0.00000000,134.00000000); //object(airprtcrprk02_lvs) (1)
CreateObject(1634,-1285.30004883,-206.60000610,14.39999962,0.00000000,0.00000000,42.00000000); //object(landjump2) (13)
CreateObject(1634,-1289.19995117,-202.30000305,17.50000000,5.00000000,0.00000000,42.00000000); //object(landjump2) (14)
CreateObject(1634,-1292.50000000,-198.80000305,21.60000038,25.00000000,0.00000000,42.00000000); //object(landjump2) (15)
CreateObject(1655,-1280.19995117,-202.60000610,14.39999962,0.00000000,0.00000000,42.00000000); //object(waterjumpx2) (7)
CreateObject(1655,-1273.69995117,-196.89999390,14.39999962,0.00000000,0.00000000,40.00000000); //object(waterjumpx2) (8)
CreateObject(1655,-1267.19995117,-191.60000610,14.39999962,0.00000000,0.00000000,40.00000000); //object(waterjumpx2) (9)
CreateObject(1655,-1271.90002441,-186.19999695,20.10000038,30.00000000,0.00000000,40.00000000); //object(waterjumpx2) (10)
CreateObject(1655,-1270.50000000,-187.50000000,17.70000076,20.00000000,0.00000000,40.00000000); //object(waterjumpx2) (11)
CreateObject(1564,-2663.00000000,1367.59997559,21.79999924,0.00000000,0.00000000,0.00000000); //object(ab_jetliteglass) (1)
CreateObject(1649,-2679.30004883,1370.19995117,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (1)
CreateObject(1649,-2675.00000000,1370.40002441,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (2)
CreateObject(1649,-2670.60009766,1370.40002441,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (3)
CreateObject(1649,-2683.69995117,1370.40002441,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (4)
CreateObject(1649,-2688.10009766,1370.40002441,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (5)
CreateObject(1649,-2692.50000000,1370.40002441,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (6)
CreateObject(1649,-2697.00000000,1370.30004883,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (7)
CreateObject(1649,-2700.00000000,1369.80004883,17.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (8)
CreateObject(1649,-2698.19995117,1371.00000000,20.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (9)
CreateObject(1649,-2693.89990234,1371.00000000,20.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (10)
CreateObject(1649,-2689.50000000,1371.00000000,20.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (11)
CreateObject(1649,-2685.19995117,1371.00000000,20.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (12)
CreateObject(1649,-2680.89990234,1371.00000000,21.00000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (13)
CreateObject(1649,-2676.39990234,1371.00000000,20.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (14)
CreateObject(1649,-2672.10009766,1371.00000000,21.00000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (15)
CreateObject(1649,-2666.00000000,1370.50000000,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (16)
CreateObject(1649,-2667.60009766,1371.00000000,20.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (17)
CreateObject(1649,-2663.30004883,1371.00000000,20.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (18)
CreateObject(1649,-2663.10009766,1371.00000000,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (19)
CreateObject(1649,-2697.80004883,1371.00000000,23.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (20)
CreateObject(1649,-2697.89990234,1371.00000000,27.00000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (21)
CreateObject(1649,-2697.80004883,1371.00000000,30.29999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (22)
CreateObject(1649,-2697.89990234,1371.00000000,33.59999847,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (23)
CreateObject(1649,-2697.80004883,1371.00000000,36.90000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (24)
CreateObject(1649,-2693.60009766,1371.00000000,24.00000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (25)
CreateObject(1649,-2689.19995117,1371.00000000,24.10000038,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (26)
CreateObject(1649,-2693.50000000,1371.00000000,27.29999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (27)
CreateObject(1649,-2693.30004883,1371.00000000,30.60000038,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (28)
CreateObject(1649,-2693.39990234,1371.00000000,33.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (29)
CreateObject(1649,-2693.50000000,1371.00000000,36.90000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (30)
CreateObject(1649,-2689.10009766,1371.00000000,27.29999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (31)
CreateObject(1649,-2688.89990234,1371.00000000,30.39999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (32)
CreateObject(1649,-2689.00000000,1371.00000000,33.59999847,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (33)
CreateObject(1649,-2689.00000000,1371.00000000,36.90000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (34)
CreateObject(1649,-2689.00000000,1371.00000000,40.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (35)
CreateObject(1649,-2693.50000000,1371.00000000,40.09999847,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (36)
CreateObject(1649,-2698.00000000,1371.00000000,40.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (37)
CreateObject(1649,-2684.69995117,1371.00000000,24.10000038,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (38)
CreateObject(1649,-2684.60009766,1371.00000000,27.29999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (39)
CreateObject(1649,-2684.60009766,1371.00000000,30.60000038,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (40)
CreateObject(1649,-2684.69995117,1371.00000000,33.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (41)
CreateObject(1649,-2684.69995117,1371.00000000,36.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (42)
CreateObject(1649,-2684.60009766,1371.00000000,40.09999847,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (43)
CreateObject(1649,-2680.30004883,1371.00000000,24.10000038,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (44)
CreateObject(1649,-2680.19995117,1371.00000000,27.29999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (45)
CreateObject(1649,-2680.30004883,1371.00000000,30.60000038,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (46)
CreateObject(1649,-2676.19995117,1371.00000000,24.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (47)
CreateObject(1649,-2671.69995117,1371.00000000,24.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (48)
CreateObject(1649,-2676.10009766,1371.00000000,27.50000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (49)
CreateObject(1649,-2671.60009766,1371.00000000,27.50000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (50)
CreateObject(1649,-2667.19995117,1371.00000000,24.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (51)
CreateObject(1649,-2667.19995117,1371.00000000,27.39999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (52)
CreateObject(1649,-2680.30004883,1371.00000000,34.00000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (53)
CreateObject(1649,-2680.30004883,1371.00000000,37.40000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (54)
CreateObject(1649,-2680.39990234,1371.00000000,40.79999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (55)
CreateObject(1649,-2675.89990234,1371.00000000,30.79999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (56)
CreateObject(1649,-2675.89990234,1371.00000000,34.09999847,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (57)
CreateObject(1649,-2675.89990234,1371.00000000,37.40000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (58)
CreateObject(1649,-2671.50000000,1371.00000000,30.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (59)
CreateObject(1649,-2671.39990234,1371.00000000,33.90000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (60)
CreateObject(1649,-2667.00000000,1371.00000000,30.79999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (61)
CreateObject(1649,-2667.00000000,1371.00000000,34.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (62)
CreateObject(1649,-2676.00000000,1371.00000000,40.79999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (63)
CreateObject(1649,-2671.39990234,1371.00000000,37.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (64)
CreateObject(1649,-2671.50000000,1371.00000000,40.59999847,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (65)
CreateObject(1649,-2667.00000000,1371.00000000,37.50000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (66)
CreateObject(1649,-2663.00000000,1370.59997559,24.29999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (67)
CreateObject(1649,-2663.00000000,1370.40002441,27.60000038,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (68)
CreateObject(1649,-2663.00000000,1370.00000000,30.79999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (69)
CreateObject(1649,-2663.00000000,1370.00000000,34.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (70)
CreateObject(1649,-2663.00000000,1370.19995117,37.40000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (71)
CreateObject(1649,-2667.10009766,1371.00000000,40.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (72)
CreateObject(1649,-2663.00000000,1370.30004883,40.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (73)
CreateObject(1649,-2668.50000000,1338.80004883,-102.90000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (74)
CreateObject(1649,-2703.89990234,1359.00000000,17.70000076,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (75)
CreateObject(1649,-2703.89990234,1354.80004883,17.70000076,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (76)
CreateObject(1649,-2703.80004883,1350.19995117,17.70000076,0.00000000,0.00000000,92.00000000); //object(wglasssmash) (77)
CreateObject(1649,-2703.80004883,1345.80004883,17.70000076,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (78)
CreateObject(1649,-2704.39990234,1359.19995117,20.70000076,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (79)
CreateObject(1649,-2703.80004883,1341.50000000,17.70000076,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (80)
CreateObject(1649,-2704.00000000,1337.40002441,17.70000076,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (81)
CreateObject(1649,-2704.00000000,1332.90002441,17.70000076,0.00000000,0.00000000,88.00000000); //object(wglasssmash) (82)
CreateObject(1649,-2703.30004883,1328.69995117,17.70000076,0.00000000,0.00000000,112.00000000); //object(wglasssmash) (83)
CreateObject(1649,-2703.30004883,1328.69995117,21.00000000,0.00000000,0.00000000,112.00000000); //object(wglasssmash) (84)
CreateObject(1649,-2703.89990234,1353.69995117,17.70000076,0.00000000,0.00000000,88.00000000); //object(wglasssmash) (85)
CreateObject(1649,-2703.89990234,1354.59997559,20.79999924,0.00000000,0.00000000,92.00000000); //object(wglasssmash) (86)
CreateObject(1649,-2704.00000000,1350.30004883,20.79999924,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (87)
CreateObject(1649,-2704.00000000,1346.09997559,20.89999962,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (88)
CreateObject(1649,-2704.19995117,1337.19995117,20.89999962,0.00000000,0.00000000,88.00000000); //object(wglasssmash) (89)
CreateObject(1649,-2704.19995117,1341.59997559,20.79999924,0.00000000,0.00000000,86.00000000); //object(wglasssmash) (90)
CreateObject(1649,-2702.10009766,1351.69995117,17.70000076,0.00000000,0.00000000,172.00000000); //object(wglasssmash) (91)
CreateObject(1491,-2693.19995117,1309.00000000,-121.50000000,0.00000000,0.00000000,0.00000000); //object(gen_doorint01) (1)
CreateObject(8640,-2661.80004883,1343.50000000,21.89999962,0.00000000,0.00000000,0.00000000); //object(chnatwnmll02_lvs) (1)
CreateObject(14805,-2694.80004883,1332.30004883,16.89999962,0.00000000,0.00000000,0.00000000); //object(bdupsnew_int) (1)
CreateObject(8171,-2683.89990234,1344.90002441,16.00000000,0.00000000,0.00000000,0.00000000); //object(vgssairportland06) (1)
CreateObject(8253,-2688.50000000,1343.69995117,19.89999962,0.00000000,0.00000000,0.00000000); //object(pltschlhnger01_lvs) (1)
CreateObject(8550,-2603.69995117,1379.19995117,10.39999962,0.00000000,0.00000000,0.00000000); //object(laconcha_lvs) (1)
CreateObject(3996,-2501.69995117,1425.69995117,-241.30000305,1.00000000,50.00000000,0.00000000); //object(roads08_lan) (1)
CreateObject(18367,-2631.30004883,1337.09997559,6.19999981,348.00000000,0.00000000,272.00000000); //object(cw2_bikelog) (5)
CreateObject(18367,-2631.39990234,1339.00000000,6.19999981,348.00000000,0.00000000,272.00000000); //object(cw2_bikelog) (6)
CreateObject(18367,-2631.50000000,1340.90002441,6.19999981,348.00000000,0.00000000,272.00000000); //object(cw2_bikelog) (7)
CreateObject(18367,-2631.69995117,1342.69995117,6.09999990,348.00000000,0.00000000,270.00000000); //object(cw2_bikelog) (8)
CreateObject(18367,-2631.69995117,1344.69995117,6.09999990,348.00000000,0.00000000,270.00000000); //object(cw2_bikelog) (9)
CreateObject(18367,-2631.80004883,1346.59997559,6.09999990,348.00000000,0.00000000,270.00000000); //object(cw2_bikelog) (10)
CreateObject(18367,-2631.69995117,1348.30004883,6.09999990,348.00000000,0.00000000,268.00000000); //object(cw2_bikelog) (11)
CreateObject(18367,-2631.60009766,1350.19995117,6.09999990,348.00000000,0.00000000,268.00000000); //object(cw2_bikelog) (12)
CreateObject(1264,2031.30004883,1000.70001221,-160.30000305,0.00000000,0.00000000,0.00000000); //object(blackbag1) (1)
CreateObject(1217,2009.19995117,1000.59997559,-172.30000305,0.00000000,0.00000000,0.00000000); //object(barrel2) (1)
CreateObject(3524,2023.50000000,1003.70001221,12.69999981,0.00000000,0.00000000,90.00000000); //object(skullpillar01_lvs) (12)
CreateObject(3524,2023.50000000,1012.40002441,12.69999981,0.00000000,0.00000000,90.00000000); //object(skullpillar01_lvs) (13)
CreateObject(9833,2024.90002441,996.70001221,13.00000000,0.00000000,0.00000000,0.00000000); //object(fountain_sfw) (4)
CreateObject(9833,2024.59997559,1018.70001221,13.00000000,0.00000000,0.00000000,0.00000000); //object(fountain_sfw) (5)
CreateObject(3877,2028.59997559,1003.09997559,11.50000000,0.00000000,0.00000000,0.00000000); //object(sf_rooflite) (1)
CreateObject(3877,2031.90002441,1003.00000000,11.50000000,0.00000000,0.00000000,0.00000000); //object(sf_rooflite) (2)
CreateObject(3877,2035.30004883,1002.90002441,11.50000000,0.00000000,0.00000000,0.00000000); //object(sf_rooflite) (3)
CreateObject(3877,2028.09997559,1014.00000000,11.50000000,0.00000000,0.00000000,0.00000000); //object(sf_rooflite) (4)
CreateObject(3877,2031.90002441,1014.00000000,11.50000000,0.00000000,0.00000000,0.00000000); //object(sf_rooflite) (5)
CreateObject(3877,2035.19995117,1014.09997559,11.50000000,0.00000000,0.00000000,0.00000000); //object(sf_rooflite) (6)
CreateObject(3743,2025.19995117,1015.70001221,13.69999981,0.00000000,0.00000000,270.00000000); //object(escl_singlela) (3)
CreateObject(3743,2025.80004883,999.70001221,13.69999981,0.00000000,0.00000000,270.00000000); //object(escl_singlela) (4)
CreateObject(6865,2027.40002441,1007.79998779,20.50000000,0.00000000,0.00000000,134.00000000); //object(steerskull) (1)
CreateObject(7392,2016.90002441,1019.40002441,47.79999924,0.00000000,0.00000000,0.00000000); //object(vegcandysign1) (3)
CreateObject(3509,2021.40002441,1334.00000000,9.19999981,0.00000000,0.00000000,0.00000000); //object(vgsn_nitree_r01) (1)
CreateObject(3511,2021.19995117,1351.90002441,9.10000038,0.00000000,0.00000000,0.00000000); //object(vgsn_nitree_b01) (1)


//Abandon Airfield//
CreateObject(1634, 436.426575, 2496.279297, 16.781693, 0.0000, 0.0000, 270.0000);
CreateObject(1634, 443.051819, 2496.285645, 22.960884, 33.5180, 0.0000, 270.0000);
CreateObject(1634, 436.426575, 2516.279297, 16.781693, 0.0000, 0.0000, 270.0000);
CreateObject(1634, 443.101807, 2516.255859, 22.960884, 33.5180, 0.0000, 270.0000);
CreateObject(1634, 446.425262, 2496.291748, 31.460484, 52.4256, 0.0000, 270.0000);
CreateObject(1634, 446.475250, 2516.266846, 31.460484, 52.4256, 0.0000, 270.0000);
CreateObject(1634, 446.322845, 2496.302490, 40.578209, 77.3492, 0.0000, 270.0000);
CreateObject(1634, 446.322845, 2516.275635, 40.578209, 77.3492, 0.0000, 270.0000);
CreateObject(1634, 474.857239, 2512.263428, 56.689095, 339.3735, 0.0000, 90.0000);
CreateObject(1634, 474.857239, 2508.513428, 56.689095, 339.3735, 0.0000, 90.0000);
CreateObject(1634, 474.857239, 2504.513428, 56.689095, 339.3735, 0.0000, 90.0000);
CreateObject(1634, 474.857239, 2501.137939, 56.689095, 339.3735, 0.0000, 90.0000);
CreateObject(18450, 400.677551, 2499.814941, 39.235886, 0.0000, 0.0000, 0.0000);
CreateObject(18450, 400.627563, 2515.261230, 39.235886, 0.0000, 0.0000, 0.0000);
CreateObject(18450, 321.177551, 2499.814941, 39.235886, 0.0000, 0.0000, 0.0000);
CreateObject(18450, 321.177551, 2515.315918, 39.235886, 0.0000, 0.0000, 0.0000);
CreateObject(1633, 392.151947, 2520.797363, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(1633, 392.151947, 2516.827148, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(1633, 392.151947, 2512.749512, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(1633, 392.151947, 2508.770508, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(1633, 392.151947, 2504.718750, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(1633, 392.151947, 2500.644043, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(1633, 392.151947, 2496.542480, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(1633, 392.151947, 2494.216797, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(1633, 244.503311, 2520.651855, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(18450, 241.402557, 2515.316895, 39.235886, 0.0000, 0.0000, 0.0000);
CreateObject(18450, 241.402557, 2499.820801, 39.235886, 0.0000, 0.0000, 0.0000);
CreateObject(1633, 244.503311, 2516.603027, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(1633, 244.503311, 2512.477539, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(1633, 244.503311, 2508.351074, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(1633, 244.503311, 2504.551270, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(1633, 244.503311, 2500.601074, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(1633, 244.503311, 2496.776367, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(1633, 244.503311, 2493.925781, 40.879929, 0.0000, 0.0000, 90.0000);
CreateObject(1633, 238.124664, 2520.563721, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 238.124664, 2516.518799, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 238.124664, 2512.469971, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 238.124664, 2508.323486, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 238.124664, 2504.173096, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 238.124664, 2500.173096, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 238.124664, 2496.173096, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 238.124664, 2493.872314, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 385.720428, 2520.693604, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 385.720428, 2516.642822, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 385.720428, 2512.770264, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 385.720428, 2508.724365, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 385.720428, 2504.597900, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 385.720428, 2504.597900, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 385.720428, 2500.648682, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 385.720428, 2496.648682, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(1633, 385.720428, 2494.148682, 40.879929, 0.0000, 0.0000, 270.0000);
CreateObject(18450, 577.560059, 2506.103027, 109.859802, 0.8594, 331.6386, 0.0000);
CreateObject(13592, 191.412842, 2541.399170, 25.672304, 0.0000, 0.0000, 281.2500);
CreateObject(13592, 183.987579, 2541.051514, 25.672300, 0.0000, 0.0000, 281.2500);
CreateObject(13592, 176.837555, 2540.697021, 25.672300, 0.0000, 0.0000, 281.2500);
CreateObject(13592, 169.462402, 2540.347412, 25.672300, 0.0000, 0.0000, 281.2500);
CreateObject(13592, 155.387360, 2539.673096, 25.672300, 0.0000, 0.0000, 281.2500);
CreateObject(5147, 290.957123, 2585.414795, 28.804176, 0.0000, 14.6104, 270.0000);
CreateObject(5147, 290.973450, 2767.187500, 88.251282, 0.0000, 14.6104, 270.0000);
CreateObject(5147, 290.948212, 2948.727295, 147.680618, 0.0000, 14.6104, 270.0000);
CreateObject(5147, 290.942322, 3130.549316, 207.157730, 0.0000, 14.6104, 270.0000);
CreateObject(5147, 290.922424, 3312.724854, 266.716888, 0.0000, 14.6104, 270.0000);
CreateObject(8417, 290.843170, 3441.096924, 296.878937, 0.0000, 0.0000, 0.0000);
CreateObject(8417, 290.893158, 3481.047119, 296.878937, 0.0000, 0.0000, 0.0000);
CreateObject(974, 283.096619, 3422.934570, 299.642609, 0.0000, 0.0000, 326.2500);
CreateObject(974, 277.700592, 3426.497803, 299.642609, 0.0000, 0.0000, 326.2500);
CreateObject(974, 273.079926, 3429.536377, 299.617615, 0.0000, 0.0000, 326.2500);
CreateObject(974, 298.699219, 3423.133301, 299.617615, 0.0000, 0.0000, 33.7500);
CreateObject(974, 304.160126, 3426.802979, 299.617615, 0.0000, 0.0000, 33.7500);
CreateObject(974, 308.477692, 3429.720703, 299.617615, 0.0000, 0.0000, 33.7500);
CreateObject(979, 281.883911, 3424.270508, 297.680084, 0.0000, 0.0000, 326.2500);
CreateObject(979, 274.137909, 3429.454102, 297.680084, 0.0000, 0.0000, 326.2500);
CreateObject(978, 299.344208, 3424.729736, 297.680084, 0.0000, 0.0000, 36.3283);
CreateObject(978, 306.694305, 3430.151855, 297.680084, 0.0000, 0.0000, 36.3283);
CreateObject(6986, 297.528564, 3413.472412, 295.181915, 263.7431, 0.0000, 356.5623);
CreateObject(6986, 284.903534, 3413.472412, 295.181915, 263.7431, 0.0000, 359.1406);
CreateObject(8620, 291.024872, 3417.924316, 318.695343, 0.0000, 0.0000, 0.0000);
CreateObject(6986, 275.548218, 3427.695068, 306.002350, 268.8997, 20.6265, 77.8906);
CreateObject(6986, 306.484680, 3427.745117, 305.488953, 268.8997, 20.6265, 324.3763);
CreateObject(1634, 290.912109, 3132.331055, 206.770966, 326.4820, 0.0000, 180.0000);
CreateObject(1634, 290.921448, 2948.110107, 146.487457, 328.2008, 0.0000, 180.0000);
CreateObject(1634, 290.857086, 2765.085205, 86.758408, 328.2008, 0.0000, 180.0000);
CreateObject(974, 311.090393, 3435.115234, 299.592621, 0.0000, 0.0000, 88.2038);
CreateObject(974, 311.165375, 3441.790527, 299.617615, 0.0000, 0.0000, 89.9226);
CreateObject(974, 311.167175, 3448.425049, 299.617615, 0.0000, 0.0000, 89.9226);
CreateObject(974, 311.167175, 3455.077393, 299.617615, 0.0000, 0.0000, 89.9226);
CreateObject(974, 311.167175, 3461.581299, 299.617615, 0.0000, 0.0000, 89.9226);
CreateObject(974, 311.167175, 3468.183838, 299.617615, 0.0000, 0.0000, 89.9226);
CreateObject(974, 311.167175, 3474.810303, 299.617615, 0.0000, 0.0000, 89.9226);
CreateObject(974, 311.167175, 3481.310303, 299.617615, 0.0000, 0.0000, 89.9226);
CreateObject(974, 311.167175, 3487.810303, 299.617615, 0.0000, 0.0000, 89.9226);
CreateObject(974, 311.167175, 3494.484619, 299.617615, 0.0000, 0.0000, 89.9226);
CreateObject(974, 311.167175, 3497.634033, 299.617615, 0.0000, 0.0000, 89.9226);
CreateObject(974, 307.845337, 3500.951416, 299.592621, 0.0000, 0.0000, 179.9227);
CreateObject(974, 301.220306, 3500.951416, 299.592621, 0.0000, 0.0000, 179.9227);
CreateObject(974, 294.720306, 3500.951416, 299.592621, 0.0000, 0.0000, 179.9227);
CreateObject(974, 288.170135, 3500.951416, 299.592621, 0.0000, 0.0000, 179.9227);
CreateObject(974, 282.045166, 3500.951416, 299.592621, 0.0000, 0.0000, 179.9227);
CreateObject(974, 275.545288, 3500.951416, 299.592621, 0.0000, 0.0000, 179.9227);
CreateObject(974, 273.620453, 3500.951416, 299.592621, 0.0000, 0.0000, 179.9227);
CreateObject(974, 270.416229, 3497.652588, 299.592621, 0.0000, 0.0000, 269.9227);
CreateObject(974, 270.416229, 3491.052002, 299.592621, 0.0000, 0.0000, 269.9227);
CreateObject(974, 270.416229, 3484.453369, 299.592621, 0.0000, 0.0000, 269.9227);
CreateObject(974, 270.416229, 3477.929443, 299.592621, 0.0000, 0.0000, 269.9227);
CreateObject(974, 270.416229, 3471.303955, 299.592621, 0.0000, 0.0000, 269.9227);
CreateObject(974, 270.416229, 3464.752197, 299.592621, 0.0000, 0.0000, 269.9227);
CreateObject(974, 270.416229, 3458.225342, 299.592621, 0.0000, 0.0000, 269.9227);
CreateObject(974, 270.416229, 3451.600830, 299.592621, 0.0000, 0.0000, 269.9227);
CreateObject(974, 270.416229, 3445.000244, 299.592621, 0.0000, 0.0000, 269.9227);
CreateObject(974, 270.416229, 3438.377686, 299.592621, 0.0000, 0.0000, 269.9227);
CreateObject(974, 270.416229, 3434.578857, 299.592621, 0.0000, 0.0000, 269.9227);
CreateObject(970, 309.097961, 3496.163330, 297.391357, 0.0000, 0.0000, 0.0000);
CreateObject(970, 305.574707, 3498.892090, 297.391357, 0.0000, 0.0000, 270.0000);
CreateObject(10281, 290.843750, 3421.274414, 305.555603, 0.0000, 347.9679, 180.0000);
CreateObject(8841, 290.655304, 3471.949707, 300.166107, 0.0000, 0.0000, 270.0000);
CreateObject(3458, 272.712982, 3480.783203, 298.361389, 0.0000, 0.0000, 90.0001);
CreateObject(3458, 272.712982, 3441.278320, 298.361389, 0.0000, 0.0000, 90.0001);
CreateObject(18450, 646.318665, 2505.524414, 146.943863, 0.8594, 331.6386, 0.0000);
CreateObject(18450, 715.736389, 2504.983887, 184.385666, 0.8594, 331.6386, 0.0000);
CreateObject(18450, 785.327637, 2504.428955, 221.919876, 0.8594, 331.6386, 0.0000);
CreateObject(18450, 854.078979, 2503.876709, 259.010895, 0.8594, 331.6386, 0.0000);
CreateObject(18450, 924.288391, 2503.312256, 296.881897, 0.8594, 331.6386, 0.0000);
CreateObject(18450, 994.372314, 2502.772949, 334.750641, 0.8594, 331.6386, 0.0000);
CreateObject(8040, 1069.238403, 2502.761230, 354.935303, 0.0000, 0.0000, 180.0000);
CreateObject(1634, 467.832611, 2512.244629, 58.448864, 358.2811, 0.0000, 90.0000);
CreateObject(1634, 467.832611, 2508.094238, 58.448864, 358.2811, 0.0000, 90.0000);
CreateObject(1634, 467.832611, 2503.966797, 58.448864, 358.2811, 0.0000, 90.0000);
CreateObject(1634, 467.832611, 2501.146973, 58.448864, 358.2811, 0.0000, 90.0000);
CreateObject(1634, 204.631012, 2497.555420, 16.781693, 0.0000, 0.0000, 90.0000);
CreateObject(1634, 204.631012, 2504.155029, 16.781693, 0.0000, 0.0000, 90.0000);
CreateObject(1634, 197.375534, 2497.543701, 22.024113, 19.7670, 0.0000, 90.0000);
CreateObject(18450, 148.402557, 2499.820801, 32.485886, 0.0000, 0.0000, 0.0000);
CreateObject(18450, 148.402557, 2515.193359, 32.485886, 0.0000, 0.0000, 0.0000);
CreateObject(1634, 205.882156, 2499.754639, 40.876953, 0.0000, 0.0000, 90.0000);
CreateObject(1634, 204.833862, 2515.494873, 40.876953, 0.0000, 0.0000, 90.0000);
CreateObject(1634, 111.395638, 2510.502930, 34.126953, 0.0000, 0.0000, 105.4698);
CreateObject(1634, 111.395638, 2501.751953, 34.126953, 0.0000, 0.0000, 90.0000);
CreateObject(1634, 111.395638, 2497.653320, 34.126953, 0.0000, 0.0000, 90.0000);
CreateObject(18450, 63.152557, 2499.820801, 38.660927, 0.0000, 0.0000, 0.0000);
CreateObject(974, 115.156250, 2517.039795, 35.432365, 0.0000, 0.0000, 270.0000);
CreateObject(974, 115.156204, 2519.663330, 35.457367, 0.0000, 0.0000, 270.0000);
CreateObject(979, 116.153381, 2518.483643, 33.669857, 0.0000, 0.0000, 270.0000);
CreateObject(1634, 35.320038, 2499.792236, 39.951973, 0.0000, 0.0000, 270.0000);
CreateObject(1634, 42.486092, 2499.803467, 45.344509, 22.3454, 0.0000, 270.0000);
CreateObject(9490, -80.463524, 2501.660889, 52.182335, 0.0000, 0.0000, 0.0000);
CreateObject(9490, -275.789185, 2501.622803, 77.236992, 0.0000, 0.0000, 0.0000);
CreateObject(1634, 35.320038, 2503.918701, 39.951973, 0.0000, 0.0000, 270.0000);
CreateObject(1634, 35.320038, 2495.842041, 39.951973, 0.0000, 0.0000, 270.0000);
CreateObject(1634, 42.486092, 2503.876221, 45.344509, 22.3454, 0.0000, 270.0000);
CreateObject(1634, 42.486092, 2495.854248, 45.344509, 22.3454, 0.0000, 270.0000);
CreateObject(1634, 57.070038, 2503.918701, 39.951973, 0.0000, 0.0000, 90.0000);
CreateObject(1634, 57.070038, 2499.769287, 39.951973, 0.0000, 0.0000, 90.0000);
CreateObject(1634, 57.070038, 2495.644775, 39.951973, 0.0000, 0.0000, 90.0000);
CreateObject(1634, 49.711121, 2503.876221, 45.469517, 22.3454, 0.0000, 90.0000);
CreateObject(1634, 49.711121, 2499.726807, 45.469517, 22.3454, 0.0000, 90.0000);
CreateObject(1634, 49.711121, 2495.697998, 45.469517, 22.3454, 0.0000, 90.0000);
CreateObject(8040, -407.139526, 2500.476563, 89.807915, 0.0000, 0.0000, 0.0000);
CreateObject(980, -418.356293, 2512.786133, 91.815681, 0.0000, 0.0000, 270.0000);
CreateObject(980, -418.356293, 2501.536133, 91.815681, 0.0000, 0.0000, 270.0000);
CreateObject(980, -424.054199, 2495.792725, 91.815681, 0.0000, 0.0000, 0.0000);
CreateObject(980, -432.304199, 2495.792725, 91.815681, 0.0000, 0.0000, 0.0000);
CreateObject(980, -438.018707, 2501.598389, 91.815681, 0.0000, 0.0000, 270.0000);
CreateObject(980, -438.018707, 2513.098389, 91.815681, 0.0000, 0.0000, 270.0000);
CreateObject(980, -368.153442, 2489.502441, 91.815681, 0.0000, 0.0000, 270.0001);
CreateObject(980, -368.153442, 2510.752441, 91.815681, 0.0000, 0.0000, 270.0001);
CreateObject(980, -368.153442, 2512.752441, 91.815681, 0.0000, 0.0000, 270.0001);
CreateObject(13592, 198.878799, 2485.800049, 25.379976, 0.0000, 0.0000, 6.0161);
CreateObject(13592, 198.878799, 2515.300049, 25.379976, 0.0000, 0.0000, 6.0161);
CreateObject(8397, 291.063416, 2471.539063, 25.978897, 0.0000, 0.0000, 0.0000);
CreateObject(1634, 289.686493, 2461.187012, 16.548883, 0.0000, 0.0000, 180.0000);
CreateObject(1634, 292.686493, 2461.187012, 16.548883, 0.0000, 0.0000, 180.0000);
CreateObject(1634, 289.688934, 2454.327881, 22.435965, 29.2208, 0.0000, 180.0000);
CreateObject(1634, 292.688934, 2454.327881, 22.435965, 29.2208, 0.0000, 180.0000);
CreateObject(1634, 289.686127, 2450.590576, 30.626730, 50.7067, 0.0000, 180.0000);
CreateObject(1634, 292.711182, 2450.590576, 30.626730, 50.7067, 0.0000, 180.0000);
CreateObject(1634, 289.673523, 2450.146240, 39.642414, 73.0521, 0.0000, 180.0000);
CreateObject(1634, 292.748566, 2450.146240, 39.642414, 73.0521, 0.0000, 180.0000);
CreateObject(13641, 291.310669, 2453.180908, 47.504684, 0.0000, 270.6186, 268.0403);
CreateObject(1318, 295.869446, 2478.535400, 17.930532, 0.0000, 0.0000, 90.0000);
CreateObject(1318, 286.369446, 2478.535400, 17.930532, 0.0000, 0.0000, 90.0000);
CreateObject(1698, 289.243469, 2468.253174, 60.446823, 0.0000, 0.0000, 270.0000);
CreateObject(1698, 292.493530, 2468.253174, 60.446823, 0.0000, 0.0000, 270.0000);
CreateObject(1698, 293.243530, 2468.253174, 60.446823, 0.0000, 0.0000, 270.0000);
CreateObject(1698, 293.243530, 2466.901611, 60.446823, 0.0000, 0.0000, 270.0000);
CreateObject(1698, 289.993530, 2466.901611, 60.446823, 0.0000, 0.0000, 270.0000);
CreateObject(1698, 289.318573, 2466.901611, 60.446823, 0.0000, 0.0000, 270.0000);
CreateObject(1698, 288.344940, 2470.552246, 60.441032, 0.0000, 0.0000, 180.0000);
CreateObject(1698, 288.344940, 2473.816406, 60.441032, 0.0000, 0.0000, 180.0000);
CreateObject(1698, 290.721527, 2474.730225, 60.435242, 0.0000, 0.0000, 90.0000);
CreateObject(1698, 294.219910, 2470.552246, 60.441032, 0.0000, 0.0000, 180.0000);
CreateObject(1698, 294.219910, 2473.779297, 60.441032, 0.0000, 0.0000, 180.0000);
CreateObject(1698, 292.021454, 2474.680420, 60.435242, 0.0000, 0.0000, 90.0000);
CreateObject(1698, 291.946472, 2476.003174, 60.435242, 0.0000, 0.0000, 90.0000);
CreateObject(1698, 289.371490, 2476.003174, 60.435242, 0.0000, 0.0000, 90.0000);
CreateObject(1698, 293.271149, 2476.003174, 60.435242, 0.0000, 0.0000, 90.0000);
CreateObject(4141, -68.539757, 2522.326416, 25.892351, 0.0000, 0.0000, 90.0001);
CreateObject(1634, -34.716225, 2516.626221, 16.781693, 0.0000, 0.0000, 90.0000);
CreateObject(1634, -41.918739, 2516.623047, 22.089239, 22.3454, 0.0000, 90.0000);
CreateObject(1634, -46.540771, 2516.673340, 29.829685, 44.6907, 0.0000, 90.0000);
CreateObject(1634, -22.716225, 2524.077393, 16.781693, 0.0000, 0.0000, 90.0000);
CreateObject(1634, -30.036335, 2524.006348, 22.169888, 22.3454, 0.0000, 90.0000);
CreateObject(1634, -34.631485, 2523.993408, 29.937063, 44.6907, 0.0000, 90.0000);
CreateObject(13638, -73.140541, 2521.931396, 39.625629, 0.0000, 0.0000, 0.0000);
CreateObject(13638, -69.747635, 2537.123047, 47.587185, 0.0000, 0.0000, 270.0000);
CreateObject(13593, -59.721886, 2539.880371, 52.091873, 13.7510, 0.8594, 88.2811);
CreateObject(8040, 327.785583, 2836.687012, 159.169510, 359.1406, 0.0000, 270.0000);
CreateObject(16370, 384.515808, 2538.821533, 16.972271, 0.0000, 0.0000, 180.0000);
CreateObject(973, 385.528809, 2528.677734, 16.400698, 0.0000, 0.0000, 180.0000);
CreateObject(1278, 373.699585, 2531.694580, 29.813505, 0.0000, 0.0000, 0.0000);
CreateObject(1278, 374.688416, 2553.356201, 29.780188, 0.0000, 0.0000, 0.0000);
CreateObject(1278, 393.464569, 2552.942627, 29.730719, 0.0000, 0.0000, 0.0000);
CreateObject(1278, 393.971344, 2531.788086, 29.732801, 0.0000, 0.0000, 0.0000);
CreateObject(1634, -47.643913, 2522.477051, 52.470917, 0.0000, 0.0000, 180.0000);
CreateObject(3279, 460.324097, 2505.422852, 19.341293, 0.0000, 0.0000, 180.0000);
CreateObject(9076, 478.593018, 2506.197998, 32.930832, 0.0000, 0.0000, 0.0000);
CreateObject(18450, 515.016724, 2506.713135, 76.087959, 0.8594, 331.6386, 0.0000);
CreateObject(6986, 1022.945679, 2509.621094, 351.767365, 271.4780, 20.6265, 293.4368);
CreateObject(6986, 1022.945679, 2494.871094, 351.767365, 274.9158, 20.6265, 293.4368);
CreateObject(8620, 1032.021851, 2502.571289, 376.040894, 0.0000, 0.0000, 90.0000);
CreateObject(3851, 291.072357, 3315.707764, 268.961609, 0.0000, 0.0000, 90.0000);
CreateObject(3851, 291.163696, 3309.931641, 267.019287, 0.0000, 0.0000, 90.0000);
CreateObject(3851, 290.743896, 3239.321289, 239.453094, 0.0000, 0.0000, 90.0000);
CreateObject(3851, 290.923706, 3229.090576, 236.774536, 0.0000, 0.0000, 90.0000);
CreateObject(3851, 290.642761, 3221.632568, 234.830414, 0.0000, 0.0000, 90.0000);
CreateObject(3851, 291.172913, 3201.865723, 229.580643, 0.0000, 0.0000, 78.7500);
CreateObject(3851, 290.792877, 3124.094971, 208.995590, 0.0000, 24.0642, 270.0000);
CreateObject(3851, 291.093079, 2588.107422, 30.951277, 0.0000, 0.0000, 270.0000);
CreateObject(3851, 290.865143, 2583.033447, 29.245070, 0.0000, 0.0000, 90.0000);
CreateObject(3851, 290.657593, 2575.646729, 26.629803, 0.0000, 0.0000, 90.0000);
CreateObject(3851, 290.651154, 2569.425293, 24.244911, 0.0000, 0.0000, 90.0000);
CreateObject(974, 333.675018, 2797.022461, 161.100815, 0.0000, 0.0000, 0.0000);
CreateObject(974, 321.190918, 2797.043213, 161.280472, 0.0000, 0.0000, 180.0000);
CreateObject(3502, 327.398407, 2792.792480, 160.170914, 0.0000, 0.0000, 180.0000);
CreateObject(3502, 327.471191, 2784.344482, 158.972931, 343.6707, 0.0000, 180.0000);
CreateObject(3502, 327.508972, 2776.734131, 155.356644, 325.6225, 0.0000, 180.0000);
CreateObject(3502, 327.844910, 2769.935303, 149.929214, 317.8876, 42.1124, 186.8755);
CreateObject(3502, 326.522675, 2763.943115, 143.914047, 317.8876, 0.0000, 150.5472);
CreateObject(3502, 324.249481, 2759.286377, 137.251541, 298.9801, 0.0000, 157.5000);
CreateObject(3502, 323.406860, 2756.875000, 129.344788, 278.3536, 0.0000, 180.0000);
CreateObject(3502, 323.415558, 2754.916748, 121.407379, 289.5262, 0.0000, 180.0000);
CreateObject(3502, 323.883392, 2752.491211, 112.999039, 284.3696, 1.7189, 202.5000);
CreateObject(3502, 323.884735, 2749.157959, 104.913811, 301.5584, 0.0000, 168.7500);
CreateObject(3502, 321.625549, 2745.984131, 98.092026, 301.5584, 0.0000, 123.7499);
CreateObject(3502, 317.379120, 2744.905762, 91.085762, 306.7150, 0.0000, 90.0000);
CreateObject(3502, 311.600006, 2745.606201, 84.582993, 317.0282, 359.1406, 78.7500);
CreateObject(3502, 305.486450, 2746.223389, 78.300812, 312.7310, 0.0000, 90.0000);
CreateObject(3502, 299.338806, 2746.981934, 73.854889, 332.4980, 0.0000, 78.7501);
CreateObject(3502, 291.595978, 2748.559570, 71.379295, 351.4056, 0.0000, 78.7500);
CreateObject(3502, 283.241699, 2750.252197, 70.645042, 0.0000, 0.0000, 78.7500);
CreateObject(3502, 274.791809, 2751.951660, 70.646690, 0.0000, 0.0000, 78.7500);
CreateObject(3502, 266.769928, 2753.556885, 70.682198, 0.0000, 0.0000, 78.7500);
CreateObject(3502, 258.657318, 2755.180420, 70.639084, 0.0000, 0.0000, 78.7500);
CreateObject(3502, 250.560165, 2755.046875, 70.654312, 0.0000, 0.0000, 101.2500);
CreateObject(3502, 242.351807, 2752.526611, 70.695244, 0.0000, 0.0000, 112.5000);
CreateObject(3502, 235.220261, 2748.712891, 70.548325, 0.0000, 0.0000, 123.7499);
CreateObject(3502, 228.521530, 2743.318359, 70.377098, 0.0000, 0.0000, 135.0000);
CreateObject(3502, 222.542511, 2737.358643, 68.942101, 341.0924, 0.0000, 135.0000);
CreateObject(3502, 217.291962, 2732.035400, 65.848145, 333.3575, 0.0000, 135.0000);
CreateObject(3502, 212.132629, 2726.881348, 61.189163, 322.1848, 0.0000, 133.2811);
CreateObject(3502, 206.987625, 2722.647461, 54.997482, 314.4499, 0.0000, 123.7499);
CreateObject(13635, -37.068810, 2439.251953, 17.920225, 0.0000, 0.0000, 191.2500);
CreateObject(3565, -26.717237, 2425.685791, 19.097420, 0.0000, 0.0000, 281.2500);
CreateObject(3565, -26.832134, 2423.832520, 16.571541, 0.0000, 0.0000, 11.2500);
CreateObject(3565, -25.356560, 2418.742676, 21.780157, 0.0000, 0.0000, 101.2500);
CreateObject(3621, 33.812569, 2389.800049, 17.803598, 0.0000, 0.0000, 337.5000);
CreateObject(5152, -26.540609, 2424.503662, 21.269989, 0.8594, 347.1084, 281.2500);
CreateObject(5152, -23.386625, 2415.527832, 23.226456, 359.1406, 354.8434, 337.5000);
CreateObject(5152, -18.813684, 2413.650635, 23.402435, 0.0000, 0.0000, 157.5000);
CreateObject(3757, -3.504057, 2411.657471, 18.348886, 0.8594, 1.7189, 243.2028);
CreateObject(973, -9.850763, 2406.922363, 23.544468, 0.0000, 0.0000, 67.5000);
CreateObject(973, -4.463177, 2404.908936, 23.444469, 0.0000, 0.0000, 247.5000);
CreateObject(5152, 2.130503, 2403.130371, 23.902428, 0.0000, 0.0000, 337.5000);
CreateObject(5152, 8.053474, 2400.703125, 23.477434, 0.0000, 0.0000, 157.5000);
CreateObject(1225, 5.954505, 2401.848145, 23.609995, 94.5380, 0.0000, 0.0000);
CreateObject(1225, 5.387224, 2399.986084, 23.609995, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 6.641665, 2403.116943, 23.609995, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 4.759972, 2398.568359, 23.609995, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 7.188162, 2404.225342, 23.609995, 0.0000, 0.0000, 0.0000);
CreateObject(3374, 26.819040, 2392.773682, 22.000893, 0.0000, 0.0000, 337.5000);
CreateObject(3374, 30.453606, 2391.343750, 22.000893, 0.0000, 0.0000, 337.5000);
CreateObject(3374, 33.192371, 2390.214844, 22.000893, 0.0000, 0.0000, 337.5000);
CreateObject(3374, 30.563713, 2391.175293, 25.000893, 0.0000, 0.0000, 337.5000);
CreateObject(1225, 28.485146, 2393.347900, 23.912670, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 27.829077, 2391.845215, 23.912670, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 29.967049, 2389.870850, 26.912670, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 31.215355, 2392.505859, 26.912670, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 33.603313, 2391.629639, 23.912670, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 32.246468, 2388.996826, 23.912670, 0.0000, 0.0000, 0.0000);
CreateObject(5152, 20.709349, 2395.039795, 23.877428, 0.0000, 346.2490, 337.5000);
CreateObject(18609, 39.312683, 2384.469482, 24.376728, 0.0000, 0.0000, 337.5000);
CreateObject(18609, 44.086937, 2389.512695, 24.376728, 0.0000, 0.0000, 157.5000);
CreateObject(18609, 43.798290, 2382.547852, 24.376728, 0.0000, 0.0000, 337.5000);
CreateObject(18609, 46.034332, 2381.623535, 24.376728, 0.0000, 0.0000, 337.5000);
CreateObject(1225, 41.058258, 2390.678223, 23.609995, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 38.456413, 2384.484619, 23.609995, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 45.940269, 2381.268555, 23.609995, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 49.495262, 2387.259521, 23.609995, 0.0000, 0.0000, 0.0000);
CreateObject(5152, 51.840660, 2382.439453, 23.852428, 0.0000, 0.0000, 337.5000);
CreateObject(3565, 59.974770, 2379.510742, 24.552181, 0.0000, 0.0000, 337.5000);
CreateObject(5152, 63.728313, 2377.969971, 25.847734, 0.0000, 11.1727, 337.5000);
CreateObject(2780, 68.458481, 2373.395020, 20.506916, 0.0000, 0.0000, 0.0000);
CreateObject(2780, 70.195122, 2377.120605, 20.506916, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 71.069336, 2371.189209, 23.609995, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 71.605751, 2372.543457, 23.609995, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 72.008560, 2373.810791, 23.609995, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 72.533707, 2375.077148, 23.609995, 0.0000, 0.0000, 0.0000);
CreateObject(1225, 73.129395, 2376.545654, 23.609995, 0.0000, 0.0000, 0.0000);
CreateObject(3280, 81.986549, 2370.259766, 23.204241, 0.0000, 0.0000, 337.5000);
CreateObject(3280, 83.440002, 2369.646729, 23.204241, 0.0000, 0.0000, 337.5000);
CreateObject(3280, 82.843063, 2368.234375, 23.204241, 0.0000, 0.0000, 337.5000);
CreateObject(3280, 84.286362, 2367.640869, 23.204241, 0.0000, 0.0000, 337.5000);
CreateObject(3280, 83.752022, 2366.241455, 23.204241, 0.0000, 0.0000, 337.5000);
CreateObject(3280, 83.156067, 2364.835693, 23.204241, 0.0000, 0.0000, 337.5000);
CreateObject(3280, 84.582115, 2364.177979, 23.254240, 0.0000, 0.0000, 337.5000);
CreateObject(5152, 86.837044, 2363.186523, 24.577417, 0.8594, 341.9518, 337.5000);
CreateObject(3374, 91.737808, 2363.601318, 24.698215, 0.0000, 0.0000, 337.5000);
CreateObject(3374, 93.339500, 2367.412354, 24.698215, 0.0000, 0.0000, 337.5000);
CreateObject(3461, 92.377815, 2369.618652, 27.779251, 0.0000, 0.0000, 0.0000);
CreateObject(3461, 95.743340, 2368.416504, 27.779251, 0.0000, 0.0000, 0.0000);
CreateObject(1238, 93.108475, 2369.355469, 26.522419, 0.0000, 0.0000, 0.0000);
CreateObject(1238, 94.943214, 2368.622070, 26.522419, 0.0000, 0.0000, 0.0000);
CreateObject(1238, 94.070473, 2368.917969, 26.522419, 0.0000, 0.0000, 0.0000);
CreateObject(1238, 94.783173, 2366.961182, 26.522419, 0.0000, 0.0000, 0.0000);
CreateObject(1238, 94.140579, 2365.532959, 26.522419, 0.0000, 0.0000, 0.0000);
CreateObject(1238, 92.141006, 2368.062256, 26.522419, 0.0000, 0.0000, 0.0000);
CreateObject(1238, 91.543037, 2366.634277, 26.522419, 0.0000, 0.0000, 0.0000);
CreateObject(978, -67.052475, 2506.790283, 16.324594, 0.0000, 0.0000, 0.0000);
CreateObject(978, -75.568436, 2509.453369, 16.324594, 0.0000, 0.0000, 325.6225);
CreateObject(978, -79.478027, 2516.814941, 16.324594, 0.0000, 0.0000, 271.0141);
CreateObject(978, -79.629120, 2526.123047, 16.324594, 0.0000, 0.0000, 271.0141);
CreateObject(978, -79.776482, 2535.466797, 16.324594, 0.0000, 0.0000, 271.0141);
CreateObject(978, -65.977127, 2540.030029, 16.324594, 0.0000, 0.0000, 181.0141);
CreateObject(971, -75.143814, 2543.786133, 19.479305, 91.9597, 0.0000, 0.0000);
CreateObject(978, -57.908310, 2536.827393, 16.310402, 0.0000, 0.0000, 136.0141);
CreateObject(978, -53.528755, 2528.989014, 16.324594, 0.0000, 0.0000, 102.2640);
CreateObject(978, -54.965240, 2520.484863, 16.282404, 0.0000, 0.0000, 57.2641);
CreateObject(978, -49.073395, 2514.531006, 16.274595, 0.0000, 0.0000, 57.2640);
CreateObject(978, -62.187820, 2516.483887, 16.307404, 0.0000, 0.0000, 1.0140);
CreateObject(978, -69.032394, 2520.669189, 16.282404, 0.0000, 0.0000, 297.1066);
CreateObject(978, -62.294044, 2510.005615, 16.332405, 0.0000, 0.0000, 1.0140);
CreateObject(978, -70.861069, 2512.445068, 16.332403, 0.0000, 0.0000, 327.2640);
CreateObject(978, -74.867134, 2519.682129, 16.324594, 0.0000, 0.0000, 271.0139);
CreateObject(978, -73.543053, 2528.481934, 16.324594, 0.0000, 0.0000, 252.8889);
CreateObject(978, -68.140182, 2528.473389, 16.324594, 0.0000, 0.0000, 229.6066);
CreateObject(978, -71.715881, 2535.265625, 16.324594, 0.0000, 0.0000, 256.5582);
CreateObject(978, -61.454975, 2528.980225, 16.324594, 0.0000, 0.0000, 140.3891);
CreateObject(978, -57.390610, 2524.729980, 16.332403, 0.0000, 0.0000, 131.7175);
CreateObject(2931, -78.114738, 2535.803711, 15.517785, 0.0000, 0.0000, 0.0000);
CreateObject(2931, -77.139740, 2535.803711, 15.517785, 0.0000, 0.0000, 0.0000);
CreateObject(2931, -76.114708, 2535.803711, 15.517785, 0.0000, 0.0000, 0.0000);
CreateObject(2931, -75.089691, 2535.803711, 15.517785, 0.0000, 0.0000, 0.0000);
CreateObject(2931, -74.125160, 2535.791260, 15.467786, 0.0000, 0.0000, 0.0000);
CreateObject(2931, -55.232269, 2524.388184, 15.525594, 0.0000, 0.0000, 213.7500);
CreateObject(2931, -54.382217, 2524.936035, 15.525594, 0.0000, 0.0000, 213.7500);
CreateObject(974, -51.417572, 2519.733398, 19.619915, 89.3814, 0.0000, 33.7500);
CreateObject(974, -49.167465, 2516.415527, 19.669914, 89.3814, 0.0000, 33.7500);
CreateObject(974, -47.992363, 2510.694336, 19.769913, 89.3814, 0.0000, 33.7500);
CreateObject(974, -47.942345, 2504.134277, 19.844912, 89.3814, 0.0000, 33.7500);
CreateObject(974, -51.967300, 2502.508789, 19.794912, 89.3814, 0.0000, 357.6537);
CreateObject(974, -58.592186, 2502.785645, 19.769913, 89.3814, 0.0000, 356.7942);
CreateObject(974, -65.242256, 2503.137207, 19.744913, 89.3814, 0.0000, 357.6537);
CreateObject(2931, -67.705429, 2501.736084, 19.802341, 0.0000, 0.0000, 90.0000);
CreateObject(2931, -67.705429, 2502.736084, 19.802341, 0.0000, 0.0000, 90.0000);
CreateObject(2931, -67.705429, 2503.759033, 19.802341, 0.0000, 0.0000, 90.0000);
CreateObject(974, -71.649536, 2502.775391, 22.766031, 89.3814, 0.0000, 356.7942);
CreateObject(974, -78.199738, 2503.148926, 22.766031, 89.3814, 0.0000, 356.7942);
CreateObject(974, -84.774803, 2503.497559, 22.766031, 89.3814, 0.0000, 356.7942);
CreateObject(974, -84.524788, 2508.943848, 22.691032, 89.3814, 0.0000, 356.7942);
CreateObject(974, -84.224770, 2514.238770, 22.616034, 89.3814, 0.0000, 356.7942);
CreateObject(974, -77.574684, 2513.865234, 22.641033, 89.3814, 0.0000, 356.7942);
CreateObject(974, -71.074608, 2513.516602, 22.641033, 89.3814, 0.0000, 356.7942);
CreateObject(5153, -66.262154, 2511.384277, 21.640356, 0.0000, 0.0000, 160.0010);
CreateObject(5153, -62.522850, 2510.017334, 19.898579, 0.0000, 0.0000, 160.0010);
CreateObject(978, -56.294090, 2510.229736, 16.332405, 0.0000, 0.0000, 4.4517);
CreateObject(978, -79.328003, 2507.616699, 16.324594, 0.0000, 0.0000, 271.0141);
CreateObject(978, -79.252998, 2504.421387, 16.324594, 0.0000, 0.0000, 271.0141);
CreateObject(1225, -79.147263, 2532.705811, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -72.874405, 2532.687988, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -77.633583, 2540.057129, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -76.133537, 2540.057129, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -74.833565, 2540.057129, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -73.683525, 2540.057129, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -72.208542, 2540.057129, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -79.133583, 2540.057129, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -56.383518, 2544.294678, 16.256290, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -56.416801, 2540.913086, 16.243130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -52.856586, 2542.698730, 16.067318, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -53.113335, 2538.974609, 16.064171, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -48.758293, 2540.506592, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -49.652527, 2535.709473, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -45.916924, 2537.672607, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -46.149227, 2533.091064, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -46.154903, 2529.077881, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -49.552940, 2532.055420, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -49.616234, 2528.596924, 15.897939, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -57.360077, 2538.823975, 16.205574, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -56.161831, 2537.445068, 16.174110, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -55.449047, 2538.755859, 16.183708, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -53.714092, 2535.936768, 16.081795, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -50.946384, 2535.963623, 15.939130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -51.734570, 2537.083008, 15.984719, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -52.065823, 2535.010010, 15.992684, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -53.789726, 2544.112061, 16.121677, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -50.248867, 2542.231934, 15.930734, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -47.742260, 2539.517578, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -46.578789, 2538.598145, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -46.076492, 2536.388184, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -45.826492, 2534.638184, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -46.001503, 2531.462891, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(978, -44.825314, 2534.421387, 16.324594, 0.0000, 0.0000, 91.0141);
CreateObject(978, -44.625332, 2525.520020, 16.324594, 0.0000, 0.0000, 91.0141);
CreateObject(978, -44.600300, 2522.949219, 16.324594, 0.0000, 0.0000, 91.0141);
CreateObject(1558, -54.458908, 2519.883789, 16.066135, 0.0000, 0.0000, 326.2500);
CreateObject(1558, -53.883873, 2520.780273, 16.066135, 0.0000, 0.0000, 326.2500);
CreateObject(1558, -53.883873, 2520.780273, 16.916122, 0.0000, 0.0000, 326.2500);
CreateObject(1558, -53.058823, 2520.257324, 16.066135, 0.0000, 0.0000, 326.2500);
CreateObject(1558, -52.117447, 2511.807617, 16.066135, 0.0000, 0.0000, 0.0000);
CreateObject(1558, -52.167450, 2512.828613, 16.066135, 0.0000, 0.0000, 0.0000);
CreateObject(1558, -52.167450, 2513.849609, 16.066135, 0.0000, 0.0000, 0.0000);
CreateObject(1558, -52.167450, 2514.870605, 16.066135, 0.0000, 0.0000, 0.0000);
CreateObject(1558, -67.685272, 2516.884277, 16.066135, 0.0000, 0.0000, 303.7500);
CreateObject(1558, -68.235306, 2516.510742, 16.066135, 0.0000, 0.0000, 303.7500);
CreateObject(1558, -74.002228, 2517.831787, 16.066135, 0.0000, 0.0000, 258.7500);
CreateObject(1558, -73.302185, 2517.657471, 16.066135, 0.0000, 0.0000, 258.7500);
CreateObject(1558, -72.277122, 2517.458252, 16.066135, 0.0000, 0.0000, 258.7500);
CreateObject(1558, -70.130219, 2527.101318, 16.058327, 0.0000, 0.0000, 225.0000);
CreateObject(1558, -70.830261, 2527.848389, 16.058327, 0.0000, 0.0000, 225.0000);
CreateObject(14467, -62.737183, 2522.049561, 18.225977, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -64.723793, 2500.825439, 20.183189, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -64.523300, 2504.910156, 20.139036, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -55.042389, 2528.098633, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -54.142334, 2528.596680, 15.890130, 0.0000, 0.0000, 0.0000);
CreateObject(1225, -57.888443, 2526.488281, 16.048021, 0.0000, 0.0000, 0.0000);
CreateObject(978, -63.057915, 2505.615234, 20.569687, 0.0000, 0.0000, 356.7176);
CreateObject(978, -54.482758, 2505.116211, 20.569687, 0.0000, 0.0000, 356.7176);
CreateObject(978, -72.745720, 2505.500977, 23.585342, 0.0000, 0.0000, 356.7176);
CreateObject(978, -76.395592, 2505.700195, 23.585342, 0.0000, 0.0000, 356.7176);
CreateObject(978, -82.986816, 2516.479492, 23.441919, 0.0000, 0.0000, 356.7176);
CreateObject(978, -73.636780, 2515.929688, 23.441919, 0.0000, 0.0000, 356.7176);
CreateObject(978, -76.732475, 2511.331299, 23.515873, 0.0000, 0.0000, 176.7177);
CreateObject(978, -73.257446, 2511.132080, 23.515873, 0.0000, 0.0000, 176.7177);
CreateObject(1558, -81.861702, 2510.836670, 23.250786, 0.0000, 0.0000, 270.0000);
CreateObject(1558, -81.861702, 2509.785889, 23.250786, 0.0000, 0.0000, 270.0000);
CreateObject(1558, -81.861702, 2508.715088, 23.250786, 0.0000, 0.0000, 270.0000);
CreateObject(1558, -81.936707, 2507.669189, 23.250786, 0.0000, 0.0000, 270.0000);
CreateObject(1558, -81.986710, 2506.523682, 23.250786, 0.0000, 0.0000, 270.0000);
CreateObject(978, -87.537079, 2512.046387, 23.440081, 0.0000, 0.0000, 266.7175);
CreateObject(978, -63.965134, 2509.652588, 21.265661, 0.0000, 336.7952, 159.5282);
CreateObject(978, -63.515121, 2511.396729, 21.265661, 0.0000, 336.7952, 159.5283);
CreateObject(1558, -68.169800, 2513.524170, 23.220963, 0.0000, 0.0000, 0.0000);
CreateObject(1558, -68.194801, 2514.619873, 23.220963, 0.0000, 0.0000, 0.0000);
CreateObject(1558, -68.194801, 2515.591064, 23.220963, 0.0000, 0.0000, 0.0000);
CreateObject(13592, 161.962463, 2539.924072, 25.647301, 0.0000, 0.0000, 281.2500);
//========================Las Venturas Map========================
CreateObject(1655, 2044.015503, 1005.179443, 10.671991, 0.0000, 0.0000, 0.0000);
CreateObject(1655, 2050.739746, 1005.119019, 10.646992, 0.0000, 0.0000, 0.0000);
CreateObject(1655, 2044.003540, 1010.894592, 14.493576, 19.7670, 0.0000, 0.0000);
CreateObject(3665, 2073.347656, 1055.102051, 11.303473, 0.0000, 0.0000, 0.0000);
CreateObject(3665, 2073.291504, 1064.497192, 15.220837, 0.0000, 0.0000, 0.0000);
CreateObject(3665, 2073.301270, 1072.380249, 11.653467, 0.0000, 0.0000, 0.0000);
CreateObject(1634, 2146.526123, 1096.360107, 12.766363, 0.0000, 0.0000, 332.4980);
CreateObject(1634, 2150.012695, 1094.530151, 12.771708, 0.0000, 0.0000, 332.4980);
CreateObject(1634, 2153.639160, 1092.594971, 12.755322, 0.0000, 0.0000, 332.4980);
CreateObject(1634, 2157.114258, 1090.778320, 12.770010, 0.0000, 0.0000, 332.4980);
CreateObject(1634, 2160.631348, 1088.995239, 12.809027, 0.0000, 0.0000, 332.4980);
CreateObject(1634, 2153.547607, 1097.495850, 16.144245, 26.6425, 0.0000, 332.4980);
CreateObject(1634, 2156.934326, 1095.744141, 16.144245, 26.6425, 0.0000, 332.4980);
CreateObject(1655, 2158.400879, 1107.566040, 23.386053, 0.0000, 0.0000, 152.9800);
CreateObject(1655, 2153.473877, 1130.737793, 23.311054, 0.0000, 0.0000, 63.5983);
CreateObject(1655, 2149.540527, 1132.717163, 25.431639, 6.8755, 0.0000, 63.5983);
CreateObject(1655, 2187.490967, 1152.892334, 11.478123, 0.0000, 0.0000, 153.9432);
CreateObject(1655, 2179.695313, 1156.741089, 11.475159, 0.0000, 0.0000, 153.9432);
CreateObject(1655, 2181.465576, 1150.155151, 15.626043, 28.3614, 0.0000, 153.9432);
CreateObject(1655, 2131.663818, 1142.419312, 13.809444, 0.0000, 0.0000, 240.7467);
CreateObject(1655, 2133.638184, 1141.301514, 15.910673, 22.3454, 0.0000, 240.7467);
CreateObject(1655, 2085.583496, 1165.647339, 11.530357, 0.0000, 0.0000, 66.3847);
CreateObject(1655, 2092.190674, 1148.697510, 11.405359, 0.0000, 0.0000, 151.4691);
CreateObject(1655, 2101.754395, 1168.409790, 24.587616, 0.0000, 0.0000, 332.7061);
CreateObject(1634, 2081.608887, 1122.628052, 10.567638, 0.0000, 0.0000, 335.9358);
CreateObject(1634, 2077.856689, 1124.298584, 10.542639, 0.0000, 0.0000, 335.9358);
CreateObject(1634, 2081.987305, 1128.065430, 14.558548, 26.6425, 0.0000, 335.9358);
CreateObject(1634, 2116.558838, 1189.003906, 10.542639, 0.0000, 0.0000, 152.1204);
CreateObject(1634, 2113.056885, 1190.807983, 10.569199, 0.0000, 0.0000, 152.1204);
CreateObject(1634, 2111.860596, 1183.784302, 16.264568, 28.3614, 0.0000, 152.1204);
CreateObject(1655, 2076.615479, 1074.819946, 10.605242, 0.0000, 0.0000, 181.5494);
CreateObject(1655, 2076.626221, 1068.474609, 10.669970, 0.0000, 0.0000, 0.3119);
CreateObject(1634, 1978.092041, 1179.671143, 26.818417, 0.0000, 0.0000, 177.9037);
CreateObject(1634, 1978.292847, 1202.371338, 26.868416, 0.0000, 0.0000, 0.9636);
CreateObject(1634, 1978.252808, 1207.798096, 30.441944, 18.0482, 0.0000, 0.9636);
CreateObject(1634, 1978.044067, 1212.029053, 35.360344, 30.0803, 0.0000, 0.9636);
CreateObject(1634, 1977.980957, 1215.826416, 42.499245, 42.9718, 0.0000, 0.9636);
CreateObject(1634, 1977.609253, 1173.492554, 31.168373, 18.0482, 0.0000, 173.7108);
CreateObject(1634, 1977.141602, 1168.407227, 37.125748, 30.0803, 0.0000, 174.5703);
CreateObject(1634, 1976.960449, 1164.884033, 43.635105, 42.9718, 0.0000, 176.2891);
CreateObject(1634, 1992.750000, 1187.686646, 26.818417, 0.0000, 0.0000, 267.2852);
CreateObject(1634, 1993.106079, 1191.398560, 26.868416, 0.0000, 0.0000, 267.2852);
CreateObject(1634, 1982.050903, 1179.531494, 26.818417, 0.0000, 0.0000, 178.8668);
CreateObject(1655, 2113.030273, 1116.183472, 10.795429, 0.0000, 0.0000, 285.4370);
CreateObject(1655, 2115.189941, 1108.199463, 10.788090, 0.0000, 0.0000, 285.4370);
CreateObject(1655, 2145.392090, 1172.697876, 10.788090, 0.0000, 0.0000, 200.3528);
CreateObject(1655, 2137.417236, 1169.717163, 10.820425, 0.0000, 0.0000, 200.3528);
CreateObject(1655, 2001.728149, 1190.952026, 18.061054, 0.0000, 0.0000, 177.9036);
CreateObject(1655, 1994.326294, 1191.225952, 18.061054, 0.0000, 0.0000, 177.9036);
CreateObject(1655, 1894.297485, 1108.251221, 18.136053, 0.0000, 0.0000, 84.3289);
CreateObject(1655, 1978.503784, 1109.425659, 22.618692, 0.0000, 0.0000, 178.0077);
CreateObject(1655, 1986.505249, 1109.225464, 22.568693, 0.0000, 0.0000, 178.0077);
CreateObject(1655, 1993.931274, 1173.526733, 21.393711, 0.0000, 0.0000, 35.3410);
CreateObject(1655, 1984.832275, 1211.516357, 18.086054, 0.0000, 0.0000, 178.0078);
CreateObject(1655, 2014.264404, 1208.380249, 18.072199, 0.0000, 0.0000, 267.3893);
CreateObject(1655, 2040.237915, 1196.422119, 10.671991, 0.0000, 0.0000, 59.5091);
CreateObject(1655, 2041.874512, 1226.246826, 10.707575, 0.0000, 0.0000, 119.6696);
CreateObject(1655, 2038.230591, 1224.160034, 13.569122, 18.0482, 0.0000, 119.6696);
CreateObject(1655, 1986.073364, 1239.360962, 18.086054, 0.0000, 0.0000, 25.9911);
CreateObject(1655, 1978.566406, 1235.760986, 18.086054, 0.0000, 0.0000, 25.9911);
CreateObject(1655, 1885.592651, 1249.760010, 23.987698, 0.0000, 0.0000, 142.8745);
CreateObject(18450, 2067.853516, 1178.708618, 23.364935, 0.0000, 0.0000, 331.6386);
CreateObject(1634, 2033.633545, 1188.894775, 24.731007, 0.0000, 0.0000, 103.9917);
CreateObject(1634, 2033.333252, 1192.520874, 24.681007, 0.0000, 0.0000, 86.8029);
CreateObject(1634, 2033.745361, 1195.913574, 24.706007, 0.0000, 0.0000, 75.6303);
CreateObject(1634, 2034.937500, 1198.482788, 24.731007, 0.0000, 0.0000, 55.0038);
CreateObject(1634, 2036.913696, 1200.504150, 24.708010, 0.0000, 0.0000, 36.9557);
CreateObject(3330, 2203.400146, 1186.819946, 45.474373, 295.5423, 0.8594, 331.6386);
CreateObject(1655, 2200.783203, 1192.367798, 50.866886, 21.4859, 0.0000, 332.7061);
CreateObject(1655, 2208.382813, 1188.358398, 50.823746, 21.4859, 0.0000, 332.7061);
CreateObject(1655, 2206.210693, 1193.299683, 55.572361, 40.3935, 0.0000, 332.7061);
CreateObject(1655, 1995.150879, 1108.882080, 22.568693, 0.0000, 0.0000, 178.0077);
CreateObject(1655, 2002.987183, 1108.650391, 22.543694, 0.0000, 0.0000, 178.0077);
CreateObject(1655, 2002.793213, 1102.159790, 26.390604, 15.4699, 0.0000, 178.0077);
CreateObject(1655, 1995.096069, 1102.432007, 26.394543, 15.4699, 0.0000, 178.0077);
CreateObject(1655, 1901.068726, 1112.977051, 62.861416, 0.0000, 0.0000, 90.3448);
CreateObject(1655, 1901.125366, 1118.680054, 62.834652, 0.0000, 0.0000, 90.3448);
CreateObject(1655, 1891.506592, 1239.685181, 62.861416, 0.0000, 0.0000, 90.3448);
CreateObject(1655, 1886.069824, 1239.663452, 66.072006, 15.4699, 0.0000, 90.3448);
CreateObject(1655, 1904.464233, 1053.663696, 21.850489, 0.0000, 0.0000, 90.3448);
CreateObject(1655, 1904.333008, 1062.243286, 21.875488, 0.0000, 0.0000, 90.3448);
CreateObject(1655, 1904.333618, 1070.929199, 21.875488, 0.0000, 0.0000, 90.3448);
CreateObject(1655, 1904.460938, 1044.939941, 21.875488, 0.0000, 0.0000, 90.3448);
CreateObject(1655, 1898.176636, 1053.569336, 26.193447, 22.3454, 0.0000, 90.3448);
CreateObject(1655, 1898.133545, 1061.945557, 26.170877, 22.3454, 0.0000, 90.3448);
CreateObject(1655, 1967.200806, 1106.093750, 18.036055, 0.0000, 0.0000, 178.8669);
CreateObject(1655, 1966.144653, 1234.450562, 62.436394, 0.0000, 0.0000, 45.6541);
CreateObject(1655, 1957.172607, 1240.051636, 62.111370, 0.0000, 0.0000, 239.0276);
CreateObject(1655, 1958.073975, 1176.679443, 62.436398, 0.0000, 0.0000, 305.2038);
CreateObject(1655, 1964.369019, 1181.519897, 62.136375, 0.0000, 0.0000, 126.4411);
CreateObject(1655, 1952.866333, 1121.182495, 62.186382, 0.0000, 0.0000, 135.0355);
CreateObject(1655, 1943.258789, 1114.765259, 62.136372, 0.0000, 0.0000, 313.6942);
CreateObject(1655, 1852.212891, 1047.332275, 16.606623, 0.0000, 0.0000, 180.5860);
CreateObject(1655, 1846.910645, 1047.317261, 16.581623, 0.0000, 0.0000, 180.5860);
CreateObject(1655, 1846.888184, 1022.839539, 16.775244, 0.0000, 0.0000, 358.3853);
CreateObject(1655, 1853.981445, 1022.623779, 16.800243, 0.0000, 0.0000, 358.3853);
CreateObject(1655, 1854.043823, 943.808838, 16.506624, 0.0000, 0.0000, 214.1043);
CreateObject(1655, 1857.053345, 939.317627, 19.879660, 17.1887, 0.0000, 214.1043);
CreateObject(1655, 1880.225830, 917.370178, 16.581623, 0.0000, 0.0000, 56.8272);
CreateObject(1655, 1877.119873, 919.354431, 18.905249, 16.3293, 0.0000, 56.8272);
CreateObject(1655, 2015.807495, 916.430054, 16.581623, 0.0000, 0.0000, 270.7230);
CreateObject(1655, 2021.294678, 916.530090, 20.176229, 20.6265, 0.0000, 270.7230);
CreateObject(1655, 2090.088379, 971.421509, 10.637636, 0.0000, 0.0000, 233.7672);
CreateObject(1655, 2107.426514, 948.335510, 15.959930, 6.0161, 0.0000, 199.3894);
CreateObject(1655, 2117.288574, 911.181885, 17.004805, 0.0000, 0.0000, 182.2006);
CreateObject(1655, 2117.735596, 896.736816, 15.942299, 11.1727, 0.0000, 2.6825);
CreateObject(1655, 2115.345947, 930.050659, 17.204802, 8.5944, 0.0000, 19.8712);
CreateObject(1655, 2155.601807, 966.850586, 10.670431, 0.0000, 0.0000, 233.7672);
CreateObject(1655, 2213.796631, 947.918640, 15.672132, 0.0000, 0.0000, 270.7230);
CreateObject(1655, 2213.639648, 956.522949, 15.647133, 0.0000, 0.0000, 270.7230);
CreateObject(1655, 2218.402344, 952.968201, 18.373819, 13.7510, 0.0000, 270.7230);
CreateObject(1655, 2407.651123, 1360.115845, 7.314067, 7.7349, 0.0000, 359.2449);
CreateObject(1655, 2414.054199, 1353.234375, 7.695815, 6.8755, 0.0000, 271.5825);
CreateObject(1655, 2414.424316, 1213.387939, 7.471543, 6.8755, 0.0000, 270.7230);
CreateObject(1655, 2407.417969, 1206.571777, 7.464175, 6.8755, 0.0000, 179.6226);
CreateObject(1655, 2012.458740, 1137.986450, 18.086054, 0.0000, 0.0000, 10.4177);
CreateObject(1655, 2029.434937, 1125.349243, 14.495415, 18.0482, 0.0000, 92.0634);
CreateObject(1655, 2021.343628, 1167.647827, 10.745430, 0.0000, 0.0000, 120.4246);
CreateObject(1655, 2016.649536, 1164.944092, 14.890793, 24.9237, 0.0000, 120.4246);
CreateObject(1634, 2096.391357, 1264.067871, 10.767635, 0.0000, 0.0000, 358.2810);
CreateObject(1634, 2096.572998, 1269.891968, 14.516583, 14.6104, 0.0000, 358.2810);
CreateObject(1634, 2096.679932, 1274.651367, 20.291264, 34.3775, 0.0000, 358.2810);
CreateObject(1634, 2096.707031, 1277.202759, 27.042923, 52.4256, 0.0000, 358.2810);
CreateObject(1634, 2096.723877, 1276.718628, 29.777796, 79.9276, 0.0000, 358.2810);
CreateObject(1634, 2096.622070, 1274.769531, 33.226582, 101.4135, 0.0000, 358.2810);
CreateObject(1634, 2096.503418, 1272.924805, 35.178162, 116.8833, 0.0000, 358.2810);
CreateObject(1655, 2029.196289, 1250.736328, 10.770430, 0.0000, 0.0000, 130.8424);
CreateObject(1655, 2024.147461, 1246.406006, 15.248047, 21.4859, 0.0000, 130.8424);
CreateObject(1655, 1995.519409, 1254.901611, 10.795429, 0.0000, 0.0000, 179.8306);
CreateObject(1655, 2011.068604, 1256.734131, 10.870428, 0.0000, 0.0000, 166.0796);
CreateObject(1655, 2009.445801, 1250.349976, 14.321423, 10.3132, 0.0000, 166.0796);
CreateObject(1655, 2034.592041, 1159.912720, 10.695431, 0.0000, 0.0000, 144.5935);
CreateObject(1655, 2030.874512, 1154.678711, 14.622963, 17.1887, 0.0000, 144.5935);
CreateObject(1655, 2024.085083, 1094.098511, 10.646992, 0.0000, 0.0000, 33.8299);
CreateObject(1655, 2020.472046, 1099.486694, 15.241920, 23.2048, 0.0000, 33.8299);
CreateObject(1655, 2119.034668, 1109.374390, 13.763147, 23.2048, 0.0000, 287.1559);
CreateObject(1655, 2122.983154, 1168.474854, 10.745430, 0.0000, 0.0000, 154.0473);
CreateObject(1655, 2120.712891, 1163.753052, 13.758076, 13.7510, 0.0000, 154.0473);
CreateObject(1655, 2088.875732, 1227.585205, 10.795429, 0.0000, 0.0000, 153.0834);
CreateObject(1655, 2085.979980, 1221.857422, 14.870539, 18.0482, 0.0000, 153.0834);
CreateObject(1655, 2083.996582, 1218.047852, 19.937353, 34.3775, 0.0000, 153.0834);
CreateObject(1655, 2109.014893, 1256.784912, 10.870428, 0.0000, 0.0000, 294.8909);
CreateObject(1655, 2112.629639, 1258.576782, 13.366432, 17.1887, 0.0000, 294.8909);
CreateObject(1655, 2162.514893, 1274.765869, 16.351379, 0.0000, 0.0000, 271.6861);
CreateObject(18450, 2107.798584, 1346.646606, 15.748384, 0.0000, 0.0000, 89.3814);
CreateObject(1655, 2096.700195, 1393.617554, 17.382721, 9.4538, 0.0000, 177.9036);
CreateObject(1655, 2105.370605, 1393.240723, 17.397350, 9.4538, 0.0000, 177.9036);
CreateObject(1655, 2114.008789, 1392.927490, 17.352127, 9.4538, 0.0000, 177.9036);
CreateObject(1655, 2122.677246, 1392.499023, 17.460079, 9.4538, 0.0000, 179.6224);
CreateObject(1655, 2131.255615, 1392.442383, 17.454044, 9.4538, 0.0000, 179.6224);
CreateObject(1655, 2139.921875, 1392.378052, 17.493141, 9.4538, 0.0000, 179.6224);
CreateObject(1655, 2148.564697, 1392.278564, 17.511917, 9.4538, 0.0000, 179.6224);
CreateObject(1655, 2096.728516, 1413.579834, 17.426376, 9.4538, 0.0000, 359.2443);
CreateObject(1655, 2105.203857, 1413.442993, 17.421942, 9.4538, 0.0000, 359.2443);
CreateObject(1655, 2113.848145, 1413.351196, 17.430040, 9.4538, 0.0000, 359.2443);
CreateObject(1655, 2122.466553, 1413.215942, 17.445667, 9.4538, 0.0000, 359.2443);
CreateObject(1655, 2130.871094, 1413.081665, 17.425385, 9.4538, 0.0000, 359.2443);
CreateObject(1655, 2139.470703, 1412.907349, 17.400473, 9.4538, 0.0000, 359.2443);
CreateObject(1655, 2148.079834, 1412.769165, 17.360483, 9.4538, 0.0000, 359.2443);
CreateObject(1655, 2173.307617, 1401.676758, 16.453753, 0.0000, 0.0000, 89.3814);
CreateObject(1655, 2173.242432, 1393.627441, 16.453753, 0.0000, 0.0000, 89.3814);
CreateObject(1655, 2173.337891, 1409.939331, 16.478752, 0.0000, 0.0000, 89.3814);
CreateObject(1655, 2167.125244, 1401.826660, 20.869982, 24.9237, 0.0000, 89.3814);
CreateObject(1655, 2088.763672, 1403.369019, 16.144821, 0.0000, 0.0000, 89.3814);
CreateObject(1655, 2082.772217, 1403.384888, 20.186579, 21.4859, 0.0000, 89.3814);
CreateObject(1655, 2104.446289, 1378.401978, 17.167250, 0.0000, 0.0000, 359.9999);
CreateObject(1655, 2111.708496, 1378.471924, 17.192249, 0.0000, 0.0000, 359.9999);
CreateObject(1655, 2110.472412, 1310.093018, 17.142250, 0.0000, 0.0000, 177.0442);
CreateObject(1655, 2104.263672, 1310.416382, 17.142250, 0.0000, 0.0000, 177.0442);
CreateObject(1655, 2107.453613, 1304.978760, 20.842270, 24.0642, 0.0000, 177.0442);
CreateObject(1655, 2081.988037, 1372.994385, 10.701725, 0.0000, 0.0000, 322.1848);
CreateObject(1655, 2086.125488, 1378.349731, 15.276936, 21.4859, 0.0000, 322.1848);
CreateObject(1655, 2184.014404, 1373.687866, 10.695257, 0.0000, 0.0000, 3.4377);
CreateObject(1655, 2183.763672, 1378.540405, 13.792595, 20.6265, 0.0000, 3.4377);
CreateObject(1655, 2200.955811, 1323.530029, 10.820431, 0.0000, 0.0000, 178.7629);
CreateObject(1655, 2200.858398, 1317.654175, 14.218340, 14.6104, 0.0000, 178.7629);
CreateObject(1655, 2200.765137, 1313.587280, 18.351999, 31.7992, 0.0000, 178.7629);
CreateObject(1655, 2191.414307, 1262.125732, 10.671991, 0.0000, 0.0000, 180.4818);
CreateObject(1655, 2183.447754, 1261.991211, 10.696991, 0.0000, 0.0000, 180.4818);
CreateObject(1655, 2179.178467, 1353.634399, 10.595432, 0.0000, 0.0000, 88.5219);
CreateObject(1655, 2172.454590, 1353.688477, 14.820467, 18.0482, 0.0000, 88.5219);
CreateObject(1655, 2068.336914, 1314.473145, 10.646992, 0.0000, 0.0000, 88.5219);
CreateObject(1655, 2061.587158, 1314.617920, 14.299417, 12.0321, 0.0000, 88.5219);
CreateObject(1655, 2059.487549, 1369.023438, 10.679777, 0.0000, 0.0000, 34.3774);
CreateObject(1655, 2055.831055, 1374.293579, 10.696991, 0.0000, 0.0000, 214.7550);
CreateObject(1655, 2001.992554, 1284.198120, 10.845428, 0.0000, 0.0000, 60.1605);
CreateObject(1655, 1995.891479, 1287.708740, 15.269648, 18.0482, 0.0000, 60.1605);
CreateObject(1655, 2029.609985, 1342.844727, 10.820429, 0.0000, 0.0000, 89.3814);
CreateObject(1655, 2020.144409, 1420.344971, 10.870428, 0.0000, 0.0000, 103.1323);
CreateObject(1655, 2013.976318, 1418.898804, 14.363232, 12.8916, 0.0000, 103.1323);
CreateObject(1655, 1899.015259, 1398.216919, 9.182930, 0.0000, 0.0000, 90.2407);
CreateObject(1655, 1894.081299, 1398.251465, 12.419456, 21.4859, 0.0000, 90.2407);
CreateObject(1655, 1970.662354, 1450.672729, 10.621992, 0.0000, 0.0000, 122.0400);
CreateObject(1655, 1968.568970, 1449.295898, 12.091372, 16.3293, 0.0000, 122.0400);
CreateObject(1655, 1844.416504, 1289.835693, 16.922461, 0.0000, 0.0000, 183.9195);
CreateObject(1655, 1844.879150, 1283.786011, 21.109169, 22.3454, 0.0000, 183.9195);
CreateObject(1655, 1853.491089, 1291.294922, 16.947460, 0.0000, 0.0000, 198.5300);
CreateObject(1655, 1855.331421, 1285.789307, 20.211519, 12.8916, 0.0000, 198.5300);
CreateObject(1655, 1870.406616, 1383.952026, 16.872461, 0.0000, 0.0000, 226.8916);
CreateObject(1655, 1864.663574, 1377.770508, 16.897461, 0.0000, 0.0000, 226.8916);
CreateObject(1655, 1873.947632, 1380.721924, 19.477295, 11.1727, 0.0000, 226.8916);
CreateObject(1655, 1913.731812, 1360.548096, 24.693867, 0.0000, 0.0000, 270.7226);
CreateObject(1655, 1913.305054, 1352.062012, 25.093861, 6.8755, 0.0000, 270.7226);
CreateObject(1655, 1913.978760, 1328.660400, 24.668867, 0.0000, 0.0000, 230.3294);
CreateObject(1655, 1908.590942, 1322.050415, 24.693867, 0.0000, 0.0000, 230.3294);
CreateObject(1655, 1913.007080, 1318.358032, 28.087133, 14.6104, 0.0000, 230.3294);
CreateObject(1633, 1899.124268, 1339.270264, 24.744045, 0.0000, 0.0000, 91.1002);
CreateObject(1633, 1894.521973, 1339.221313, 26.867674, 25.7831, 0.0000, 91.1002);
CreateObject(1633, 1888.604004, 1339.239014, 32.124439, 25.7831, 0.0000, 91.1002);
CreateObject(1633, 1883.406250, 1339.273804, 38.051407, 37.8152, 0.0000, 91.1002);
CreateObject(1633, 1879.331787, 1339.108398, 43.561325, 37.8152, 0.0000, 91.1002);
CreateObject(1633, 1875.179932, 1339.075562, 49.233124, 37.8152, 0.0000, 91.1002);
CreateObject(1633, 1911.548218, 1293.294312, 55.398354, 0.0000, 0.0000, 266.3213);
CreateObject(1633, 1911.767944, 1303.960449, 55.398354, 0.0000, 0.0000, 272.3374);
CreateObject(1633, 1864.708008, 1292.754639, 55.398361, 0.0000, 0.0000, 228.5060);
CreateObject(1633, 1869.262573, 1288.685913, 57.745491, 9.4538, 0.0000, 228.5060);
CreateObject(1633, 1873.946045, 1284.494995, 60.754929, 9.4538, 0.0000, 228.5060);
CreateObject(1633, 1878.389771, 1280.537598, 63.551651, 9.4538, 0.0000, 228.5060);
CreateObject(1633, 1883.361084, 1276.134521, 66.682610, 9.4538, 0.0000, 228.5060);
CreateObject(1633, 1888.410156, 1271.679199, 69.884407, 9.4538, 0.0000, 228.5060);
CreateObject(1633, 1892.659180, 1267.855347, 72.624100, 9.4538, 0.0000, 228.5060);
CreateObject(1633, 1897.173584, 1263.781738, 75.480942, 9.4538, 0.0000, 228.5060);
CreateObject(1655, 1940.398438, 1374.697876, 15.793591, 0.0000, 0.0000, 324.1116);
CreateObject(1655, 1990.197266, 1395.160156, 9.082932, 0.0000, 0.0000, 270.8266);
CreateObject(1655, 1995.572388, 1395.271362, 12.229017, 14.6104, 0.0000, 270.8266);
CreateObject(1655, 1942.430420, 1361.851929, 15.793589, 0.0000, 0.0000, 239.8869);
CreateObject(1655, 2061.942871, 1189.168579, 10.746990, 0.0000, 0.0000, 213.2442);
CreateObject(1655, 2044.417603, 1087.897095, 10.671991, 0.0000, 0.0000, 134.1759);
CreateObject(1655, 2039.549805, 1083.143799, 14.968399, 18.0482, 0.0000, 134.1759);
CreateObject(1655, 1966.134277, 1074.632202, 21.850489, 0.0000, 0.0000, 0.9638);
CreateObject(1655, 1974.804932, 1074.840698, 21.875488, 0.0000, 0.0000, 0.9638);
CreateObject(1655, 1982.529175, 1074.930908, 21.875488, 0.0000, 0.0000, 0.9638);
CreateObject(1655, 1978.516724, 1081.949219, 26.055248, 15.4699, 0.0000, 0.9638);
CreateObject(1655, 1966.259521, 1034.428589, 21.875488, 0.0000, 0.0000, 224.3146);
CreateObject(1655, 1970.680786, 1029.853027, 25.394035, 12.8916, 0.0000, 224.3146);
CreateObject(1655, 1974.052002, 1026.545410, 29.800024, 27.5020, 0.0000, 224.3146);
CreateObject(1655, 2017.722168, 993.729309, 39.066189, 0.0000, 0.0000, 229.4713);
CreateObject(1655, 2022.201782, 989.882996, 42.506664, 14.6104, 0.0000, 229.4713);
CreateObject(1655, 2018.051147, 1023.049744, 39.116192, 0.0000, 0.0000, 317.9934);
CreateObject(1655, 2021.833618, 1027.236694, 42.512119, 17.1887, 0.0000, 317.9934);
CreateObject(1655, 1996.659790, 988.933533, 38.991184, 0.0000, 0.0000, 178.7653);
CreateObject(1655, 1925.942017, 1319.023926, 15.668459, 0.0000, 0.0000, 142.6681);
CreateObject(1655, 1947.018433, 1319.948486, 15.893587, 0.0000, 0.0000, 230.3294);
CreateObject(1655, 1951.579102, 1316.132446, 19.066544, 11.1727, 0.0000, 230.3294);
CreateObject(1655, 1961.944580, 1291.972656, 10.820429, 0.0000, 0.0000, 43.0758);
CreateObject(1655, 1957.419800, 1296.730591, 14.547640, 13.7510, 0.0000, 43.0758);
CreateObject(1655, 2075.210205, 1298.683594, 10.721991, 0.0000, 0.0000, 319.7104);
CreateObject(1655, 2079.697998, 1303.989868, 14.862385, 16.3293, 0.0000, 319.7104);
CreateObject(1655, 2115.080566, 1032.766602, 10.778509, 0.0000, 0.0000, 23.3087);
CreateObject(1655, 2112.514404, 1038.552490, 14.270746, 12.0321, 0.0000, 23.3087);
CreateObject(1655, 2172.939453, 1107.543701, 23.285923, 0.0000, 0.0000, 243.2205);
CreateObject(1655, 2182.324463, 1125.064331, 23.361053, 0.0000, 0.0000, 243.2205);
CreateObject(1655, 2201.326416, 1118.197754, 26.653242, 0.0000, 0.0000, 243.2205);
CreateObject(1655, 2192.866943, 1100.870972, 26.678242, 0.0000, 0.0000, 225.1725);
CreateObject(1655, 2216.443359, 1084.978027, 29.554125, 0.0000, 0.0000, 243.2205);
CreateObject(1655, 2237.440674, 1077.554443, 33.473530, 0.0000, 0.0000, 258.6903);
CreateObject(1655, 2242.868408, 1076.449951, 36.858742, 18.9076, 0.0000, 258.6903);
CreateObject(1655, 2286.225098, 1078.144653, 29.850111, 6.8755, 0.0000, 241.5017);
CreateObject(1655, 2257.651123, 1124.627197, 33.548534, 0.0000, 0.0000, 312.8343);
CreateObject(1655, 2268.643311, 1120.724121, 29.325117, 0.0000, 0.0000, 323.1475);
CreateObject(1655, 2146.984863, 1051.830566, 10.820429, 0.0000, 0.0000, 33.6220);
CreateObject(1655, 2143.184814, 1057.518311, 14.767033, 14.6104, 0.0000, 33.6220);
CreateObject(1655, 1893.529785, 1094.822510, 10.694075, 0.0000, 0.0000, 214.1040);
CreateObject(1655, 1897.163574, 1089.431030, 14.311029, 13.7510, 0.0000, 214.1040);
CreateObject(13641, 2117.548828, 1118.158081, 15.120859, 0.0000, 335.9358, 14.6104);
CreateObject(13645, 2043.066406, 1145.558838, 10.289736, 0.0000, 0.0000, 0.0000);
CreateObject(13645, 2045.791138, 1145.620361, 10.289736, 0.0000, 0.0000, 0.0000);
CreateObject(1655, 2044.350830, 1041.738037, 10.696991, 0.0000, 0.0000, 175.4289);


//=======================Lv Map============================
AddStaticVehicleEx(522,1549.22912598,1854.20861816,10.34054184,100.00000000,-1,-1,15); //NRG-500
AddStaticVehicleEx(522,1549.04492188,1851.07348633,10.34054184,99.99755859,-1,-1,15); //NRG-500
AddStaticVehicleEx(522,1548.76953125,1846.37145996,10.34054184,99.99755859,-1,-1,15); //NRG-500
AddStaticVehicleEx(522,1548.49414062,1841.66931152,10.34054184,99.99755859,-1,-1,15); //NRG-500
AddStaticVehicleEx(522,1548.12695312,1835.39990234,10.34054184,99.99755859,-1,-1,15); //NRG-500
AddStaticVehicleEx(522,1547.85156250,1830.69763184,10.34054184,99.99755859,-1,-1,15); //NRG-500
AddStaticVehicleEx(522,1547.57617188,1825.99548340,10.34054184,99.99755859,-1,-1,15); //NRG-500
CreateObject(18449,1485.58007812,1709.72070312,9.72545242,0.00000000,0.00000000,94.00000000); //object(cs_roadbridge01) (1)
CreateObject(18449,1484.14538574,1702.40905762,57.31738281,0.00000000,180.00000000,90.00000000); //object(cs_roadbridge01) (4)
CreateObject(18449,1484.84752897,1720.53164562,10.03892913,0.36309237,-3.44485516,93.76823070); //object(cs_roadbridge01) (5)
CreateObject(18449,1484.23832354,1730.16907266,10.93824754,0.71859890,-7.36107698,93.57253701); //object(cs_roadbridge01) (6)
CreateObject(18449,1483.74347437,1738.64207960,12.36174011,1.05685567,-11.89471989,93.41777517); //object(cs_roadbridge01) (7)
CreateObject(18449,1483.35399397,1745.95976176,14.24773930,1.36104679,-17.25708654,93.30752808); //object(cs_roadbridge01) (8)
CreateObject(18449,1483.06089487,1752.13121451,16.53457755,1.60142071,-23.75666095,93.23886803); //object(cs_roadbridge01) (9)
CreateObject(18449,1482.85518959,1757.16553318,19.16058731,1.72715814,-31.83826123,93.18680698); //object(cs_roadbridge01) (10)
CreateObject(18449,1482.72789066,1761.07181311,22.06410104,1.66857389,-42.10201642,93.06698413); //object(cs_roadbridge01) (11)
CreateObject(18449,1482.67001061,1763.85914966,25.18345119,1.41902493,-55.19724773,92.71242636); //object(cs_roadbridge01) (12)
CreateObject(18449,1482.67256195,1765.53663816,28.45697021,1.25993655,-71.35906950,92.21434144); //object(cs_roadbridge01) (13)
CreateObject(18449,1482.72655721,1766.11337395,31.82299056,1.31331982,-89.55198513,92.12333314); //object(cs_roadbridge01) (14)
CreateObject(18449,1482.82300891,1765.59845239,35.21984468,1.35520427,-107.36448777,91.86293898); //object(cs_roadbridge01) (15)
CreateObject(18449,1482.95292959,1764.00096881,38.58586502,1.64438467,-122.69622216,91.28847626); //object(cs_roadbridge01) (16)
CreateObject(18449,1483.10733175,1761.33001855,41.85938404,1.92651217,-134.98649644,90.99696617); //object(cs_roadbridge01) (17)
CreateObject(18449,1483.27722794,1757.59469698,44.97873419,2.00056107,-144.67738589,90.92809642); //object(cs_roadbridge01) (18)
CreateObject(18449,1483.45363066,1752.80409941,47.88224792,1.89654076,-152.42776446,90.91358725); //object(cs_roadbridge01) (19)
CreateObject(18449,1483.62755246,1746.96732121,50.50825769,1.67891853,-158.78912960,90.87760053); //object(cs_roadbridge01) (20)
CreateObject(18449,1483.79000584,1740.09345771,52.79509594,1.39380298,-164.15742860,90.79628925); //object(cs_roadbridge01) (21)
CreateObject(18449,1483.93200333,1732.19160426,54.68109512,1.06936863,-168.80427565,90.66530494); //object(cs_roadbridge01) (22)
CreateObject(18449,1484.04455746,1723.27085619,56.10458770,0.72256032,-172.91494204,90.48656638); //object(cs_roadbridge01) (23)
CreateObject(18449,1484.11868076,1713.34030887,57.00390611,0.36385333,-176.61707174,90.26359546); //object(cs_roadbridge01) (24)
CreateObject(18450,1415.35778809,1710.49645996,9.63850307,0.00000000,0.00000000,100.00000000); //object(cs_roadbridge04) (1)
CreateObject(18450,1483.78230052,1691.58584785,57.00333339,4.85338789,176.53665895,86.28688146); //object(cs_roadbridge04) (2)
CreateObject(18450,1482.73446572,1681.96480036,56.10237195,10.02418816,172.55762838,82.67332500); //object(cs_roadbridge04) (3)
CreateObject(18450,1481.06401262,1673.53307359,54.67627869,15.56781420,167.88882956,79.25487037); //object(cs_roadbridge04) (4)
CreateObject(18450,1478.83307250,1666.27782599,52.78683383,21.52512438,162.29380688,76.20992778); //object(cs_roadbridge04) (5)
CreateObject(18450,1476.10377665,1660.18621600,50.49581758,27.88348674,155.44457126,73.85225532); //object(cs_roadbridge04) (6)
CreateObject(18450,1472.93825633,1655.24540206,47.86501015,34.50352674,146.88578906,72.69579134); //object(cs_roadbridge04) (7)
CreateObject(18450,1469.39868164,1651.44250488,44.95619202,41.01260376,136.02435303,73.48690796); //object(cs_roadbridge04) (8)
CreateObject(18450,1465.54706746,1648.76479610,41.83114264,46.71517788,122.26851128,77.05847804); //object(cs_roadbridge04) (9)
CreateObject(18450,1461.44566146,1647.19932097,38.55164297,50.66031261,105.56205609,83.74751063); //object(cs_roadbridge04) (10)
CreateObject(18450,1457.15655613,1646.73327566,35.17947299,52.03510926,87.20510159,92.50075217); //object(cs_roadbridge04) (11)
CreateObject(18450,1452.74188275,1647.35381861,31.77641290,50.71139149,69.65579761,101.01408080); //object(cs_roadbridge04) (12)
CreateObject(18450,1448.26377261,1649.04810827,28.40424291,47.29335371,54.79208911,107.45415714); //object(cs_roadbridge04) (13)
CreateObject(18450,1443.78435697,1651.80330307,25.12474325,42.60008838,42.98542795,111.40607980); //object(cs_roadbridge04) (14)
CreateObject(18450,1439.36576713,1655.60656147,21.99969412,37.26520268,33.72948792,113.28098691); //object(cs_roadbridge04) (15)
CreateObject(18450,1435.07013436,1660.44504190,19.09087573,31.67547691,26.36173769,113.62662679); //object(cs_roadbridge04) (16)
CreateObject(18450,1430.95958995,1666.30590280,16.46006831,26.04553850,20.33735939,112.87430364); //object(cs_roadbridge04) (17)
CreateObject(18450,1427.09626518,1673.17630263,14.16905206,20.49201873,15.26160869,111.31713627); //object(cs_roadbridge04) (18)
CreateObject(18450,1423.54229132,1681.04339981,12.27960720,15.07971303,10.85781411,109.14596174); //object(cs_roadbridge04) (19)
CreateObject(18450,1420.35979967,1689.89435280,10.85351394,9.84633073,6.93190418,106.48507824); //object(cs_roadbridge04) (20)
CreateObject(18450,1417.61092150,1699.71632004,9.95255249,4.81493819,3.34590957,103.41732875); //object(cs_roadbridge04) (21)
CreateObject(1655,1546.17126465,1506.12255859,11.14864349,0.00000000,0.00000000,170.00000000); //object(waterjumpx2) (1)
CreateObject(1655,1545.04162598,1499.21435547,16.17864227,23.98446655,357.81091309,168.88708496); //object(waterjumpx2) (2)
CreateObject(1655,1543.99804688,1493.30493164,22.17864227,23.98315430,357.80822754,168.88183594); //object(waterjumpx2) (3)
CreateObject(1655,1543.00646973,1487.38122559,28.17864227,23.98315430,357.80822754,168.88183594); //object(waterjumpx2) (4)
CreateObject(1655,1541.99353027,1481.44799805,34.17864227,23.98315430,357.80822754,168.88183594); //object(waterjumpx2) (5)
CreateObject(1634,1275.07360840,1290.28320312,11.11027718,0.00000000,0.00000000,0.00000000); //object(landjump2) (1)
CreateObject(1634,1275.12878418,1298.37915039,14.61027718,0.00000000,0.00000000,0.00000000); //object(landjump2) (2)
CreateObject(1634,1275.18347168,1306.47485352,18.11027718,0.00000000,0.00000000,0.00000000); //object(landjump2) (3)
CreateObject(18449,1276.47900391,1365.24975586,15.13116932,0.00000000,0.00000000,268.00000000); //object(cs_roadbridge01) (45)
CreateObject(1634,1276.87365723,1405.73254395,16.77223778,0.00000000,0.00000000,0.00000000); //object(landjump2) (4)
CreateObject(1634,1276.93896484,1413.23242188,21.52223778,16.00000000,0.00000000,0.00000000); //object(landjump2) (5)
CreateObject(3602,1281.33691406,1438.66320801,16.82969284,0.00000000,0.00000000,0.00000000); //object(hillhouse05_la) (1)
CreateObject(13638,1285.26013184,1451.36486816,26.22835732,0.00000000,0.00000000,268.00000000); //object(stunt1) (1)
CreateObject(13638,1296.48242188,1448.45263672,32.97835541,0.00000000,4.00000000,177.99499512); //object(stunt1) (2)
CreateObject(13638,1306.43786621,1436.49938965,41.22835541,0.00000000,3.99902344,177.98950195); //object(stunt1) (3)
CreateObject(13638,1315.93823242,1424.15893555,49.22835541,0.00000000,3.99902344,177.98950195); //object(stunt1) (4)
CreateObject(13641,1320.54699707,1418.32507324,55.24254608,0.00000000,0.00000000,0.00000000); //object(kickramp04) (1)
CreateObject(13647,1463.44372559,1377.87951660,30.70030975,0.00000000,0.00000000,270.00000000); //object(wall1) (1)
CreateObject(18367,1463.65527344,1366.55541992,34.27843475,0.00000000,0.00000000,0.00000000); //object(cw2_bikelog) (1)
CreateObject(18367,1463.83203125,1337.10742188,37.27843475,0.00000000,0.00000000,0.00000000); //object(cw2_bikelog) (2)
CreateObject(18367,1463.93261719,1306.98425293,40.52843475,0.00000000,0.00000000,0.00000000); //object(cw2_bikelog) (3)
CreateObject(18367,1464.17358398,1277.59594727,43.27843475,0.00000000,0.00000000,0.00000000); //object(cw2_bikelog) (4)
CreateObject(18367,1462.58203125,1245.76586914,46.52843475,0.00000000,0.00000000,90.00000000); //object(cw2_bikelog) (5)
CreateObject(18367,1491.86779785,1245.53784180,49.52843475,0.00000000,0.00000000,180.00000000); //object(cw2_bikelog) (6)
CreateObject(18367,1491.86718750,1245.53710938,49.52843475,0.00000000,0.00000000,179.99450684); //object(cw2_bikelog) (7)
CreateObject(1634,1491.58544922,1279.79968262,54.19127274,0.00000000,0.00000000,0.00000000); //object(landjump2) (7)
CreateObject(1634,1491.54858398,1287.80346680,57.69127274,0.00000000,0.00000000,0.00000000); //object(landjump2) (8)
CreateObject(1634,1491.57446289,1295.80798340,61.19127274,0.00000000,0.00000000,0.00000000); //object(landjump2) (9)
CreateObject(10377,1506.42602539,1367.02648926,47.56622314,0.00000000,0.00000000,0.00000000); //object(cityhall_sfs) (1)
CreateObject(1634,1498.39428711,1324.38427734,53.02347565,0.00000000,0.00000000,0.00000000); //object(landjump2) (10)
CreateObject(1634,1498.40710449,1331.59106445,57.77347565,18.00000000,0.00000000,0.00000000); //object(landjump2) (11)
CreateObject(1634,1498.35852051,1338.08483887,64.02347565,17.99560547,0.00000000,0.00000000); //object(landjump2) (12)
CreateObject(1634,1498.36279297,1344.58435059,69.77347565,17.99560547,0.00000000,0.00000000); //object(landjump2) (13)
CreateObject(1634,1498.31713867,1351.07800293,75.52347565,17.99560547,0.00000000,0.00000000); //object(landjump2) (14)
CreateObject(1634,1501.86608887,1417.82409668,52.06018448,0.00000000,0.00000000,0.00000000); //object(landjump2) (15)
CreateObject(1634,1498.32910156,1417.83837891,52.06018448,0.00000000,0.00000000,0.00000000); //object(landjump2) (16)
CreateObject(1634,1494.79296875,1417.85302734,52.06018448,0.00000000,0.00000000,0.00000000); //object(landjump2) (17)
CreateObject(3270,1388.06164551,1433.41491699,9.82031250,0.00000000,0.00000000,102.00000000); //object(bonyrd_block2_) (1)
CreateObject(3270,1388.12207031,1429.41406250,11.82031250,0.00000000,0.00000000,101.99707031); //object(bonyrd_block2_) (2)
CreateObject(3270,1390.23535156,1421.22241211,14.07031250,0.00000000,0.00000000,101.99707031); //object(bonyrd_block2_) (3)
CreateObject(3270,1391.90490723,1409.59216309,19.07031250,358.04373169,12.00711060,102.41305542); //object(bonyrd_block2_) (4)
CreateObject(13592,1371.20654297,1530.31164551,21.38310623,0.00000000,0.00000000,0.00000000); //object(loopbig) (1)
CreateObject(13592,1372.18273926,1536.23254395,21.38310623,0.00000000,0.00000000,0.00000000); //object(loopbig) (2)
CreateObject(13592,1373.28234863,1543.60339355,21.38310623,0.00000000,0.00000000,0.00000000); //object(loopbig) (3)
CreateObject(13592,1374.31860352,1550.63696289,21.38310623,0.00000000,0.00000000,0.00000000); //object(loopbig) (4)
CreateObject(13592,1375.37841797,1557.91406250,21.38310623,0.00000000,0.00000000,0.00000000); //object(loopbig) (5)
CreateObject(13666,1588.48474121,1586.68139648,14.87651062,0.00000000,0.00000000,0.00000000); //object(loopwee) (1)
CreateObject(13666,1591.86926270,1579.04614258,14.87651062,0.00000000,0.00000000,0.00000000); //object(loopwee) (2)
CreateObject(13666,1595.39123535,1572.63354492,14.87651062,0.00000000,0.00000000,0.00000000); //object(loopwee) (3)
CreateObject(13666,1598.65832520,1565.29443359,14.87651062,0.00000000,0.00000000,0.00000000); //object(loopwee) (4)
CreateObject(13666,1602.33203125,1557.86035156,14.87651062,0.00000000,0.00000000,2.00000000); //object(loopwee) (5)
CreateObject(13666,1606.06738281,1551.45788574,14.87651062,0.00000000,0.00000000,1.99951172); //object(loopwee) (6)
CreateObject(1632,1464.90405273,1474.09826660,11.12042427,0.00000000,0.00000000,180.00000000); //object(waterjump1) (1)
CreateObject(1632,1464.91784668,1466.00512695,14.12042427,0.00000000,0.00000000,179.99450684); //object(waterjump1) (9)
CreateObject(1632,1464.97326660,1457.89904785,17.12042427,0.00000000,0.00000000,179.99450684); //object(waterjump1) (10)
CreateObject(1632,1465.10913086,1451.13464355,22.12042427,26.00000000,0.00000000,179.99450684); //object(waterjump1) (11)
CreateObject(1632,1465.11730957,1444.84851074,27.87042427,17.99914551,0.00000000,179.99450684); //object(waterjump1) (13)
CreateObject(18367,1464.73632812,1442.13220215,30.27843475,3.99755859,2.00488281,5.86016846); //object(cw2_bikelog) (10)
CreateObject(18367,1466.38427734,1429.53479004,30.52843475,3.99353027,1.99951172,355.85571289); //object(cw2_bikelog) (11)
CreateObject(13592,1489.12048340,1161.29040527,26.30747223,0.00000000,0.00000000,280.00000000); //object(loopbig) (6)
CreateObject(1632,1494.72131348,1149.50305176,17.39808655,0.00000000,0.00000000,190.00000000); //object(waterjump1) (14)
CreateObject(7072,1711.19848633,1589.49755859,25.55412483,0.00000000,0.00000000,0.00000000); //object(vegascowboy3) (1)
CreateObject(7072,1715.36938477,1629.07324219,25.55412483,0.00000000,0.00000000,0.00000000); //object(vegascowboy3) (2)
CreateObject(1631,1425.69152832,1788.38671875,10.51909256,0.00000000,0.00000000,0.00000000); //object(waterjump2) (1)
CreateObject(1632,1527.85083008,1311.97033691,11.17890549,0.00000000,0.00000000,180.00000000); //object(waterjump1) (15)
CreateObject(3269,1523.76025391,1273.05065918,9.81250000,0.00000000,0.00000000,0.00000000); //object(bonyrd_block1_) (1)
CreateObject(3625,1558.11877441,1329.03796387,12.70622253,0.00000000,0.00000000,0.00000000); //object(crgostntrmp) (1)
CreateObject(3625,1568.40161133,1328.48352051,15.20622253,0.00000000,0.00000000,0.00000000); //object(crgostntrmp) (2)
CreateObject(3625,1579.41235352,1328.46191406,17.95622253,0.00000000,0.00000000,0.00000000); //object(crgostntrmp) (3)
CreateObject(3625,1588.76184082,1328.39172363,21.45622253,0.00000000,0.00000000,0.00000000); //object(crgostntrmp) (4)
CreateObject(3625,1599.76171875,1328.31103516,24.45622253,0.00000000,0.00000000,0.00000000); //object(crgostntrmp) (5)
CreateObject(3625,1608.76171875,1328.24462891,26.95622253,0.00000000,0.00000000,0.00000000); //object(crgostntrmp) (6)
CreateObject(3625,1620.76171875,1328.30859375,29.70622253,0.00000000,0.00000000,0.00000000); //object(crgostntrmp) (7)
CreateObject(3625,1625.51171875,1328.33410645,32.20622253,0.00000000,0.00000000,0.00000000); //object(crgostntrmp) (8)
CreateObject(3625,1629.02038574,1328.32556152,33.95622253,0.00000000,0.00000000,0.00000000); //object(crgostntrmp) (9)
CreateObject(3625,1633.82702637,1328.21032715,36.70622253,0.00000000,0.00000000,0.00000000); //object(crgostntrmp) (10)
CreateObject(1632,1639.20581055,1333.16369629,38.14696121,0.00000000,0.00000000,270.00000000); //object(waterjump1) (16)
CreateObject(1632,1639.28210449,1329.15637207,38.14696121,0.00000000,0.00000000,270.00000000); //object(waterjump1) (17)
CreateObject(1632,1639.29711914,1325.89697266,38.14696121,0.00000000,0.00000000,270.00000000); //object(waterjump1) (18)
CreateObject(13590,1534.50793457,1757.77844238,12.19615555,0.00000000,0.00000000,0.00000000); //object(kickbus04) (1)
CreateObject(13593,1525.28320312,1754.16735840,10.56317139,0.00000000,0.00000000,0.00000000); //object(kickramp03) (1)
CreateObject(13636,1344.09448242,1589.51110840,12.10070419,0.00000000,0.00000000,0.00000000); //object(logramps) (1)
CreateObject(1632,1607.87707520,1543.54626465,11.11533546,0.00000000,0.00000000,180.00000000); //object(waterjump1) (19)
CreateObject(1632,1607.75842285,1536.29382324,15.36533546,16.00000000,0.00000000,179.99450684); //object(waterjump1) (20)
CreateObject(1632,1607.66064453,1529.94116211,21.36533546,27.99609375,0.00000000,179.99450684); //object(waterjump1) (21)
CreateObject(1632,1611.79602051,1499.07067871,21.58819008,0.00000000,0.00000000,240.00000000); //object(waterjump1) (22)
CreateObject(1632,1639.41625977,1471.73046875,27.83819008,0.00000000,0.00000000,239.99633789); //object(waterjump1) (23)
CreateObject(1632,1326.45141602,1295.63525391,11.12042427,0.00000000,0.00000000,96.00000000); //object(waterjump1) (24)
CreateObject(1632,1326.49853516,1309.05444336,11.12042427,0.00000000,0.00000000,95.99853516); //object(waterjump1) (25)
CreateObject(1632,1326.55090332,1323.64306641,11.12042427,0.00000000,0.00000000,95.99853516); //object(waterjump1) (26)
CreateObject(4585,1310.48352051,1837.58166504,30.44990540,0.00000000,301.99996948,0.00000000); //object(towerlan2) (1)
CreateObject(1632,1231.26074219,1856.08105469,100.82453156,0.00000000,0.00000000,90.00000000); //object(waterjump1) (27)
CreateObject(1632,1231.09228516,1851.96240234,100.82453156,0.00000000,0.00000000,90.00000000); //object(waterjump1) (28)
CreateObject(1632,1231.11743164,1848.13867188,100.82453156,0.00000000,0.00000000,90.00000000); //object(waterjump1) (29)
CreateObject(1632,1231.11718750,1848.13867188,100.82453156,0.00000000,0.00000000,90.00000000); //object(waterjump1) (30)
CreateObject(1632,1231.19348145,1844.07067871,100.82453156,0.00000000,0.00000000,90.00000000); //object(waterjump1) (31)
CreateObject(1632,1231.26965332,1840.00231934,100.82453156,0.00000000,0.00000000,90.00000000); //object(waterjump1) (32)
CreateObject(1632,1231.38159180,1835.76562500,100.82453156,0.00000000,0.00000000,90.00000000); //object(waterjump1) (33)
CreateObject(1632,1231.41345215,1831.91174316,100.82453156,0.00000000,0.00000000,90.00000000); //object(waterjump1) (34)
CreateObject(1632,1231.25158691,1827.76184082,100.82453156,0.00000000,0.00000000,90.00000000); //object(waterjump1) (35)
CreateObject(1632,1231.27661133,1823.93847656,100.82453156,0.00000000,0.00000000,90.00000000); //object(waterjump1) (36)
CreateObject(1632,1231.10791016,1819.81982422,100.82453156,0.00000000,0.00000000,90.00000000); //object(waterjump1) (37)
CreateObject(18245,1450.24401855,1776.81896973,22.87505722,0.00000000,0.00000000,90.00000000); //object(cuntwjunk02) (1)
CreateObject(1634,1451.70410156,1718.89025879,11.11763000,0.00000000,0.00000000,0.00000000); //object(landjump2) (6)
CreateObject(1634,1451.92028809,1776.11169434,30.70762634,0.00000000,0.00000000,0.00000000); //object(landjump2) (19)
CreateObject(1634,1452.04760742,1783.79443359,35.45762634,16.00000000,0.00000000,0.00000000); //object(landjump2) (21)
CreateObject(1634,1452.10998535,1790.53356934,41.20762634,15.99609375,0.00000000,0.00000000); //object(landjump2) (22)
CreateObject(13594,1451.59765625,1795.18334961,46.21024323,0.00000000,0.00000000,0.00000000); //object(fireyfire) (1)
CreateObject(16776,1415.39086914,1310.41027832,9.82031250,0.00000000,0.00000000,268.00000000); //object(des_cockbody) (1)
CreateObject(16776,1378.45727539,1313.03735352,9.82031250,0.00000000,0.00000000,87.99499512); //object(des_cockbody) (3)
CreateObject(1634,1402.35192871,1321.78308105,11.11763000,0.00000000,0.00000000,180.00000000); //object(landjump2) (23)
CreateObject(1634,1392.79052734,1320.29296875,11.11763000,0.00000000,0.00000000,179.99450684); //object(landjump2) (24)
CreateObject(1222,1456.31848145,1262.44006348,24.42882729,0.00000000,0.00000000,0.00000000); //object(barrel3) (1)
CreateObject(1225,1398.11181641,1322.83056641,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (1)
CreateObject(1225,1397.12695312,1322.65380859,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (2)
CreateObject(1225,1396.14257812,1322.47705078,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (3)
CreateObject(1225,1396.36291504,1321.24609375,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (4)
CreateObject(1225,1397.10058594,1321.37829590,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (5)
CreateObject(1225,1397.83886719,1321.51013184,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (6)
CreateObject(1225,1398.10327148,1320.03320312,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (7)
CreateObject(1225,1397.11816406,1319.85693359,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (8)
CreateObject(1225,1396.37988281,1319.72424316,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (9)
CreateObject(1225,1396.37988281,1319.72363281,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (10)
CreateObject(1225,1396.63696289,1318.24560547,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (11)
CreateObject(1225,1397.37573242,1318.37365723,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (12)
CreateObject(1225,1398.11401367,1318.50158691,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (13)
CreateObject(1225,1398.37036133,1317.02294922,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (14)
CreateObject(1225,1397.38476562,1316.85107422,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (15)
CreateObject(1225,1396.89208984,1316.76489258,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (16)
CreateObject(1225,1397.06298828,1315.77929688,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (17)
CreateObject(1225,1397.64086914,1315.37231445,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (18)
CreateObject(1225,1398.37963867,1315.50061035,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (19)
CreateObject(1225,1398.55029297,1314.51464844,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (20)
CreateObject(1225,1397.56445312,1314.34326172,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (21)
CreateObject(1225,1396.57910156,1314.17138672,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (22)
CreateObject(1225,1396.79333496,1312.93920898,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (23)
CreateObject(1225,1397.28564453,1313.02416992,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (24)
CreateObject(1225,1398.51684570,1313.23767090,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (25)
CreateObject(1225,1398.51660156,1313.23730469,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (26)
CreateObject(1225,1397.42065430,1311.78076172,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (27)
CreateObject(1225,1398.91113281,1311.94287109,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (28)
CreateObject(1225,1396.42578125,1311.67138672,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (29)
CreateObject(1225,1396.56127930,1310.42822266,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (30)
CreateObject(1225,1398.05175781,1310.59033203,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (31)
CreateObject(1225,1399.29443359,1310.72534180,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (32)
CreateObject(1225,1399.40234375,1309.73046875,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (33)
CreateObject(1225,1398.15966797,1309.59497070,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (34)
CreateObject(1225,1396.41943359,1309.40502930,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (35)
CreateObject(1225,1396.60864258,1307.66455078,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (36)
CreateObject(1225,1397.85107422,1307.79956055,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (37)
CreateObject(1225,1399.09326172,1307.93432617,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (38)
CreateObject(1225,1399.09277344,1307.93359375,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (39)
CreateObject(12990,1441.96997070,1317.38464355,13.93368721,334.00000000,0.00000000,0.00000000); //object(sw_jetty) (1)
CreateObject(12990,1441.83422852,1290.44335938,21.60368538,353.99533081,0.00000000,0.00000000); //object(sw_jetty) (4)
CreateObject(12990,1441.30395508,1267.48388672,28.60368538,327.99047852,0.00000000,356.00000000); //object(sw_jetty) (5)
CreateObject(1634,1440.08154297,1250.28332520,37.46021271,0.00000000,0.00000000,176.00000000); //object(landjump2) (25)
CreateObject(6295,1425.21826172,1497.49633789,17.16270447,4.67608643,62.36203003,93.15106201); //object(sanpedlithus_law2) (1)
CreateObject(1634,1426.77551270,1513.97399902,29.33344078,24.00000000,0.00000000,358.00000000); //object(landjump2) (26)
CreateObject(1634,1427.07055664,1473.92370605,10.10344505,23.99963379,0.00000000,357.99499512); //object(landjump2) (27)
CreateObject(1634,1365.92663574,1471.27709961,11.11763000,0.00000000,0.00000000,90.00000000); //object(landjump2) (28)
CreateObject(1634,1358.55920410,1471.34924316,16.57762909,22.00000000,0.00000000,90.00000000); //object(landjump2) (29)
CreateObject(9259,1341.73144531,1470.37292480,16.03126526,0.00000000,0.00000000,0.00000000); //object(preshoosbig02_sfn) (1)
CreateObject(1634,1337.80151367,1469.12329102,22.41243553,0.00000000,0.00000000,90.00000000); //object(landjump2) (31)
CreateObject(1634,1337.59020996,1475.36999512,22.41243553,0.00000000,0.00000000,90.00000000); //object(landjump2) (32)
CreateObject(1634,1338.01940918,1462.62536621,22.41243553,0.00000000,0.00000000,90.00000000); //object(landjump2) (33)
CreateObject(1634,1502.96166992,1568.58898926,11.11763000,0.00000000,0.00000000,270.00000000); //object(landjump2) (35)
CreateObject(1634,1502.52929688,1560.10131836,11.11763000,0.00000000,0.00000000,270.00000000); //object(landjump2) (36)
CreateObject(3630,1501.27709961,1553.55322266,11.30595016,0.00000000,0.00000000,0.00000000); //object(crdboxes2_las) (1)
CreateObject(3630,1501.27636719,1553.55273438,13.80595016,0.00000000,0.00000000,0.00000000); //object(crdboxes2_las) (2)
CreateObject(3630,1504.07617188,1574.23779297,11.05595016,0.00000000,0.00000000,0.00000000); //object(crdboxes2_las) (3)
CreateObject(3630,1504.07617188,1574.23730469,14.05595016,0.00000000,0.00000000,0.00000000); //object(crdboxes2_las) (4)
CreateObject(1225,1509.00000000,1564.49096680,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (40)
CreateObject(1225,1508.85986328,1565.48046875,10.22606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (41)
CreateObject(1225,1505.02282715,1566.62402344,13.97606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (42)
CreateObject(1225,1505.22802734,1561.60278320,13.97606754,0.00000000,0.00000000,0.00000000); //object(barrel4) (43)
CreateObject(11417,1393.42028809,1728.17504883,12.81262493,0.00000000,0.00000000,0.00000000); //object(xenonsign2_sfse) (1)
CreateObject(2918,1379.92395020,1666.82458496,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (1)
CreateObject(2918,1378.67687988,1666.73327637,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (2)
CreateObject(2918,1377.42980957,1666.64147949,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (3)
CreateObject(2918,1376.18273926,1666.54968262,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (4)
CreateObject(2918,1374.68627930,1666.43969727,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (5)
CreateObject(2918,1373.68798828,1666.36669922,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (6)
CreateObject(2918,1372.44055176,1666.27526855,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (7)
CreateObject(2918,1370.94409180,1666.16528320,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (8)
CreateObject(2918,1369.69641113,1666.07409668,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (9)
CreateObject(2918,1368.19995117,1665.96411133,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (10)
CreateObject(2918,1368.27197266,1664.96630859,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (11)
CreateObject(2918,1368.32604980,1664.21765137,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (12)
CreateObject(2918,1368.43432617,1662.72045898,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (13)
CreateObject(2918,1368.52453613,1661.47277832,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (14)
CreateObject(2918,1368.63354492,1659.97631836,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (15)
CreateObject(2918,1368.76013184,1658.22985840,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (16)
CreateObject(2918,1368.75976562,1658.22949219,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (17)
CreateObject(2918,1368.85070801,1656.98254395,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (18)
CreateObject(2918,1368.85058594,1656.98242188,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (19)
CreateObject(2918,1368.68322754,1654.41418457,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (20)
CreateObject(2918,1368.76538086,1653.07043457,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (21)
CreateObject(2918,1368.63354492,1652.17858887,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (22)
CreateObject(2918,1368.94152832,1650.94104004,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (23)
CreateObject(2918,1370.05908203,1650.91625977,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (24)
CreateObject(2918,1370.73645020,1651.23681641,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (25)
CreateObject(2918,1371.18823242,1651.45019531,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (26)
CreateObject(2918,1371.41345215,1651.55712891,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (27)
CreateObject(2918,1371.86499023,1651.77050781,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (28)
CreateObject(2918,1372.31616211,1651.98437500,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (29)
CreateObject(2918,1373.23132324,1652.97094727,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (30)
CreateObject(2918,1373.34948730,1653.30358887,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (31)
CreateObject(2918,1373.46765137,1653.63562012,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (32)
CreateObject(2918,1373.25292969,1654.08666992,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (33)
CreateObject(2918,1373.03906250,1654.53784180,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (34)
CreateObject(2918,1373.18225098,1655.98767090,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (35)
CreateObject(2918,1373.07470703,1656.21325684,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (36)
CreateObject(2918,1369.48315430,1655.61962891,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (37)
CreateObject(2918,1372.97863770,1656.99719238,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (38)
CreateObject(2918,1372.76464844,1657.44897461,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (39)
CreateObject(2918,1372.65771484,1657.67419434,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (40)
CreateObject(2918,1372.55029297,1657.89978027,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (41)
CreateObject(2918,1372.46704102,1659.24304199,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (42)
CreateObject(2918,1372.35986328,1659.46813965,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (43)
CreateObject(2918,1372.37145996,1660.02661133,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (44)
CreateObject(2918,1372.62121582,1661.25097656,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (45)
CreateObject(2918,1372.74011230,1661.58386230,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (46)
CreateObject(2918,1372.63232422,1661.80895996,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (47)
CreateObject(2918,1372.52490234,1662.03454590,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (48)
CreateObject(2918,1372.64343262,1662.36706543,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (49)
CreateObject(2918,1372.76159668,1662.69909668,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (50)
CreateObject(2918,1372.87976074,1663.03112793,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (51)
CreateObject(2918,1372.99792480,1663.36315918,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (52)
CreateObject(2918,1373.11608887,1663.69519043,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (53)
CreateObject(2918,1373.23425293,1664.02722168,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (54)
CreateObject(2918,1373.92333984,1664.90600586,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (55)
CreateObject(2918,1373.60205078,1665.58312988,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (56)
CreateObject(2918,1372.24584961,1664.94140625,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (57)
CreateObject(2918,1372.01916504,1664.83447266,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (58)
CreateObject(2918,1371.79260254,1664.72705078,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (59)
CreateObject(2918,1370.78125000,1664.52478027,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (60)
CreateObject(2918,1370.44836426,1664.64343262,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (61)
CreateObject(2918,1370.22229004,1664.53564453,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (62)
CreateObject(2918,1369.99572754,1664.42822266,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (63)
CreateObject(2918,1369.98303223,1663.86889648,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (64)
CreateObject(2918,1370.08935547,1663.64221191,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (65)
CreateObject(2918,1370.51660156,1662.73779297,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (66)
CreateObject(2918,1370.27856445,1662.07153320,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (67)
CreateObject(2918,1370.38525391,1661.84533691,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (68)
CreateObject(2918,1370.49169922,1661.61877441,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (69)
CreateObject(2918,1370.59814453,1661.39221191,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (70)
CreateObject(2918,1370.70458984,1661.16564941,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (71)
CreateObject(2918,1370.81103516,1660.93908691,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (72)
CreateObject(2918,1371.02441406,1660.48657227,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (73)
CreateObject(2918,1370.78637695,1659.82055664,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (74)
CreateObject(2918,1370.76196289,1658.70263672,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (75)
CreateObject(2918,1370.74963379,1658.14331055,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (76)
CreateObject(2918,1371.28369141,1657.01281738,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (77)
CreateObject(2918,1371.39013672,1656.78674316,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (78)
CreateObject(2918,1371.69836426,1655.54943848,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (79)
CreateObject(2918,1371.57922363,1655.21594238,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (80)
CreateObject(2918,1371.68603516,1654.98986816,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (81)
CreateObject(2918,1371.56652832,1654.65637207,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (82)
CreateObject(2918,1371.44738770,1654.32336426,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (83)
CreateObject(2918,1371.66113281,1653.87133789,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (84)
CreateObject(2918,1371.54211426,1653.53820801,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (85)
CreateObject(2918,1371.74377441,1652.52734375,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (86)
CreateObject(2918,1371.51721191,1652.42041016,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (87)
CreateObject(2918,1371.29064941,1652.31298828,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (88)
CreateObject(2918,1370.62426758,1652.55053711,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (89)
CreateObject(2918,1370.29113770,1652.66882324,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (90)
CreateObject(2918,1370.18408203,1652.89392090,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (91)
CreateObject(2918,1370.38537598,1651.88281250,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (92)
CreateObject(2918,1369.61206055,1652.34680176,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (93)
CreateObject(2918,1369.29052734,1653.02453613,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (94)
CreateObject(2918,1369.40905762,1653.35729980,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (95)
CreateObject(2918,1369.52722168,1653.68933105,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (96)
CreateObject(2918,1369.64538574,1654.02136230,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (97)
CreateObject(2918,1369.88256836,1654.68627930,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (98)
CreateObject(2918,1369.77490234,1654.91149902,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (99)
CreateObject(2918,1369.91760254,1656.36169434,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (100)
CreateObject(2918,1369.81005859,1656.58728027,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (101)
CreateObject(2918,1370.04760742,1657.25268555,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (102)
CreateObject(2918,1369.93994141,1657.47790527,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (103)
CreateObject(2918,1369.95153809,1658.03637695,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (104)
CreateObject(2918,1369.52343750,1658.93994141,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (105)
CreateObject(2918,1369.76147461,1659.60522461,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (106)
CreateObject(2918,1369.55895996,1660.61523438,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (107)
CreateObject(2918,1369.45166016,1660.84118652,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (108)
CreateObject(2918,1369.34423828,1661.06677246,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (109)
CreateObject(2918,1369.23681641,1661.29235840,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (110)
CreateObject(2918,1369.12939453,1661.51794434,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (111)
CreateObject(2918,1369.02197266,1661.74353027,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (112)
CreateObject(2918,1368.81970215,1662.75390625,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (113)
CreateObject(2918,1371.62561035,1663.25231934,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (114)
CreateObject(2918,1371.62500000,1663.25195312,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (115)
CreateObject(2918,1371.39904785,1663.14501953,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (116)
CreateObject(2918,1371.82617188,1662.24072266,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (117)
CreateObject(2918,1371.35852051,1650.95654297,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (118)
CreateObject(2918,1372.03625488,1651.27685547,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (119)
CreateObject(2918,1373.04687500,1651.47814941,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (120)
CreateObject(2918,1373.27282715,1651.58447266,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (121)
CreateObject(2918,1373.49841309,1651.69091797,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (122)
CreateObject(2918,1373.83093262,1651.57141113,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (123)
CreateObject(2918,1375.37548828,1650.64331055,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (124)
CreateObject(2918,1375.05419922,1651.32043457,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (125)
CreateObject(2918,1375.27966309,1651.42724609,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (126)
CreateObject(2918,1376.05200195,1650.96276855,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (127)
CreateObject(2918,1376.50366211,1651.17578125,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (128)
CreateObject(2918,1377.40673828,1651.60351562,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (129)
CreateObject(2918,1377.63220215,1651.71044922,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (130)
CreateObject(2918,1377.85778809,1651.81689453,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (131)
CreateObject(2918,1378.08337402,1651.92333984,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (132)
CreateObject(2918,1378.30895996,1652.02978516,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (133)
CreateObject(2918,1378.76049805,1652.24316406,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (134)
CreateObject(2918,1378.98571777,1652.35009766,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (135)
CreateObject(2918,1379.43725586,1652.56347656,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (136)
CreateObject(2918,1380.11437988,1652.88427734,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (137)
CreateObject(2918,1380.34020996,1652.99072266,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (138)
CreateObject(2918,1380.56579590,1653.09716797,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (139)
CreateObject(2918,1381.24328613,1653.41748047,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (140)
CreateObject(2918,1381.36218262,1653.74987793,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (141)
CreateObject(2918,1381.25439453,1653.97497559,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (142)
CreateObject(2918,1381.14697266,1654.20056152,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (143)
CreateObject(2918,1380.71875000,1655.10400391,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (144)
CreateObject(2918,1380.63598633,1656.44714355,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (145)
CreateObject(2918,1380.31494141,1657.12414551,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (146)
CreateObject(2918,1380.20751953,1657.34997559,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (147)
CreateObject(2918,1380.32604980,1657.68249512,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (148)
CreateObject(2918,1380.44421387,1658.01452637,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (149)
CreateObject(2918,1380.33642578,1658.23962402,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (150)
CreateObject(2918,1380.46704102,1659.13098145,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (151)
CreateObject(2918,1380.35986328,1659.35681152,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (152)
CreateObject(2918,1380.49047852,1660.24816895,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (153)
CreateObject(2918,1380.60925293,1660.58093262,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (154)
CreateObject(2918,1380.73950195,1661.47180176,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (155)
CreateObject(2918,1380.63232422,1661.69763184,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (156)
CreateObject(2918,1380.31103516,1662.37512207,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (157)
CreateObject(2918,1380.01391602,1664.17053223,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (158)
CreateObject(2918,1379.90673828,1664.39587402,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (159)
CreateObject(2918,1379.83557129,1666.29797363,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (160)
CreateObject(2918,1380.02465820,1664.72827148,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (161)
CreateObject(2918,1380.10717773,1663.38391113,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (162)
CreateObject(2918,1379.20263672,1662.95605469,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (163)
CreateObject(2918,1378.52429199,1662.63525391,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (164)
CreateObject(2918,1378.29748535,1662.52783203,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (165)
CreateObject(2918,1377.61901855,1662.20654297,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (166)
CreateObject(2918,1377.39221191,1662.09912109,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (167)
CreateObject(2918,1376.71374512,1661.77783203,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (168)
CreateObject(2918,1376.03503418,1661.45654297,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (169)
CreateObject(2918,1375.80822754,1661.34912109,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (170)
CreateObject(2918,1374.90380859,1660.92089844,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (171)
CreateObject(2918,1374.22546387,1660.60009766,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (172)
CreateObject(2918,1373.99865723,1660.49267578,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (173)
CreateObject(2918,1373.77209473,1660.38525391,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (174)
CreateObject(2918,1373.54553223,1660.27783203,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (175)
CreateObject(2918,1373.31896973,1660.17041016,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (176)
CreateObject(2918,1373.63916016,1659.49206543,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (177)
CreateObject(2918,1373.74560547,1659.26525879,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (178)
CreateObject(2918,1374.06591797,1658.58679199,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (179)
CreateObject(2918,1374.17236328,1658.35998535,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (180)
CreateObject(2918,1374.27880859,1658.13342285,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (181)
CreateObject(2918,1374.59912109,1657.45495605,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (182)
CreateObject(2918,1374.70556641,1657.22814941,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (183)
CreateObject(2918,1375.13281250,1656.32373047,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (184)
CreateObject(2918,1375.45361328,1655.64538574,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (185)
CreateObject(2918,1375.88085938,1654.74072266,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (186)
CreateObject(2918,1375.98779297,1654.51428223,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (187)
CreateObject(2918,1376.41503906,1653.60986328,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (188)
CreateObject(2918,1376.52197266,1653.38342285,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (189)
CreateObject(2918,1376.94921875,1652.47900391,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (190)
CreateObject(2918,1376.60424805,1652.03869629,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (191)
CreateObject(2918,1376.37756348,1651.93115234,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (192)
CreateObject(2918,1376.27001953,1652.15661621,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (193)
CreateObject(2918,1376.16259766,1652.38220215,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (194)
CreateObject(2918,1375.62744141,1653.51159668,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (195)
CreateObject(2918,1375.30615234,1654.18859863,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (196)
CreateObject(2918,1375.19873047,1654.41442871,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (197)
CreateObject(2918,1375.09130859,1654.64001465,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (198)
CreateObject(2918,1374.98388672,1654.86560059,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (199)
CreateObject(2918,1374.55566406,1655.76904297,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (200)
CreateObject(2918,1374.34179688,1656.22045898,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (201)
CreateObject(2918,1374.23486328,1656.44567871,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (202)
CreateObject(2918,1374.66210938,1655.54150391,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (203)
CreateObject(2918,1374.65002441,1654.98217773,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (204)
CreateObject(2918,1374.85119629,1653.97070312,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (205)
CreateObject(2918,1374.95751953,1653.74475098,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (206)
CreateObject(2918,1375.06396484,1653.51818848,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (207)
CreateObject(2918,1374.94445801,1653.18469238,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (208)
CreateObject(2918,1374.82531738,1652.85168457,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (209)
CreateObject(2918,1374.70617676,1652.51867676,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (210)
CreateObject(2918,1377.19152832,1653.69482422,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (211)
CreateObject(2918,1377.64331055,1653.90820312,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (212)
CreateObject(2918,1377.86853027,1654.01513672,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (213)
CreateObject(2918,1378.09411621,1654.12158203,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (214)
CreateObject(2918,1378.31970215,1654.22802734,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (215)
CreateObject(2918,1378.54528809,1654.33447266,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (216)
CreateObject(2918,1378.99682617,1654.54785156,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (217)
CreateObject(2918,1379.22204590,1654.65478516,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (218)
CreateObject(2918,1379.44763184,1654.76123047,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (219)
CreateObject(2918,1379.68530273,1655.42651367,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (220)
CreateObject(2918,1379.80358887,1655.75866699,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (221)
CreateObject(2918,1379.69580078,1655.98376465,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (222)
CreateObject(2918,1379.01745605,1655.66259766,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (223)
CreateObject(2918,1378.79064941,1655.55517578,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (224)
CreateObject(2918,1377.88623047,1655.12695312,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (225)
CreateObject(2918,1377.65979004,1655.02001953,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (226)
CreateObject(2918,1376.64843750,1654.81774902,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (227)
CreateObject(2918,1376.54150391,1655.04333496,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (228)
CreateObject(2918,1376.77905273,1655.70874023,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (229)
CreateObject(2918,1377.00427246,1655.81494141,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (230)
CreateObject(2918,1377.90771484,1656.24218750,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (231)
CreateObject(2918,1378.58508301,1656.56298828,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (232)
CreateObject(2918,1379.26281738,1656.88330078,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (233)
CreateObject(2918,1379.15576172,1657.10876465,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (234)
CreateObject(2918,1378.72753906,1658.01220703,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (235)
CreateObject(2918,1377.82373047,1657.58398438,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (236)
CreateObject(2918,1377.59729004,1657.47705078,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (237)
CreateObject(2918,1376.91882324,1657.15576172,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (238)
CreateObject(2918,1376.69201660,1657.04833984,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (239)
CreateObject(2918,1376.46545410,1656.94091797,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (240)
CreateObject(2918,1376.35791016,1657.16638184,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (241)
CreateObject(2918,1375.92968750,1658.06982422,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (242)
CreateObject(2918,1376.60754395,1658.39013672,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (243)
CreateObject(2918,1376.83337402,1658.49658203,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (244)
CreateObject(2918,1377.05895996,1658.60302734,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (245)
CreateObject(2918,1378.18835449,1659.13720703,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (246)
CreateObject(2918,1378.41345215,1659.24365234,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (247)
CreateObject(2918,1378.74597168,1659.12414551,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (248)
CreateObject(2918,1378.85205078,1658.89807129,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (249)
CreateObject(2918,1378.63769531,1659.34936523,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (250)
CreateObject(2918,1378.53076172,1659.57458496,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (251)
CreateObject(2918,1378.76831055,1660.23999023,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (252)
CreateObject(2918,1379.44543457,1660.56005859,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (253)
CreateObject(2918,1378.91064453,1661.68933105,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (254)
CreateObject(2918,1378.68420410,1661.58154297,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (255)
CreateObject(2918,1378.45764160,1661.47412109,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (256)
CreateObject(2918,1378.23107910,1661.36669922,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (257)
CreateObject(2918,1378.00451660,1661.25927734,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (258)
CreateObject(2918,1377.32604980,1660.93798828,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (259)
CreateObject(2918,1376.87329102,1660.72363281,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (260)
CreateObject(2918,1375.96923828,1660.29589844,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (261)
CreateObject(2918,1375.74279785,1660.18896484,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (262)
CreateObject(2918,1375.71801758,1659.07080078,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (263)
CreateObject(2918,1374.60009766,1659.09448242,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (264)
CreateObject(2918,1376.74011230,1659.83020020,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (265)
CreateObject(2918,1373.67468262,1661.93237305,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (266)
CreateObject(2918,1373.99304199,1663.14013672,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (267)
CreateObject(2918,1374.05603027,1663.38134766,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (268)
CreateObject(2918,1375.64721680,1664.51184082,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (269)
CreateObject(2918,1374.80737305,1665.25048828,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (270)
CreateObject(2918,1374.55126953,1664.28320312,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (271)
CreateObject(2918,1375.51757812,1664.02783203,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (272)
CreateObject(2918,1375.32604980,1663.30224609,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (273)
CreateObject(2918,1375.26135254,1663.06005859,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (274)
CreateObject(2918,1375.19689941,1662.81787109,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (275)
CreateObject(2918,1375.13244629,1662.57568359,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (276)
CreateObject(2918,1374.81262207,1661.36669922,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (277)
CreateObject(2918,1375.29589844,1661.23852539,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (278)
CreateObject(2918,1376.40405273,1662.49694824,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (279)
CreateObject(2918,1376.53100586,1662.97949219,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (280)
CreateObject(2918,1376.83581543,1663.15734863,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (281)
CreateObject(2918,1376.89880371,1663.39892578,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (282)
CreateObject(2918,1376.96228027,1663.64013672,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (283)
CreateObject(2918,1377.02575684,1663.88134766,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (284)
CreateObject(2918,1377.33093262,1664.05871582,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (285)
CreateObject(2918,1377.39392090,1664.30029297,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (286)
CreateObject(2918,1377.77661133,1665.75000000,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (287)
CreateObject(2918,1377.84020996,1665.99169922,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (288)
CreateObject(2918,1376.74536133,1665.76318359,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (289)
CreateObject(2918,1378.67871094,1665.25195312,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (290)
CreateObject(2918,1378.35949707,1664.04345703,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (291)
CreateObject(2918,1378.35937500,1664.04296875,11.70944309,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (292)
CreateObject(1633,1376.69604492,1638.76818848,10.56250000,0.00000000,0.00000000,0.00000000); //object(landjump) (1)
CreateObject(12956,1422.56225586,1256.50769043,13.64855099,0.00000000,0.00000000,0.00000000); //object(sw_trailerjump) (1)
CreateObject(13648,1337.51989746,1373.14074707,9.82031250,0.00000000,0.00000000,0.00000000); //object(wall2) (1)
CreateObject(1633,1337.14270020,1396.34338379,12.87060356,0.00000000,0.00000000,0.00000000); //object(landjump) (2)
CreateObject(6052,1329.59020996,1406.40429688,16.06795120,0.00000000,0.00000000,190.00000000); //object(artcurve_law) (1)
CreateObject(3269,1306.12316895,1419.92150879,18.32031250,0.00000000,0.00000000,122.00000000); //object(bonyrd_block1_) (2)
CreateObject(1634,1289.56604004,1411.59887695,24.27930260,0.00000000,0.00000000,116.00000000); //object(landjump2) (37)
CreateObject(1634,1282.30712891,1407.89550781,27.77930260,0.00000000,0.00000000,115.99914551); //object(landjump2) (38)

//======================================Base Objects======================================================
CreateObject(1437,-1696.50000000,-195.50000000,-127.19999695,0.00000000,0.00000000,0.00000000); //object(dyn_ladder_2) (1)
CreateObject(4882,-1622.40002441,-177.50000000,18.79999924,0.00000000,0.00000000,316.00000000); //object(lasbrid1_las) (1)
CreateObject(14596,-1598.30004883,-182.30000305,24.20000076,0.00000000,0.00000000,44.00000000); //object(paperchase_stairs) (1)
CreateObject(2918,-1623.30004883,-178.39999390,15.39999962,0.00000000,0.00000000,0.00000000); //object(kmb_mine) (1)
CreateObject(18367,-1605.00000000,-183.50000000,31.00000000,350.00000000,0.00000000,314.00000000); //object(cw2_bikelog) (1)
CreateObject(18367,-1626.19995117,-204.10000610,40.00000000,0.00000000,0.00000000,316.00000000); //object(cw2_bikelog) (2)
CreateObject(7153,-1528.19995117,-39.09999847,-186.19999695,0.00000000,0.00000000,0.00000000); //object(shamheliprt05) (1)
CreateObject(1634,-1648.69995117,-226.60000610,44.29999924,0.00000000,0.00000000,134.00000000); //object(landjump2) (1)
CreateObject(1894,-1643.90002441,-196.19999695,13.10000038,10.00000000,30.00000000,138.00000000); //object(garys_luv_ramp) (1)
CreateObject(3270,-1569.30004883,-194.39999390,13.10000038,0.00000000,0.00000000,52.00000000); //object(bonyrd_block2_) (1)
CreateObject(3625,-1656.69995117,-133.60000610,16.00000000,0.00000000,0.00000000,44.00000000); //object(crgostntrmp) (1)
CreateObject(13636,-1592.19995117,-148.80000305,15.80000019,0.00000000,0.00000000,314.00000000); //object(logramps) (1)
CreateObject(13641,-1627.90002441,-209.10000610,27.20000076,0.00000000,0.00000000,322.00000000); //object(kickramp04) (1)
CreateObject(13641,-1669.00000000,-303.50000000,14.00000000,0.00000000,0.00000000,42.00000000); //object(kickramp04) (2)
CreateObject(13641,-1657.40002441,-292.10000610,18.60000038,0.00000000,0.00000000,42.00000000); //object(kickramp04) (3)
CreateObject(13641,-1644.90002441,-279.89999390,22.39999962,0.00000000,0.00000000,42.00000000); //object(kickramp04) (4)
CreateObject(13641,-1633.50000000,-268.70001221,27.89999962,0.00000000,0.00000000,42.00000000); //object(kickramp04) (5)
CreateObject(13641,-1621.00000000,-256.20001221,31.70000076,0.00000000,0.00000000,42.00000000); //object(kickramp04) (6)
CreateObject(13645,-1687.80004883,-162.10000610,16.70000076,0.00000000,0.00000000,42.00000000); //object(kickramp06) (1)
CreateObject(1634,-1085.69995117,430.89999390,14.69999981,0.00000000,0.00000000,314.00000000); //object(landjump2) (2)
CreateObject(1634,-1082.50000000,434.10000610,18.50000000,25.00000000,0.00000000,314.00000000); //object(landjump2) (3)
CreateObject(1634,-1083.00000000,427.89999390,14.60000038,0.00000000,0.00000000,314.00000000); //object(landjump2) (4)
CreateObject(1634,-1079.80004883,430.89999390,18.50000000,25.00000000,0.00000000,314.00000000); //object(landjump2) (5)
CreateObject(1655,-1079.00000000,423.79998779,14.60000038,0.00000000,0.00000000,314.00000000); //object(waterjumpx2) (1)
CreateObject(1655,-1075.59997559,427.00000000,18.00000000,20.00000000,0.00000000,314.00000000); //object(waterjumpx2) (2)
CreateObject(1655,-1072.19995117,430.39999390,22.10000038,20.00000000,0.00000000,316.00000000); //object(waterjumpx2) (3)
CreateObject(1655,-1072.69995117,417.00000000,14.80000019,0.00000000,0.00000000,314.00000000); //object(waterjumpx2) (4)
CreateObject(1655,-1066.30004883,410.50000000,14.69999981,0.00000000,0.00000000,314.00000000); //object(waterjumpx2) (5)
CreateObject(1655,-1066.00000000,417.60000610,17.89999962,20.00000000,0.00000000,314.00000000); //object(waterjumpx2) (6)
CreateObject(1634,-1454.00000000,-150.69999695,14.39999962,0.00000000,0.00000000,256.00000000); //object(landjump2) (6)
CreateObject(1634,-1449.50000000,-151.69999695,18.00000000,25.00000000,0.00000000,256.00000000); //object(landjump2) (7)
CreateObject(1634,-1455.09997559,-154.50000000,14.39999962,0.00000000,0.00000000,256.00000000); //object(landjump2) (8)
CreateObject(1634,-1450.19995117,-155.69999695,18.29999924,25.00000000,0.00000000,256.00000000); //object(landjump2) (9)
CreateObject(13604,-1636.90002441,-325.00000000,14.89999962,0.00000000,0.00000000,44.00000000); //object(kickramp05) (1)
CreateObject(13604,-1638.90002441,-318.00000000,18.29999924,0.00000000,0.00000000,316.00000000); //object(kickramp05) (2)
CreateObject(13647,-1608.30004883,-283.89999390,13.10000038,0.00000000,0.00000000,48.00000000); //object(wall1) (1)
CreateObject(13647,-1607.90002441,-284.60000610,13.10000038,0.00000000,0.00000000,48.00000000); //object(wall1) (2)
CreateObject(13647,-1607.50000000,-284.89999390,13.10000038,0.00000000,0.00000000,48.00000000); //object(wall1) (3)
CreateObject(16302,-1493.00000000,-220.89999390,19.50000000,0.00000000,0.00000000,0.00000000); //object(des_gravelpile04) (1)
CreateObject(16302,-1542.40002441,-154.00000000,19.50000000,0.00000000,0.00000000,0.00000000); //object(des_gravelpile04) (2)
CreateObject(16302,-1524.30004883,-155.89999390,27.70000076,0.00000000,0.00000000,0.00000000); //object(des_gravelpile04) (3)
CreateObject(16302,-1504.69995117,-170.80000305,34.70000076,0.00000000,0.00000000,0.00000000); //object(des_gravelpile04) (4)
CreateObject(16302,-1489.50000000,-179.69999695,44.40000153,0.00000000,0.00000000,0.00000000); //object(des_gravelpile04) (5)
CreateObject(18262,-1467.59997559,-186.69999695,39.40000153,0.00000000,0.00000000,76.00000000); //object(cw2_phroofstuf) (1)
CreateObject(18609,-1462.59997559,-190.60000610,40.09999847,0.00000000,0.00000000,354.00000000); //object(cs_logs06) (1)
CreateObject(13648,-1449.90002441,-189.10000610,39.40000153,20.00000000,10.00000000,260.00000000); //object(wall2) (1)
CreateObject(8302,-1434.80004883,-192.19999695,47.29999924,0.00000000,0.00000000,272.00000000); //object(jumpbox01_lvs01) (1)
CreateObject(12956,-1512.19995117,-93.80000305,17.00000000,0.00000000,0.00000000,0.00000000); //object(sw_trailerjump) (1)
CreateObject(13590,-1478.69995117,-119.50000000,15.50000000,0.00000000,0.00000000,314.00000000); //object(kickbus04) (1)
CreateObject(6052,-1556.09997559,-16.89999962,15.89999962,0.00000000,0.00000000,144.00000000); //object(artcurve_law) (1)
CreateObject(6052,-1551.69995117,-11.19999981,20.10000038,0.00000000,0.00000000,0.00000000); //object(artcurve_law) (2)
CreateObject(6052,-1540.00000000,-10.89999962,20.00000000,10.00000000,0.00000000,106.00000000); //object(artcurve_law) (3)
CreateObject(1894,-1537.30004883,3.20000005,21.10000038,3.00000000,26.00000000,304.00000000); //object(garys_luv_ramp) (2)
CreateObject(3364,-1568.40002441,-277.79998779,13.10000038,0.00000000,0.00000000,310.00000000); //object(des_ruin3_) (1)
CreateObject(3852,-1440.50000000,-111.00000000,15.00000000,0.00000000,0.00000000,314.00000000); //object(sf_jump) (1)
CreateObject(1225,-1404.90002441,-201.30000305,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (1)
CreateObject(1225,-1404.50000000,-194.50000000,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (2)
CreateObject(1225,-1405.19995117,-196.50000000,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (3)
CreateObject(1225,-1405.90002441,-198.10000610,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (4)
CreateObject(1225,-1407.40002441,-201.89999390,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (5)
CreateObject(1225,-1408.00000000,-203.50000000,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (6)
CreateObject(1225,-1403.69995117,-199.00000000,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (7)
CreateObject(1225,-1402.80004883,-197.19999695,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (8)
CreateObject(1225,-1402.30004883,-195.30000305,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (9)
CreateObject(1225,-1406.69995117,-200.00000000,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (10)
CreateObject(1225,-1405.80004883,-203.19999695,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (11)
CreateObject(1225,-1406.50000000,-204.80000305,24.79999924,0.00000000,0.00000000,0.00000000); //object(barrel4) (12)
CreateObject(7073,-1424.69995117,-48.50000000,31.39999962,0.00000000,50.00000000,36.00000000); //object(vegascowboy1) (1)
CreateObject(7073,-1452.30004883,-165.10000610,32.59999847,0.00000000,0.00000000,348.00000000); //object(vegascowboy1) (2)
CreateObject(7073,-1394.09997559,-21.79999924,58.20000076,0.00000000,50.00000000,38.00000000); //object(vegascowboy1) (3)
CreateObject(7073,-1440.59997559,-139.39999390,31.39999962,0.00000000,0.00000000,0.00000000); //object(vegascowboy1) (4)
CreateObject(7073,-1376.30004883,-6.40000010,47.09999847,0.00000000,50.00000000,222.00000000); //object(vegascowboy1) (5)
CreateObject(1634,-1448.50000000,-69.00000000,14.39999962,2.00000000,0.00000000,314.00000000); //object(landjump2) (10)
CreateObject(16401,-1413.19995117,-37.29999924,40.50000000,0.00000000,0.00000000,38.00000000); //object(desn2_peckjump) (1)
CreateObject(12956,-1390.00000000,-72.80000305,17.00000000,0.00000000,0.00000000,34.00000000); //object(sw_trailerjump) (2)
CreateObject(13590,-1358.00000000,-38.59999847,15.50000000,0.00000000,0.00000000,314.00000000); //object(kickbus04) (2)
CreateObject(13638,-1326.30004883,-22.20000076,21.10000038,0.00000000,0.00000000,212.00000000); //object(stunt1) (1)
CreateObject(13638,-1332.59997559,-25.89999962,29.20000076,0.00000000,0.00000000,34.00000000); //object(stunt1) (2)
CreateObject(13638,-1339.50000000,-12.50000000,35.90000153,0.00000000,0.00000000,316.00000000); //object(stunt1) (3)
CreateObject(18367,-1335.90002441,-5.50000000,41.59999847,0.00000000,0.00000000,118.00000000); //object(cw2_bikelog) (3)
CreateObject(18367,-1309.09997559,8.80000019,45.40000153,0.00000000,0.00000000,118.00000000); //object(cw2_bikelog) (4)
CreateObject(18451,-1279.09997559,24.70000076,49.70000076,0.00000000,0.00000000,302.00000000); //object(cs_oldcarjmp) (1)
CreateObject(1634,-1265.40002441,30.20000076,33.20000076,0.00000000,0.00000000,134.00000000); //object(landjump2) (11)
CreateObject(1634,-1262.80004883,27.39999962,33.20000076,0.00000000,0.00000000,134.00000000); //object(landjump2) (12)
CreateObject(2098,-1270.50000000,26.39999962,15.10000038,0.00000000,0.00000000,316.00000000); //object(cj_slotcover1) (1)
CreateObject(2098,-1265.59997559,21.79999924,15.10000038,0.00000000,0.00000000,316.00000000); //object(cj_slotcover1) (2)
CreateObject(3749,-1267.50000000,24.39999962,19.00000000,0.00000000,0.00000000,316.00000000); //object(clubgate01_lax) (1)
CreateObject(8509,-1505.19995117,25.10000038,17.20000076,0.00000000,0.00000000,226.00000000); //object(shop09_lvs) (1)
CreateObject(13590,-1291.90002441,-80.09999847,15.50000000,0.00000000,0.00000000,224.00000000); //object(kickbus04) (3)
CreateObject(13636,-1305.09997559,-95.50000000,15.39999962,0.00000000,0.00000000,314.00000000); //object(logramps) (2)
CreateObject(13643,-1281.59997559,-106.50000000,14.39999962,0.00000000,0.00000000,314.00000000); //object(logramps02) (1)
CreateObject(14608,-1400.80004883,-236.19999695,15.39999962,0.00000000,0.00000000,284.00000000); //object(triad_buddha01) (1)
CreateObject(13637,-1343.50000000,-83.30000305,15.19999981,0.00000000,0.00000000,64.00000000); //object(tuberamp) (1)
CreateObject(13637,-1321.19995117,-120.40000153,15.19999981,0.00000000,0.00000000,0.00000000); //object(tuberamp) (2)
CreateObject(3461,-1377.59997559,-253.50000000,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (1)
CreateObject(3461,-1373.59997559,-249.10000610,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (2)
CreateObject(3461,-1370.40002441,-246.30000305,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (3)
CreateObject(3461,-1366.90002441,-243.30000305,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (4)
CreateObject(3461,-1363.80004883,-240.50000000,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (5)
CreateObject(3461,-1389.00000000,-243.39999390,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (6)
CreateObject(3461,-1383.90002441,-238.30000305,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (7)
CreateObject(3461,-1381.00000000,-235.30000305,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (8)
CreateObject(3461,-1377.90002441,-232.30000305,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (9)
CreateObject(3461,-1375.30004883,-229.69999695,14.69999981,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (10)
CreateObject(3515,-1380.00000000,-253.50000000,15.10000038,0.00000000,0.00000000,0.00000000); //object(vgsfountain) (1)
CreateObject(3515,-1388.80004883,-245.50000000,15.10000038,0.00000000,0.00000000,0.00000000); //object(vgsfountain) (2)
CreateObject(3524,-1366.30004883,-231.19999695,16.00000000,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (1)
CreateObject(3743,-1381.59997559,-250.00000000,17.10000038,0.00000000,0.00000000,316.00000000); //object(escl_singlela) (1)
CreateObject(3743,-1382.80004883,-248.80000305,17.10000038,0.00000000,0.00000000,316.00000000); //object(escl_singlela) (2)
CreateObject(6965,-1355.69995117,-221.69999695,17.79999924,0.00000000,0.00000000,0.00000000); //object(venefountain02) (1)
CreateObject(7392,-1360.80004883,-250.89999390,22.89999962,0.00000000,0.00000000,326.00000000); //object(vegcandysign1) (1)
CreateObject(7392,-1382.00000000,-229.00000000,22.89999962,0.00000000,0.00000000,318.00000000); //object(vegcandysign1) (2)
CreateObject(9833,-1361.09997559,-237.39999390,16.29999924,0.00000000,0.00000000,0.00000000); //object(fountain_sfw) (1)
CreateObject(9833,-1371.19995117,-227.50000000,16.29999924,0.00000000,0.00000000,0.00000000); //object(fountain_sfw) (2)
CreateObject(9833,-1356.00000000,-221.60000610,24.50000000,0.00000000,0.00000000,0.00000000); //object(fountain_sfw) (3)
CreateObject(16135,-1319.40002441,-175.60000610,13.60000038,0.00000000,0.00000000,46.00000000); //object(des_geysrwalk2) (1)
CreateObject(3524,-1319.50000000,-174.30000305,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (2)
CreateObject(3524,-1313.40002441,-175.19999695,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (3)
CreateObject(3524,-1323.30004883,-170.89999390,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (4)
CreateObject(3524,-1324.30004883,-165.19999695,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (5)
CreateObject(3524,-1321.00000000,-160.30000305,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (6)
CreateObject(3524,-1315.80004883,-158.00000000,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (7)
CreateObject(3524,-1311.30004883,-159.00000000,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (8)
CreateObject(3524,-1307.50000000,-162.69999695,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (9)
CreateObject(3524,-1306.30004883,-168.69999695,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (10)
CreateObject(3524,-1309.00000000,-172.89999390,16.29999924,0.00000000,0.00000000,0.00000000); //object(skullpillar01_lvs) (11)
CreateObject(6189,-1228.80004883,-248.30000305,27.79999924,335.00000000,0.00000000,42.00000000); //object(gaz_pier1) (1)
CreateObject(6189,-1195.59997559,-284.79998779,50.79999924,335.00000000,0.00000000,42.00000000); //object(gaz_pier1) (2)
CreateObject(6189,-1138.90002441,-347.89999390,90.69999695,335.00000000,0.00000000,42.00000000); //object(gaz_pier1) (3)
CreateObject(8040,-1077.50000000,-416.70001221,132.69999695,0.00000000,0.00000000,134.00000000); //object(airprtcrprk02_lvs) (1)
CreateObject(1634,-1285.30004883,-206.60000610,14.39999962,0.00000000,0.00000000,42.00000000); //object(landjump2) (13)
CreateObject(1634,-1289.19995117,-202.30000305,17.50000000,5.00000000,0.00000000,42.00000000); //object(landjump2) (14)
CreateObject(1634,-1292.50000000,-198.80000305,21.60000038,25.00000000,0.00000000,42.00000000); //object(landjump2) (15)
CreateObject(1655,-1280.19995117,-202.60000610,14.39999962,0.00000000,0.00000000,42.00000000); //object(waterjumpx2) (7)
CreateObject(1655,-1273.69995117,-196.89999390,14.39999962,0.00000000,0.00000000,40.00000000); //object(waterjumpx2) (8)
CreateObject(1655,-1267.19995117,-191.60000610,14.39999962,0.00000000,0.00000000,40.00000000); //object(waterjumpx2) (9)
CreateObject(1655,-1271.90002441,-186.19999695,20.10000038,30.00000000,0.00000000,40.00000000); //object(waterjumpx2) (10)
CreateObject(1655,-1270.50000000,-187.50000000,17.70000076,20.00000000,0.00000000,40.00000000); //object(waterjumpx2) (11)
CreateObject(1564,-2663.00000000,1367.59997559,21.79999924,0.00000000,0.00000000,0.00000000); //object(ab_jetliteglass) (1)
CreateObject(1649,-2679.30004883,1370.19995117,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (1)
CreateObject(1649,-2675.00000000,1370.40002441,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (2)
CreateObject(1649,-2670.60009766,1370.40002441,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (3)
CreateObject(1649,-2683.69995117,1370.40002441,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (4)
CreateObject(1649,-2688.10009766,1370.40002441,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (5)
CreateObject(1649,-2692.50000000,1370.40002441,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (6)
CreateObject(1649,-2697.00000000,1370.30004883,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (7)
CreateObject(1649,-2700.00000000,1369.80004883,17.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (8)
CreateObject(1649,-2698.19995117,1371.00000000,20.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (9)
CreateObject(1649,-2693.89990234,1371.00000000,20.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (10)
CreateObject(1649,-2689.50000000,1371.00000000,20.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (11)
CreateObject(1649,-2685.19995117,1371.00000000,20.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (12)
CreateObject(1649,-2680.89990234,1371.00000000,21.00000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (13)
CreateObject(1649,-2676.39990234,1371.00000000,20.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (14)
CreateObject(1649,-2672.10009766,1371.00000000,21.00000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (15)
CreateObject(1649,-2666.00000000,1370.50000000,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (16)
CreateObject(1649,-2667.60009766,1371.00000000,20.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (17)
CreateObject(1649,-2663.30004883,1371.00000000,20.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (18)
CreateObject(1649,-2663.10009766,1371.00000000,17.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (19)
CreateObject(1649,-2697.80004883,1371.00000000,23.89999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (20)
CreateObject(1649,-2697.89990234,1371.00000000,27.00000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (21)
CreateObject(1649,-2697.80004883,1371.00000000,30.29999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (22)
CreateObject(1649,-2697.89990234,1371.00000000,33.59999847,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (23)
CreateObject(1649,-2697.80004883,1371.00000000,36.90000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (24)
CreateObject(1649,-2693.60009766,1371.00000000,24.00000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (25)
CreateObject(1649,-2689.19995117,1371.00000000,24.10000038,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (26)
CreateObject(1649,-2693.50000000,1371.00000000,27.29999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (27)
CreateObject(1649,-2693.30004883,1371.00000000,30.60000038,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (28)
CreateObject(1649,-2693.39990234,1371.00000000,33.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (29)
CreateObject(1649,-2693.50000000,1371.00000000,36.90000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (30)
CreateObject(1649,-2689.10009766,1371.00000000,27.29999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (31)
CreateObject(1649,-2688.89990234,1371.00000000,30.39999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (32)
CreateObject(1649,-2689.00000000,1371.00000000,33.59999847,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (33)
CreateObject(1649,-2689.00000000,1371.00000000,36.90000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (34)
CreateObject(1649,-2689.00000000,1371.00000000,40.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (35)
CreateObject(1649,-2693.50000000,1371.00000000,40.09999847,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (36)
CreateObject(1649,-2698.00000000,1371.00000000,40.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (37)
CreateObject(1649,-2684.69995117,1371.00000000,24.10000038,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (38)
CreateObject(1649,-2684.60009766,1371.00000000,27.29999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (39)
CreateObject(1649,-2684.60009766,1371.00000000,30.60000038,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (40)
CreateObject(1649,-2684.69995117,1371.00000000,33.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (41)
CreateObject(1649,-2684.69995117,1371.00000000,36.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (42)
CreateObject(1649,-2684.60009766,1371.00000000,40.09999847,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (43)
CreateObject(1649,-2680.30004883,1371.00000000,24.10000038,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (44)
CreateObject(1649,-2680.19995117,1371.00000000,27.29999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (45)
CreateObject(1649,-2680.30004883,1371.00000000,30.60000038,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (46)
CreateObject(1649,-2676.19995117,1371.00000000,24.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (47)
CreateObject(1649,-2671.69995117,1371.00000000,24.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (48)
CreateObject(1649,-2676.10009766,1371.00000000,27.50000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (49)
CreateObject(1649,-2671.60009766,1371.00000000,27.50000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (50)
CreateObject(1649,-2667.19995117,1371.00000000,24.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (51)
CreateObject(1649,-2667.19995117,1371.00000000,27.39999962,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (52)
CreateObject(1649,-2680.30004883,1371.00000000,34.00000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (53)
CreateObject(1649,-2680.30004883,1371.00000000,37.40000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (54)
CreateObject(1649,-2680.39990234,1371.00000000,40.79999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (55)
CreateObject(1649,-2675.89990234,1371.00000000,30.79999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (56)
CreateObject(1649,-2675.89990234,1371.00000000,34.09999847,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (57)
CreateObject(1649,-2675.89990234,1371.00000000,37.40000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (58)
CreateObject(1649,-2671.50000000,1371.00000000,30.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (59)
CreateObject(1649,-2671.39990234,1371.00000000,33.90000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (60)
CreateObject(1649,-2667.00000000,1371.00000000,30.79999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (61)
CreateObject(1649,-2667.00000000,1371.00000000,34.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (62)
CreateObject(1649,-2676.00000000,1371.00000000,40.79999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (63)
CreateObject(1649,-2671.39990234,1371.00000000,37.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (64)
CreateObject(1649,-2671.50000000,1371.00000000,40.59999847,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (65)
CreateObject(1649,-2667.00000000,1371.00000000,37.50000000,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (66)
CreateObject(1649,-2663.00000000,1370.59997559,24.29999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (67)
CreateObject(1649,-2663.00000000,1370.40002441,27.60000038,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (68)
CreateObject(1649,-2663.00000000,1370.00000000,30.79999924,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (69)
CreateObject(1649,-2663.00000000,1370.00000000,34.20000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (70)
CreateObject(1649,-2663.00000000,1370.19995117,37.40000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (71)
CreateObject(1649,-2667.10009766,1371.00000000,40.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (72)
CreateObject(1649,-2663.00000000,1370.30004883,40.70000076,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (73)
CreateObject(1649,-2668.50000000,1338.80004883,-102.90000153,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (74)
CreateObject(1649,-2703.89990234,1359.00000000,17.70000076,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (75)
CreateObject(1649,-2703.89990234,1354.80004883,17.70000076,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (76)
CreateObject(1649,-2703.80004883,1350.19995117,17.70000076,0.00000000,0.00000000,92.00000000); //object(wglasssmash) (77)
CreateObject(1649,-2703.80004883,1345.80004883,17.70000076,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (78)
CreateObject(1649,-2704.39990234,1359.19995117,20.70000076,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (79)
CreateObject(1649,-2703.80004883,1341.50000000,17.70000076,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (80)
CreateObject(1649,-2704.00000000,1337.40002441,17.70000076,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (81)
CreateObject(1649,-2704.00000000,1332.90002441,17.70000076,0.00000000,0.00000000,88.00000000); //object(wglasssmash) (82)
CreateObject(1649,-2703.30004883,1328.69995117,17.70000076,0.00000000,0.00000000,112.00000000); //object(wglasssmash) (83)
CreateObject(1649,-2703.30004883,1328.69995117,21.00000000,0.00000000,0.00000000,112.00000000); //object(wglasssmash) (84)
CreateObject(1649,-2703.89990234,1353.69995117,17.70000076,0.00000000,0.00000000,88.00000000); //object(wglasssmash) (85)
CreateObject(1649,-2703.89990234,1354.59997559,20.79999924,0.00000000,0.00000000,92.00000000); //object(wglasssmash) (86)
CreateObject(1649,-2704.00000000,1350.30004883,20.79999924,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (87)
CreateObject(1649,-2704.00000000,1346.09997559,20.89999962,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (88)
CreateObject(1649,-2704.19995117,1337.19995117,20.89999962,0.00000000,0.00000000,88.00000000); //object(wglasssmash) (89)
CreateObject(1649,-2704.19995117,1341.59997559,20.79999924,0.00000000,0.00000000,86.00000000); //object(wglasssmash) (90)
CreateObject(1649,-2702.10009766,1351.69995117,17.70000076,0.00000000,0.00000000,172.00000000); //object(wglasssmash) (91)
CreateObject(1491,-2693.19995117,1309.00000000,-121.50000000,0.00000000,0.00000000,0.00000000); //object(gen_doorint01) (1)
CreateObject(8640,-2661.80004883,1343.50000000,21.89999962,0.00000000,0.00000000,0.00000000); //object(chnatwnmll02_lvs) (1)
CreateObject(14805,-2694.80004883,1332.30004883,16.89999962,0.00000000,0.00000000,0.00000000); //object(bdupsnew_int) (1)
CreateObject(8171,-2683.89990234,1344.90002441,16.00000000,0.00000000,0.00000000,0.00000000); //object(vgssairportland06) (1)
CreateObject(8253,-2688.50000000,1343.69995117,19.89999962,0.00000000,0.00000000,0.00000000); //object(pltschlhnger01_lvs) (1)
CreateObject(8550,-2603.69995117,1379.19995117,10.39999962,0.00000000,0.00000000,0.00000000); //object(laconcha_lvs) (1)
CreateObject(3996,-2501.69995117,1425.69995117,-241.30000305,1.00000000,50.00000000,0.00000000); //object(roads08_lan) (1)
CreateObject(18367,-2631.30004883,1337.09997559,6.19999981,348.00000000,0.00000000,272.00000000); //object(cw2_bikelog) (5)
CreateObject(18367,-2631.39990234,1339.00000000,6.19999981,348.00000000,0.00000000,272.00000000); //object(cw2_bikelog) (6)
CreateObject(18367,-2631.50000000,1340.90002441,6.19999981,348.00000000,0.00000000,272.00000000); //object(cw2_bikelog) (7)
CreateObject(18367,-2631.69995117,1342.69995117,6.09999990,348.00000000,0.00000000,270.00000000); //object(cw2_bikelog) (8)
CreateObject(18367,-2631.69995117,1344.69995117,6.09999990,348.00000000,0.00000000,270.00000000); //object(cw2_bikelog) (9)
CreateObject(18367,-2631.80004883,1346.59997559,6.09999990,348.00000000,0.00000000,270.00000000); //object(cw2_bikelog) (10)
CreateObject(18367,-2631.69995117,1348.30004883,6.09999990,348.00000000,0.00000000,268.00000000); //object(cw2_bikelog) (11)
CreateObject(18367,-2631.60009766,1350.19995117,6.09999990,348.00000000,0.00000000,268.00000000); //object(cw2_bikelog) (12)
CreateObject(1264,2031.30004883,1000.70001221,-160.30000305,0.00000000,0.00000000,0.00000000); //object(blackbag1) (1)
CreateObject(1217,2009.19995117,1000.59997559,-172.30000305,0.00000000,0.00000000,0.00000000); //object(barrel2) (1)
CreateObject(3524,2023.50000000,1003.70001221,12.69999981,0.00000000,0.00000000,90.00000000); //object(skullpillar01_lvs) (12)
CreateObject(3524,2023.50000000,1012.40002441,12.69999981,0.00000000,0.00000000,90.00000000); //object(skullpillar01_lvs) (13)
CreateObject(9833,2024.90002441,996.70001221,13.00000000,0.00000000,0.00000000,0.00000000); //object(fountain_sfw) (4)
CreateObject(9833,2024.59997559,1018.70001221,13.00000000,0.00000000,0.00000000,0.00000000); //object(fountain_sfw) (5)
CreateObject(3877,2028.59997559,1003.09997559,11.50000000,0.00000000,0.00000000,0.00000000); //object(sf_rooflite) (1)
CreateObject(3877,2031.90002441,1003.00000000,11.50000000,0.00000000,0.00000000,0.00000000); //object(sf_rooflite) (2)
CreateObject(3877,2035.30004883,1002.90002441,11.50000000,0.00000000,0.00000000,0.00000000); //object(sf_rooflite) (3)
CreateObject(3877,2028.09997559,1014.00000000,11.50000000,0.00000000,0.00000000,0.00000000); //object(sf_rooflite) (4)
CreateObject(3877,2031.90002441,1014.00000000,11.50000000,0.00000000,0.00000000,0.00000000); //object(sf_rooflite) (5)
CreateObject(3877,2035.19995117,1014.09997559,11.50000000,0.00000000,0.00000000,0.00000000); //object(sf_rooflite) (6)
CreateObject(3743,2025.19995117,1015.70001221,13.69999981,0.00000000,0.00000000,270.00000000); //object(escl_singlela) (3)
CreateObject(3743,2025.80004883,999.70001221,13.69999981,0.00000000,0.00000000,270.00000000); //object(escl_singlela) (4)
CreateObject(6865,2027.40002441,1007.79998779,20.50000000,0.00000000,0.00000000,134.00000000); //object(steerskull) (1)
CreateObject(7392,2016.90002441,1019.40002441,47.79999924,0.00000000,0.00000000,0.00000000); //object(vegcandysign1) (3)
CreateObject(3509,2021.40002441,1334.00000000,9.19999981,0.00000000,0.00000000,0.00000000); //object(vgsn_nitree_r01) (1)
CreateObject(3511,2021.19995117,1351.90002441,9.10000038,0.00000000,0.00000000,0.00000000); //object(vgsn_nitree_b01) (1)

	SetTimer("MoneyGrubScoreUpdate", 1000, 1);
	//SetTimer("GameModeExitFunc", gRoundTime, 0);

	return 1;
}


public SendPlayerFormattedText(playerid, const str[], define)
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessage(playerid, 0xFF004040, tmpbuf);
}

public SendAllFormattedText(playerid, const str[], define)
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessageToAll(0xFFFF00AA, tmpbuf);
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

