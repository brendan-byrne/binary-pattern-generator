import promidi.*;
MidiIO midiIO;

int x = -128/20;
int y = 0;
int z;
int wideness;
int t = 128;

boolean clock = false;
boolean data = false;
boolean half = false;
boolean doubleHalf = false;
boolean tripleHalf = false;

void setup() {
  size(128*6, 128*6);
  smooth();
  background(0);
  frameRate(10000000);
  midiIO = MidiIO.getInstance(this);
  midiIO.printDevices();
  midiIO.plug(this, "noteOn", 11, 0);
  midiIO.plug(this, "noteOff", 11, 0);
  midiIO.plug(this, "controllerIn", 11, 0);
}

void draw() {
  if (clock == true) {
    x+=wideness;
    z = t;
    if (data == true) {
      if (half == true) {
        z-=t/4;
      }
      if (doubleHalf == true) {
        z-=t/4;
      }
      if (tripleHalf == true) {
        z-=t/4;
      }
    rect(x, y, wideness, z);
    }
  }
  
  if (x >= 128*6) {
    x = -wideness;
    y+=t;
    if (y >= 128*6) {
      fill(0);
      rect(0, 0, 128*6, 128*6);
      fill(255);
      y = 0;
    }
  }
}

void noteOn(Note note) {
  int vel = note.getVelocity();
  int pit = note.getPitch();
  if (pit == 48 && vel == 96) data = true;
  if (pit == 49 && vel == 96) clock = true; 
  if (pit == 50 && vel == 96) half = true;
  if (pit == 51 && vel == 96) doubleHalf = true;
  if (pit == 52 && vel == 96) tripleHalf = true;
  
  if (pit == 48 && vel == 0) data = false;
  if (pit == 49 && vel == 0) clock = false; 
  if (pit == 50 && vel == 0) half = false;
  if (pit == 51 && vel == 0) doubleHalf = false;
  if (pit == 52 && vel == 0) tripleHalf = false;
  
 
  

}

void noteOff(Note note) {
  int pit = note.getPitch();

}

void controllerIn(Controller controller) {
  int num = controller.getNumber();
  int val = controller.getValue();
  if (num == 20) {
    wideness = val;
  }
    if (num == 21) {
    t = val;
  }
}

void programChange(ProgramChange programChange) {
  int num = programChange.getNumber();

  fill(255, num*2, num*2, num*2);
  stroke(255, num);
  ellipse(num*5, num*5, 30, 30);
}

