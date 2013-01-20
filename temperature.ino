# Author @nonNoise
# See the http://kitagami.org/Study/Arduinopy20130120/20130120.html
#include "string.h"

// the setup routine runs once when you press reset:
void setup() {
  Serial.begin(115200);
}

#define _Read_MAX_CHAR_ 50
// the loop routine runs over and over again forever:
void loop() {
  int tmp = 0;
  int strlen;
  int AD;
  //strlen = Arduino_py_Command(Cbuf);

  double sensorVal;
  double temp = 0;
  double offset = 0.40; //オフセット(V)
  double tc = 19.53; //温度係数(mV)
  temp = 0;
  for(int i=0;i<1000;i++) {
    AD = analogRead(0);
    temp += (( 4.8 / 1024 * AD ) - offset ) / ( tc / 1000 );
  }

  Serial.println(temp/1000);

  delay(500);

}
