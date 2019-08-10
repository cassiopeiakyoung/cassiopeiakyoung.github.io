/* Welcome to the MarkerBot autonomous base code!
 * If you're here, that means you've downloaded this file from my website and plan to program MarkerBot 2000 to drive on its own. 
 * 
 * If you're a more experienced coder, feel free to skip the tutorial and start writing code - just make sure to write your code in 
 * int main(), or you might mess something up. (If you're feeling REALLY confident, disregard that and just do whatever.) 
 * 
 * If you're less experienced or just starting out at coding, there are a couple things you need to learn. I am not a teacher in any
 * way, so I recommend visiting websites like w3schools.com and reading the C++ tutorials. The Arduino website is also a great resource
 * for reference for many Arduino built-in functions. Arduino is a language based heavily off C++, so many things you learn on w3schools 
 * can be applied here. What you need to know are how to use functions and the built-in delay() function. I've written a few functions
 * to be used with MarkerBot: 
 * 
 * bothMotorsRun()
 * rightMotorRun()
 * leftMotorRun()
 * bothMotorsStop()
 * penUp()
 * penDown()
 * 
 * Each of these function's names are relatively self-explanatory. You can use the functions in combination with the delay() function to
 * command MarkerBot to start one action and wait before starting the next. An example would be:
 * 
   int main(){

      bothMotorsRun();
      delay(1000);
      bothMotorsStop();
      penDown();

      return 0;
  
    }
 *  
 *  This function commands MarkerBot to start both motors, wait 1 second (the delay function takes time in milliseconds), then stop the motors
 *  and move the pen down. Feel free to experiment and come up with something new!
 *  
 */

#include "Arduino.h"
#include <Wire.h>

const int xPin = A0;
const int yPin = A1;
const int swPin = 8;
const int motorRPin = 10;
const int motorLPin = 11;

void setup() {
  Wire.begin();

  digitalWrite(swPin, HIGH);
  
  pinMode(swPin, INPUT);
  pinMode(motorRPin, OUTPUT);
  pinMode(motorLPin, OUTPUT);
  
  Serial.begin(9600);
}

void loop() {

  int xVal = analogRead(xPin);
  int yVal = analogRead(yPin);
  int zVal = digitalRead(swPin);

  Wire.beginTransmission(9);
  Wire.write(zVal);
  Wire.endTransmission();

  main();

}

int main(){

  bothMotorsRun();
  delay(1000);
  bothMotorsStop();
  penDown();

  return 0;
  
}

void penDown(){
  Wire.beginTransmission(9);
  Wire.write(0);
  Wire.endTransmission();
}

void penUp(){
  Wire.beginTransmission(9);
  Wire.write(1);
  Wire.endTransmission();
}

void leftMotorRun(){
  analogWrite(motorLPin, 255);
  digitalWrite(motorRPin, LOW);
}

void rightMotorRun(){
  analogWrite(motorRPin, 255);
  digitalWrite(motorLPin, LOW);
}

void bothMotorsRun(){
  analogWrite(motorRPin, 255);
  analogWrite(motorLPin, 255);
}

void bothMotorsStop(){
  digitalWrite(motorRPin, LOW);
  digitalWrite(motorLPin, LOW);
}
