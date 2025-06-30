#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
    b_Vehicle[0] = AddStaticVehicleEx(403, -1581.7670, 122.6043, 4.1414, 227.6672, 0, 0, 180); //Linerunner
    b_Vehicle[1] = AddStaticVehicleEx(403, -1578.0797, 126.4924, 4.1603, 226.4326, 0, 0, 180); //Linerunner
    b_Vehicle[2] = AddStaticVehicleEx(543, -1515.3192, 150.1043, 3.3918, 313.2837, 0, 0, 180); //Sadler
    b_Vehicle[3] = AddStaticVehicleEx(403, -1585.9954, 118.5116, 4.1576, 226.4662, 0, 0, 180); //Linerunner
    b_Vehicle[4] = AddStaticVehicleEx(422, -1527.4829, 163.1116, 3.4861, 313.8506, 0, 0, 180); //Bobcat
    b_Vehicle[5] = AddStaticVehicleEx(422, -1524.6824, 160.1540, 3.4863, 313.0188, 0, 0, 180); //Bobcat
    b_Vehicle[6] = AddStaticVehicleEx(422, -1521.8432, 157.2636, 3.5448, 313.1865, 0, 0, 180); //Bobcat
    b_Vehicle[7] = AddStaticVehicleEx(543, -1518.5523, 153.7229, 3.3598, 313.0597, 0, 0, 180); //Sadler
    b_Vehicle[8] = AddStaticVehicleEx(543, -1512.2877, 146.6811, 3.3598, 313.6118, 0, 0, 180); //Sadler
    b_Vehicle[9] = AddStaticVehicleEx(609, -1589.6096, 112.9612, 3.6181, 226.5939, 0, 0, 180); //Boxville
    b_Vehicle[10] = AddStaticVehicleEx(563, -1568.6867, 61.0861, 18.0348, 341.1049, 0, 0, 180); //Raindance
    b_Vehicle[11] = AddStaticVehicleEx(609, -1597.9790, 104.6190, 3.6178, 227.0103, 0, 0, 180); //Boxville
    b_Vehicle[12] = AddStaticVehicleEx(609, -1593.9066, 108.6700, 3.6178, 226.5214, 0, 0, 180); //Boxville
    b_Vehicle[13] = AddStaticVehicleEx(549, -1534.1280, 156.9143, 3.2523, 313.1048, 0, 0, 180); //Tampa
    b_Vehicle[14] = AddStaticVehicleEx(549, -1518.4675, 140.7695, 3.2519, 313.4613, 0, 0, 180); //Tampa
    b_Vehicle[15] = AddStaticVehicleEx(514, -1603.3988, 100.8300, 4.1378, 225.6806, 0, 0, 180); //Tanker
    b_Vehicle[16] = AddStaticVehicleEx(515, -1607.8698, 96.6133, 4.5733, 225.5127, 0, 0, 180); //RoadTrain
    b_Vehicle[17] = AddStaticVehicleEx(515, -1613.4554, 90.8914, 4.5732, 224.9090, 0, 0, 180); //RoadTrain
    b_Vehicle[18] = AddStaticVehicleEx(576, -1541.4508, 116.7160, 3.1634, 135.3062, 0, 0, 180); //Tornado

    return 1;
}