// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>
#include <fixes>
#include <a_graphfunc>
#include <zcmd>
#include <sscanf2>
#include <math>


#define MAX_POINTS 230
#define MAX_AUTO 3
#define DIALOG_TRADE 152
#define DIALOG_BUY 153
#define DIALOG_SELL 222

new Text:TDEditor_PTD;

enum pdata
{
	showing,
	moneyput[MAX_AUTO],
 	Float:put,
 	buy[MAX_AUTO],
 	aktbiz
}

new pData[MAX_PLAYERS][pdata];
enum pdta
{
	Float:val

}

enum tradeenum{
	name[128],
	Float:x,
	Float:y,
	Float:z,
	Float:r,
	Float:stand,
	Float:differenz,
	Graph:graph,
	mstr[256]
}

new tradeautomat[MAX_AUTO][tradeenum]={
{"Fastfood AG", -1814.5582, 904.7863, 24.8906, -1.00, 26.55, -0.444},
{"SAM AG", 1813.2036, 943.3578, 10.0, -5.00, 14.596, -0.0099},
{"Donutfactory",192.0,168.0,15.0,0.0,45.854285,10.125469}
};

new pointData[MAX_AUTO][MAX_POINTS][pdta];

forward InitializeTD(str[]);
public InitializeTD(str[])
{
	TDEditor_PTD = TextDrawCreate(315.768646, 246.101257, str);
	TextDrawLetterSize( TDEditor_PTD, 0.398000, 1.590000);
	TextDrawTextSize(TDEditor_PTD, 0.000000, 200.000000);
	TextDrawAlignment(TDEditor_PTD, 2);
	TextDrawColor(TDEditor_PTD, -1);
	TextDrawUseBox(TDEditor_PTD, true);
	TextDrawBoxColor( TDEditor_PTD, 255);
	TextDrawSetShadow(TDEditor_PTD, false);
	TextDrawSetOutline(TDEditor_PTD, false);
	TextDrawBackgroundColor(TDEditor_PTD, 255);//untere Box
	TextDrawFont(TDEditor_PTD, 1);
	TextDrawSetProportional( TDEditor_PTD, true);
	TextDrawSetShadow(TDEditor_PTD, 1);
}

forward InitializeBiz();
public InitializeBiz(){
	new text[128];
	for(new i=0;i<MAX_AUTO;i++){
		format(text,sizeof(text),"%s", tradeautomat[i][name]);
    	Create3DTextLabel(text, 0xFFA000FF, tradeautomat[i][x], tradeautomat[i][y], tradeautomat[i][z]+0.5, 10.0,0);
    	Create3DTextLabel("Benutze N um das Menü zu öffnen", 0xFFFFFFFF, tradeautomat[i][x], tradeautomat[i][y], tradeautomat[i][z]+0.25, 10.00, 0);
		CreateObject(2754,tradeautomat[i][x], tradeautomat[i][y], tradeautomat[i][z], 0.0, 0.0, -90.0);
		}
	return 1;
}

public OnGameModeInit()
{
 	AddPlayerClass(250, 0, 1958.3783, 1343.1572, 15.3746, 0, 0, 0 ,0 , 0 ,0);
	SetGameModeText("SNENS");
    InitializeTD("Werte werden berechnet....");
    for(new j = 0; j<MAX_AUTO; j++){
  	 	for(new i = 0; i < MAX_POINTS; i++)
    	{
	   	 	if(i == 0) pointData[j][i][val] = floatrandom(-5.0,15.0,6);
	   		else if(i == MAX_POINTS - 1) pointData[j][i][val] = pointData[j][i-1][val];
	    	else if(i > 50) pointData[j][i][val] = pointData[j][i-1][val] + 0.1;
	    	else pointData[j][i][val] = pointData[j][i-1][val] + floatrandom(0,1.9,9);
		}
		
  		tradeautomat[j][graph] = GRAPHIC::Create(200.0, 250.0, 0, 0, 230, 230);
		GRAPHIC::XYAxisColor(tradeautomat[j][graph], 0xFFFFFFFF, 0xFFFFFFFF);
		GRAPHIC::UseBackground(tradeautomat[j][graph], 1);
		GRAPHIC::BackgroundColor(tradeautomat[j][graph], 0x000000FF);
	}


    SetTimer("UpdateBizes", 60000, true);

    InitializeBiz();
    return 1;
}
/*
CMD:trade(playerid, params[])
{
	new money, bbuy[24], mstr[256];
	if(sscanf(params, "is[24]", money, bbuy)) return SendClientMessage(playerid, -1, "[USAGE] /trade [MONEY] [Buy/Sell]");
	if(money < 0) return SendClientMessage(playerid, -1, "[ERROR] Money must be positive.");
	if(!strcmp(bbuy, "buy", true, 3))
	{
	    pData[playerid][moneyput] = money;
		pData[playerid][put] = pointData[1][MAX_POINTS - 1][val];
		GivePlayerMoney(playerid, -money);
		pData[playerid][buy] = 1; // buy
		format(mstr, 256, "You have put on buy at %f", pData[playerid][put]);
		SendClientMessage(playerid, -1, mstr);
	}
	else if(!strcmp(bbuy, "sell", true, 4))
	{#+
	    pData[playerid][moneyput] = money;
		pData[playerid][put] = pointData[1][MAX_POINTS - 1][val];
		GivePlayerMoney(playerid, -money);
		pData[playerid][buy] = 2; // sell
		format(mstr, 256, "You have put on sell at %f", pData[playerid][put]);
		SendClientMessage(playerid, -1, mstr);
	}
	else SendClientMessage(playerid, -1, "ERROR");
	return 1;
}

CMD:stoptrade(playerid, params[])
{
	if(pData[playerid][moneyput] == 0) return SendClientMessage(playerid, -1, "ERROR");
	new Float:diff;
	if(pData[playerid][buy] == 1) diff = pointData[1][MAX_POINTS-1][val] - pData[playerid][put];
	else if(pData[playerid][buy] == 2) diff = pData[playerid][put] - pointData[1][MAX_POINTS - 1][val];
	new multi = floatround(diff);
	GivePlayerMoney(playerid, multi*pData[playerid][moneyput]);
	new mstr[256];
	format(mstr, 256, "You have earned %i.", multi*pData[playerid][moneyput]);
	SendClientMessage(playerid, -1, mstr);
	pData[playerid][moneyput] = 0;
	pData[playerid][put] = 0;
	pData[playerid][buy] = 0;
	return 1;
}

native Graph:GRAPHIC::Create(Float:x, Float:y, Float:x_min, Float:y_min, Float:x_max, Float:y_max);
native GRAPHIC::XYAxisColor(Graph:_id, _x_color, _y_color);
native GRAPHIC::UseBackground(Graph:_id, use);
native GRAPHIC::BackgroundColor(Graph:_id, color);
native GRAPHIC::GRAPHIC::AddPoint(Graph:_id, Float:x, Float:y, color);
native GRAPHIC::ShowForPlayer(playerid, Graph:_id);
native GRAPHIC::HideForPlayer(playerid, Graph:_id);
native GRAPHIC::ShowForAll(Graph:_id);
native GRAPHIC::HideForAll(Graph:_id);
native GRAPHIC::Update(Graph:_id, playerid = INVALID_PLAYER_ID);
native GRAPHIC::Destroy(Graph:_id);
native GRAPHIC::OtherXYAxis(oper, playerid, Graph:_id, xAxis, yAxis);


forward ChangeVals(bizid);
public ChangeVals()
{
    GRAPHIC::RemoveTD(MAX_POINTS);
	GRAPHIC::Destroy(MY_GRAPH);
    MY_GRAPH = GRAPHIC::Create(200.0, 250.0, 0, 0, 230, 230);
    GRAPHIC::XYAxisColor(MY_GRAPH, 0x000000FF, 0x000000FF);


	GRAPHIC::UseBackground(MY_GRAPH, 1);
	GRAPHIC::BackgroundColor(MY_GRAPH, 0x000000FF);
	new Float:exps;
	new Float:oldshit = exps;
	for(new i = 0; i < MAX_POINTS; i++)
	{
		exps = floatrandom(12,55,4);
	    if(i == MAX_POINTS - 1) pointData[1][i][val] = pointData[1][i][val] + exps;
	    else pointData[1][i][val] = pointData[1][i+1][val];
	    if(pointData[1][i][val] < 0.0) pointData[1][i][val] = 0.0;
	    if(pointData[1][i][val] > 229.0) pointData[1][i][val] = 229.0;
	    if(i < 0 || i > MAX_POINTS-1) continue;
	    GRAPHIC::AddPoint(MY_GRAPH, i,  pointData[1][i][val], 0xFFFFFFFF);
	}
	new Float:newshit = exps;
	new Float:diff = newshit - oldshit;
	new mstr[256];
	if(diff >= 0) format(mstr, 256, "      Neu: %f     Diff:~g~%f", newshit, diff);
	else format(mstr, 256, "      Neu: %f     Diff:~r~%f", newshit, diff);
	//TextDrawDestroy(TDEditor_PTD);
	//InitializeTD(mstr);
	TextDrawSetString(TDEditor_PTD, mstr);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(pData[i][showing] == 1)
			{
			    GRAPHIC::ShowForPlayer(i, MY_GRAPH);
				//TextDrawHideForPlayer(i, TDEditor_PTD);
				TextDrawShowForPlayer(i, TDEditor_PTD);
			}
	    }
	}
	GRAPHIC::ResetTD();
}*/
forward UpdateBizes();
public UpdateBizes(){
	for(new i=0;i<MAX_AUTO; i++){
		ChangeVals(i);
	}
	return 1;
}

forward ChangeVals(bizid);
public ChangeVals(bizid){
    GRAPHIC::RemoveTD(MAX_POINTS);
	GRAPHIC::Destroy(tradeautomat[bizid][graph]);
    tradeautomat[bizid][graph] = GRAPHIC::Create(200.0, 250.0, 0, 0, 230, 230);
    GRAPHIC::XYAxisColor(tradeautomat[bizid][graph], 0xFFFFFFFF, 0xFFFFFFFF);
    GRAPHIC::UseBackground(tradeautomat[bizid][graph], 1);
	GRAPHIC::BackgroundColor(tradeautomat[bizid][graph], 0x000000FF);
	new Float:exps;
	new Float:oldshit = pointData[bizid][MAX_POINTS-1][val];
	for(new i = 0; i < MAX_POINTS; i++)
	{
		exps = floatrandom(0.02566, 0.98553312354, 4);
	    if(i == MAX_POINTS - 1) pointData[bizid][i][val] = pointData[bizid][i][val] + exps;
	    else pointData[bizid][i][val] = pointData[bizid][i+1][val];
	    if(i < 0 || i > MAX_POINTS-1) continue;
	    GRAPHIC::AddPoint(tradeautomat[bizid][graph], i,  pointData[bizid][i][val], 0xFFFFFFFF);
	}
	
	new Float:newshit = pointData[bizid][MAX_POINTS - 1][val];
	new Float:diff =  newshit - oldshit;
	tradeautomat[bizid][stand] = newshit;
	tradeautomat[bizid][differenz] = diff;
	if(diff >= 0) format(tradeautomat[bizid][mstr], 256, "      Neu: %f  		   Diff:~g~%f", tradeautomat[bizid][stand], tradeautomat[bizid][differenz]);
	else format(tradeautomat[bizid][mstr], 256, "      Neu: %f     	   Diff:~r~%f", tradeautomat[bizid][stand], tradeautomat[bizid][differenz]);
	//TextDrawDestroy(TDEditor_PTD);
	//InitializeTD(mstr);

	TextDrawSetString(TDEditor_PTD, tradeautomat[bizid][mstr]);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(pData[i][showing] == 1)
			{
			    GRAPHIC::ShowForPlayer(i, tradeautomat[bizid][graph]);
				//TextDrawHideForPlayer(i, TDEditor_PTD);
				TextDrawShowForPlayer(i, TDEditor_PTD);
			}
	    }
	}
	GRAPHIC::ResetTD();
    return 1;
}


CMD:gmx(playerid,params[])
{

	SendRconCommand("gmx");
	return 1;
}

CMD:gobiz(playerid,params[])
{
	new bID;
	if(sscanf(params,"i",bID))return SendClientMessage(playerid,0,"FEHLER: /gotoxyz [x-pos] [y-pos] [zpos]");
	SetPlayerPos(playerid,tradeautomat[bID][x],tradeautomat[bID][y],tradeautomat[bID][z]);
	return 1;
}

CMD:geld(playerid,params[])
{
	GivePlayerMoney(playerid,10000);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerPos(playerid, -1800.8541,929.4044,24.7487);
	return 1;
}


public OnPlayerText(playerid, text[])
{
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

public OnPlayerActionStateChange(playerid, ACTION:newactions, ACTION:oldactions)
{
	if(newactions & KEY_NO){
		for(new i=0;i<=MAX_AUTO;i++){
			if(IsPlayerInRangeOfPoint(playerid,10,tradeautomat[i][x],tradeautomat[i][y], tradeautomat[i][z])){
				SendClientMessage(playerid,0xFFFF00FF,"B?SE: {FFFFFF}Willkommen bei der Nova e-Sports B?rse.");
           		ShowPlayerDialog(playerid, DIALOG_TRADE, DIALOG_STYLE_LIST, "Nova e-Sports B?rse", "Aktien kaufen\nAktien verkaufen\nAktienkurs einsehen", "Best?igen", "Abbrechen");
           		pData[playerid][moneyput][pData[playerid][aktbiz]]=i;
				new fstring[128], string[128];
				format(string,sizeof(string),"Diff: %f",floatstr(tradeautomat[pData[playerid][aktbiz]][differenz]));
				format(fstring,sizeof(fstring),"Wert: %f",floatstr(tradeautomat[pData[playerid][aktbiz]][stand]));
				SendClientMessage(playerid,0xFFFFFFFF,string);
				SendClientMessage(playerid,0xFFFFFFFF,fstring);
	            return 1;
 			}
		}
	}
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

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_TRADE){
	    if(response){
			switch(listitem)
			{
			    //Aktien kaufen
			    case 0:
			    {
			    	
				ShowPlayerDialog(playerid,DIALOG_BUY,DIALOG_STYLE_INPUT,"Nova e-Sports Börse","Gebe den Betrag an für den du Aktien erwerben willst:","Kaufen","Abbrechen");
				
				}
				//Aktien verkaufen
				case 1:
				{
					SendClientMessage(playerid,0xFFFF00FF,"BÖRSE: {FFFFFF}Du hast erfolgreich deine Aktien verkauft!");
					if(pData[playerid][moneyput][pData[playerid][aktbiz]] == 0) return SendClientMessage(playerid, -1, "FEHLER: Du hast keine Aktien bei diesem Biz erworben.");
					new Float:diff;
					if(pData[playerid][buy] == 1) diff = pointData[1][MAX_POINTS-1][val] - pData[playerid][put];
					else if(pData[playerid][buy] == 2) diff = pData[playerid][put] - pointData[pData[playerid][aktbiz]][MAX_POINTS - 1][val];
					new multi = floatround(diff);
					GivePlayerMoney(playerid, multi*pData[playerid][moneyput]);
					SendClientMessage(playerid, -1, "ERFOLG: Du hast deine Aktien verkauft.");
					format(tradeautomat[pData[playerid][aktbiz]][mstr], 256, " %i.", multi*pData[playerid][moneyput]);
					SendClientMessage(playerid, -1, tradeautomat[pData[playerid][aktbiz]][mstr]);
					pData[playerid][moneyput][pData[playerid][aktbiz]] = 0;
					pData[playerid][put] = 0;
					pData[playerid][buy] = 0;
				}
				//Aktienkurs anzeigen
				case 2:
				{
					new bizid = pData[playerid][aktbiz];
					if(pData[playerid][showing] == 0)
					{
						GRAPHIC::ShowForPlayer(playerid, tradeautomat[bizid][graph]);
	   					TextDrawShowForPlayer(playerid, TDEditor_PTD);
						pData[playerid][showing] = 1;
						TogglePlayerControllable(playerid,false);
						GRAPHIC::ResetTD();
					}
					else
					{
	   					GRAPHIC::HideForPlayer(playerid, tradeautomat[bizid][graph]);
	    				TextDrawHideForPlayer(playerid, TDEditor_PTD);
						pData[playerid][showing] = 0;
						TogglePlayerControllable(playerid,true);
						GRAPHIC::ResetTD();

					}
				}

			}


		}
	}
	
	if(dialogid == DIALOG_BUY){
		if(response){
  			if(strlen(inputtext)>0)
			{
				new string[128];
				SendClientMessage(playerid,0xFFFFFFFF,inputtext);
				pData[playerid][buy][pData[playerid][aktbiz]]=strval(inputtext);
				if(GetPlayerMoney(playerid)<strval(inputtext))return SendClientMessage(playerid,0xFFFFFFFF,"Du hast nicht genug Geld bei dir!");
				format(string,sizeof(string),"ERFOLG: Du hast Aktien im Wert von $%i gekauft!");
				SendClientMessage(playerid,0xFFFFFFFF,string);
				GivePlayerMoney(playerid,GetPlayerMoney(playerid)-strval(inputtext));
				
			}else
			{
                SendClientMessage(playerid,0xFFFFFFFF,"FEHLER: Du hast keinen Wert eingegeben.");
    			SendClientMessage(playerid,0xFFFFFFFF,"FEHLER: Der Vorgang wurde abgebrochen.");
			}
		}
	}
	return 0;
}
