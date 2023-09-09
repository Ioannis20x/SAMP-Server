#include <a_samp>
#include <zCMD>
#include <sscanf2>
#include <a_mysql>
#include <streamer>

#define COLOR_RED 0xCC210AFF
#define COLOR_YELLOW 0xFFFA00FF
#define COLOR_GREY 0x828282FF
#define COLOR_DARK_RED 0x6A0000FF
#define COLOR_GREEN 0x00FF00FF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_HGREEN 0x9ACD32FF
#define COLOR_BLACK 0x000000FF
#define COLOR_BLUE 0x0000FFFF
#define COLOR_HBLUE 0x51CCFFFF
#define COLOR_PINK 0xFFA1C8FF
#define COLOR_ORANGE 0xFF8C00FF
#define COLOR_CHAT 0xFFFFFFFF
#define COLOR_FADE1 0xE6E6E6FF
#define COLOR_FADE2 0xD1CFD1FF
#define COLOR_FADE3 0xBEC1BEFF
#define COLOR_FADE4 0x919397FF

public OnGameModeInit()
{//LVKH
CreateObject(5708, 1934.92493, 716.14740, 20.14940,   0.00000, 0.00000, 180.00000);
CreateObject(8645, 1877.66418, 683.95453, 10.49140,   0.00000, 0.00000, 90.00000);
CreateObject(8645, 1877.66418, 658.21680, 10.49140,   0.00000, 0.00000, 270.00000);
CreateObject(8645, 1877.34290, 723.00507, 10.49140,   0.00000, 0.00000, 270.00000);
CreateObject(8645, 1877.32288, 748.25677, 10.49140,   0.00000, 0.00000, 90.00000);
CreateObject(9131, 1882.98108, 762.76581, 10.13140,   0.00000, 0.00000, 0.00000);
//SAM AG
CreateObject(3515, -1942.81812, 486.64020, 31.81610,   0.00000, 0.00000, 0.00000);
CreateObject(18739, -1942.69006, 486.71689, 32.79680,   0.00000, 0.00000, 0.00000);
CreateObject(19485, -1909.55908, 497.21899, 25.7101, 0, 0, 0);


CreateObject(6283, 379.06250, -2070.70337, 11.95690,   359.69839, 0.00000, 0.00000);
CreateObject(19368, 358.27200, -2039.85498, 6.74340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 358.27200, -2043.05505, 6.74340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 358.27200, -2046.25513, 6.74340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 358.27200, -2039.85498, 6.58340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 358.27200, -2043.05505, 6.58340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 358.27200, -2046.25500, 6.42340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 358.27200, -2046.25513, 6.58340,   -0.04000, 90.00000, 0.00000);
CreateObject(2395, 357.35330, -2038.73254, 6.88000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 357.35330, -2042.45251, 6.88000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 357.35330, -2046.17249, 6.88000,   -90.00000, 90.00000, 0.00000);
CreateObject(19368, 354.77200, -2046.25500, 6.42340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 350.89200, -2046.25513, 6.52340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 353.99200, -2046.25513, 6.74340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 354.77200, -2043.05518, 6.42340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 350.89200, -2043.05505, 6.58340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 353.97198, -2043.05505, 6.74340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 350.89200, -2039.85498, 6.58340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 353.97198, -2039.85498, 6.74340,   -0.04000, 90.00000, 0.00000);
CreateObject(2395, 354.61331, -2038.73254, 6.88000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 354.61331, -2042.45251, 6.88000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 354.61331, -2046.17249, 6.88000,   -90.00000, 90.00000, 0.00000);
CreateObject(19368, 350.89200, -2046.25500, 6.42340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 350.89200, -2043.05518, 6.42340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 350.89200, -2039.85498, 6.42340,   -0.04000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2046.17249, 6.88000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2042.45251, 6.88000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 6.88000,   -90.00000, 90.00000, 0.00000);
CreateObject(19368, 350.89200, -2039.85498, 6.74340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 350.89200, -2043.05505, 6.74340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 350.89200, -2046.25513, 6.72340,   -0.04000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2046.17249, 6.88000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2042.45251, 6.88000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 6.88000,   -90.00000, 90.00000, 0.00000);
CreateObject(970, 360.37839, -2014.32703, 7.38000,   0.00000, 0.00000, 90.00000);
CreateObject(970, 349.19849, -2045.00000, 7.38000,   0.00000, 0.00000, 90.00000);
CreateObject(970, 349.19849, -2040.33997, 7.38000,   0.00000, 0.00000, 90.00000);
CreateObject(2395, 349.13330, -2038.73254, 6.82000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 6.76000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 6.70000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 6.64000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 6.58000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 6.52000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 6.46000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 6.82000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 6.76000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 6.70000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 6.58000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 6.52000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 6.46000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 6.64000,   -90.00000, 90.00000, 0.00000);
CreateObject(19815, 349.10129, -2042.74890, 6.32290,   0.00000, 0.00000, 90.00000);
CreateObject(19815, 349.10129, -2039.74890, 6.32290,   0.00000, 0.00000, 90.00000);
CreateObject(19815, 350.61630, -2047.24280, 6.32290,   0.00000, 0.00000, 180.00000);
CreateObject(19368, 350.89200, -2039.85498, 6.24340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 350.89200, -2039.85498, 6.06340,   -0.04000, 90.00000, 0.00000);
CreateObject(19368, 350.89200, -2039.85498, 5.92340,   -0.04000, 90.00000, 0.00000);
CreateObject(19121, 349.27121, -2042.68591, 7.41190,   0.00000, 0.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 6.40000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 6.40000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 6.34000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 6.34000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 6.28000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 6.22000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 6.16000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 6.10000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 6.04000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 5.98000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 349.13330, -2038.73254, 5.94000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 6.28000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 6.22000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 6.16000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 6.10000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.89328, -2038.73340, 6.04000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 5.98000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.87329, -2038.73254, 5.94000,   -90.00000, 90.00000, 0.00000);
CreateObject(2395, 351.73120, -2044.47180, 5.79010,   90.00000, 0.00000, 0.00000);
CreateObject(2395, 349.61121, -2044.47180, 5.79010,   90.00000, 0.00000, 0.00000);
CreateObject(2395, 355.46121, -2044.48901, 5.79010,   90.00000, 0.00000, 0.00000);
CreateObject(2395, 359.19119, -2044.48901, 5.79010,   90.00000, 0.00000, 0.00000);
CreateObject(2395, 349.61121, -2041.75183, 5.79010,   90.00000, 0.00000, 0.00000);
CreateObject(2395, 351.75119, -2041.75220, 5.79010,   90.00000, 0.00000, 0.00000);
CreateObject(2395, 355.46121, -2041.74902, 5.79010,   90.00000, 0.00000, 0.00000);
CreateObject(2395, 349.61121, -2039.03186, 5.77010,   90.00000, 0.00000, 0.00000);
CreateObject(2395, 351.75119, -2039.03223, 5.77010,   90.00000, 0.00000, 0.00000);
CreateObject(2395, 355.46121, -2039.02905, 5.77010,   90.00000, 0.00000, 0.00000);
CreateObject(2395, 359.19119, -2041.74902, 5.79010,   90.00000, 0.00000, 0.00000);
CreateObject(2395, 359.19119, -2039.02905, 5.77010,   90.00000, 0.00000, 0.00000);
CreateObject(19815, 349.10001, -2045.72180, 6.32290,   0.00000, 0.00000, 90.00000);
CreateObject(2395, 349.61121, -2038.23193, 5.77010,   90.00000, 0.00000, 0.00000);
CreateObject(2395, 351.75119, -2038.25220, 5.77010,   90.00000, 0.00000, 0.00000);
CreateObject(2395, 355.46121, -2038.24915, 5.77010,   90.00000, 0.00000, 0.00000);
CreateObject(2395, 359.21680, -2038.26331, 5.77010,   90.00000, 0.00000, 0.00000);
CreateObject(19815, 356.09631, -2038.27124, 6.32290,   0.00000, 0.00000, 0.00000);
CreateObject(19815, 359.07629, -2038.27124, 6.32290,   0.00000, 0.00000, 0.00000);
CreateObject(19815, 353.59631, -2047.28284, 6.32290,   0.00000, 0.00000, 180.00000);
CreateObject(19815, 356.58179, -2047.27075, 6.32290,   0.00000, 0.00000, 180.00000);
CreateObject(19815, 359.58179, -2047.26978, 6.32290,   0.00000, 0.00000, 180.00000);
CreateObject(1269, 349.54401, -2038.53076, 7.62660,   0.00000, 0.00000, -90.00000);
CreateObject(1269, 349.54401, -2046.65076, 7.62660,   0.00000, 0.00000, -90.00000);
CreateObject(1246, 321.79648, -1902.14673, 46.43383,   0.00000, 0.00000, 0.00000);
CreateObject(970, 360.37839, -2018.44702, 7.38000,   0.00000, 0.00000, 90.00000);
CreateObject(970, 360.37839, -2022.58704, 7.38000,   0.00000, 0.00000, 90.00000);
CreateObject(3862, 354.53079, -2026.92163, 8.02211,   0.00000, 0.00000, 55.88034);
CreateObject(970, 358.31839, -2024.62695, 7.38000,   0.00000, 0.00000, 0.00000);
CreateObject(970, 354.45840, -2024.64697, 7.38000,   0.00000, 0.00000, 0.00000);
CreateObject(970, 352.39841, -2026.68701, 7.38000,   0.00000, 0.00000, 90.00000);
CreateObject(970, 352.39841, -2030.76697, 7.38000,   0.00000, 0.00000, 90.00000);
CreateObject(970, 352.39841, -2034.88696, 7.38000,   0.00000, 0.00000, 90.00000);
CreateObject(970, 351.29849, -2038.30005, 7.38000,   0.00000, 0.00000, 0.00000);
CreateObject(970, 352.39841, -2036.16699, 7.38000,   0.00000, 0.00000, 90.00000);
CreateObject(970, 355.35849, -2038.30005, 7.38000,   0.00000, 0.00000, 0.00000);
CreateObject(970, 357.75851, -2038.30005, 7.38000,   0.00000, 0.00000, 0.00000);
CreateObject(970, 351.25851, -2047.02002, 7.38000,   0.00000, 0.00000, 0.00000);
CreateObject(970, 355.35849, -2047.02002, 7.38000,   0.00000, 0.00000, 0.00000);
CreateObject(970, 357.77850, -2047.02002, 7.38000,   0.00000, 0.00000, 0.00000);
CreateObject(970, 364.83090, -2038.30005, 7.38000,   0.00000, 0.00000, 0.00000);
CreateObject(970, 374.51849, -2038.30005, 7.38000,   0.00000, 0.00000, 0.00000);
CreateObject(1215, 361.34109, -2038.30005, 7.38000,   0.00000, 0.00000, 0.00000);
CreateObject(1215, 378.30801, -2038.30005, 7.38000,   0.00000, 0.00000, 0.00000);

//Newsvan
CreateDynamicObject(16155,-218.41751098633,1412.0537109375,28.464504241943,0,0,285.24597167969);
CreateDynamicObject(2007,-217.61587524414,1409.7971191406,26.765625,0,0,269.25);
CreateDynamicObject(2009,-218.61212158203,1411.8537597656,26.7734375,0,0,270);
CreateDynamicObject(1723,-221.39657592773,1410.0789794922,26.7734375,0,0,90);
CreateDynamicObject(1715,-218.52700805664,1410.9708251953,26.7734375,0,0,270);
CreateDynamicObject(1963,-219.94709777832,1411.306640625,26.726245880127,0,0,90.5);
CreateDynamicObject(1717,-217.6351776123,1409.3314208984,26.765625,0,0,202);
CreateDynamicObject(2894,-220.34916687012,1410.7330322266,27.148431777954,0,0,286);
CreateDynamicObject(1958,-219.53067016602,1412.0372314453,27.214599609375,0,0,340);
CreateDynamicObject(3350,-221.47648620605,1408.4689941406,25.82345199585,0,0,126);
CreateDynamicObject(1893,-220.4801940918,1411.3532714844,29.867433547974,0,0,0);
CreateDynamicObject(1893,-220.55816650391,1409.1508789063,29.942443847656,0,0,0);
CreateDynamicObject(14820,-219.89140319824,1411.1959228516,27.185531616211,0,0,110);
CreateDynamicObject(3034,-221.88198852539,1410.4915771484,28.777812957764,0,0,90.25);
CreateDynamicObject(2955,-218.9574432373,1408.0163574219,27.965101242065,0,0,270);


//Park an SH
CreateObject(19536, 1479.12537, -1696.07971, 12.36520,   0.00000, 0.00000, 0.00000);
CreateObject(19536, 1479.14514, -1633.72278, 12.28520,   0.00000, 0.00000, 0.00000);
CreateObject(19536, 1479.65710, -1628.21619, 12.30520,   0.00000, 0.00000, 0.00000);

//scarfo Base
CreateObject(3573, 1803.30835, -2058.39404, 14.98440,   0.00000, 0.00000, 180.00000);
CreateObject(1497, 1767.85339, -2019.43677, 13.11660,   0.00000, 0.00000, 0.00000);
CreateObject(1497, 1764.30200, -2032.73291, 13.11660,   0.00000, 0.00000, 90.00000);
CreateObject(1497, 1764.33337, -2049.79688, 13.11660,   0.00000, 0.00000, 90.00000);

}
public OnPlayerRequestClass(playerid)
{
//Airport
RemoveBuildingForPlayer(playerid, 3769, 1961.4453, -2216.1719, 14.9844, 0.25);
RemoveBuildingForPlayer(playerid, 3664, 1960.6953, -2236.4297, 19.2813, 0.25);
RemoveBuildingForPlayer(playerid, 1412, 1949.3438, -2227.5156, 13.6563, 0.25);
RemoveBuildingForPlayer(playerid, 1412, 1944.0625, -2227.5156, 13.6563, 0.25);
RemoveBuildingForPlayer(playerid, 1412, 1954.6172, -2227.4844, 13.6875, 0.25);
RemoveBuildingForPlayer(playerid, 1412, 1965.1719, -2227.4141, 13.7578, 0.25);
RemoveBuildingForPlayer(playerid, 1412, 1959.8984, -2227.4453, 13.7266, 0.25);
RemoveBuildingForPlayer(playerid, 3625, 1961.4453, -2216.1719, 14.9844, 0.25);
RemoveBuildingForPlayer(playerid, 1412, 1975.7266, -2227.4141, 13.7578, 0.25);
RemoveBuildingForPlayer(playerid, 1412, 1970.4453, -2227.4141, 13.7578, 0.25);
RemoveBuildingForPlayer(playerid, 1412, 1981.0000, -2227.4141, 13.7578, 0.25);
RemoveBuildingForPlayer(playerid, 1412, 1996.8281, -2227.3828, 13.7891, 0.25);
RemoveBuildingForPlayer(playerid, 1412, 1991.5547, -2227.4141, 13.7578, 0.25);
RemoveBuildingForPlayer(playerid, 1412, 1986.2813, -2227.4141, 13.7578, 0.25);
RemoveBuildingForPlayer(playerid, 1412, 2002.1094, -2227.3438, 13.8281, 0.25);
//Pier
RemoveBuildingForPlayer(playerid, 6463, 389.7734, -2028.4688, 19.8047, 0.25);
RemoveBuildingForPlayer(playerid, 6464, 379.0625, -2065.0234, 11.7969, 0.25);
RemoveBuildingForPlayer(playerid, 6465, 368.0547, -2028.2422, 8.7344, 0.25);
RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2028.5000, 32.2266, 0.25);
RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2021.6406, 29.9297, 0.25);
RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2017.4531, 24.0313, 0.25);
RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2017.4297, 16.8516, 0.25);
RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2021.6328, 10.9844, 0.25);
RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2028.5156, 8.7813, 0.25);
RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2035.3984, 10.9453, 0.25);
RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2039.6406, 16.8438, 0.25);
RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2039.6563, 24.1094, 0.25);
RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2035.3828, 29.9531, 0.25);
RemoveBuildingForPlayer(playerid, 1529, 399.0078, -2066.8828, 11.2344, 0.25);
RemoveBuildingForPlayer(playerid, 1215, 360.4531, -2086.6719, 7.3750, 0.25);
RemoveBuildingForPlayer(playerid, 1308, 353.0156, -2081.1875, 6.5938, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 368.9297, -2083.2656, 7.2109, 0.25);
RemoveBuildingForPlayer(playerid, 1308, 353.0156, -2050.4844, 6.5938, 0.25);
RemoveBuildingForPlayer(playerid, 1232, 364.6094, -2036.1797, 9.5000, 0.25);
RemoveBuildingForPlayer(playerid, 6462, 368.0547, -2028.2422, 8.7344, 0.25);
RemoveBuildingForPlayer(playerid, 6466, 374.6953, -2054.8828, 8.7031, 0.25);
RemoveBuildingForPlayer(playerid, 1232, 374.7969, -2046.9375, 9.5000, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 378.4609, -2012.9297, 7.2109, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 378.4609, -2083.2656, 7.2109, 0.25);
RemoveBuildingForPlayer(playerid, 1215, 379.7422, -2086.8594, 7.3750, 0.25);
RemoveBuildingForPlayer(playerid, 1215, 381.0313, -2070.9375, 7.3750, 0.25);
RemoveBuildingForPlayer(playerid, 6283, 379.0625, -2065.0234, 11.7969, 0.25);
RemoveBuildingForPlayer(playerid, 1215, 379.5938, -2055.1016, 7.3750, 0.25);
RemoveBuildingForPlayer(playerid, 1215, 386.5703, -2061.9531, 7.3750, 0.25);
RemoveBuildingForPlayer(playerid, 1215, 379.5938, -2042.4922, 7.3750, 0.25);
RemoveBuildingForPlayer(playerid, 1215, 379.5938, -2030.3359, 7.3750, 0.25);
RemoveBuildingForPlayer(playerid, 1215, 379.5938, -2016.7500, 7.3750, 0.25);
RemoveBuildingForPlayer(playerid, 1215, 386.5703, -2049.3516, 7.3750, 0.25);
RemoveBuildingForPlayer(playerid, 1340, 388.8594, -2071.6641, 7.9453, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 390.2031, -2083.2656, 7.2109, 0.25);
RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2039.6406, 16.8438, 0.25);
RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2039.6563, 24.1094, 0.25);
RemoveBuildingForPlayer(playerid, 6298, 389.7734, -2028.4688, 19.8047, 0.25);
RemoveBuildingForPlayer(playerid, 6461, 389.7734, -2028.5000, 20.1094, 0.25);
RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2028.5000, 32.2266, 0.25);
RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2021.6406, 29.9297, 0.25);
RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2017.4531, 24.0313, 0.25);
RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2017.4297, 16.8516, 0.25);
RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2021.6328, 10.9844, 0.25);
RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2028.5156, 8.7813, 0.25);
RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2035.3984, 10.9453, 0.25);
RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2035.3828, 29.9531, 0.25);
RemoveBuildingForPlayer(playerid, 1215, 400.3906, -2086.4219, 7.3750, 0.25);
RemoveBuildingForPlayer(playerid, 1308, 400.7578, -2081.1875, 6.5938, 0.25);
RemoveBuildingForPlayer(playerid, 1308, 400.7578, -2050.4844, 6.5938, 0.25);

//SAM AG
RemoveBuildingForPlayer(playerid, 10938, -1909.5547, 497.2188, 25.7109, 0.25);
RemoveBuildingForPlayer(playerid, 11144, -1909.5547, 497.2188, 25.7109, 0.25);


//LS PARK
RemoveBuildingForPlayer(playerid, 4057, 1479.5547, -1693.1406, 19.5781, 0.25);
RemoveBuildingForPlayer(playerid, 4210, 1479.5625, -1631.4531, 12.0781, 0.25);
RemoveBuildingForPlayer(playerid, 713, 1457.9375, -1620.6953, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 713, 1496.8672, -1707.8203, 13.4063, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1451.6250, -1727.6719, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1467.9844, -1727.6719, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1485.1719, -1727.6719, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1468.9844, -1713.5078, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 1231, 1479.6953, -1716.7031, 15.6250, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1505.1797, -1727.6719, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1488.7656, -1713.7031, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 1289, 1504.7500, -1711.8828, 13.5938, 0.25);
RemoveBuildingForPlayer(playerid, 1258, 1445.0078, -1704.7656, 13.6953, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1433.7109, -1702.3594, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1433.7109, -1676.6875, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1258, 1445.0078, -1692.2344, 13.6953, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1433.7109, -1656.2500, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1433.7109, -1636.2344, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 712, 1445.8125, -1650.0234, 22.2578, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1433.7109, -1619.0547, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1283, 1443.2031, -1592.9453, 15.6250, 0.25);
RemoveBuildingForPlayer(playerid, 673, 1457.7266, -1710.0625, 12.3984, 0.25);
RemoveBuildingForPlayer(playerid, 620, 1461.6563, -1707.6875, 11.8359, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1468.9844, -1704.6406, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 700, 1463.0625, -1701.5703, 13.7266, 0.25);
RemoveBuildingForPlayer(playerid, 1231, 1479.6953, -1702.5313, 15.6250, 0.25);
RemoveBuildingForPlayer(playerid, 673, 1457.5547, -1697.2891, 12.3984, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1468.9844, -1694.0469, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 1231, 1479.3828, -1692.3906, 15.6328, 0.25);
RemoveBuildingForPlayer(playerid, 4186, 1479.5547, -1693.1406, 19.5781, 0.25);
RemoveBuildingForPlayer(playerid, 620, 1461.1250, -1687.5625, 11.8359, 0.25);
RemoveBuildingForPlayer(playerid, 700, 1463.0625, -1690.6484, 13.7266, 0.25);
RemoveBuildingForPlayer(playerid, 641, 1458.6172, -1684.1328, 11.1016, 0.25);
RemoveBuildingForPlayer(playerid, 625, 1457.2734, -1666.2969, 13.6953, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1468.9844, -1682.7188, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 712, 1471.4063, -1666.1797, 22.2578, 0.25);
RemoveBuildingForPlayer(playerid, 1231, 1479.3828, -1682.3125, 15.6328, 0.25);
RemoveBuildingForPlayer(playerid, 625, 1458.2578, -1659.2578, 13.6953, 0.25);
RemoveBuildingForPlayer(playerid, 712, 1449.8516, -1655.9375, 22.2578, 0.25);
RemoveBuildingForPlayer(playerid, 1231, 1477.9375, -1652.7266, 15.6328, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1479.6094, -1653.2500, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 625, 1457.3516, -1650.5703, 13.6953, 0.25);
RemoveBuildingForPlayer(playerid, 625, 1454.4219, -1642.4922, 13.6953, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1467.8516, -1646.5938, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1472.8984, -1651.5078, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1465.9375, -1639.8203, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 1231, 1466.4688, -1637.9609, 15.6328, 0.25);
RemoveBuildingForPlayer(playerid, 625, 1449.5938, -1635.0469, 13.6953, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1467.7109, -1632.8906, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 1232, 1465.8906, -1629.9766, 15.5313, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1472.6641, -1627.8828, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1479.4688, -1626.0234, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 3985, 1479.5625, -1631.4531, 12.0781, 0.25);
RemoveBuildingForPlayer(playerid, 4206, 1479.5547, -1639.6094, 13.6484, 0.25);
RemoveBuildingForPlayer(playerid, 1232, 1465.8359, -1608.3750, 15.3750, 0.25);
RemoveBuildingForPlayer(playerid, 1229, 1466.4844, -1598.0938, 14.1094, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1451.3359, -1596.7031, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1471.3516, -1596.7031, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1488.7656, -1704.5938, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 700, 1494.2109, -1694.4375, 13.7266, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1488.7656, -1693.7344, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 620, 1496.9766, -1686.8516, 11.8359, 0.25);
RemoveBuildingForPlayer(playerid, 641, 1494.1406, -1689.2344, 11.1016, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1488.7656, -1682.6719, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 712, 1480.6094, -1666.1797, 22.2578, 0.25);
RemoveBuildingForPlayer(playerid, 712, 1488.2266, -1666.1797, 22.2578, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1486.4063, -1651.3906, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1491.3672, -1646.3828, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1493.1328, -1639.4531, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1486.1797, -1627.7656, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 1280, 1491.2188, -1632.6797, 13.4531, 0.25);
RemoveBuildingForPlayer(playerid, 1232, 1494.4141, -1629.9766, 15.5313, 0.25);
RemoveBuildingForPlayer(playerid, 1232, 1494.3594, -1608.3750, 15.3750, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1488.5313, -1596.7031, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1229, 1498.0547, -1598.0938, 14.1094, 0.25);
RemoveBuildingForPlayer(playerid, 1288, 1504.7500, -1705.4063, 13.5938, 0.25);
RemoveBuildingForPlayer(playerid, 1287, 1504.7500, -1704.4688, 13.5938, 0.25);
RemoveBuildingForPlayer(playerid, 1286, 1504.7500, -1695.0547, 13.5938, 0.25);
RemoveBuildingForPlayer(playerid, 1285, 1504.7500, -1694.0391, 13.5938, 0.25);
RemoveBuildingForPlayer(playerid, 673, 1498.9609, -1684.6094, 12.3984, 0.25);
RemoveBuildingForPlayer(playerid, 625, 1504.1641, -1662.0156, 13.6953, 0.25);
RemoveBuildingForPlayer(playerid, 625, 1504.7188, -1670.9219, 13.6953, 0.25);
RemoveBuildingForPlayer(playerid, 620, 1503.1875, -1621.1250, 11.8359, 0.25);
RemoveBuildingForPlayer(playerid, 673, 1501.2813, -1624.5781, 12.3984, 0.25);
RemoveBuildingForPlayer(playerid, 673, 1498.3594, -1616.9688, 12.3984, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1504.8906, -1596.7031, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 712, 1508.4453, -1668.7422, 22.2578, 0.25);
RemoveBuildingForPlayer(playerid, 625, 1505.6953, -1654.8359, 13.6953, 0.25);
RemoveBuildingForPlayer(playerid, 625, 1508.5156, -1647.8594, 13.6953, 0.25);
RemoveBuildingForPlayer(playerid, 625, 1513.2734, -1642.4922, 13.6953, 0.25);
RemoveBuildingForPlayer(playerid, 1258, 1510.8906, -1607.3125, 13.6953, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1524.8281, -1721.6328, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1524.8281, -1705.2734, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1229, 1524.2188, -1693.9688, 14.1094, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1524.8281, -1688.0859, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1229, 1524.2188, -1673.7109, 14.1094, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1524.8281, -1668.0781, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1524.8281, -1647.6406, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1524.8281, -1621.9609, 16.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1226, 1525.3828, -1611.1563, 16.4219, 0.25);
//Scarfo Base
RemoveBuildingForPlayer(playerid, 3573, 1798.6484, -2057.9141, 14.9844, 0.25);
//LV KH
RemoveBuildingForPlayer(playerid, 8513, 1927.3906, 703.2266, 14.0781, 0.25);
RemoveBuildingForPlayer(playerid, 8820, 1927.3906, 703.2266, 14.0781, 0.25);
RemoveBuildingForPlayer(playerid, 1344, 1878.6484, 683.7734, 10.6250, 0.25);
RemoveBuildingForPlayer(playerid, 1344, 1881.3828, 683.7734, 10.6250, 0.25);
RemoveBuildingForPlayer(playerid, 625, 1879.0547, 698.9141, 10.7109, 0.25);
RemoveBuildingForPlayer(playerid, 625, 1879.0547, 710.3359, 10.7109, 0.25);
RemoveBuildingForPlayer(playerid, 1231, 1917.7109, 683.2656, 12.4609, 0.25);
RemoveBuildingForPlayer(playerid, 1343, 1885.4844, 683.7500, 10.5625, 0.25);
RemoveBuildingForPlayer(playerid, 628, 1905.0859, 703.2969, 11.8125, 0.25);
RemoveBuildingForPlayer(playerid, 627, 1908.9297, 703.1328, 11.9297, 0.25);
RemoveBuildingForPlayer(playerid, 8841, 1924.8203, 703.2188, 13.1484, 0.25);
RemoveBuildingForPlayer(playerid, 627, 1923.8438, 703.1328, 11.9297, 0.25);
RemoveBuildingForPlayer(playerid, 627, 1925.4609, 703.1328, 11.9297, 0.25);
RemoveBuildingForPlayer(playerid, 1231, 1937.2969, 683.2656, 12.4609, 0.25);
RemoveBuildingForPlayer(playerid, 627, 1938.6563, 703.1328, 11.9297, 0.25);
RemoveBuildingForPlayer(playerid, 627, 1940.2031, 703.1328, 11.9297, 0.25);
RemoveBuildingForPlayer(playerid, 1343, 1969.2109, 712.7344, 10.5625, 0.25);
RemoveBuildingForPlayer(playerid, 644, 1945.9766, 703.2031, 10.1250, 0.25);
RemoveBuildingForPlayer(playerid, 1344, 1975.6953, 712.7031, 10.6250, 0.25);
RemoveBuildingForPlayer(playerid, 632, 1896.0703, 717.8984, 10.2734, 0.25);
RemoveBuildingForPlayer(playerid, 1344, 1884.8359, 722.7031, 10.6250, 0.25);
RemoveBuildingForPlayer(playerid, 1344, 1882.1016, 722.7031, 10.6250, 0.25);
RemoveBuildingForPlayer(playerid, 1343, 1877.8828, 722.7344, 10.5625, 0.25);
RemoveBuildingForPlayer(playerid, 1231, 1937.3594, 723.0859, 12.4609, 0.25);
RemoveBuildingForPlayer(playerid, 1231, 1917.4219, 723.0859, 12.4609, 0.25);
RemoveBuildingForPlayer(playerid, 1257, 1885.1875, 767.1641, 11.0781, 0.25);
//LSPD Int
RemoveBuildingForPlayer(playerid, 2252, 301.0703, 180.3672, 1007.4531, 0.25);
RemoveBuildingForPlayer(playerid, 2208, 296.2500, 185.1172, 1006.1797, 0.25);
RemoveBuildingForPlayer(playerid, 14854, 296.6875, 184.5000, 1008.5938, 0.25);
RemoveBuildingForPlayer(playerid, 1806, 296.4922, 185.9141, 1006.1797, 0.25);
RemoveBuildingForPlayer(playerid, 1806, 298.4609, 185.9141, 1006.1797, 0.25);
RemoveBuildingForPlayer(playerid, 2252, 291.6563, 187.9844, 1007.4531, 0.25);
RemoveBuildingForPlayer(playerid, 2186, 300.2969, 188.7344, 1006.1797, 0.25);
RemoveBuildingForPlayer(playerid, 2252, 231.5781, 158.7891, 1003.3594, 0.25);
RemoveBuildingForPlayer(playerid, 2186, 228.8125, 162.3828, 1002.0391, 0.25);
RemoveBuildingForPlayer(playerid, 1806, 230.5234, 164.1641, 1002.0156, 0.25);
RemoveBuildingForPlayer(playerid, 14855, 231.4688, 163.8516, 1006.5234, 0.25);
RemoveBuildingForPlayer(playerid, 1806, 230.5234, 166.0000, 1002.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2208, 231.3984, 166.4609, 1002.0391, 0.25);
RemoveBuildingForPlayer(playerid, 2252, 233.9453, 168.5000, 1003.3594, 0.25);
RemoveBuildingForPlayer(playerid, 14886, 268.4375, 186.9297, 1006.8828, 0.25);
}

