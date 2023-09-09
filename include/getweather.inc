/*

	About: GetWeather function realisation
	Author: ziggi

*/

#if !defined _samp_included
	#error "Please include a_samp or a_npc before getweather"
#endif

#if defined _getweather_included
	#endinput
#endif

#define _getweather_included

/*
	Vars
*/

static
	gCurrentWeather;

/*
	SetWeather
*/

stock Weather_SetWeather(weatherid)
{
	gCurrentWeather = weatherid;

	return
		SetWeather(weatherid);
}
#if defined _ALS_SetWeather
	#undef SetWeather
#else
	#define _ALS_SetWeather
#endif

#define SetWeather Weather_SetWeather

/*
	GetWeather
*/

stock GetWeather()
{
	return gCurrentWeather;
}
