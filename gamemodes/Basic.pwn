/*
                                    Copyright © SA-MP
 ______________________________________________________________________________________________
|                                                                                              |
|    * Gamemode developed by Ygzeb.                                                            |
|______________________________________________________________________________________________|

                                     Blank Gamemode
                                   -----------------
*/

//==============================================================================
// Include.
//==============================================================================
#include <a_samp>
#include <streamer>
#include <utils>
//==============================================================================
// Print.
//==============================================================================
main()
{
print("Mein erstes Script!");
}
//==============================================================================
//------------------------------------------------------------------------------
//                         Publics.
//------------------------------------------------------------------------------
//==============================================================================
//==============================================================================
// Public - OnGameModeInit.
//==============================================================================
public OnGameModeInit()
{
UsePlayerPedAnims();
SetGameModeText("Blank");
AddPlayerClass(115, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
AddPlayerClass(122, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
AddPlayerClass(166, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
AddPlayerClass(270, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
return 1;
}
//==============================================================================
// Public - OnPlayerRequestClass.
//==============================================================================
public OnPlayerRequestClass(playerid, classid)
{
SetPlayerPos(playerid, 2294.2810, 558.2053, 7.7813);
SetPlayerCameraPos(playerid, 2294.3071, 560.6948, 8.7324);
SetPlayerCameraLookAt(playerid, 2294.2810, 558.2053, 7.7813);
SetPlayerFacingAngle(playerid, 0);
return 1;
}
//==============================================================================
// Public - OnPlayerConnect.
//==============================================================================
public OnPlayerConnect(playerid)
{
SendClientMessage(playerid, 0xFFFFFFAA, "Welcome to my {FFA600}SA-MP Server!");
SetPlayerColor(playerid, 0xFFA600AA);
return 1;
}
//==============================================================================
// Public - OnPlayerSpawn.
//==============================================================================
public OnPlayerSpawn(playerid)
{
SetPlayerPos(playerid, 1876.31, -1398.76, 13.57);
SetPlayerFacingAngle(playerid, 212.11);
SetPlayerVirtualWorld(playerid, 0);
SetPlayerInterior(playerid, 0);
SetCameraBehindPlayer(playerid);
GivePlayerWeapon(playerid, 23, 15000);
SetPlayerHealth(playerid, 50);
SendClientMessage(playerid, -1, "You spawned!"); // Function added.
return 1;
}
//==============================================================================
// Public - OnPlayerDeath.
//==============================================================================
public OnPlayerDeath(playerid)
{
   GameTextForPlayer(playerid, "Wasted", 5000, 2); // Screen message for player.
   return 1;
}
//==============================================================================
// Public - OnPlayerCommandText.
//==============================================================================
public OnPlayerCommandText(playerid, cmdtext[])
{
if(strcmp("/Credits", cmdtext, true, 10) == 0)
{
SendClientMessage(playerid, 0xFFFFFFAA, "Ioannis20x");
return 1;
}
return 0;
}

//VERBOTENE WAFFEN
public OnPlayerUpdate(playerid)
{
if(GetPlayerWeapon(playerid) == 38) return Kick(playerid); // Kicking the player if he is using minigun.
return 1;
}



public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == 3)
    {
        if(response) // If they clicked 'Select' or double-clicked a weapon.
        {
            switch(listitem) // We create a switch to list all the items; each case is a item from our dialog.
            {
                case 0:
                {
                    GivePlayerWeapon(playerid, 24, 14); // Give them a desert eagle with 14 bullets.
                }
                case 1:
                {
                    GivePlayerWeapon(playerid, 30, 120); // Give them an AK-47 with 120 bullets.
                }
                case 2:
                {
                    GivePlayerWeapon(playerid, 27, 28); // Give them a Combat Shotgun with 28 bullets.
                }
            }
        }
        return 1; // Ending the dialog #3.
    }
    return 1;
}
