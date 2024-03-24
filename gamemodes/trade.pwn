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
#define MAX_AUTO 2
#define DIALOG_TRADE 152
#define DIALOG_BUY 153
#define DIALOG_SELL 222

new MAX_EXPS = 1.0425;

new Text:TDEditor_PTD;

enum pdata
{
	showing,
	moneyput,
 	Float:put,
 	buy
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
	Float:differenz
}

new tradeautomat[MAX_AUTO][tradeenum]={
{"Fastfood AG", -1814.5582, 904.7863, 24.8906, -1.00, 25, -0.444},
{"SAM AG", 0, 0, 3, -5.00, 10, -0.0099}


};

new Graph:MY_GRAPH;
new pointData[MAX_AUTO][MAX_POINTS][pdta];

new Float:IncDec[][1] = {
	{1.045}, {2.042}, {-1.045}, {-2.042}, {1.234}, {-1.234}, {-0.124}, {0.124}
};
forward InitializeTD(str[]);
public InitializeTD(str[])
{
	TDEditor_PTD = TextDrawCreate(315.768646, 246.101257, str);
	TextDrawLetterSize( TDEditor_PTD, 0.398000, 1.590000);
	TextDrawTextSize(TDEditor_PTD, 0.000000, 200.000000);
	TextDrawAlignment(TDEditor_PTD, 2);
	TextDrawColor(TDEditor_PTD, -1);
	TextDrawUseBox(TDEditor_PTD, 1);
	TextDrawBoxColor( TDEditor_PTD, 255);
	TextDrawSetShadow(TDEditor_PTD, 0);
	TextDrawSetOutline(TDEditor_PTD, 0);
	TextDrawBackgroundColor(TDEditor_PTD, 255);//untere Box
	TextDrawFont(TDEditor_PTD, 1);
	TextDrawSetProportional( TDEditor_PTD, 1);
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

forward CreditsEzpz();


public OnGameModeInit()
{
 	AddPlayerClass(0, 0, 1958.3783, 1343.1572, 15.3746, 0, 0, 0 ,0 , 0 ,0);
	SetGameModeText("SNENS");
    InitializeTD("Nothing");
    for(new i = 0; i < MAX_POINTS; i++)
    {
	    if(i == 0) pointData[1][i][val] = floatrandom(-5.0,5.0,6);
	    else if(i == MAX_POINTS - 1) pointData[1][i][val] = pointData[1][i-1][val];
	    else if(i > 150) pointData[1][i][val] = pointData[1][i-1][val] + 0.1;
	    else pointData[1][i][val] = pointData[1][i-1][val] + floatrandom(0,1.0,2);
	}
    MY_GRAPH = GRAPHIC::Create(200.0, 250.0, 0, 0, 230, 230);
	GRAPHIC::XYAxisColor(MY_GRAPH, 0x000000FF, 0x000000FF);

	GRAPHIC::UseBackground(MY_GRAPH, 1);
	GRAPHIC::BackgroundColor(MY_GRAPH, 0x000000FF);

    SetTimer("ChangeVals", 1500, true);

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
*/
/*CMD:stoptrade(playerid, params[])
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
}/*/

/*native Graph:GRAPHIC::Create(Float:x, Float:y, Float:x_min, Float:y_min, Float:x_max, Float:y_max);
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
native GRAPHIC::OtherXYAxis(oper, playerid, Graph:_id, xAxis, yAxis);*/


forward ChangeVals();/*
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

public ChangeVals(){
    GRAPHIC::RemoveTD(MAX_POINTS);
	GRAPHIC::Destroy(MY_GRAPH);
    MY_GRAPH = GRAPHIC::Create(200.0, 250.0, 0, 0, 230, 230);
    GRAPHIC::XYAxisColor(MY_GRAPH, 0xFFFFFFFF, 0xFFFFFFFF);
    GRAPHIC::UseBackground(MY_GRAPH, 1);
	GRAPHIC::BackgroundColor(MY_GRAPH, 0x000000FF);
	new Float:exps;
	new Float:oldshit = pointData[1][MAX_POINTS-1][val];
	for(new i = 0; i < MAX_POINTS; i++)
	{
		exps = floatrandom(-12,5,4);
	    if(i == MAX_POINTS - 1) pointData[1][i][val] = pointData[1][i][val] + exps;
	    else pointData[1][i][val] = pointData[1][i+1][val];
	    if(i < 0 || i > MAX_POINTS-1) continue;
	    GRAPHIC::AddPoint(MY_GRAPH, i,  pointData[1][i][val], 0xFFFFFFFF);
	}

	new Float:newshit = exps;
	new Float:diff =  oldshit - newshit;
	new mstr[256];
	if(diff >= 0) format(mstr, 256, "      Neu: %f  		   Diff:~g~%f", newshit, diff);
	else format(mstr, 256, "      Neu: %f     	   Diff:~r~%f", newshit, diff);
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
    return 1;
}


CMD:gmx(playerid,params[])
{

	SendRconCommand("gmx");
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
			if(IsPlayerInRangeOfPoint(playerid,10,-1814.5582, 904.7863, 24.8906)){
				SendClientMessage(playerid,0xFFFF00FF,"BÖRSE: {FFFFFF}Willkommen bei der Nova e-Sports Börse.");
           		ShowPlayerDialog(playerid, DIALOG_TRADE, DIALOG_STYLE_LIST, "Nova e-Sports Börse", "Aktien kaufen\nAktien verkaufen\nAktienkurs einsehen", "Bestätigen", "Abbrechen");
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
					SendClientMessage(playerid,0xFFFF00FF,"BÖRSE: {FFFFFF}Du hast erfolgreich deine Aktien verkauf!");
					if(pData[playerid][moneyput] == 0) return SendClientMessage(playerid, -1, "FEHLER: Du hast keine Aktien bei diesem Biz erworben.");
					new Float:diff;
					if(pData[playerid][buy] == 1) diff = pointData[1][MAX_POINTS-1][val] - pData[playerid][put];
					else if(pData[playerid][buy] == 2) diff = pData[playerid][put] - pointData[1][MAX_POINTS - 1][val];
					new multi = floatround(diff);
					GivePlayerMoney(playerid, multi*pData[playerid][moneyput]);
					new mstr[256];
					SendClientMessage(playerid, -1, "ERFOLG: Du hast deine Aktien verkauft.");
					format(mstr, 256, " %i.", multi*pData[playerid][moneyput]);
					SendClientMessage(playerid, -1, mstr);
					pData[playerid][moneyput] = 0;
					pData[playerid][put] = 0;
					pData[playerid][buy] = 0;
				}
				//Aktienkurs anzeigen
				case 2:
				{
					if(pData[playerid][showing] == 0)
					{
						GRAPHIC::ShowForPlayer(playerid, MY_GRAPH);
	   					TextDrawShowForPlayer(playerid, TDEditor_PTD);
						pData[playerid][showing] = 1;
						TogglePlayerControllable(playerid,false);
					}
					else
					{
	   					GRAPHIC::HideForPlayer(playerid, MY_GRAPH);
	    				TextDrawHideForPlayer(playerid, TDEditor_PTD);
						pData[playerid][showing] = 0;
						TogglePlayerControllable(playerid,true);
					}
				}

			}


		}
	}
	
	if(dialogid == DIALOG_BUY){
		if(response){
  			if(strlen(inputtext)>0)
			{
				SendClientMessage(playerid,0xFFFFFFFF,inputtext);
			}else
			{
                SendClientMessage(playerid,0xFFFFFFFF,"FEHLER: Du hast keinen Wert eingegeben.");
    			SendClientMessage(playerid,0xFFFFFFFF,"FEHLER: Der Vorgang wurde abgebrochen.");
			}
		}
	}
	return 0;
}
