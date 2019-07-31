#include <Wire.h>

const int xPin = A0;
const int yPin = A1;
const int swPin = 8;
const int motorRPin = 10;
const int motorLPin = 11; 

void setup(){
  pinMode(swPin,INPUT);
  Serial.begin(9600);

  Wire.begin();
}

void loop(){
  int xVal = analogRead(xPin);
  int yVal = analogRead(yPin);
  int zVal = digitalRead(swPin);

  Wire.beginTransmission(9);
  Wire.write(zVal);
  Wire.endTransmission();

  Serial.print("X:");
  Serial.print(xVal);
  Serial.print("  Y:");
  Serial.print(yVal);
  Serial.print("  Z:");
  Serial.println(zVal);

  switch(xVal){
    case 0:

      analogWrite(motorRPin, 255);
      delay(20);
      break;
      
    case 1023:
      
      analogWrite(motorLPin, 255);
      delay(20);
      break;
        
    default:
      digitalWrite(motorRPin, LOW);
      digitalWrite(motorLPin, LOW);
      break;
  }

  switch(yVal){
      
    case 0:

      digitalWrite(motorLPin, LOW);
      analogWrite(motorRPin, 255);
      delay(20);
      digitalWrite(motorRPin, LOW);
      analogWrite(motorLPin, 255);
      delay(20);
      break;
      
    default:
      digitalWrite(motorRPin, LOW);
      digitalWrite(motorLPin, LOW);
      break;
  }
  
}
