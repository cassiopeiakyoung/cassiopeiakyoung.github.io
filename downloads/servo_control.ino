#include <Servo.h>

#include <Wire.h>


Servo servo1;


int servoState;

boolean state = true;      // the current state of the output pin

int reading;           // the current reading from the input pin

int previous = LOW;    // the previous reading from the input pin


// the follow variables are long's because the time, measured in miliseconds,

// will quickly become a bigger number than can be stored in an int.

long time = 0;         // the last time the output pin was toggled

long debounce = 1000;   // the debounce time, increase if the output flickers


void setup(){

  Wire.begin(9);

  Wire.onReceive(receiveEvent);

  

  servo1.attach(9);

  Serial.begin(9600);

}


void receiveEvent(int bytes){

  reading = Wire.read();

}


void loop(){
  if(state == true && reading == LOW && millis() - time > debounce) {
    servoState = 45;
    state = false;
    time = millis();
    }
    else if(state == false && reading == LOW && millis() - time > debounce) {
      servoState = 0;
      state = true;
      time = millis();
      }
   
   servo1.write(servoState);


  Serial.print(reading);

  Serial.print("|");

  Serial.println(servoState);

  
}
