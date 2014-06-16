int pins[] = {0, 2, 4, 6, 10, 22, 1, 3, 5, 9, 23, 11};
int pots[] = {13, 12, 15, 14, 17, 16, 19, 18, 21, 20};

int channel = 1;
int velocity = 96;

const int numInputs = 12;
int currentInput[numInputs];
int lastInput[numInputs];

const int numPots = 10;
int currentValue[numPots];
int lastValue[numPots];

void setup() {
  for (int x=0; x<numInputs; x++)
    pinMode(pins[x], INPUT);
  for (int x=0; x<numPots; x++)
    pinMode(pots[x], INPUT);
}

void loop() {
  for (int x=0; x<12; x++) {
    currentInput[x] = digitalRead(pins[x]);
    if (currentInput[x] == HIGH && lastInput[x] == LOW) usbMIDI.sendNoteOn(48+x, velocity, channel);
    if (currentInput[x] == LOW && lastInput[x] == HIGH) usbMIDI.sendNoteOff(48+x, 0, 1);
    lastInput[x] = currentInput[x];
  }

  for (int x=0; x<10; x++) {
  currentValue[x] = analogRead(pots[x]);
  if ((currentValue[x] > lastValue[x] + 7) || (currentValue[x] < lastValue[x] - 7)) {
    lastValue[x] = currentValue[x];
    currentValue[x] = byte(currentValue[x]/8);
    usbMIDI.sendControlChange(20+x, currentValue[x], 1);
  }
  }
}



