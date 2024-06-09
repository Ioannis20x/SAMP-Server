// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>
#define FILTERSCRIPT
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
new g_Object[702];
g_Object[0] = CreateObject(967, 1007.3259, 2403.1208, 9.6253, 0.0000, 0.0000, -90.2994); //bar_gatebox01
g_Object[1] = CreateObject(966, 1007.8391, 2404.1379, 9.6757, 0.0000, 0.0000, -179.8000); //bar_gatebar01
SetObjectMaterial(g_Object[1], 0, 16640, "a51", "redmetal", 0xFFFFFFFF);
g_Object[2] = CreateObject(966, 1006.8178, 2404.1457, 9.6757, 0.0000, 0.0000, 0.0000); //bar_gatebar01
SetObjectMaterial(g_Object[2], 0, 16640, "a51", "redmetal", 0xFFFFFFFF);
g_Object[3] = CreateObject(987, 1013.3449, 2443.3535, 9.6503, 0.0000, 0.0000, 0.0000); //elecfence_BAR
SetObjectMaterial(g_Object[3], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[3], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[4] = CreateObject(967, 1007.3344, 2405.2126, 9.6253, 0.0000, 0.0000, 89.9999); //bar_gatebox01
g_Object[5] = CreateObject(10829, 999.2788, 2449.6237, 9.7756, 0.0000, 0.0000, -179.0997); //gatehouse1_SFSe
SetObjectMaterial(g_Object[5], 0, 7978, "vgssairport", "airportwindow02_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[5], 2, 16640, "a51", "concretewall22_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[5], 3, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[5], 4, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[6] = CreateObject(987, 989.9199, 2443.4421, 9.6503, 0.0000, 0.0000, 0.6998); //elecfence_BAR
SetObjectMaterial(g_Object[6], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[6], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[7] = CreateObject(19376, 921.9265, 2466.8410, 9.7721, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[7], 0, 6487, "councl_law2", "rodeo3sjm", 0xFFFFFFFF);
g_Object[8] = CreateObject(19376, 996.0272, 2467.8911, 9.7622, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[8], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[9] = CreateObject(18981, 1008.1431, 2455.7302, 9.3402, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[9], 0, 10765, "airportgnd_sfse", "ws_airpt_concrete", 0xFFFFFFFF);
g_Object[10] = CreateObject(19376, 995.7924, 2482.9199, 9.7622, 0.0000, -89.9999, 0.8998); //wall024
SetObjectMaterial(g_Object[10], 0, 3967, "cj_airprt", "Road_blank256HV", 0xFFFFFFFF);
g_Object[11] = CreateObject(19376, 995.8784, 2477.5073, 9.7721, 0.0000, -89.9999, 0.8998); //wall024
SetObjectMaterial(g_Object[11], 0, 3967, "cj_airprt", "Road_blank256HV", 0xFFFFFFFF);
g_Object[12] = CreateObject(987, 977.9210, 2443.2934, 9.6503, 0.0000, 0.0000, 0.6998); //elecfence_BAR
SetObjectMaterial(g_Object[12], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[12], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[13] = CreateObject(987, 1019.3325, 2443.2534, 9.6503, 0.0000, 0.0000, 0.0000); //elecfence_BAR
SetObjectMaterial(g_Object[13], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[13], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[14] = CreateObject(18981, 950.5302, 2455.3049, 9.3400, 0.0000, 90.0000, -179.4002); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[14], 0, 10765, "airportgnd_sfse", "ws_airpt_concrete", 0xFFFFFFFF);
g_Object[15] = CreateObject(19354, 1006.3994, 2494.8342, 8.1147, 0.0000, 0.0000, -178.6994); //wall002
SetObjectMaterial(g_Object[15], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[16] = CreateObject(987, 965.9721, 2443.1523, 9.6503, 0.0000, 0.0000, 0.6998); //elecfence_BAR
SetObjectMaterial(g_Object[16], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[16], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[17] = CreateObject(987, 942.0441, 2442.8623, 9.6503, 0.0000, 0.0000, 0.6998); //elecfence_BAR
SetObjectMaterial(g_Object[17], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[17], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[18] = CreateObject(19376, 932.4154, 2466.9870, 9.7721, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[18], 0, 6487, "councl_law2", "rodeo3sjm", 0xFFFFFFFF);
g_Object[19] = CreateObject(18981, 975.5285, 2455.5681, 9.3400, 0.0000, 90.0000, -179.4002); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[19], 0, 10765, "airportgnd_sfse", "ws_airpt_concrete", 0xFFFFFFFF);
g_Object[20] = CreateObject(18981, 985.0078, 2455.6669, 9.3500, 0.0000, 90.0000, -179.4002); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[20], 0, 10765, "airportgnd_sfse", "ws_airpt_concrete", 0xFFFFFFFF);
g_Object[21] = CreateObject(19453, 938.7592, 2476.5488, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[21], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[22] = CreateObject(19453, 941.7285, 2500.6376, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[22], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[23] = CreateObject(18981, 950.1265, 2493.8195, 9.3420, 0.0000, 90.0000, -179.4002); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[23], 0, 10765, "airportgnd_sfse", "ws_airpt_concrete", 0xFFFFFFFF);
g_Object[24] = CreateObject(18981, 950.3883, 2468.8288, 9.3420, 0.0000, 90.0000, -179.4002); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[24], 0, 10765, "airportgnd_sfse", "ws_airpt_concrete", 0xFFFFFFFF);
g_Object[25] = CreateObject(19376, 942.9041, 2467.1318, 9.7721, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[25], 0, 6487, "councl_law2", "rodeo3sjm", 0xFFFFFFFF);
g_Object[26] = CreateObject(19354, 984.3150, 2454.1203, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[26], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[27] = CreateObject(19987, 991.1074, 2462.7766, 9.7615, 0.0000, 0.0000, 82.5998); //SAMPRoadSign40
g_Object[28] = CreateObject(987, 916.7996, 2578.7297, 9.6603, 0.0000, 0.0000, -98.3999); //elecfence_BAR
SetObjectMaterial(g_Object[28], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[28], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[28], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[29] = CreateObject(19354, 992.3941, 2454.2221, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[29], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[30] = CreateObject(19354, 1013.0446, 2472.1323, 8.2517, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[30], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[31] = CreateObject(19354, 980.2354, 2454.0690, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[31], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[32] = CreateObject(19354, 984.0607, 2450.3361, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[32], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[33] = CreateObject(19354, 984.4379, 2444.0368, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[33], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[34] = CreateObject(19354, 987.6276, 2444.0759, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[34], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[35] = CreateObject(19354, 990.8372, 2444.1152, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[35], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[36] = CreateObject(19354, 992.5172, 2444.1330, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[36], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[37] = CreateObject(19354, 994.0078, 2445.8056, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[37], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[38] = CreateObject(19354, 993.9697, 2448.9365, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[38], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[39] = CreateObject(19354, 990.9779, 2445.8066, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[39], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[40] = CreateObject(19354, 990.9401, 2448.8979, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[40], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[41] = CreateObject(19354, 989.9879, 2445.7712, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[41], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[42] = CreateObject(19354, 981.8217, 2448.6447, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[42], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[43] = CreateObject(19354, 981.8579, 2445.6950, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[43], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[44] = CreateObject(19354, 989.9500, 2448.8825, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[44], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[45] = CreateObject(19354, 986.9478, 2445.7573, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[45], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[46] = CreateObject(19354, 986.9102, 2448.8444, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[46], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[47] = CreateObject(19354, 990.4603, 2450.4172, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[47], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[48] = CreateObject(19354, 992.4196, 2450.4426, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[48], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[49] = CreateObject(19354, 987.2600, 2450.3771, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[49], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[50] = CreateObject(19354, 988.3646, 2454.1726, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[50], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[51] = CreateObject(19354, 985.9381, 2445.7109, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[51], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[52] = CreateObject(19354, 985.9019, 2448.6816, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[52], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[53] = CreateObject(19354, 982.8720, 2448.6496, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[53], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[54] = CreateObject(19354, 982.9086, 2445.6594, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[54], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[55] = CreateObject(987, 958.3284, 2555.5258, 14.6400, 0.0000, 0.0000, 146.8999); //elecfence_BAR
SetObjectMaterial(g_Object[55], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[55], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[55], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[56] = CreateObject(19354, 978.7918, 2448.6232, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[56], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[57] = CreateObject(987, 927.1729, 2573.1081, 9.6503, 0.0000, 0.0000, 152.4001); //elecfence_BAR
SetObjectMaterial(g_Object[57], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[57], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[57], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[58] = CreateObject(19354, 980.8809, 2450.2971, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[58], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[59] = CreateObject(19354, 977.6710, 2450.2568, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[59], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[60] = CreateObject(19354, 974.4915, 2450.2163, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[60], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[61] = CreateObject(19354, 981.2780, 2443.9990, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[61], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[62] = CreateObject(19354, 978.0786, 2443.9599, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[62], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[63] = CreateObject(19354, 974.8989, 2443.9230, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[63], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[64] = CreateObject(19354, 971.6892, 2443.8818, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[64], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[65] = CreateObject(19453, 996.4591, 2462.1406, 8.1134, 0.0000, 0.0000, -89.3999); //wall093
SetObjectMaterial(g_Object[65], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[66] = CreateObject(987, 937.9425, 2484.5026, 9.6503, 0.0000, 0.0000, -88.8999); //elecfence_BAR
SetObjectMaterial(g_Object[66], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[66], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[67] = CreateObject(987, 913.3043, 2555.0581, 9.6603, 0.0000, 0.0000, -98.3999); //elecfence_BAR
SetObjectMaterial(g_Object[67], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[67], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[67], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[68] = CreateObject(19453, 986.8300, 2462.0388, 8.1134, 0.0000, 0.0000, -89.3999); //wall093
SetObjectMaterial(g_Object[68], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[69] = CreateObject(19453, 977.2003, 2461.9589, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[69], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[70] = CreateObject(19453, 967.5814, 2461.8247, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[70], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[71] = CreateObject(19453, 957.9522, 2461.6914, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[71], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[72] = CreateObject(19354, 978.8283, 2445.6315, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[72], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[73] = CreateObject(19354, 976.1759, 2454.0163, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[73], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[74] = CreateObject(19354, 972.1060, 2453.9631, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[74], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[75] = CreateObject(19354, 967.9265, 2453.9096, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[75], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[76] = CreateObject(19354, 971.3217, 2450.1777, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[76], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[77] = CreateObject(19354, 968.1126, 2450.1381, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[77], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[78] = CreateObject(19354, 968.4799, 2443.8435, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[78], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[79] = CreateObject(19354, 968.0593, 2443.8354, 8.1047, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[79], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[80] = CreateObject(19354, 977.7617, 2448.6303, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[80], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[81] = CreateObject(19354, 977.7988, 2445.5891, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[81], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[82] = CreateObject(19354, 974.7315, 2448.6115, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[82], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[83] = CreateObject(19354, 974.7686, 2445.5610, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[83], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[84] = CreateObject(19354, 973.6812, 2448.6164, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[84], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[85] = CreateObject(19354, 973.7182, 2445.5949, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[85], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[86] = CreateObject(19354, 970.6619, 2448.5446, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[86], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[87] = CreateObject(19354, 970.6989, 2445.5136, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[87], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[88] = CreateObject(19354, 969.5023, 2448.5083, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[88], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[89] = CreateObject(19354, 969.5385, 2445.5253, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[89], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[90] = CreateObject(19354, 966.4810, 2448.6059, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[90], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[91] = CreateObject(19354, 966.5191, 2445.4853, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[91], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[92] = CreateObject(19354, 965.1389, 2452.8818, 8.1047, 0.0000, 0.0000, -50.4000); //wall002
SetObjectMaterial(g_Object[92], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[93] = CreateObject(19354, 962.7042, 2450.8674, 8.1047, 0.0000, 0.0000, -50.4000); //wall002
SetObjectMaterial(g_Object[93], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[94] = CreateObject(19354, 960.2614, 2448.8469, 8.1047, 0.0000, 0.0000, -50.4000); //wall002
SetObjectMaterial(g_Object[94], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[95] = CreateObject(19354, 957.8806, 2446.8757, 8.1047, 0.0000, 0.0000, -50.4000); //wall002
SetObjectMaterial(g_Object[95], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[96] = CreateObject(18981, 1008.1431, 2480.6984, 9.3402, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[96], 0, 10765, "airportgnd_sfse", "ws_airpt_concrete", 0xFFFFFFFF);
g_Object[97] = CreateObject(19453, 947.7769, 2445.7553, 8.1034, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[97], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[98] = CreateObject(987, 973.2739, 2506.5559, 9.6503, 0.0000, 0.0000, -179.4002); //elecfence_BAR
SetObjectMaterial(g_Object[98], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[98], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[99] = CreateObject(987, 958.3284, 2555.5258, 9.6503, 0.0000, 0.0000, 146.8999); //elecfence_BAR
SetObjectMaterial(g_Object[99], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[99], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[99], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[100] = CreateObject(19453, 959.4268, 2445.9187, 8.1034, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[100], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[101] = CreateObject(19354, 950.9948, 2446.8159, 8.1047, 0.0000, 0.0000, -50.4000); //wall002
SetObjectMaterial(g_Object[101], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[102] = CreateObject(19354, 953.4456, 2448.8432, 8.1047, 0.0000, 0.0000, -50.4000); //wall002
SetObjectMaterial(g_Object[102], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[103] = CreateObject(19354, 955.9036, 2450.8784, 8.1047, 0.0000, 0.0000, -50.4000); //wall002
SetObjectMaterial(g_Object[103], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[104] = CreateObject(19354, 958.3618, 2452.9123, 8.1047, 0.0000, 0.0000, -50.4000); //wall002
SetObjectMaterial(g_Object[104], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[105] = CreateObject(19354, 960.8275, 2454.9528, 8.1047, 0.0000, 0.0000, -50.4000); //wall002
SetObjectMaterial(g_Object[105], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[106] = CreateObject(19453, 957.2034, 2455.8808, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[106], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[107] = CreateObject(19453, 947.6547, 2455.7492, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[107], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[108] = CreateObject(987, 968.3474, 2548.9936, 9.6503, 0.0000, 0.0000, 146.8999); //elecfence_BAR
SetObjectMaterial(g_Object[108], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[108], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[108], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[109] = CreateObject(14787, 939.1890, 2528.2775, 9.9188, 0.0000, 0.0000, 90.5998); //ab_sfGymBits02a
g_Object[110] = CreateObject(19354, 950.5922, 2454.1696, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[110], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[111] = CreateObject(19354, 950.6306, 2451.0109, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[111], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[112] = CreateObject(19354, 950.6649, 2448.2114, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[112], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[113] = CreateObject(19354, 951.5429, 2454.1372, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[113], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[114] = CreateObject(19354, 951.5817, 2450.9575, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[114], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[115] = CreateObject(19354, 951.6060, 2448.9660, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[115], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[116] = CreateObject(19354, 952.4733, 2454.1301, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[116], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[117] = CreateObject(19354, 952.5120, 2450.9602, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[117], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[118] = CreateObject(19354, 952.5274, 2449.6992, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[118], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[119] = CreateObject(19354, 942.9431, 2454.0178, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[119], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[120] = CreateObject(19354, 942.9821, 2450.8374, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[120], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[121] = CreateObject(19354, 943.0208, 2447.6567, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[121], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[122] = CreateObject(19354, 943.0250, 2447.3264, 8.1047, 0.0000, 0.0000, 0.6998); //wall002
SetObjectMaterial(g_Object[122], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[123] = CreateObject(18980, 1029.2551, 2511.2026, 7.1585, 0.0000, 0.0000, -31.1000); //Concrete1mx1mx25m
SetObjectMaterial(g_Object[123], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[124] = CreateObject(3998, 969.1646, 2476.1662, 16.1424, 0.0000, 0.0000, 90.1996); //court1_LAn
SetObjectMaterial(g_Object[124], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[124], 1, 10977, "mission_sfse", "ws_apartmentbrown2", 0xFFFFFFFF);
g_Object[125] = CreateObject(987, 949.3557, 2506.3024, 9.6503, 0.0000, 0.0000, -179.4002); //elecfence_BAR
SetObjectMaterial(g_Object[125], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[125], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[126] = CreateObject(987, 978.3582, 2542.4670, 9.6503, 0.0000, 0.0000, 146.8999); //elecfence_BAR
SetObjectMaterial(g_Object[126], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[126], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[126], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[127] = CreateObject(987, 988.3770, 2535.9328, 9.6503, 0.0000, 0.0000, 146.8999); //elecfence_BAR
SetObjectMaterial(g_Object[127], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[127], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[127], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[128] = CreateObject(987, 1031.0935, 2443.2644, 9.6503, 0.0000, 0.0000, 90.1996); //elecfence_BAR
SetObjectMaterial(g_Object[128], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[128], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[129] = CreateObject(987, 937.8767, 2472.4528, 9.6503, 0.0000, 0.0000, -179.0997); //elecfence_BAR
SetObjectMaterial(g_Object[129], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[129], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[130] = CreateObject(987, 948.3093, 2562.0571, 9.6503, 0.0000, 0.0000, 152.4001); //elecfence_BAR
SetObjectMaterial(g_Object[130], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[130], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[130], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[131] = CreateObject(987, 926.3358, 2461.4826, 9.6503, 0.0000, 0.0000, 0.6998); //elecfence_BAR
SetObjectMaterial(g_Object[131], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[131], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[132] = CreateObject(987, 914.3466, 2461.3395, 9.6503, 0.0000, 0.0000, 0.6998); //elecfence_BAR
SetObjectMaterial(g_Object[132], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[132], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[133] = CreateObject(987, 925.8883, 2472.2631, 9.6503, 0.0000, 0.0000, -179.0997); //elecfence_BAR
SetObjectMaterial(g_Object[133], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[133], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[134] = CreateObject(987, 1015.0109, 2519.9943, 9.6503, 0.0000, 0.0000, -114.9001); //elecfence_BAR
SetObjectMaterial(g_Object[134], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[134], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[135] = CreateObject(987, 938.3825, 2461.5664, 9.6503, 0.0000, 0.0000, -88.8999); //elecfence_BAR
SetObjectMaterial(g_Object[135], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[135], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[136] = CreateObject(987, 938.6749, 2442.8171, 9.6503, 0.0000, 0.0000, 0.6998); //elecfence_BAR
SetObjectMaterial(g_Object[136], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[136], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
SetObjectMaterial(g_Object[136], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[137] = CreateObject(3998, 910.6525, 2508.4223, 16.1424, 0.0000, 0.0000, -0.7997); //court1_LAn
SetObjectMaterial(g_Object[137], 0, 6205, "lawartg", "luxorwall01_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[137], 1, 10977, "mission_sfse", "ws_apartmentbrown2", 0xFFFFFFFF);
g_Object[138] = CreateObject(18980, 985.2318, 2506.7500, 2.1486, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx25m
SetObjectMaterial(g_Object[138], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[139] = CreateObject(987, 937.5305, 2506.2272, 9.6503, 0.0000, 0.0000, -88.8999); //elecfence_BAR
SetObjectMaterial(g_Object[139], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[139], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[140] = CreateObject(987, 937.7141, 2496.4782, 9.6503, 0.0000, 0.0000, -88.8999); //elecfence_BAR
SetObjectMaterial(g_Object[140], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[140], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[141] = CreateObject(987, 954.0230, 2443.0085, 9.6503, 0.0000, 0.0000, 0.6998); //elecfence_BAR
SetObjectMaterial(g_Object[141], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[141], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[142] = CreateObject(987, 1029.6457, 2499.3022, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[142], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[142], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[143] = CreateObject(18981, 1018.8131, 2455.7302, 9.3304, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[143], 0, 10765, "airportgnd_sfse", "ws_airpt_concrete", 0xFFFFFFFF);
g_Object[144] = CreateObject(987, 1030.9549, 2455.2126, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[144], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[144], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[145] = CreateObject(19453, 952.9227, 2461.6208, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[145], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[146] = CreateObject(19453, 948.1074, 2466.4018, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[146], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[147] = CreateObject(19453, 947.9406, 2475.9707, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[147], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[148] = CreateObject(19453, 947.7736, 2485.5292, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[148], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[149] = CreateObject(19453, 947.6597, 2492.0205, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[149], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[150] = CreateObject(19453, 938.4932, 2491.7487, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[150], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[151] = CreateObject(19453, 938.6613, 2482.1105, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[151], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[152] = CreateObject(18981, 1018.8131, 2471.7172, 9.3505, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[152], 0, 10765, "airportgnd_sfse", "ws_airpt_concrete", 0xFFFFFFFF);
g_Object[153] = CreateObject(19453, 924.7454, 2462.1489, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[153], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[154] = CreateObject(19453, 915.1267, 2462.0148, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[154], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[155] = CreateObject(19453, 1011.6309, 2457.5937, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[155], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[156] = CreateObject(19453, 934.3441, 2462.2797, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[156], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[157] = CreateObject(19453, 1011.7954, 2448.1142, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[157], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[158] = CreateObject(18980, 972.8922, 2506.7500, 2.1486, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx25m
SetObjectMaterial(g_Object[158], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[159] = CreateObject(19453, 1002.0947, 2448.0861, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[159], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[160] = CreateObject(19453, 939.2291, 2457.6164, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[160], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[161] = CreateObject(19453, 939.3560, 2450.3642, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[161], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[162] = CreateObject(19453, 961.6765, 2443.8215, 8.1034, 0.0000, 0.0000, -89.2994); //wall093
SetObjectMaterial(g_Object[162], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[163] = CreateObject(19453, 944.1981, 2443.6035, 8.1034, 0.0000, 0.0000, -89.2994); //wall093
SetObjectMaterial(g_Object[163], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[164] = CreateObject(987, 1030.6838, 2464.2175, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[164], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[164], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[165] = CreateObject(987, 1030.3542, 2475.4333, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[165], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[165], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[166] = CreateObject(987, 998.6417, 2529.8205, 9.6503, 0.0000, 0.0000, 149.3000); //elecfence_BAR
SetObjectMaterial(g_Object[166], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[166], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[166], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[167] = CreateObject(987, 1030.0002, 2487.3671, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[167], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[167], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[168] = CreateObject(987, 1008.8889, 2523.6152, 9.6503, 0.0000, 0.0000, 148.8000); //elecfence_BAR
SetObjectMaterial(g_Object[168], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[168], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[168], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[169] = CreateObject(987, 1013.9033, 2517.6103, 9.6503, 0.0000, 0.0000, -114.9001); //elecfence_BAR
SetObjectMaterial(g_Object[169], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[169], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[169], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[170] = CreateObject(987, 1019.1447, 2517.4040, 9.6503, 0.0000, 0.0000, 148.8000); //elecfence_BAR
SetObjectMaterial(g_Object[170], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[170], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[170], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[171] = CreateObject(987, 996.7924, 2506.8039, 9.6503, 0.0000, 0.0000, -179.4002); //elecfence_BAR
SetObjectMaterial(g_Object[171], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[171], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[172] = CreateObject(18980, 1008.7315, 2507.1503, 2.1486, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx25m
SetObjectMaterial(g_Object[172], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[173] = CreateObject(3279, 1021.4270, 2509.3349, 9.6365, 0.0000, 0.0000, -25.3999); //a51_spottower
SetObjectMaterial(g_Object[173], 0, 16640, "a51", "redmetal", 0xFFFFFFFF);
SetObjectMaterial(g_Object[173], 1, 6404, "beafron1_law2", "compfence7_LAe", 0xFFFFFFFF);
SetObjectMaterial(g_Object[173], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[174] = CreateObject(987, 911.5551, 2543.2138, 9.6603, 0.0000, 0.0000, -98.3999); //elecfence_BAR
SetObjectMaterial(g_Object[174], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[174], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[174], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[175] = CreateObject(987, 909.8092, 2531.3935, 9.6603, 0.0000, 0.0000, -98.3999); //elecfence_BAR
SetObjectMaterial(g_Object[175], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[175], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[175], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[176] = CreateObject(987, 961.3148, 2506.4291, 9.6503, 0.0000, 0.0000, -179.4002); //elecfence_BAR
SetObjectMaterial(g_Object[176], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[176], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[177] = CreateObject(987, 911.5551, 2543.2138, 14.6099, 0.0000, 0.0000, -98.3999); //elecfence_BAR
SetObjectMaterial(g_Object[177], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[177], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[177], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[178] = CreateObject(19453, 1002.0670, 2449.6572, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[178], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[179] = CreateObject(987, 909.8037, 2531.3554, 14.6099, 0.0000, 0.0000, -98.3999); //elecfence_BAR
SetObjectMaterial(g_Object[179], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[179], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[180] = CreateObject(19376, 985.1654, 2492.3781, 9.7622, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[180], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[181] = CreateObject(19376, 963.6472, 2492.0776, 9.7622, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[181], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[182] = CreateObject(19376, 953.1494, 2491.9357, 9.7622, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[182], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[183] = CreateObject(18981, 1008.1431, 2494.4299, 9.3420, 0.0000, 90.0000, -179.4002); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[183], 0, 10765, "airportgnd_sfse", "ws_airpt_concrete", 0xFFFFFFFF);
g_Object[184] = CreateObject(19453, 951.8775, 2445.8132, 8.1034, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[184], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[185] = CreateObject(18981, 983.1646, 2494.1652, 9.3402, 0.0000, 90.0000, -179.4002); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[185], 0, 10765, "airportgnd_sfse", "ws_airpt_concrete", 0xFFFFFFFF);
g_Object[186] = CreateObject(18981, 958.1765, 2493.9020, 9.3402, 0.0000, 90.0000, -179.4002); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[186], 0, 10765, "airportgnd_sfse", "ws_airpt_concrete", 0xFFFFFFFF);
g_Object[187] = CreateObject(19453, 927.9011, 2471.6730, 8.1134, 0.0000, 0.0000, -89.2994); //wall093
SetObjectMaterial(g_Object[187], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[188] = CreateObject(19453, 918.3740, 2471.6567, 8.1134, 0.0000, 0.0000, -90.3992); //wall093
SetObjectMaterial(g_Object[188], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[189] = CreateObject(19376, 953.2824, 2482.3105, 9.7819, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[189], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[190] = CreateObject(19376, 953.4171, 2472.6831, 9.7819, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[190], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[191] = CreateObject(19376, 953.7838, 2482.3159, 9.7622, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[191], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[192] = CreateObject(19376, 964.8723, 2467.3801, 9.7523, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[192], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[193] = CreateObject(19376, 975.3311, 2467.5239, 9.7523, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[193], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[194] = CreateObject(987, 913.3051, 2555.0659, 14.6099, 0.0000, 0.0000, -98.3999); //elecfence_BAR
SetObjectMaterial(g_Object[194], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[194], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[194], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[195] = CreateObject(19376, 955.0537, 2467.2456, 9.7523, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[195], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[196] = CreateObject(19376, 953.9177, 2472.7175, 9.7622, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[196], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[197] = CreateObject(19376, 953.9932, 2467.3156, 9.7423, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[197], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[198] = CreateObject(1616, 991.2525, 2485.4594, 24.0902, 0.0000, 0.0000, -12.0999); //nt_securecam1_01
g_Object[199] = CreateObject(19376, 974.1350, 2492.2910, 9.7721, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[199], 0, 3967, "cj_airprt", "Road_blank256HV", 0xFFFFFFFF);
g_Object[200] = CreateObject(19376, 974.2697, 2482.6728, 9.7721, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[200], 0, 3967, "cj_airprt", "Road_blank256HV", 0xFFFFFFFF);
g_Object[201] = CreateObject(987, 927.1729, 2573.1081, 14.6302, 0.0000, 0.0000, 152.4001); //elecfence_BAR
SetObjectMaterial(g_Object[201], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[201], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[201], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[202] = CreateObject(18980, 916.8919, 2578.2121, 7.1286, 0.0000, 0.0000, -21.1998); //Concrete1mx1mx25m
SetObjectMaterial(g_Object[202], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[203] = CreateObject(19376, 953.5029, 2466.5407, 9.7840, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[203], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[204] = CreateObject(19376, 963.9915, 2466.6867, 9.7839, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[204], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[205] = CreateObject(19354, 964.2335, 2447.5031, 8.1047, 0.0000, 0.0000, 178.2001); //wall002
SetObjectMaterial(g_Object[205], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[206] = CreateObject(19354, 964.3314, 2450.6347, 8.1047, 0.0000, 0.0000, 178.2001); //wall002
SetObjectMaterial(g_Object[206], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[207] = CreateObject(19453, 939.3900, 2448.4125, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[207], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[208] = CreateObject(19376, 974.4702, 2466.8310, 9.7839, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[208], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[209] = CreateObject(987, 915.0560, 2566.9240, 14.6099, 0.0000, 0.0000, -98.3999); //elecfence_BAR
SetObjectMaterial(g_Object[209], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[209], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[209], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[210] = CreateObject(987, 916.8004, 2578.7355, 14.6099, 0.0000, 0.0000, -98.3999); //elecfence_BAR
SetObjectMaterial(g_Object[210], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[210], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[210], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[211] = CreateObject(987, 915.0540, 2566.9091, 9.6603, 0.0000, 0.0000, -98.3999); //elecfence_BAR
SetObjectMaterial(g_Object[211], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[211], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[211], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[212] = CreateObject(987, 937.7987, 2567.5502, 14.6302, 0.0000, 0.0000, 152.4001); //elecfence_BAR
SetObjectMaterial(g_Object[212], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[212], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[212], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[213] = CreateObject(987, 948.4334, 2561.9914, 14.6302, 0.0000, 0.0000, 152.4001); //elecfence_BAR
SetObjectMaterial(g_Object[213], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[213], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[213], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[214] = CreateObject(987, 937.7188, 2567.5942, 9.6503, 0.0000, 0.0000, 152.4001); //elecfence_BAR
SetObjectMaterial(g_Object[214], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[214], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[214], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[215] = CreateObject(19376, 995.4483, 2467.1245, 9.7734, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[215], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[216] = CreateObject(987, 968.3645, 2548.9824, 14.6400, 0.0000, 0.0000, 146.8999); //elecfence_BAR
SetObjectMaterial(g_Object[216], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[216], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[216], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[217] = CreateObject(19912, 973.3272, 2506.3039, 11.8617, 0.0000, 0.0000, 180.0000); //SAMPMetalGate1
SetObjectMaterial(g_Object[217], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[217], 1, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[217], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[218] = CreateObject(3279, 1024.7834, 2452.7070, 9.6365, 0.0000, 0.0000, -178.8000); //a51_spottower
SetObjectMaterial(g_Object[218], 0, 16640, "a51", "redmetal", 0xFFFFFFFF);
SetObjectMaterial(g_Object[218], 1, 6404, "beafron1_law2", "compfence7_LAe", 0xFFFFFFFF);
SetObjectMaterial(g_Object[218], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[219] = CreateObject(987, 978.4174, 2542.4289, 14.6400, 0.0000, 0.0000, 146.8999); //elecfence_BAR
SetObjectMaterial(g_Object[219], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[219], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[219], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[220] = CreateObject(987, 988.4531, 2535.8854, 14.6400, 0.0000, 0.0000, 146.8999); //elecfence_BAR
SetObjectMaterial(g_Object[220], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[220], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[220], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[221] = CreateObject(987, 998.6417, 2529.8205, 14.6302, 0.0000, 0.0000, 149.3000); //elecfence_BAR
SetObjectMaterial(g_Object[221], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[221], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[221], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[222] = CreateObject(3279, 951.9249, 2493.2312, 9.6365, 0.0000, 0.0000, 92.5000); //a51_spottower
SetObjectMaterial(g_Object[222], 0, 16640, "a51", "redmetal", 0xFFFFFFFF);
SetObjectMaterial(g_Object[222], 1, 6404, "beafron1_law2", "compfence7_LAe", 0xFFFFFFFF);
SetObjectMaterial(g_Object[222], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[223] = CreateObject(3279, 945.6967, 2449.9831, 9.6365, 0.0000, 0.0000, 90.9000); //a51_spottower
SetObjectMaterial(g_Object[223], 0, 16640, "a51", "redmetal", 0xFFFFFFFF);
SetObjectMaterial(g_Object[223], 1, 6404, "beafron1_law2", "compfence7_LAe", 0xFFFFFFFF);
SetObjectMaterial(g_Object[223], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[224] = CreateObject(987, 1008.8889, 2523.6152, 14.6400, 0.0000, 0.0000, 148.8000); //elecfence_BAR
SetObjectMaterial(g_Object[224], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[224], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[224], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[225] = CreateObject(987, 1019.1447, 2517.4040, 14.6503, 0.0000, 0.0000, 148.8000); //elecfence_BAR
SetObjectMaterial(g_Object[225], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[225], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[225], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[226] = CreateObject(19273, 969.2965, 2482.1188, 11.9287, 0.0000, 0.0000, 90.0000); //KeypadNonDynamic
SetObjectMaterial(g_Object[226], 0, 1977, "cooler1", "kb_vend1", 0xFFFFFFFF);
g_Object[227] = CreateObject(987, 1029.3581, 2511.2175, 14.6503, 0.0000, 0.0000, 148.8000); //elecfence_BAR
SetObjectMaterial(g_Object[227], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[227], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[227], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[228] = CreateObject(987, 1008.7415, 2506.9301, 9.6503, 0.0000, 0.0000, -179.4002); //elecfence_BAR
SetObjectMaterial(g_Object[228], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[228], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[229] = CreateObject(18980, 1014.6826, 2519.6647, 2.1486, 0.0000, 0.0000, -28.8999); //Concrete1mx1mx25m
SetObjectMaterial(g_Object[229], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[230] = CreateObject(18980, 909.4613, 2528.5881, 7.1286, 0.0000, 0.0000, -8.2999); //Concrete1mx1mx25m
SetObjectMaterial(g_Object[230], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[231] = CreateObject(18980, 937.4511, 2506.2294, 2.1486, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx25m
SetObjectMaterial(g_Object[231], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[232] = CreateObject(18980, 937.6013, 2473.0078, 2.1486, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx25m
SetObjectMaterial(g_Object[232], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[233] = CreateObject(18980, 922.5797, 2472.7175, 2.1486, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx25m
SetObjectMaterial(g_Object[233], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[234] = CreateObject(19376, 996.0385, 2467.1342, 9.7634, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[234], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[235] = CreateObject(19453, 943.3607, 2462.3952, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[235], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[236] = CreateObject(19376, 984.1594, 2491.9802, 9.7529, 0.0000, -89.8999, 90.7994); //wall024
SetObjectMaterial(g_Object[236], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[237] = CreateObject(19453, 943.2288, 2471.8750, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[237], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[238] = CreateObject(19376, 984.3422, 2482.4582, 9.7795, 0.0000, -89.8999, 90.7994); //wall024
SetObjectMaterial(g_Object[238], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[239] = CreateObject(19376, 985.7324, 2482.4826, 9.7693, 0.0000, -89.8999, 90.8992); //wall024
SetObjectMaterial(g_Object[239], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[240] = CreateObject(19453, 942.1489, 2476.5700, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[240], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[241] = CreateObject(19453, 941.9821, 2486.1284, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[241], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[242] = CreateObject(19453, 941.8162, 2495.6362, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[242], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[243] = CreateObject(19453, 941.7811, 2497.6369, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[243], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[244] = CreateObject(19453, 938.3355, 2500.7385, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[244], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[245] = CreateObject(19453, 943.1486, 2505.5375, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[245], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[246] = CreateObject(19453, 952.7478, 2505.6611, 8.1134, 0.0000, 0.0000, -89.3992); //wall093
SetObjectMaterial(g_Object[246], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[247] = CreateObject(19453, 962.3272, 2505.7629, 8.1134, 0.0000, 0.0000, -89.3992); //wall093
SetObjectMaterial(g_Object[247], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[248] = CreateObject(19453, 968.5473, 2505.8322, 8.1134, 0.0000, 0.0000, -89.3992); //wall093
SetObjectMaterial(g_Object[248], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[249] = CreateObject(19453, 989.5360, 2506.0500, 8.1134, 0.0000, 0.0000, -89.3992); //wall093
SetObjectMaterial(g_Object[249], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[250] = CreateObject(19453, 999.1254, 2506.1520, 8.1134, 0.0000, 0.0000, -89.3992); //wall093
SetObjectMaterial(g_Object[250], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[251] = CreateObject(19453, 1006.0551, 2506.2258, 8.1134, 0.0000, 0.0000, -89.3992); //wall093
SetObjectMaterial(g_Object[251], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[252] = CreateObject(18981, 1018.6923, 2494.5368, 9.3520, 0.0000, 90.0000, -179.4002); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[252], 0, 10765, "airportgnd_sfse", "ws_airpt_concrete", 0xFFFFFFFF);
g_Object[253] = CreateObject(16061, 1033.0190, 2471.7871, 9.4398, 0.0000, 0.0000, 0.0000); //des_treeline2
g_Object[254] = CreateObject(19966, 1002.0308, 2403.4714, 10.9617, 0.0000, 0.0000, 176.1999); //SAMPRoadSign19
SetObjectMaterial(g_Object[254], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[254], 2, 66, "cj_barr_set_1", "Stop2_64", 0xFFFFFFFF);
g_Object[255] = CreateObject(19354, 979.0211, 2505.9458, 8.1246, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[255], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[256] = CreateObject(19354, 975.4514, 2505.9118, 8.1246, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[256], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[257] = CreateObject(19354, 982.6610, 2505.9943, 8.1246, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[257], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[258] = CreateObject(19453, 1011.4635, 2467.2016, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[258], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[259] = CreateObject(19453, 1011.3645, 2472.8605, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[259], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[260] = CreateObject(19453, 1011.0733, 2489.5717, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[260], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[261] = CreateObject(19453, 1010.9290, 2497.8190, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[261], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[262] = CreateObject(19453, 1010.8668, 2501.3776, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[262], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[263] = CreateObject(19453, 1001.6469, 2466.9174, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[263], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[264] = CreateObject(19453, 996.8493, 2462.1430, 8.1134, 0.0000, 0.0000, -89.3999); //wall093
SetObjectMaterial(g_Object[264], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[265] = CreateObject(19453, 1001.4801, 2476.5058, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[265], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[266] = CreateObject(19453, 1001.3162, 2485.9033, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[266], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[267] = CreateObject(19453, 1001.1931, 2492.9328, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[267], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[268] = CreateObject(19453, 996.3048, 2497.5947, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[268], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[269] = CreateObject(19453, 986.7263, 2497.4633, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[269], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[270] = CreateObject(19453, 977.1071, 2497.3303, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[270], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[271] = CreateObject(19453, 967.5783, 2497.1967, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[271], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[272] = CreateObject(19453, 958.0192, 2497.0637, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[272], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[273] = CreateObject(19453, 952.2996, 2496.9816, 8.1134, 0.0000, 0.0000, -89.1996); //wall093
SetObjectMaterial(g_Object[273], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[274] = CreateObject(19453, 937.5103, 2471.7939, 8.1134, 0.0000, 0.0000, -89.2994); //wall093
SetObjectMaterial(g_Object[274], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[275] = CreateObject(19967, 938.6145, 2462.0893, 9.7278, 0.0000, 0.0000, 100.2994); //SAMPRoadSign20
g_Object[276] = CreateObject(19966, 1013.6774, 2443.1313, 9.6442, 0.0000, 0.0000, 0.0000); //SAMPRoadSign19
g_Object[277] = CreateObject(19966, 1001.4274, 2465.1481, 9.7018, 0.0000, 0.0000, 176.1999); //SAMPRoadSign19
g_Object[278] = CreateObject(19985, 1011.6444, 2467.3723, 9.7614, 0.0000, 0.0000, -17.5000); //SAMPRoadSign38
g_Object[279] = CreateObject(19354, 998.5529, 2501.7905, 8.1147, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[279], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[280] = CreateObject(3998, 910.1419, 2471.8581, 15.5621, 0.0000, 0.0000, -0.7997); //court1_LAn
SetObjectMaterial(g_Object[280], 0, 6205, "lawartg", "luxorwall01_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[280], 1, 10977, "mission_sfse", "ws_apartmentbrown2", 0xFFFFFFFF);
g_Object[281] = CreateObject(19354, 949.1878, 2501.1384, 8.1147, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[281], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[282] = CreateObject(19354, 989.0136, 2501.6657, 8.1147, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[282], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[283] = CreateObject(19354, 979.7446, 2501.5419, 8.1147, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[283], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[284] = CreateObject(19376, 995.6441, 2492.5224, 9.7622, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[284], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[285] = CreateObject(19376, 1025.2176, 2464.1257, 9.7811, 0.0000, -89.9999, 0.8998); //wall024
SetObjectMaterial(g_Object[285], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[286] = CreateObject(19376, 1017.0692, 2463.9973, 9.7712, 0.0000, -89.9999, 0.8998); //wall024
SetObjectMaterial(g_Object[286], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
g_Object[287] = CreateObject(19354, 970.6655, 2501.4235, 8.1147, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[287], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[288] = CreateObject(19354, 960.5565, 2501.2893, 8.1147, 0.0000, 0.0000, -89.2994); //wall002
SetObjectMaterial(g_Object[288], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[289] = CreateObject(19354, 1006.5753, 2487.0773, 8.1147, 0.0000, 0.0000, -178.6994); //wall002
SetObjectMaterial(g_Object[289], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[290] = CreateObject(19354, 1006.8071, 2476.8376, 8.1147, 0.0000, 0.0000, -178.6994); //wall002
SetObjectMaterial(g_Object[290], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[291] = CreateObject(19354, 1007.0297, 2467.0290, 8.1147, 0.0000, 0.0000, -178.6994); //wall002
SetObjectMaterial(g_Object[291], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[292] = CreateObject(807, 899.7326, 2558.9047, 15.9574, 22.8999, 21.2000, 0.0000); //p_rubble
g_Object[293] = CreateObject(19354, 1013.0728, 2474.8833, 8.2517, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[293], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[294] = CreateObject(19354, 1013.0078, 2477.3757, 8.2510, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[294], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[295] = CreateObject(19354, 1027.7729, 2478.1689, 8.2770, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[295], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[296] = CreateObject(19354, 1013.1220, 2469.1496, 8.2517, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[296], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[297] = CreateObject(19354, 1029.3680, 2481.6765, 8.2798, -89.8999, -93.5000, -90.8992); //wall002
SetObjectMaterial(g_Object[297], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[298] = CreateObject(19354, 1029.5261, 2478.1853, 8.2803, -89.8999, -93.5000, -90.8992); //wall002
SetObjectMaterial(g_Object[298], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[299] = CreateObject(19354, 1029.6844, 2474.6982, 8.2805, -89.8999, -93.5000, -90.8992); //wall002
SetObjectMaterial(g_Object[299], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[300] = CreateObject(19354, 1027.8354, 2475.2658, 8.2874, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[300], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[301] = CreateObject(19354, 1027.9504, 2472.4472, 8.2875, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[301], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[302] = CreateObject(19354, 1028.1345, 2469.5180, 8.2881, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[302], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[303] = CreateObject(19354, 1012.8939, 2485.1616, 8.2509, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[303], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[304] = CreateObject(19354, 1013.9207, 2487.8117, 8.2622, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[304], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[305] = CreateObject(19354, 1013.8405, 2490.8947, 8.2622, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[305], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[306] = CreateObject(19354, 1012.8154, 2487.7834, 8.2508, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[306], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[307] = CreateObject(19354, 1012.7349, 2490.8662, 8.2503, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[307], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[308] = CreateObject(19354, 1013.7484, 2494.4179, 8.2621, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[308], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[309] = CreateObject(19354, 1013.6724, 2497.3107, 8.2615, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[309], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[310] = CreateObject(19354, 1017.1530, 2497.4057, 8.2679, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[310], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[311] = CreateObject(19354, 1012.6668, 2497.2832, 8.2503, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[311], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[312] = CreateObject(19354, 1012.7426, 2494.3908, 8.2503, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[312], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[313] = CreateObject(19354, 1026.9477, 2494.7619, 8.2753, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[313], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[314] = CreateObject(19354, 1026.9831, 2497.6562, 8.2749, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[314], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[315] = CreateObject(19354, 1028.7412, 2495.5927, 8.2784, -89.8999, -93.5000, -90.8992); //wall002
SetObjectMaterial(g_Object[315], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[316] = CreateObject(19354, 1028.7280, 2495.8630, 8.2784, -89.8999, -93.5000, -90.8992); //wall002
SetObjectMaterial(g_Object[316], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[317] = CreateObject(19354, 1027.1074, 2491.2109, 8.2756, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[317], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[318] = CreateObject(19354, 1027.2845, 2487.4511, 8.2761, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[318], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[319] = CreateObject(19354, 1027.4377, 2483.8625, 8.2763, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[319], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[320] = CreateObject(19354, 1027.5571, 2480.8322, 8.2768, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[320], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[321] = CreateObject(19354, 1029.8425, 2471.2219, 8.2810, -89.8999, -93.5000, -90.8992); //wall002
SetObjectMaterial(g_Object[321], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[322] = CreateObject(19354, 1029.2119, 2485.1591, 8.2796, -89.8999, -93.5000, -90.8992); //wall002
SetObjectMaterial(g_Object[322], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[323] = CreateObject(19354, 1029.0544, 2488.6499, 8.2791, -89.8999, -93.5000, -90.8992); //wall002
SetObjectMaterial(g_Object[323], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[324] = CreateObject(19354, 1028.8988, 2492.1118, 8.2788, -89.8999, -93.5000, -90.8992); //wall002
SetObjectMaterial(g_Object[324], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[325] = CreateObject(19354, 1024.6440, 2469.4291, 8.2819, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[325], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[326] = CreateObject(19354, 1021.1851, 2469.3395, 8.2756, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[326], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[327] = CreateObject(19354, 1017.7363, 2469.2519, 8.2699, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[327], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[328] = CreateObject(19354, 1014.4072, 2469.1682, 8.2641, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[328], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[329] = CreateObject(19354, 1014.3292, 2472.1604, 8.2636, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[329], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[330] = CreateObject(19354, 1020.6425, 2497.4936, 8.2740, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[330], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[331] = CreateObject(19354, 1024.1213, 2497.5837, 8.2798, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[331], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[332] = CreateObject(19354, 1024.3105, 2491.1425, 8.2805, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[332], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[333] = CreateObject(19354, 1024.2185, 2494.6821, 8.2803, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[333], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[334] = CreateObject(19354, 1024.4062, 2487.3789, 8.2809, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[334], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[335] = CreateObject(19354, 1024.4980, 2483.7854, 8.2812, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[335], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[336] = CreateObject(19354, 1024.5754, 2480.7524, 8.2812, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[336], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[337] = CreateObject(19354, 1024.6416, 2478.0888, 8.2817, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[337], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[338] = CreateObject(19354, 1024.7141, 2475.1860, 8.2819, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[338], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[339] = CreateObject(19354, 1024.7884, 2472.3654, 8.2819, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[339], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[340] = CreateObject(870, 998.4625, 2494.8852, 10.0845, 0.0000, 0.0000, 0.0000); //veg_Pflowers2wee
g_Object[341] = CreateObject(14468, 955.3035, 2491.3164, 10.3451, 0.0000, 0.2998, -90.2994); //flower-bush09a
g_Object[342] = CreateObject(870, 999.0225, 2491.0932, 10.0845, 0.0000, 0.0000, 0.0000); //veg_Pflowers2wee
g_Object[343] = CreateObject(1256, 987.5211, 2491.9814, 10.4926, 0.0000, 0.0000, 0.8999); //Stonebench1
g_Object[344] = CreateObject(672, 992.5852, 2492.9628, 10.6054, 0.0000, 0.0000, 0.0000); //sm_veg_tree5
g_Object[345] = CreateObject(870, 992.6511, 2489.6218, 10.0845, 0.0000, 0.0000, 0.0000); //veg_Pflowers2wee
g_Object[346] = CreateObject(19354, 1014.2573, 2474.9125, 8.2636, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[346], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[347] = CreateObject(19354, 1014.1879, 2477.4050, 8.2531, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[347], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[348] = CreateObject(870, 995.8914, 2489.6218, 10.0845, 0.0000, 0.0000, 0.0000); //veg_Pflowers2wee
g_Object[349] = CreateObject(870, 995.0609, 2492.6518, 10.0745, 0.0000, 0.0000, 0.0000); //veg_Pflowers2wee
g_Object[350] = CreateObject(870, 989.7802, 2490.5727, 10.0845, 0.0000, 0.0000, 0.0000); //veg_Pflowers2wee
g_Object[351] = CreateObject(638, 1015.9843, 2468.2919, 10.1155, 0.0000, 0.0000, 90.3999); //kb_planter+bush
g_Object[352] = CreateObject(870, 988.5100, 2493.4140, 10.0845, 0.0000, 0.0000, 0.0000); //veg_Pflowers2wee
g_Object[353] = CreateObject(870, 990.9105, 2495.3544, 10.0845, 0.0000, 0.0000, 0.0000); //veg_Pflowers2wee
g_Object[354] = CreateObject(870, 994.0407, 2495.3544, 10.0845, 0.0000, 0.0000, 0.0000); //veg_Pflowers2wee
g_Object[355] = CreateObject(638, 1000.0955, 2472.2883, 10.1406, 0.0000, 0.0000, 90.7994); //kb_planter+bush
g_Object[356] = CreateObject(869, 988.6798, 2483.9941, 10.2770, 0.0000, 0.0000, 0.0000); //veg_Pflowerswee
g_Object[357] = CreateObject(1256, 989.6754, 2488.7114, 10.4926, 0.0000, 0.0000, 91.6996); //Stonebench1
g_Object[358] = CreateObject(19273, 916.4721, 2508.1757, 11.8406, 0.0000, 0.0000, 0.0000); //KeypadNonDynamic
SetObjectMaterial(g_Object[358], 0, 1977, "cooler1", "kb_vend1", 0xFFFFFFFF);
g_Object[359] = CreateObject(869, 982.2374, 2490.7268, 10.2770, 0.0000, 0.0000, 0.0000); //veg_Pflowerswee
g_Object[360] = CreateObject(638, 997.5753, 2472.2507, 10.1406, 0.0000, 0.0000, 90.7994); //kb_planter+bush
g_Object[361] = CreateObject(869, 981.6074, 2483.9941, 10.2770, 0.0000, 0.0000, 0.0000); //veg_Pflowerswee
g_Object[362] = CreateObject(638, 995.0354, 2472.2131, 10.1406, 0.0000, 0.0000, 90.7994); //kb_planter+bush
g_Object[363] = CreateObject(1256, 984.4016, 2491.9343, 10.4926, 0.0000, 0.0000, -178.8999); //Stonebench1
g_Object[364] = CreateObject(638, 1000.8217, 2467.9389, 10.1159, 0.0000, 0.0000, 0.0000); //kb_planter+bush
g_Object[365] = CreateObject(869, 986.3189, 2483.9941, 10.2770, 0.0000, 0.0000, 0.0000); //veg_Pflowerswee
g_Object[366] = CreateObject(638, 1000.8217, 2470.5012, 10.1159, 0.0000, 0.0000, 0.0000); //kb_planter+bush
g_Object[367] = CreateObject(672, 982.2149, 2495.0148, 10.6054, 0.0000, 0.0000, 0.0000); //sm_veg_tree5
g_Object[368] = CreateObject(19786, 995.7611, 2469.9479, 11.8359, 0.0000, 0.0000, 53.7000); //LCDTVBig1
SetObjectMaterial(g_Object[368], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterialText(g_Object[368], "Department", 1, 90, "Arial", 50, 1, 0xFF000000, 0x0, 0);
g_Object[369] = CreateObject(638, 1000.8217, 2465.3869, 10.1159, 0.0000, 0.0000, 0.0000); //kb_planter+bush
g_Object[370] = CreateObject(638, 1000.8217, 2464.2648, 10.1159, 0.0000, 0.0000, 0.0000); //kb_planter+bush
g_Object[371] = CreateObject(638, 999.2852, 2463.5329, 10.1259, 0.0000, 0.0000, 90.9000); //kb_planter+bush
g_Object[372] = CreateObject(1256, 982.6416, 2488.3920, 10.4926, 0.0000, 0.0000, 91.6996); //Stonebench1
g_Object[373] = CreateObject(14468, 954.4779, 2489.5356, 10.3527, 0.0000, 0.2998, 0.0000); //flower-bush09a
g_Object[374] = CreateObject(638, 996.6854, 2463.4907, 10.1259, 0.0000, 0.0000, 90.9000); //kb_planter+bush
g_Object[375] = CreateObject(14468, 951.0667, 2489.5356, 10.3704, 0.0000, 0.2998, 0.0000); //flower-bush09a
g_Object[376] = CreateObject(19273, 985.2075, 2506.2851, 11.5186, 0.0000, 0.0000, 0.0000); //KeypadNonDynamic
SetObjectMaterial(g_Object[376], 0, 1977, "cooler1", "kb_vend1", 0xFFFFFFFF);
g_Object[377] = CreateObject(638, 994.0858, 2463.4492, 10.1259, 0.0000, 0.0000, 90.9000); //kb_planter+bush
g_Object[378] = CreateObject(1278, 917.7324, 2577.6066, 23.5862, 0.0000, 0.0000, 25.0000); //sub_floodlite
g_Object[379] = CreateObject(19435, 988.7399, 2486.8474, 9.7889, 0.0000, 90.0998, 0.0000); //wall075
SetObjectMaterial(g_Object[379], 0, 9515, "bigboxtemp1", "poshground_sfw", 0xFFFFFFFF);
g_Object[380] = CreateObject(19273, 997.1644, 2454.2402, 11.2292, 0.0000, 0.0000, 180.0000); //KeypadNonDynamic
SetObjectMaterial(g_Object[380], 0, 1977, "cooler1", "kb_vend1", 0xFFFFFFFF);
g_Object[381] = CreateObject(19435, 985.2396, 2486.8474, 9.7952, 0.0000, 90.0998, 0.0000); //wall075
SetObjectMaterial(g_Object[381], 0, 9515, "bigboxtemp1", "poshground_sfw", 0xFFFFFFFF);
g_Object[382] = CreateObject(19435, 981.7396, 2486.8474, 9.8014, 0.0000, 90.0998, 0.0000); //wall075
SetObjectMaterial(g_Object[382], 0, 9515, "bigboxtemp1", "poshground_sfw", 0xFFFFFFFF);
g_Object[383] = CreateObject(19435, 981.1787, 2486.8474, 9.7824, 0.0000, 90.0998, 0.0000); //wall075
SetObjectMaterial(g_Object[383], 0, 9515, "bigboxtemp1", "poshground_sfw", 0xFFFFFFFF);
g_Object[384] = CreateObject(19435, 985.9696, 2492.8823, 9.8084, 0.4000, 90.0000, 89.4999); //wall075
SetObjectMaterial(g_Object[384], 0, 9515, "bigboxtemp1", "poshground_sfw", 0xFFFFFFFF);
g_Object[385] = CreateObject(3335, 995.6857, 2469.8862, 9.6384, 0.0000, 0.0000, 53.7999); //CE_roadsign1
SetObjectMaterial(g_Object[385], 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xFFFFFFFF);
SetObjectMaterial(g_Object[385], 1, 1560, "7_11_door", "cj_sheetmetal2", 0xFFFFFFFF);
SetObjectMaterial(g_Object[385], 2, 16093, "a51_ext", "ws_whitewall2_top", 0xFFFFFFFF);
g_Object[386] = CreateObject(19435, 985.9498, 2489.3898, 9.8084, 0.4000, 90.0000, 89.6996); //wall075
SetObjectMaterial(g_Object[386], 0, 9515, "bigboxtemp1", "poshground_sfw", 0xFFFFFFFF);
g_Object[387] = CreateObject(19786, 995.7158, 2469.8723, 11.7658, 0.0000, 0.0000, 53.7000); //LCDTVBig1
SetObjectMaterial(g_Object[387], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterialText(g_Object[387], "_________________", 1, 90, "Arial", 50, 1, 0xFFFFFFFF, 0x0, 0);
g_Object[388] = CreateObject(19435, 985.9824, 2495.4748, 9.7684, 0.4000, 90.0000, 89.6996); //wall075
SetObjectMaterial(g_Object[388], 0, 9515, "bigboxtemp1", "poshground_sfw", 0xFFFFFFFF);
g_Object[389] = CreateObject(19786, 995.7531, 2469.9531, 11.3957, 0.0000, 0.0000, 53.7000); //LCDTVBig1
SetObjectMaterial(g_Object[389], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterialText(g_Object[389], "of Corrections", 1, 90, "Arial", 40, 1, 0xFF000000, 0x0, 0);
g_Object[390] = CreateObject(3398, 1015.1519, 2518.5456, 23.4134, 0.0000, 0.0000, -84.4000); //cxrf_floodlite_
g_Object[391] = CreateObject(817, 963.3344, 2494.9423, 10.2636, 0.0000, 0.0000, 0.0000); //veg_Pflowers01
g_Object[392] = CreateObject(19124, 898.0584, 2507.7517, 29.2786, 0.0000, 0.0000, 0.0000); //BollardLight4
g_Object[393] = CreateObject(638, 1012.2072, 2467.2648, 10.0754, 0.0000, 0.0000, 0.0000); //kb_planter+bush
g_Object[394] = CreateObject(638, 1012.2072, 2463.8627, 10.0754, 0.0000, 0.0000, 0.0000); //kb_planter+bush
g_Object[395] = CreateObject(638, 1012.2072, 2465.6232, 10.0754, 0.0000, 0.0000, 0.0000); //kb_planter+bush
g_Object[396] = CreateObject(638, 1014.0612, 2463.0986, 10.1155, 0.0000, 0.0000, 90.3999); //kb_planter+bush
g_Object[397] = CreateObject(638, 1016.6314, 2463.1166, 10.1155, 0.0000, 0.0000, 90.3999); //kb_planter+bush
g_Object[398] = CreateObject(638, 1019.1917, 2463.1342, 10.1155, 0.0000, 0.0000, 90.3999); //kb_planter+bush
g_Object[399] = CreateObject(638, 1021.7020, 2463.1520, 10.1155, 0.0000, 0.0000, 90.3999); //kb_planter+bush
g_Object[400] = CreateObject(638, 1024.3321, 2463.1708, 10.1155, 0.0000, 0.0000, 90.3999); //kb_planter+bush
g_Object[401] = CreateObject(638, 1026.9023, 2463.1877, 10.1155, 0.0000, 0.0000, 90.3999); //kb_planter+bush
g_Object[402] = CreateObject(638, 1028.8918, 2463.1999, 10.1155, 0.0000, 0.0000, 90.3999); //kb_planter+bush
g_Object[403] = CreateObject(638, 1028.8553, 2468.3818, 10.1155, 0.0000, 0.0000, 90.3999); //kb_planter+bush
g_Object[404] = CreateObject(638, 1026.2253, 2468.3635, 10.1155, 0.0000, 0.0000, 90.3999); //kb_planter+bush
g_Object[405] = CreateObject(638, 1023.6453, 2468.3461, 10.1155, 0.0000, 0.0000, 90.3999); //kb_planter+bush
g_Object[406] = CreateObject(638, 1021.1151, 2468.3291, 10.1155, 0.0000, 0.0000, 90.3999); //kb_planter+bush
g_Object[407] = CreateObject(638, 1018.5548, 2468.3110, 10.1155, 0.0000, 0.0000, 90.3999); //kb_planter+bush
g_Object[408] = CreateObject(638, 1013.4744, 2468.2746, 10.1155, 0.0000, 0.0000, 90.3999); //kb_planter+bush
g_Object[409] = CreateObject(19376, 930.5153, 2478.2895, 9.7728, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[409], 0, 3967, "cj_airprt", "Road_blank256HV", 0xFFFFFFFF);
g_Object[410] = CreateObject(3515, 1016.5753, 2465.6374, 9.4601, 0.0000, 14.2999, 0.0000); //vgsfountain
g_Object[411] = CreateObject(3515, 1023.1563, 2465.6374, 9.5289, 0.0000, -15.3000, 0.0000); //vgsfountain
g_Object[412] = CreateObject(2114, 930.3494, 2482.9040, 9.9925, 0.0000, 0.0000, 0.0000); //basketball
g_Object[413] = CreateObject(19376, 930.3806, 2487.9113, 9.7728, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[413], 0, 3967, "cj_airprt", "Road_blank256HV", 0xFFFFFFFF);
g_Object[414] = CreateObject(3819, 925.4107, 2477.9606, 9.7693, 0.0000, 0.0000, -178.9998); //bleacher_SFSx
SetObjectMaterial(g_Object[414], 2, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[415] = CreateObject(19453, 935.4005, 2487.7531, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[415], 0, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
g_Object[416] = CreateObject(3819, 925.2764, 2487.9125, 9.7693, 0.0000, 0.0000, -179.5000); //bleacher_SFSx
SetObjectMaterial(g_Object[416], 2, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[417] = CreateObject(19453, 935.5637, 2478.5065, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[417], 0, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
g_Object[418] = CreateObject(19453, 930.9146, 2473.7136, 8.1232, 0.0000, 0.0000, -89.3000); //wall093
SetObjectMaterial(g_Object[418], 0, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
g_Object[419] = CreateObject(19453, 925.3112, 2487.5773, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[419], 0, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
g_Object[420] = CreateObject(19453, 925.4724, 2478.3566, 8.1134, 0.0000, 0.0000, -179.0001); //wall093
SetObjectMaterial(g_Object[420], 0, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
g_Object[421] = CreateObject(19453, 930.2943, 2473.7026, 8.1134, 0.0000, 0.0000, -89.3000); //wall093
SetObjectMaterial(g_Object[421], 0, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
g_Object[422] = CreateObject(946, 930.6237, 2474.0981, 12.0282, 0.0000, 0.0000, 1.5000); //bskball_lax
g_Object[423] = CreateObject(19453, 929.9558, 2492.4035, 8.1134, 0.0000, 0.0000, -89.3000); //wall093
SetObjectMaterial(g_Object[423], 0, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
g_Object[424] = CreateObject(19453, 930.4357, 2492.4101, 8.1134, 0.0000, 0.0000, -89.3000); //wall093
SetObjectMaterial(g_Object[424], 0, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
g_Object[425] = CreateObject(946, 930.3176, 2492.0705, 12.0282, 0.0000, 0.0000, -178.0997); //bskball_lax
g_Object[426] = CreateObject(19453, 930.1820, 2482.9089, 8.1134, 0.0000, 0.0000, -89.3000); //wall093
SetObjectMaterial(g_Object[426], 0, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
g_Object[427] = CreateObject(19453, 930.7525, 2482.9211, 8.1134, 0.0000, 0.0000, -89.3000); //wall093
SetObjectMaterial(g_Object[427], 0, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
g_Object[428] = CreateObject(2915, 938.5770, 2529.9709, 9.9917, 0.0000, 0.0000, -95.5998); //kmb_dumbbell2
g_Object[429] = CreateObject(2628, 937.1815, 2527.3364, 9.8500, 0.0000, 0.0000, 90.3999); //gym_bench2
g_Object[430] = CreateObject(2629, 937.2210, 2524.3718, 9.8760, 0.0000, 0.0000, 90.2994); //gym_bench1
g_Object[431] = CreateObject(2628, 937.1422, 2533.0073, 9.8500, 0.0000, 0.0000, 90.3999); //gym_bench2
g_Object[432] = CreateObject(2629, 937.1906, 2530.1708, 9.8760, 0.0000, 0.0000, 90.2994); //gym_bench1
g_Object[433] = CreateObject(2913, 936.6010, 2529.7211, 10.7733, -90.3999, 0.0000, 0.0000); //kmb_bpress
g_Object[434] = CreateObject(3398, 924.0817, 2527.7521, 23.4134, 0.0000, 0.0000, 127.9999); //cxrf_floodlite_
g_Object[435] = CreateObject(3398, 919.5360, 2529.0063, 23.4134, 0.0000, 0.0000, -139.5000); //cxrf_floodlite_
g_Object[436] = CreateObject(2913, 936.6010, 2523.9355, 10.7833, -90.3999, 0.0000, 0.0000); //kmb_bpress
g_Object[437] = CreateObject(2915, 937.2144, 2525.2558, 9.9917, 0.0000, 0.0000, -0.1000); //kmb_dumbbell2
g_Object[438] = CreateObject(3819, 935.3441, 2488.1457, 9.7693, 0.0000, 0.0000, 1.2999); //bleacher_SFSx
SetObjectMaterial(g_Object[438], 2, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[439] = CreateObject(3819, 935.5208, 2477.7341, 9.7693, 0.0000, 0.0000, 1.2999); //bleacher_SFSx
SetObjectMaterial(g_Object[439], 2, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[440] = CreateObject(1216, 922.8956, 2508.8881, 10.5481, 0.0000, 0.0000, 87.3000); //phonebooth1
g_Object[441] = CreateObject(19376, 930.5153, 2478.2895, 9.7728, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[441], 0, 3967, "cj_airprt", "Road_blank256HV", 0xFFFFFFFF);
g_Object[442] = CreateObject(19376, 923.9088, 2513.0263, 9.7728, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[442], 0, 4835, "airoads_las", "concretenewb256", 0xFFFFFFFF);
g_Object[443] = CreateObject(19376, 924.0437, 2503.4096, 9.7728, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[443], 0, 4835, "airoads_las", "concretenewb256", 0xFFFFFFFF);
g_Object[444] = CreateObject(1216, 922.9942, 2510.9843, 10.5481, 0.0000, 0.0000, 87.3000); //phonebooth1
g_Object[445] = CreateObject(19376, 923.7741, 2522.6555, 9.7728, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[445], 0, 4835, "airoads_las", "concretenewb256", 0xFFFFFFFF);
g_Object[446] = CreateObject(19376, 934.2728, 2522.8002, 9.7728, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[446], 0, 4835, "airoads_las", "concretenewb256", 0xFFFFFFFF);
g_Object[447] = CreateObject(19376, 944.7617, 2522.9436, 9.7728, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[447], 0, 4835, "airoads_las", "concretenewb256", 0xFFFFFFFF);
g_Object[448] = CreateObject(19376, 955.2504, 2523.0893, 9.7728, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[448], 0, 4835, "airoads_las", "concretenewb256", 0xFFFFFFFF);
g_Object[449] = CreateObject(1216, 923.0927, 2513.0737, 10.5481, 0.0000, 0.0000, 87.3000); //phonebooth1
g_Object[450] = CreateObject(19376, 955.1160, 2532.7207, 9.7728, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[450], 0, 4835, "airoads_las", "concretenewb256", 0xFFFFFFFF);
g_Object[451] = CreateObject(19376, 944.6173, 2532.5751, 9.7728, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[451], 0, 4835, "airoads_las", "concretenewb256", 0xFFFFFFFF);
g_Object[452] = CreateObject(19376, 934.1187, 2532.4304, 9.7728, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[452], 0, 4835, "airoads_las", "concretenewb256", 0xFFFFFFFF);
g_Object[453] = CreateObject(19376, 928.0490, 2532.3417, 9.7929, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[453], 0, 4835, "airoads_las", "concretenewb256", 0xFFFFFFFF);
g_Object[454] = CreateObject(3398, 920.1203, 2492.9436, 23.7735, 0.0000, 0.0000, 131.9998); //cxrf_floodlite_
g_Object[455] = CreateObject(2596, 919.2998, 2498.8125, 13.8472, 0.0000, 0.0000, 116.5998); //CJ_SEX_TV
g_Object[456] = CreateObject(19869, 930.1953, 2473.4335, 9.8114, 0.0000, 0.0000, 0.0000); //MeshFence2
g_Object[457] = CreateObject(19376, 932.2180, 2497.4882, 9.7826, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[457], 0, 4835, "airoads_las", "concretenewb256", 0xFFFFFFFF);
g_Object[458] = CreateObject(19869, 923.0737, 2492.7727, 9.8114, 0.0000, 0.0000, 0.0000); //MeshFence2
g_Object[459] = CreateObject(3398, 937.4321, 2472.9519, 23.7735, 0.0000, 0.0000, 20.6998); //cxrf_floodlite_
g_Object[460] = CreateObject(19869, 929.8530, 2492.7727, 9.8114, 0.0000, 0.0000, 0.0000); //MeshFence2
g_Object[461] = CreateObject(19869, 934.9154, 2492.7727, 9.8114, 0.0000, 0.0000, 0.0000); //MeshFence2
g_Object[462] = CreateObject(19869, 935.3651, 2473.4731, 9.8212, 0.0000, 0.0000, 1.0999); //MeshFence2
g_Object[463] = CreateObject(19869, 921.2659, 2473.4335, 9.8114, 0.0000, 0.0000, 0.0000); //MeshFence2
g_Object[464] = CreateObject(19869, 926.4373, 2473.4335, 9.8114, 0.0000, 0.0000, 0.0000); //MeshFence2
g_Object[465] = CreateObject(3398, 923.0477, 2472.7678, 23.7735, 0.0000, 0.0000, 170.6999); //cxrf_floodlite_
g_Object[466] = CreateObject(19869, 920.3952, 2490.1257, 9.8114, 0.0000, 0.0000, -90.8999); //MeshFence2
g_Object[467] = CreateObject(19869, 929.8530, 2492.7727, 12.1913, 0.0000, 0.0000, 0.0000); //MeshFence2
g_Object[468] = CreateObject(19869, 934.9135, 2492.7727, 12.1913, 0.0000, 0.0000, 0.0000); //MeshFence2
g_Object[469] = CreateObject(19869, 923.0628, 2492.7727, 12.1913, 0.0000, 0.0000, 0.0000); //MeshFence2
g_Object[470] = CreateObject(19869, 920.3952, 2490.1257, 12.1913, 0.0000, 0.0000, -90.8999); //MeshFence2
g_Object[471] = CreateObject(19869, 935.3651, 2473.4731, 12.1913, 0.0000, 0.0000, 1.0999); //MeshFence2
g_Object[472] = CreateObject(19869, 930.2056, 2473.4335, 12.1913, 0.0000, 0.0000, 0.0000); //MeshFence2
g_Object[473] = CreateObject(19869, 926.4448, 2473.4335, 12.1913, 0.0000, 0.0000, 0.0000); //MeshFence2
g_Object[474] = CreateObject(19869, 923.0253, 2473.4335, 12.1913, 0.0000, 0.0000, 0.0000); //MeshFence2
g_Object[475] = CreateObject(1215, 923.4738, 2521.1464, 10.4062, 0.0000, 0.0000, 0.0000); //bollardlight
g_Object[476] = CreateObject(1215, 923.3438, 2514.5747, 10.4062, 0.0000, 0.0000, 0.0000); //bollardlight
g_Object[477] = CreateObject(19869, 926.4846, 2492.7727, 12.1913, 0.0000, 0.0000, 0.0000); //MeshFence2
g_Object[478] = CreateObject(1359, 923.2844, 2493.2734, 10.4390, 0.0000, 0.0000, 0.0000); //CJ_BIN1
g_Object[479] = CreateObject(1215, 923.2537, 2508.2041, 10.4062, 0.0000, 0.0000, 0.0000); //bollardlight
g_Object[480] = CreateObject(1215, 919.6234, 2498.3908, 10.4062, 0.0000, 0.0000, 0.0000); //bollardlight
g_Object[481] = CreateObject(1215, 922.5731, 2482.7172, 10.4062, 0.0000, 0.0000, 0.0000); //bollardlight
g_Object[482] = CreateObject(1215, 937.4133, 2482.9675, 10.4062, 0.0000, 0.0000, 0.0000); //bollardlight
g_Object[483] = CreateObject(8874, 911.2326, 2535.0981, 16.7940, 0.0000, 0.0000, 175.3999); //vgsEcnstrct13
g_Object[484] = CreateObject(19124, 922.5089, 2470.8920, 28.7287, 0.0000, 0.0000, 0.0000); //BollardLight4
g_Object[485] = CreateObject(19124, 897.7587, 2492.3339, 28.6888, 0.0000, 0.0000, 0.0000); //BollardLight4
g_Object[486] = CreateObject(19124, 923.2990, 2528.4731, 29.2786, 0.0000, 0.0000, 0.0000); //BollardLight4
g_Object[487] = CreateObject(19124, 969.9188, 2488.6342, 29.3187, 0.0000, 0.0000, 0.0000); //BollardLight4
g_Object[488] = CreateObject(19124, 948.7880, 2488.5942, 29.3187, 0.0000, 0.0000, 0.0000); //BollardLight4
g_Object[489] = CreateObject(19124, 948.8380, 2463.5239, 29.3187, 0.0000, 0.0000, 0.0000); //BollardLight4
g_Object[490] = CreateObject(1278, 941.4970, 2538.3735, 23.5862, 0.0000, 0.0000, 163.0000); //sub_floodlite
g_Object[491] = CreateObject(19124, 969.9782, 2463.4838, 29.3187, 0.0000, 0.0000, 0.0000); //BollardLight4
g_Object[492] = CreateObject(11711, 970.8469, 2465.8728, 13.0451, 0.0000, 0.0000, 0.0000); //ExitSign1
SetObjectMaterial(g_Object[492], 0, 10778, "airportcpark_sfse", "ws_fireexit", 0xFFFFFFFF);
g_Object[493] = CreateObject(1278, 941.3991, 2538.1423, 23.5862, 0.0000, 0.0000, -23.0000); //sub_floodlite
g_Object[494] = CreateObject(1616, 968.5305, 2463.2150, 29.3871, 0.0000, 0.0000, 101.5998); //nt_securecam1_01
g_Object[495] = CreateObject(19377, 874.4144, 2528.3872, 11.9798, 0.0000, 0.0000, 88.8999); //wall025
SetObjectMaterial(g_Object[495], 0, 3967, "cj_airprt", "bigbrick", 0xFFFFFFFF);
g_Object[496] = CreateObject(1278, 981.1810, 2524.8085, 23.5664, 0.0000, 0.0000, 0.0000); //sub_floodlite
g_Object[497] = CreateObject(1278, 981.2130, 2525.0964, 23.5862, 0.0000, 0.0000, 178.8999); //sub_floodlite
g_Object[498] = CreateObject(1616, 993.2039, 2485.3532, 24.1270, 0.0000, 0.0000, -165.2998); //nt_securecam1_01
g_Object[499] = CreateObject(1616, 993.2542, 2463.8068, 24.1270, 0.0000, 0.0000, 162.8999); //nt_securecam1_01
g_Object[500] = CreateObject(1616, 948.5067, 2477.5842, 28.9871, 0.0000, 0.0000, -4.5998); //nt_securecam1_01
g_Object[501] = CreateObject(1616, 961.7122, 2489.0649, 29.6870, 0.0000, 0.0000, -91.1996); //nt_securecam1_01
g_Object[502] = CreateObject(3398, 1028.7854, 2510.1679, 23.4134, 0.0000, 0.0000, -30.5000); //cxrf_floodlite_
g_Object[503] = CreateObject(3398, 1028.9322, 2444.3916, 23.4134, 0.0000, 0.0000, -113.9000); //cxrf_floodlite_
g_Object[504] = CreateObject(3398, 992.8530, 2464.6677, 23.4134, 0.0000, 0.0000, 50.2999); //cxrf_floodlite_
g_Object[505] = CreateObject(3398, 973.8330, 2463.1286, 23.4134, 0.0000, 0.0000, -19.3999); //cxrf_floodlite_
g_Object[506] = CreateObject(1616, 923.3466, 2480.0727, 28.5972, 0.0000, 0.0000, 167.8000); //nt_securecam1_01
g_Object[507] = CreateObject(1616, 897.3380, 2485.5869, 29.1072, 0.0000, 0.0000, 10.1000); //nt_securecam1_01
g_Object[508] = CreateObject(19376, 921.7293, 2497.3442, 9.7833, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[508], 0, 4835, "airoads_las", "concretenewb256", 0xFFFFFFFF);
g_Object[509] = CreateObject(1616, 923.5784, 2513.9255, 29.4071, 0.0000, 0.0000, -146.6999); //nt_securecam1_01
g_Object[510] = CreateObject(1616, 915.5783, 2529.0742, 29.5729, 0.0000, 0.0000, -93.3998); //nt_securecam1_01
g_Object[511] = CreateObject(1756, 936.4785, 2498.2004, 9.8562, 0.0000, 0.0000, -93.6996); //LOW_COUCH_4
g_Object[512] = CreateObject(1756, 934.6375, 2493.6684, 9.8562, 0.0000, 0.0000, -177.3999); //LOW_COUCH_4
g_Object[513] = CreateObject(1968, 926.1287, 2533.9956, 10.3949, 0.0000, 0.0000, 0.0000); //dinerseat_2
g_Object[514] = CreateObject(1968, 926.1287, 2532.4748, 10.3949, 0.0000, 0.0000, 0.0000); //dinerseat_2
g_Object[515] = CreateObject(1968, 926.1287, 2530.9541, 10.3949, 0.0000, 0.0000, 0.0000); //dinerseat_2
g_Object[516] = CreateObject(1968, 930.7689, 2530.9541, 10.3949, 0.0000, 0.0000, 0.0000); //dinerseat_2
g_Object[517] = CreateObject(1968, 930.7689, 2532.4650, 10.3949, 0.0000, 0.0000, 0.0000); //dinerseat_2
g_Object[518] = CreateObject(1968, 930.7689, 2533.9560, 10.3949, 0.0000, 0.0000, 0.0000); //dinerseat_2
g_Object[519] = CreateObject(19354, 1011.5228, 2472.6113, 8.2489, -89.8999, -93.5000, -92.5988); //wall002
SetObjectMaterial(g_Object[519], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[520] = CreateObject(19354, 1011.4749, 2475.6704, 8.2488, -89.8999, -93.5000, -92.5988); //wall002
SetObjectMaterial(g_Object[520], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[521] = CreateObject(19354, 1011.2423, 2489.8696, 8.2473, -89.8999, -93.5000, -92.3992); //wall002
SetObjectMaterial(g_Object[521], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[522] = CreateObject(19354, 1011.5496, 2470.9396, 8.2493, -89.8999, -93.5000, -92.5988); //wall002
SetObjectMaterial(g_Object[522], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[523] = CreateObject(19354, 1011.2998, 2486.8300, 8.2475, -89.8999, -93.5000, -92.5988); //wall002
SetObjectMaterial(g_Object[523], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[524] = CreateObject(19354, 1011.1754, 2493.3593, 8.2468, -89.8999, -93.5000, -92.3992); //wall002
SetObjectMaterial(g_Object[524], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[525] = CreateObject(19354, 1011.1347, 2495.4899, 8.2467, -89.8999, -93.5000, -92.3992); //wall002
SetObjectMaterial(g_Object[525], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[526] = CreateObject(970, 997.4027, 2440.9997, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[527] = CreateObject(970, 997.4166, 2436.8798, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[528] = CreateObject(970, 997.4307, 2432.7497, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[529] = CreateObject(970, 997.4453, 2428.6296, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[530] = CreateObject(970, 997.4600, 2424.4985, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[531] = CreateObject(970, 997.4741, 2420.3779, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[532] = CreateObject(970, 997.4885, 2416.2583, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[533] = CreateObject(970, 997.5029, 2412.1386, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[534] = CreateObject(970, 997.5172, 2408.0170, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[535] = CreateObject(970, 997.5253, 2405.9255, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[536] = CreateObject(970, 1017.3657, 2405.9941, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[537] = CreateObject(970, 1017.3582, 2408.0761, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[538] = CreateObject(970, 1017.3441, 2412.2058, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[539] = CreateObject(970, 1017.3297, 2416.3259, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[540] = CreateObject(970, 1017.3156, 2420.4460, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[541] = CreateObject(970, 1017.3007, 2424.5676, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[542] = CreateObject(970, 1017.2868, 2428.6872, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[543] = CreateObject(970, 1017.2725, 2432.8076, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[544] = CreateObject(970, 1017.2584, 2436.9274, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[545] = CreateObject(970, 1017.2432, 2441.0500, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[546] = CreateObject(970, 1012.8399, 2438.9543, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[547] = CreateObject(970, 1012.8541, 2434.8347, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[548] = CreateObject(970, 1012.8684, 2430.7141, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[549] = CreateObject(970, 1012.8723, 2426.5937, 10.3647, 0.0000, 0.0000, -89.9000); //fencesmallb
g_Object[550] = CreateObject(970, 1012.8795, 2422.4729, 10.3647, 0.0000, 0.0000, -89.9000); //fencesmallb
g_Object[551] = CreateObject(970, 1012.8681, 2418.3503, 10.3647, 0.0000, 0.0000, -90.3000); //fencesmallb
g_Object[552] = CreateObject(970, 1012.8466, 2414.2312, 10.3647, 0.0000, 0.0000, -90.3000); //fencesmallb
g_Object[553] = CreateObject(970, 1012.8353, 2410.1108, 10.3647, 0.0000, 0.0000, -90.1996); //fencesmallb
g_Object[554] = CreateObject(970, 1012.8275, 2408.0288, 10.3647, 0.0000, 0.0000, -90.1996); //fencesmallb
g_Object[555] = CreateObject(19376, 902.5369, 2447.9394, 9.7426, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[555], 0, 3967, "cj_airprt", "Road_blank256HV", 0xFFFFFFFF);
g_Object[556] = CreateObject(970, 1001.9500, 2438.9836, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[557] = CreateObject(970, 1001.9647, 2434.8625, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[558] = CreateObject(970, 1001.9793, 2430.7321, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[559] = CreateObject(970, 1001.9937, 2426.6110, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[560] = CreateObject(970, 1002.0087, 2422.4904, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[561] = CreateObject(970, 1002.0233, 2418.3686, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[562] = CreateObject(970, 1002.0371, 2414.2487, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[563] = CreateObject(970, 1002.0521, 2410.1374, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[564] = CreateObject(970, 1002.0584, 2408.0490, 10.3647, 0.0000, 0.0000, -89.8000); //fencesmallb
g_Object[565] = CreateObject(19376, 913.0260, 2448.0454, 9.7425, 0.0000, -89.9999, 0.7997); //wall024
SetObjectMaterial(g_Object[565], 0, 3967, "cj_airprt", "Road_blank256HV", 0xFFFFFFFF);
g_Object[566] = CreateObject(807, 909.0183, 2560.3410, 12.5607, 22.8999, 21.2000, 0.0000); //p_rubble
g_Object[567] = CreateObject(970, 1027.5194, 2497.7971, 10.3865, 0.0000, 0.0000, 1.2000); //fencesmallb
g_Object[568] = CreateObject(968, 1006.9989, 2404.1472, 10.5867, 0.0000, 0.5999, 180.0000); //barrierturn
SetObjectMaterial(g_Object[568], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[568], 1, 13659, "8bars", "barrier", 0xFFFFFFFF);
SetObjectMaterial(g_Object[568], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[568], 3, 13659, "8bars", "barrier", 0xFFFFFFFF);
g_Object[569] = CreateObject(19966, 1013.3021, 2382.8234, 10.9117, 0.0000, 0.0000, -3.2000); //SAMPRoadSign19
SetObjectMaterial(g_Object[569], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[569], 2, 66, "cj_barr_set_1", "Stop2_64", 0xFFFFFFFF);
g_Object[570] = CreateObject(970, 1023.3900, 2497.7304, 10.3865, 0.0000, 0.0000, 0.7997); //fencesmallb
g_Object[571] = CreateObject(970, 1019.2808, 2497.6679, 10.3865, 0.0000, 0.0000, 1.1000); //fencesmallb
g_Object[572] = CreateObject(970, 1015.1610, 2497.5874, 10.3865, 0.0000, 0.0000, 1.1000); //fencesmallb
g_Object[573] = CreateObject(970, 1013.0712, 2497.5458, 10.3865, 0.0000, 0.0000, 1.1000); //fencesmallb
g_Object[574] = CreateObject(970, 1011.0418, 2495.4301, 10.3865, 0.0000, 0.0000, -88.5998); //fencesmallb
g_Object[575] = CreateObject(970, 1011.1425, 2491.3012, 10.3865, 0.0000, 0.0000, -88.5998); //fencesmallb
g_Object[576] = CreateObject(970, 1011.5155, 2471.1025, 10.3865, 0.0000, 0.0000, -88.5998); //fencesmallb
g_Object[577] = CreateObject(970, 1011.2235, 2487.1518, 10.3865, 0.0000, 0.0000, -89.0998); //fencesmallb
g_Object[578] = CreateObject(19354, 1013.9735, 2485.1889, 8.2524, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[578], 0, 3119, "cs_ry_props", "lightgrey", 0xFFFFFFFF);
g_Object[579] = CreateObject(970, 1011.4140, 2475.2653, 10.3865, 0.0000, 0.0000, -88.5998); //fencesmallb
g_Object[580] = CreateObject(19354, 1012.8211, 2484.8894, 8.2508, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[580], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[581] = CreateObject(19354, 1013.9812, 2484.9177, 8.2524, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[581], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[582] = CreateObject(970, 1013.6478, 2469.0883, 10.3865, 0.0000, 0.0000, -178.3999); //fencesmallb
g_Object[583] = CreateObject(970, 1017.8062, 2469.2019, 10.3865, 0.0000, 0.0000, -178.3999); //fencesmallb
g_Object[584] = CreateObject(970, 1021.9249, 2469.3164, 10.3865, 0.0000, 0.0000, -178.3999); //fencesmallb
g_Object[585] = CreateObject(970, 1026.0633, 2469.4326, 10.3865, 0.0000, 0.0000, -178.3999); //fencesmallb
g_Object[586] = CreateObject(19354, 1013.0109, 2477.6308, 8.2510, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[586], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[587] = CreateObject(19354, 1014.1807, 2477.6599, 8.2531, -89.8999, -2.3998, -90.8992); //wall002
SetObjectMaterial(g_Object[587], 0, 3119, "cs_ry_props", "lightgrey", 0xFFD78E10);
g_Object[588] = CreateObject(970, 1027.9752, 2469.4797, 10.3865, 0.0000, 0.0000, -178.3999); //fencesmallb
g_Object[589] = CreateObject(3407, 1000.8828, 2472.8474, 9.8191, 0.0000, 0.0000, 87.8000); //CE_mailbox1
g_Object[590] = CreateObject(1366, 1011.7335, 2463.6296, 10.4649, 0.0000, 0.0000, 0.0000); //CJ_FIREHYDRANT
g_Object[591] = CreateObject(1366, 959.9027, 2462.8288, 10.4649, 0.0000, 0.0000, 0.0000); //CJ_FIREHYDRANT
g_Object[592] = CreateObject(1571, 924.5792, 2524.1259, 11.1738, 0.0000, 0.0000, 84.8999); //CJ_NOODLE_1
g_Object[593] = CreateObject(898, 877.7116, 2538.4680, 19.6539, 0.0000, 0.0000, 0.0000); //searock02
g_Object[594] = CreateObject(898, 878.5662, 2534.9594, 16.5039, 0.0000, 0.0000, -50.0000); //searock02
g_Object[595] = CreateObject(898, 881.1375, 2551.2038, 19.4139, 0.0000, 0.0000, -84.4000); //searock02
g_Object[596] = CreateObject(18228, 879.8413, 2564.8859, 6.4077, 0.0000, 0.0000, 0.0000); //cunt_rockgp2_21
g_Object[597] = CreateObject(807, 904.8673, 2540.0380, 11.8297, 0.0000, 0.0000, -162.7998); //p_rubble
g_Object[598] = CreateObject(898, 889.4298, 2563.6730, 16.1539, 0.0000, 0.0000, -84.4000); //searock02
g_Object[599] = CreateObject(898, 889.2299, 2554.8603, 15.1639, 0.0000, 0.0000, -84.4000); //searock02
g_Object[600] = CreateObject(19974, 859.8480, 2523.8994, 28.9846, 0.0000, 0.0000, -42.2999); //SAMPRoadSign27
g_Object[601] = CreateObject(898, 884.0634, 2543.0112, 15.1639, 0.0000, 0.0000, -140.8999); //searock02
g_Object[602] = CreateObject(19974, 867.7860, 2596.2958, 27.2947, 0.0000, 0.0000, -179.1999); //SAMPRoadSign27
g_Object[603] = CreateObject(898, 893.3366, 2570.2307, 12.9839, 0.0000, 0.0000, -140.8999); //searock02
g_Object[604] = CreateObject(807, 903.1154, 2550.7929, 12.8051, 0.0000, 13.5999, -10.9996); //p_rubble
g_Object[605] = CreateObject(807, 909.1594, 2547.4172, 11.4699, 0.0000, 0.0000, 0.0000); //p_rubble
g_Object[606] = CreateObject(807, 890.8372, 2534.0668, 13.6498, 0.0000, 7.8000, -80.8000); //p_rubble
g_Object[607] = CreateObject(807, 896.3024, 2541.7419, 14.0298, 0.0000, 0.0000, -80.8000); //p_rubble
g_Object[608] = CreateObject(807, 905.6580, 2541.4995, 11.9097, 0.0000, 0.0000, 0.0000); //p_rubble
g_Object[609] = CreateObject(898, 886.2426, 2559.4428, 20.8938, 0.0000, 0.0000, 0.3998); //searock02
g_Object[610] = CreateObject(898, 886.1718, 2569.6032, 21.5338, 0.0000, 0.0000, -44.5998); //searock02
g_Object[611] = CreateObject(3819, 952.2083, 2543.0078, 10.6892, 0.0000, 0.0000, 83.7994); //bleacher_SFSx
g_Object[612] = CreateObject(3819, 965.2009, 2530.4846, 10.6892, 0.0000, 0.0000, 0.8998); //bleacher_SFSx
g_Object[613] = CreateObject(19916, 923.4343, 2525.5249, 10.0256, 0.0000, 0.0000, 84.6996); //CutsceneFridge1
g_Object[614] = CreateObject(19923, 923.1267, 2524.0590, 10.0634, 0.0000, 0.0000, 84.1996); //MKIslandCooker1
SetObjectMaterial(g_Object[614], 0, 1560, "7_11_door", "cj_sheetmetal2", 0xFFFFFFFF);
g_Object[615] = CreateObject(807, 904.0300, 2564.0170, 14.8655, 0.5999, 12.8999, 0.0000); //p_rubble
g_Object[616] = CreateObject(807, 904.4063, 2573.7019, 14.0122, 0.7997, 21.2000, 0.0000); //p_rubble
g_Object[617] = CreateObject(14791, 955.8106, 2530.9479, 11.7796, 0.0000, 0.0000, 0.0000); //a_vgsGymBoxa
g_Object[618] = CreateObject(19983, 969.9431, 2488.1611, 9.7475, 0.0000, 0.0000, -179.0000); //SAMPRoadSign36
SetObjectMaterial(g_Object[618], 2, 10765, "airportgnd_sfse", "white", 0xFF0E316D);
g_Object[619] = CreateObject(19983, 1011.4564, 2477.4650, 9.7475, 0.0000, 0.0000, -5.5998); //SAMPRoadSign36
SetObjectMaterial(g_Object[619], 2, 10765, "airportgnd_sfse", "white", 0xFF0E316D);
g_Object[620] = CreateObject(19983, 938.2965, 2487.7351, 9.7475, 0.0000, 0.0000, 176.3999); //SAMPRoadSign36
SetObjectMaterial(g_Object[620], 2, 10765, "airportgnd_sfse", "white", 0xFF0E316D);
g_Object[621] = CreateObject(19786, 1012.2896, 2477.4892, 12.3596, 0.0000, 0.0000, -5.9000); //LCDTVBig1
SetObjectMaterial(g_Object[621], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterialText(g_Object[621], "P", 1, 90, "Arial", 110, 1, 0xFFFFFFFF, 0x0, 0);
g_Object[622] = CreateObject(19786, 969.1093, 2488.0466, 12.3395, 0.0000, 0.0000, -179.0000); //LCDTVBig1
SetObjectMaterial(g_Object[622], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterialText(g_Object[622], "P", 1, 90, "Arial", 110, 1, 0xFFFFFFFF, 0x0, 0);
g_Object[623] = CreateObject(19786, 937.4450, 2487.6816, 12.3395, 0.0000, 0.0000, 176.5997); //LCDTVBig1
SetObjectMaterial(g_Object[623], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterialText(g_Object[623], "P", 1, 90, "Arial", 110, 1, 0xFFFFFFFF, 0x0, 0);
g_Object[624] = CreateObject(987, 938.5125, 2454.7343, 9.6503, 0.0000, 0.0000, -88.8999); //elecfence_BAR
SetObjectMaterial(g_Object[624], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[624], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[625] = CreateObject(987, 1029.3581, 2511.2175, 9.6503, 0.0000, 0.0000, 148.8000); //elecfence_BAR
SetObjectMaterial(g_Object[625], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[625], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[625], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[626] = CreateObject(19966, 1002.0869, 2333.4531, 9.6442, 0.0000, 0.0000, 180.0000); //SAMPRoadSign19
g_Object[627] = CreateObject(19966, 1001.6668, 2443.6818, 9.6442, 0.0000, 0.0000, 162.8000); //SAMPRoadSign19
g_Object[628] = CreateObject(968, 1007.6392, 2404.1472, 10.5867, 0.0000, 0.4000, 0.0000); //barrierturn
SetObjectMaterial(g_Object[628], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[628], 1, 13659, "8bars", "barrier", 0xFFFFFFFF);
SetObjectMaterial(g_Object[628], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[628], 3, 13659, "8bars", "barrier", 0xFFFFFFFF);
g_Object[629] = CreateObject(1434, 1000.5120, 2403.5847, 9.9003, 0.0000, 0.0000, 0.0000); //DYN_ROADBARRIER_5a
SetObjectMaterial(g_Object[629], 0, 1282, "barrierm", "orangebarrier2", 0xFFFFFFFF);
g_Object[630] = CreateObject(1434, 1013.8728, 2403.5847, 9.8900, 0.0000, 0.0000, 0.0000); //DYN_ROADBARRIER_5a
SetObjectMaterial(g_Object[630], 0, 1282, "barrierm", "orangebarrier2", 0xFFFFFFFF);
g_Object[631] = CreateObject(987, 938.7480, 2442.7729, 9.6503, 0.0000, 0.0000, -90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[631], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[631], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[632] = CreateObject(1434, 1001.6016, 2442.8762, 9.9003, 0.0000, 0.0000, 0.0000); //DYN_ROADBARRIER_5a
SetObjectMaterial(g_Object[632], 0, 1282, "barrierm", "orangebarrier2", 0xFFFFFFFF);
g_Object[633] = CreateObject(1434, 1013.9124, 2442.8762, 9.9003, 0.0000, 0.0000, 0.0000); //DYN_ROADBARRIER_5a
SetObjectMaterial(g_Object[633], 0, 1282, "barrierm", "orangebarrier2", 0xFFFFFFFF);
g_Object[634] = CreateObject(19273, 990.1087, 2477.8127, 11.9889, 0.0000, 0.0000, 85.0000); //KeypadNonDynamic
SetObjectMaterial(g_Object[634], 0, 1977, "cooler1", "kb_vend1", 0xFFFFFFFF);
g_Object[635] = CreateObject(19273, 985.2075, 2507.2160, 11.5186, 0.0000, 0.0000, 180.0000); //KeypadNonDynamic
SetObjectMaterial(g_Object[635], 0, 1977, "cooler1", "kb_vend1", 0xFFFFFFFF);
g_Object[636] = CreateObject(19273, 1001.3958, 2451.7687, 11.2292, 0.0000, 0.0000, 90.8000); //KeypadNonDynamic
SetObjectMaterial(g_Object[636], 0, 1977, "cooler1", "kb_vend1", 0xFFFFFFFF);
g_Object[637] = CreateObject(19273, 915.9824, 2471.6247, 11.3606, 0.0000, 0.0000, 0.0000); //KeypadNonDynamic
SetObjectMaterial(g_Object[637], 0, 1977, "cooler1", "kb_vend1", 0xFFFFFFFF);
g_Object[638] = CreateObject(987, 1031.4947, 2431.6784, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[638], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[638], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[639] = CreateObject(987, 1055.3828, 2431.3681, 9.6503, 0.0000, 0.0000, 180.0000); //elecfence_BAR
SetObjectMaterial(g_Object[639], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[639], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[640] = CreateObject(987, 1043.4143, 2431.3681, 9.6503, 0.0000, 0.0000, 180.0000); //elecfence_BAR
SetObjectMaterial(g_Object[640], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[640], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[641] = CreateObject(987, 1067.3320, 2431.3681, 9.6503, 0.0000, 0.0000, 180.0000); //elecfence_BAR
SetObjectMaterial(g_Object[641], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[641], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[642] = CreateObject(987, 1082.8330, 2373.2890, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[642], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[642], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[643] = CreateObject(987, 1033.2746, 2371.8332, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[643], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[643], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[644] = CreateObject(987, 1044.9356, 2322.2309, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[644], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[644], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[645] = CreateObject(987, 1044.2264, 2346.1096, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[645], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[645], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[646] = CreateObject(987, 1012.6983, 2333.4870, 9.6503, 0.0000, 0.0000, 0.0000); //elecfence_BAR
SetObjectMaterial(g_Object[646], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[646], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[647] = CreateObject(987, 1044.5811, 2334.1762, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[647], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[647], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[648] = CreateObject(987, 977.7368, 2298.4433, 9.6503, 0.0000, 0.0000, 0.0000); //elecfence_BAR
SetObjectMaterial(g_Object[648], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[648], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[649] = CreateObject(987, 1045.2917, 2310.2670, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[649], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[649], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[650] = CreateObject(987, 1021.7078, 2298.4533, 9.6503, 0.0000, 0.0000, 0.0000); //elecfence_BAR
SetObjectMaterial(g_Object[650], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[650], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[651] = CreateObject(987, 989.6973, 2298.4433, 9.6503, 0.0000, 0.0000, 0.0000); //elecfence_BAR
SetObjectMaterial(g_Object[651], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[651], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[652] = CreateObject(987, 965.7476, 2298.4433, 9.6503, 0.0000, 0.0000, 0.0000); //elecfence_BAR
SetObjectMaterial(g_Object[652], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[652], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[653] = CreateObject(987, 1045.6456, 2298.3508, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[653], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[653], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[654] = CreateObject(987, 1082.4788, 2385.2773, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[654], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[654], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[655] = CreateObject(987, 1024.6877, 2333.4870, 9.6503, 0.0000, 0.0000, 0.0000); //elecfence_BAR
SetObjectMaterial(g_Object[655], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[655], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[656] = CreateObject(987, 1033.6977, 2298.4433, 9.6503, 0.0000, 0.0000, 0.0000); //elecfence_BAR
SetObjectMaterial(g_Object[656], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[656], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[657] = CreateObject(987, 1032.9394, 2333.5070, 9.6503, 0.0000, 0.0000, 0.0000); //elecfence_BAR
SetObjectMaterial(g_Object[657], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[657], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[658] = CreateObject(987, 987.8281, 2333.4655, 9.6503, 0.0000, 0.0000, 0.0000); //elecfence_BAR
SetObjectMaterial(g_Object[658], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[658], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[659] = CreateObject(987, 989.6973, 2333.4555, 9.6503, 0.0000, 0.0000, 0.0000); //elecfence_BAR
SetObjectMaterial(g_Object[659], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[659], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[660] = CreateObject(987, 938.7480, 2382.8801, 9.6503, 0.0000, 0.0000, -90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[660], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[660], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[661] = CreateObject(19912, 1001.3679, 2298.0700, 12.6014, 0.0000, 0.0000, 180.0000); //SAMPMetalGate1
SetObjectMaterial(g_Object[661], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[661], 1, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[661], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[662] = CreateObject(19912, 1001.3679, 2333.2399, 12.6014, 0.0000, 0.0000, 180.0000); //SAMPMetalGate1
SetObjectMaterial(g_Object[662], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[662], 1, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[662], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[663] = CreateObject(1422, 941.5085, 2390.9699, 9.9496, 0.0000, 0.0000, 90.0000); //DYN_ROADBARRIER_5
g_Object[664] = CreateObject(1422, 936.5285, 2390.9699, 9.9496, 0.0000, 0.0000, 90.0000); //DYN_ROADBARRIER_5
g_Object[665] = CreateObject(1422, 936.5285, 2395.6105, 9.9496, 0.0000, 0.0000, 90.0000); //DYN_ROADBARRIER_5
g_Object[666] = CreateObject(987, 938.7480, 2394.8710, 9.6503, 0.0000, 0.0000, -90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[666], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[666], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[667] = CreateObject(987, 1082.1193, 2397.2673, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[667], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[667], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[668] = CreateObject(987, 1081.7641, 2409.2314, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[668], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[668], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[669] = CreateObject(987, 1081.4815, 2419.4738, 9.6503, 0.0000, 0.0000, 91.6996); //elecfence_BAR
SetObjectMaterial(g_Object[669], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[669], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[670] = CreateObject(987, 1079.2930, 2431.3681, 9.6503, 0.0000, 0.0000, 180.0000); //elecfence_BAR
SetObjectMaterial(g_Object[670], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[670], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[671] = CreateObject(987, 1081.1849, 2431.3881, 9.6503, 0.0000, 0.0000, 180.0000); //elecfence_BAR
SetObjectMaterial(g_Object[671], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[671], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[672] = CreateObject(1422, 1079.5985, 2395.8002, 9.9496, 0.0000, 0.0000, 90.0000); //DYN_ROADBARRIER_5
g_Object[673] = CreateObject(987, 1012.6983, 2333.1567, 9.6503, 0.0000, 0.0000, -90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[673], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[673], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[674] = CreateObject(987, 1012.6983, 2321.1696, 9.6503, 0.0000, 0.0000, -90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[674], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[674], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[675] = CreateObject(987, 1012.6983, 2315.1699, 9.6503, 0.0000, 0.0000, -90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[675], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[675], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[676] = CreateObject(987, 1002.1275, 2321.3103, 9.6503, 0.0000, 0.0000, 90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[676], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[676], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[677] = CreateObject(987, 1002.1275, 2309.3286, 9.6503, 0.0000, 0.0000, 90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[677], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[677], 2, 10806, "airfence_sfse", "ws_griddyfence", 0xFFFFFFFF);
g_Object[678] = CreateObject(10829, 1001.9995, 2322.9731, 9.7756, 0.0000, 0.0000, -179.0997); //gatehouse1_SFSe
SetObjectMaterial(g_Object[678], 0, 7978, "vgssairport", "airportwindow02_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[678], 2, 16640, "a51", "concretewall22_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[678], 3, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[678], 4, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[679] = CreateObject(1422, 1083.6088, 2395.8002, 9.9496, 0.0000, 0.0000, 90.0000); //DYN_ROADBARRIER_5
g_Object[680] = CreateObject(1422, 941.5085, 2395.3901, 9.9496, 0.0000, 0.0000, 90.0000); //DYN_ROADBARRIER_5
g_Object[681] = CreateObject(1422, 1083.6088, 2390.8786, 9.9496, 0.0000, 0.0000, 90.0000); //DYN_ROADBARRIER_5
g_Object[682] = CreateObject(1422, 1079.5985, 2390.8986, 9.9496, 0.0000, 0.0000, 90.0000); //DYN_ROADBARRIER_5
g_Object[683] = CreateObject(987, 1012.6983, 2298.4433, 9.6503, 0.0000, 0.0000, 0.0000); //elecfence_BAR
SetObjectMaterial(g_Object[683], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[683], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[684] = CreateObject(987, 938.7480, 2370.8808, 9.6503, 0.0000, 0.0000, -90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[684], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[684], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[685] = CreateObject(987, 938.7480, 2358.8859, 9.6503, 0.0000, 0.0000, -90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[685], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[685], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[686] = CreateObject(987, 938.7480, 2346.9147, 9.6503, 0.0000, 0.0000, -90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[686], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[686], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[687] = CreateObject(19966, 1001.1566, 2298.4934, 9.6442, 0.0000, 0.0000, 180.0000); //SAMPRoadSign19
g_Object[688] = CreateObject(19966, 1013.4072, 2298.2431, 9.6442, 0.0000, 0.0000, 0.0000); //SAMPRoadSign19
g_Object[689] = CreateObject(987, 938.7480, 2334.9431, 9.6503, 0.0000, 0.0000, -90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[689], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[689], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[690] = CreateObject(19966, 1012.5374, 2332.7172, 9.6442, 0.0000, 0.0000, -90.0000); //SAMPRoadSign19
g_Object[691] = CreateObject(3634, 974.1918, 2375.7114, 12.4853, 0.0000, 0.0000, 180.0000); //nwccumphus1_LAS
g_Object[692] = CreateObject(3173, 974.6096, 2366.5769, 9.7643, 0.0000, 0.0000, -90.0000); //trailer_large4_01
g_Object[693] = CreateObject(9228, 984.8048, 2360.1606, 11.4876, 0.0000, 0.0000, 90.0000); //moresfnshit22
g_Object[694] = CreateObject(3759, 993.5983, 2375.0769, 13.7924, 0.0000, 0.0000, 90.0000); //vencanhou01_LAx
g_Object[695] = CreateObject(987, 938.7480, 2430.7939, 9.6503, 0.0000, 0.0000, -90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[695], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[695], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[696] = CreateObject(987, 938.7480, 2406.8605, 9.6503, 0.0000, 0.0000, -90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[696], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[696], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[697] = CreateObject(987, 938.7480, 2418.8332, 9.6503, 0.0000, 0.0000, -90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[697], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[697], 2, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
g_Object[698] = CreateObject(987, 938.7480, 2322.9602, 9.6503, 0.0000, 0.0000, -90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[698], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[698], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[699] = CreateObject(987, 938.7480, 2310.9851, 9.6503, 0.0000, 0.0000, -90.0000); //elecfence_BAR
SetObjectMaterial(g_Object[699], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[699], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[700] = CreateObject(987, 953.7574, 2298.4433, 9.6503, 0.0000, 0.0000, 0.0000); //elecfence_BAR
SetObjectMaterial(g_Object[700], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[700], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
g_Object[701] = CreateObject(987, 941.7575, 2298.4433, 9.6503, 0.0000, 0.0000, 0.0000); //elecfence_BAR
SetObjectMaterial(g_Object[701], 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[701], 2, 4992, "airportdetail", "hedge2", 0xFFFFFFFF);
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
}

#endif


