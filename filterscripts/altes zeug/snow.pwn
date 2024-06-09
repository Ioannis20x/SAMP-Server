#include <a_samp>
#include <zCMD>
/*------------------------------*/
#define MAX_SNOW 86  // ANDERE TEXTRAWS + MAX_SNOW = 92
#define SPEED    100 // WENIGER = SCHNELLER
/*------------------------------*/
forward onSnow();
new Text:s[MAX_SNOW],Float:p[MAX_SNOW][2],Float:g[MAX_SNOW][2];
Float:berx()
{
	new Float:ret=random(400)+150;
	ret=floatdiv(ret,1000);
	return ret;
}

Float:bery()
{
	new Float:ret=random(1600)+700;
	ret=floatdiv(ret,1000);
	return ret;
}

public OnFilterScriptInit()
{
	print("\nSNOW TEST");
	for(new i;i<MAX_SNOW;i++)
	{
	    new Float:x=random(627),y=random(425);
	    new Float:lsx=berx();
	    new Float:lsy=bery();
	    s[i]=TextDrawCreate(x,y,".");
	    TextDrawBackgroundColor(s[i],0x00000000);
		TextDrawFont(s[i],3);
		TextDrawLetterSize(s[i],lsx,lsy);
		TextDrawColor(s[i],0xffffffff);
		p[i][0]=x;
		p[i][1]=y;
		g[i][0]=lsx;
		g[i][1]=lsy;
		TextDrawShowForAll(s[i]);
	}
	SetTimer("onSnow",SPEED,1);
	return 1;
}
public onSnow()
{
	for(new i;i<MAX_SNOW;i++)
	{
	    p[i][1]++;
	    TextDrawDestroy(s[i]);
	    if(p[i][1]>=426)
	    {
	        p[i][0]=random(627);
	        p[i][1]=0.0;
	        g[i][0]=berx();
	    	g[i][1]=bery();
	    }
	    s[i]=TextDrawCreate(p[i][0],p[i][1],".");
	    TextDrawBackgroundColor(s[i],0x00000000);
		TextDrawFont(s[i],3);
		TextDrawLetterSize(s[i],g[i][0],g[i][1]);
		TextDrawColor(s[i],0xffffffff);
		TextDrawShowForAll(s[i]);
	}
}
public OnFilterScriptExit()
{
	for(new i;i<MAX_SNOW;i++)TextDrawDestroy(s[i]);
	return 1;
}
