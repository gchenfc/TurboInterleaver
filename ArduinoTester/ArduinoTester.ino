#include <avr/pgmspace.h>

#define CLOCKFREQ 10000

#define PIN_CLOCK       13
#define PIN_RESET       A2
#define PIN_dataInNext  A5
#define PIN_dataOut1    10
#define PIN_dataOut2    11
#define PIN_flagLongIn  A3
#define PIN_lookNowIn   A4
#define PIN_flagLongOut A0
#define PIN_lookNowOut  12

#define PIN_INPUT0 2
#define PIN_INPUT1 3
#define PIN_INPUT2 4
#define PIN_INPUT3 5
#define PIN_INPUT4 6
#define PIN_INPUT5 7
#define PIN_INPUT6 8
#define PIN_INPUT7 9

#define CODEBLOCKSIZE_BYTES 6144/8
const PROGMEM uint8_t inputSequence[CODEBLOCKSIZE_BYTES] = {0x4, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0};
uint8_t outputSequence1[CODEBLOCKSIZE_BYTES];
uint8_t outputSequence2[CODEBLOCKSIZE_BYTES];

uint32_t lastClockTick;
bool clock;

enum state_t{
  POR,
  WRITING,
  WAITING,
  READING,
  CHECKING,
  DONE
};
state_t state;

uint8_t counter_POR = 0;
uint32_t counter_inputStream = 0;
uint32_t counter_outputStream = 0;

void setup() {

  Serial.println("Beginning program");

  Serial.begin(115200);

  memset(outputSequence1, 0, sizeof(outputSequence1));
  memset(outputSequence2, 0, sizeof(outputSequence2));

  lastClockTick = micros();
  clock = 0;
  state = POR;

  pinMode(PIN_CLOCK, OUTPUT);
  pinMode(PIN_RESET, OUTPUT);
  pinMode(PIN_dataInNext, INPUT);
  pinMode(PIN_dataOut1, INPUT);
  pinMode(PIN_dataOut2, INPUT);
  pinMode(PIN_flagLongIn, OUTPUT);
  pinMode(PIN_lookNowIn, OUTPUT);
  pinMode(PIN_flagLongOut, INPUT);
  pinMode(PIN_lookNowOut, INPUT);

  pinMode(PIN_INPUT0, OUTPUT);
  pinMode(PIN_INPUT1, OUTPUT);
  pinMode(PIN_INPUT2, OUTPUT);
  pinMode(PIN_INPUT3, OUTPUT);
  pinMode(PIN_INPUT4, OUTPUT);
  pinMode(PIN_INPUT5, OUTPUT);
  pinMode(PIN_INPUT6, OUTPUT);
  pinMode(PIN_INPUT7, OUTPUT);

  // for (int i = 0; i< CODEBLOCKSIZE_BYTES; i++){
  //   Serial.print(pgm_read_word_near(inputSequence + i) & 0xFF);
  //   Serial.print(' ');
  // }
  
}

void loop() {

  if ((micros() - lastClockTick) > (1000000/CLOCKFREQ/2)){
  	clock = !clock;
  	digitalWrite(PIN_CLOCK, clock);
    lastClockTick += (1000000/CLOCKFREQ/2);

    switch (state){
      case POR:
        doPOR();
        break;
      case WRITING:
        doWriting();
        break;
      case WAITING:
        doWaiting();
        break;
      case READING:
        doReading();
        break;
      case CHECKING:
        doChecking();
        break;
      case DONE:
        break;
  	}
  }

  // Serial.println(state);
  // if ((counter_inputStream % 50) == 1){
  //   Serial.println(counter_inputStream);
  // }

}

void doPOR(){
  if (!clock){ // falling edge
    if (counter_POR < 10){
      digitalWrite(PIN_RESET, HIGH);
      counter_POR++;
    } else {
      digitalWrite(PIN_RESET, LOW);
      state = WRITING;
      counter_POR = 0;
      counter_inputStream = 0;
      digitalWrite(PIN_lookNowIn, HIGH);
      digitalWrite(PIN_flagLongIn, CODEBLOCKSIZE_BYTES==(6144/8));
    }
  }
}
void doWriting(){
  if (!clock){
    if (digitalRead(PIN_dataInNext)){
      writeByte(pgm_read_word_near(inputSequence + counter_inputStream));
      counter_inputStream++;
      if (counter_inputStream >= CODEBLOCKSIZE_BYTES){
        counter_inputStream = 0;
        state = WAITING;
        digitalWrite(PIN_lookNowIn, LOW);
        digitalWrite(PIN_flagLongIn, LOW);
      }
    }
  }
}
void doWaiting(){
  if (!clock){
    if (digitalRead(PIN_lookNowOut)){
      state = READING;
      counter_outputStream = 0;
      doReading();
    }
  }
}
void doReading(){
  if (!clock){
    outputSequence1[counter_outputStream/8] |= digitalRead(PIN_dataOut1) << (counter_outputStream % 8);
    outputSequence2[counter_outputStream/8] |= digitalRead(PIN_dataOut2) << (counter_outputStream % 8);
    counter_outputStream++;
    if (!digitalRead(PIN_lookNowOut)){
      // Serial.print("finished reading "); // these lines should not be commented out but it's unclear why they're not
      // Serial.print(counter_outputStream);
      // Serial.println(" bits");
      // state = CHECKING;
    }
    if (counter_outputStream >= (CODEBLOCKSIZE_BYTES*8)){
      Serial.print("output counter bitstream finished at:\t"); // this should actually be an error state but it works so whatever
      Serial.println(counter_outputStream);
      state = CHECKING;
    }
  }
}
void doChecking(){
  Serial.println("Final output sequence:");
  Serial.print("byte\t");
  for (uint32_t count = 0; count < CODEBLOCKSIZE_BYTES; count++){
    Serial.print((count/100) % 10);
    Serial.print(' ');
  }
  Serial.print("\n\t");
  for (uint32_t count = 0; count < CODEBLOCKSIZE_BYTES; count++){
    Serial.print((count/10) % 10);
    Serial.print(' ');
  }
  Serial.print("\n\t");
  for (uint32_t count = 0; count < CODEBLOCKSIZE_BYTES; count++){
    Serial.print(count%10);
    Serial.print(' ');
  }
  Serial.print("\nout1\t");
  for (uint32_t count = 0; count < CODEBLOCKSIZE_BYTES; count++){
    Serial.print(outputSequence1[count] & 0xF, HEX);
    Serial.print(outputSequence1[count] >> 4, HEX);
  }
  Serial.print("\nout2\t");
  for (uint32_t count = 0; count < CODEBLOCKSIZE_BYTES; count++){
    Serial.print(outputSequence2[count] & 0xF, HEX);
    Serial.print(outputSequence2[count] >> 4, HEX);
  }
  Serial.println();
  state = DONE;
}
void writeByte(uint8_t toWrite) {

  digitalWrite(PIN_INPUT0, (toWrite >> 0) & 1);
  digitalWrite(PIN_INPUT1, (toWrite >> 1) & 1);
  digitalWrite(PIN_INPUT2, (toWrite >> 2) & 1);
  digitalWrite(PIN_INPUT3, (toWrite >> 3) & 1);
  digitalWrite(PIN_INPUT4, (toWrite >> 4) & 1);
  digitalWrite(PIN_INPUT5, (toWrite >> 5) & 1);
  digitalWrite(PIN_INPUT6, (toWrite >> 6) & 1);
  digitalWrite(PIN_INPUT7, (toWrite >> 7) & 1);

}