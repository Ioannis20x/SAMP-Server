// Test menu functionality filterscipt

#include <a_samp>

#define TEST_MENU_ITEMS 6

new Menu:TestMenu = -1;
new TestMenuStrings[6][16] = {"Test1", "Test2", "Test3", "Test4", "Test5", "Test6"};

HandleTestMenuSelection(playerid, row)
{
	new s[256];

	if(row < TEST_MENU_ITEMS) {
		format(s,256,"You selected item %s",TestMenuStrings[row]);
		SendClientMessage(playerid,0xFFFFFFFF,s);
	}
}

InitTestMenu()
{
	TestMenu = CreateMenu("Test Menu", 1, 200.0, 150.0, 200.0, 200.0);
        if(TestMenu == -1)
        {
            printf("The creation of menu failed!");
            return 0;
        }
	for(new x=0; x < TEST_MENU_ITEMS; x++) {
    	        AddMenuItem(TestMenu, 0, TestMenuStrings[x]);
	}
        return 1;
}

public OnFilterScriptInit()
{
   	if(InitTestMenu())
        {
            printf("The creation of menu succeeded!");
        }
        return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
        new Menu:PlayerMenu = GetPlayerMenu(playerid);

        if(PlayerMenu == TestMenu) {
	     HandleTestMenuSelection(playerid, row);
	}
        return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/menutest", true) && TestMenu != -1)	{
    	     ShowMenuForPlayer(TestMenu, playerid);
    	     return 1;
	}
	return 0;
}
