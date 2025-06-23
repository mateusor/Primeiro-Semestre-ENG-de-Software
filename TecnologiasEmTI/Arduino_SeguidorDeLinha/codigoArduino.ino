
#include <Servo.h>

#define PINO_SENSOR_ESQ A4
#define PINO_SENSOR_DIR A5

#define PINO_SERVO_ESQ 6
#define PINO_SERVO_DIR 5

#define LIMIAR_PRETO 690

#define VEL_MAXIMA 180
#define VEL_MINIMA 0
#define VEL_PARADO 90

Servo motorEsquerdo;
Servo motorDireito;

void setup() {
  motorEsquerdo.attach(PINO_SERVO_ESQ);
  motorDireito.attach(PINO_SERVO_DIR);
  pararMovimento();
  Serial.begin(9600);
  delay(1000);
}

void loop() {
  int leituraEsq = analogRead(PINO_SENSOR_ESQ);
  int leituraDir = analogRead(PINO_SENSOR_DIR);

  Serial.print("Sensor ESQ: ");
  Serial.print(leituraEsq);
  Serial.print(" | Sensor DIR: ");
  Serial.println(leituraDir);

  if (leituraEsq < LIMIAR_PRETO && leituraDir < LIMIAR_PRETO) {
    seguirReto();
  } 
  else if (leituraEsq < LIMIAR_PRETO && leituraDir >= LIMIAR_PRETO) {
    virarParaDireita();
  } 
  else if (leituraEsq >= LIMIAR_PRETO && leituraDir < LIMIAR_PRETO) {
    virarParaEsquerda();
  } 
  else {
    pararMovimento();
  }

  delay(20);
}

void seguirReto() {
  motorEsquerdo.write(VEL_MAXIMA);
  motorDireito.write(VEL_MINIMA);
}

void virarParaDireita() {
  motorEsquerdo.write(VEL_MAXIMA);
  motorDireito.write(VEL_PARADO);
}

void virarParaEsquerda() {
  motorEsquerdo.write(VEL_PARADO);
  motorDireito.write(VEL_MINIMA);
}

void pararMovimento() {
  motorEsquerdo.write(VEL_PARADO);
  motorDireito.write(VEL_PARADO);
}
