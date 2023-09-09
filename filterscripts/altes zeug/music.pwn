// Simple Filterscript - youtube music
// /dmusic = Edinson_Walker / EdinsonWalker.
// /music = jhgr16

#include < a_samp >

public OnFilterScriptInit() {
    print("       /dmusic /music       ");
    return 1;
}

public OnFilterScriptExit() {
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[]) {
    if (strcmp("/dmusic", cmdtext, true) == 0) {
        ShowPlayerDialog(playerid, 2016, DIALOG_STYLE_INPUT, "{D6E1EB}Youtube", "{FFFFFF}Insert the video/music title", "Accept", "Cancel");
        return 1;
    } else if (strcmp("/music", cmdtext, true, 7) == 0) {
        if(!cmdtext[7])return SendClientMessage(playerid, 0xD6E1EBFF, "/music [title]");
        new ola[255];
        format(ola, sizeof(ola), "https://6t.pe/?song=%s", cmdtext[7]);
        PlayAudioStreamForPlayer(playerid, ola);
        return 1;
    }
    return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if(dialogid == 2016) {
        if (!response) return SendClientMessage(playerid, 0xD6E1EBFF, "Dialog music canceled.");
        if(strlen(inputtext)) {
            new ola[255];
            format(ola, sizeof(ola), "https://6t.pe/?song=%s", inputtext);
            PlayAudioStreamForPlayer(playerid, ola);
        }
    }
    return 0;
}
