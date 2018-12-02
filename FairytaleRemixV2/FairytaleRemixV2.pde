import controlP5.*;

//Interactive storytelling
//Programmed by Tyler Tran
//Fairytale Remix
//Tyler T, Joren A, Mark Z, Noah C.

ControlP5 cp5;

//vars
boolean startText = true;

//line
int start;
int end;
int lineY;

//button
float buttonDia = 100;
int bx;
int by;

//progress 
float progress; //where the circle starts

float increment; //har far the circle goes

int numNeeded = 20; //the goal
float lengthLine; //length of the bar

//text box stuff
ArrayList <String> messages = new ArrayList <String>();
boolean sent = false;
String prompt = "What do you want the environment to be like?";


void setup() {
  size(1600, 900);

  setupVars();
  cp5();
}

void setupVars() { //setting up variables
  //the progress line coords
  start = width/8; 
  end = width - width/8;
  lineY = height/2;

  //button
  buttonDia = 100;
  bx= width - width/8;
  by = height - height/8;

  progress = start; //progress starts at the start 

  lengthLine = end - start; //find the length of the line

  increment = lengthLine/numNeeded; //increment the progress based on the length of line and the goal
}

void cp5() {
  cp5 = new ControlP5(this);
  cp5.addTextfield(prompt).setPosition(width/8, height/8).setSize(width - ((width/8)*2), 100).setAutoClear(false).setFont(createFont("arial", 50));
}

//----------------------------------------------------------------------------------------------------------

void draw() {
  background(0); 

  progressBar(); //progress bar
  progressCircle(); //draw the progress circle

  displayText();

  button();
}

//----------------------------------------------------------------------------------------------------------

void mouseClicked() { //press the button to continue
  if (dist(mouseX, mouseY, bx, by) < buttonDia/2) { //If mouse touching button
    if (mouseButton == LEFT) { //if mouseclicked
      submit();
      if (sent == true){
        progress+=increment;
      }
    }
  }
}

//----------------------------------------------------------------------------------------------------------

void progressBar() { //just the line
  stroke(255);
  line(start, lineY, end, lineY);
}

void progressCircle() { //progress circle
  fill(255);
  ellipse(progress, lineY, 50, 50);
}

void button() {
  if (dist(mouseX, mouseY, bx, by) < buttonDia/2) {
    buttonDia = 150;
  } else {
    buttonDia = 100;
  }

  fill(255);
  ellipse(bx, by, buttonDia, buttonDia);
}

void displayText() { //display the text on the screen 
 // if (sent == true) {
    for (int i = 0; i < messages.size(); i++) { //get messages
      fill(255); //white
      text(messages.get(i), 100, 100 + (i*20)); //display message
    }
 // }
}

void submit() {
  if (cp5.get(Textfield.class, prompt).getText().equals("")) {
    sent = false;
  } else {
    messages.add(cp5.get(Textfield.class, prompt).getText());
    sent = true;
  }
}

//----------------------------------------------------------------------------------------------------------
