#define TRIGGER_PIN PIN_B0
#define END1 PIN_B1
#define END2 PIN_B2
#define AIN1  PIN_D0
#define AIN2  PIN_B7
#define PWMA PIN_B3
#define STBY PIN_D1
#define READY PIN_C7


void setup(){
 pinMode(END1, INPUT); pinMode(END2, INPUT); 
 pinMode(TRIGGER_PIN, INPUT);
 pinMode(AIN1, OUTPUT);
 pinMode(AIN2, OUTPUT);
 pinMode(STBY, OUTPUT);
 pinMode(PWMA, OUTPUT);
 digitalWrite(END1, HIGH);
 digitalWrite(END2, HIGH);
 digitalWrite(TRIGGER_PIN, HIGH);
 digitalWrite(STBY, HIGH);
 digitalWrite(PWMA, HIGH);
 digitalWrite(AIN1, HIGH);
 digitalWrite(AIN2, LOW);
}

int mode=0;

void loop(){
 for(;;){
  switch(mode){
   case 0://initial
     digitalWrite(AIN1, LOW);
     digitalWrite(AIN2, HIGH);
     mode=1;
     break;
   case 1://seeking home
     if(digitalRead(END1)){
       digitalWrite(AIN1, LOW);
       digitalWrite(AIN2, LOW);
       mode=2;
     }
     break;
   case 2://wait for signal
     if(digitalRead(END1))
       digitalWrite(READY,LOW);
     if(digitalRead(END1) && !digitalRead(TRIGGER_PIN)){
       digitalWrite(AIN1, HIGH);
       digitalWrite(AIN2, LOW);
       digitalWrite(READY,HIGH);
       mode=3;
       delay(2000);
     }
     break;
   case 3://go to other end
     if(digitalRead(END2)){
       digitalWrite(AIN1, LOW);
       digitalWrite(AIN2, HIGH);
       mode=1;
     }
     break;
   delay(10);
  } 
 }
}

