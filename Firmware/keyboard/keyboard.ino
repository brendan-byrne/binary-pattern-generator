int pins[] = {
  0, 2, 4, 6, 10, 22, 1, 3, 5, 9, 23, 11};

const int numInputs = 12;
int currentInput[numInputs];
int lastInput[numInputs];

char keyArray[] = {
  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l'};

void setup() {
  for (int x=0; x<numInputs; x++) 
    pinMode(pins[x], INPUT);
}

void loop() {
  for (int x=0; x<12; x++) {
    currentInput[x] = digitalRead(pins[x]);
    if (currentInput[x] != lastInput[x]) {
      if (currentInput[x] == HIGH) Keyboard.print(keyArray[x]);
      lastInput[x] = currentInput[x];
    }
  }
}




