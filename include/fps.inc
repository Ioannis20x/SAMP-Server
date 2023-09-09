/*  SA-MP FPS Include
 *
 *  (c) Copyright 2019, Kaliber
 *
 */
/******************************************************************************/
/*
	native GetPlayerFPS(playerid);
*/
/******************************************************************************/
#if defined _fps_included
	#endinput
#endif
#define _fps_included
/******************************************************************************/
#if !defined _samp_included
    #include <a_samp>
#endif
/******************************************************************************/
#define fps_Hook:: _fps@_
/******************************************************************************/
#define GetPlayerFPS(%0) public_fps{%0}
/******************************************************************************/
#if defined FILTERSCRIPT
    public OnFilterScriptInit()
	{
	    SetTimer(!"@fps",251,1);
        #if defined _fps@_OnFilterScriptInit
        	return fps_Hook::OnFilterScriptInit();
	    #else
	        return 1;
	    #endif
	}
	#if defined _fps@_OnFilterScriptInit
	    forward fps_Hook::OnFilterScriptInit();
	#endif
	#if defined _ALS_OnFilterScriptInit
        #undef OnFilterScriptInit
    #else
        #define _ALS_OnFilterScriptInit
    #endif
    #define OnFilterScriptInit _fps@_OnFilterScriptInit
#else
    public OnGameModeInit()
    {
        SetTimer(!"@fps",251,1);
        #if defined _fps@_OnGameModeInit
        	return fps_Hook::OnGameModeInit();
	    #else
	        return 1;
	    #endif
	}
	#if defined _fps@_OnGameModeInit
	    forward fps_Hook::OnGameModeInit();
	#endif
	#if defined _ALS_OnGameModeInit
        #undef OnGameModeInit
    #else
        #define _ALS_OnGameModeInit
    #endif
    #define OnGameModeInit _fps@_OnGameModeInit
#endif
/******************************************************************************/
new public_fps[MAX_PLAYERS char];
/******************************************************************************/
static drunk[MAX_PLAYERS];
/******************************************************************************/
static @fps();@fps()
{
	for(new i=GetPlayerPoolSize(),d,fps; i!=-1; i--)
	{
        d = GetPlayerDrunkLevel(i);
        if(d < 100) SetPlayerDrunkLevel(i,2000);
        else
        {
            fps = drunk[i]-d;
            if(fps > 0) public_fps{i} = fps;
            drunk[i] = d;
        }
	}
	return 1;
}
/******************************************************************************/
