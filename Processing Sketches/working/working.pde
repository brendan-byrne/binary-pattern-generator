import promidi.*;
MidiIO midiIO;

int x = -128/20;
int y = 0;
int z;

boolean clock = false;
boolean data = false;
boolean half = false;
boolean doubleHalf = false;
boolean tripleHalf = false;

void setup() {
  size(128*6, 128*6);
  smooth();
  background(0);
  midiIO = MidiIO.getInstance(this);
  midiIO.printDevices();
  midiIO.plug(this, "noteOn", 11, 0);
  midiIO.plug(this, "noteOff", 11, 0);
  midiIO.plug(this, "controllerIn", 11, 0);
}

void draw() {
}

void noteOn(Note note) {
  int vel = note.getVelocity();
  int pit = note.getPitch();
  if (pit == 48 && vel == 96) data = !data;
  if (pit == 49 && vel == 96) clock = !clock; 
  if (pit == 50 && vel == 96) half = !half;
  if (pit == 51 && vel == 96) doubleHalf = !doubleHalf;
  if (pit == 52 && vel == 96) doubleHalf = !doubleHalf;
  
  if (clock == true) {
    x+=128/20;
    z = 64;
    if (data == true) {
      if (half == true) {
        z-=64/4;
      }
      if (doubleHalf == true) {
        z-=64/4;
      }
      if (tripleHalf == true) {
        z-=64/4;
      }
    rect(x, y, 128/20, z);
    }
  }
  
  if (x >= 128*6) {
    x = -10;
    y+=128/2;
    if (y == 128*6) {
      fill(0);
      rect(0, 0, 128*6, 128*6);
      fill(255);
      y = 0;
    }
  }  
}

void noteOff(Note note) {
  int pit = note.getPitch();
}

void controllerIn(Controller controller) {
  int num = controller.getNumber();
  int val = controller.getValue();

  fill(255, num*2, val*2, num*2);
  stroke(255, num);
  ellipse(num*5, val*5, 30, 30);
}

void programChange(ProgramChange programChange) {
  int num = programChange.getNumber();

  fill(255, num*2, num*2, num*2);
  stroke(255, num);
  ellipse(num*5, num*5, 30, 30);
}

