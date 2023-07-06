#aircraft.livery.init("Aircraft/L-39ZA/Models/Liveries");

if(getprop("/sim/variant-id")==1) {
    aircraft.livery.init("Aircraft/L-39/Models/Liveries/L-39C");
    print("L-39C Liveries slected ");
}
else {
    aircraft.livery.init("Aircraft/L-39/Models/Liveries/L-39ZA");
    print("L-39ZA Liveries slected ");
}

