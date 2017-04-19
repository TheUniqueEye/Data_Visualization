/* 2016-2-15 
 Data Visualization Proj3. - 3D Event River (Processing 3)
 Based on Bowie_2D Matrix
 
 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 ::::::: How does Dead Rock Star Stay Alive :::::::::::::::::::::::
 ::::::::::::::::::::::::::::::::::::::::::::code: Jing Yan :::::::
 ::::::::::::::::::::theuniqueeye@gmail.com ::::::::::::::::::::::*/

/*
 Required Libraries: -> Accessible from Processing Import Library
 1. Peasy Cam 
 2. Control P5 
 3. Minim 
 
 Usage: 1. A mouse left-drag will rotate the camera around the subject.
 2. A right drag will zoom in and out. 
 3. A middle-drag (command-left-drag on mac) will pan. 
 4. A double-click restores the camera to its original position. 
 5. The shift key constrains rotation and panning to one axis or the other.
 
 Interaction key: (could use screen interaction instead)
 D/d for data, T/t for title, L/l for label, R/r for rotate camera, M/m for creature motion, 
 change perspective: 1 for close view, 2 for middle view, 3 for far away view
 
 */


// PeasyCam for 3D
import peasy.*;
PeasyCam cam;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

// CP5 for interaction
import controlP5.*;
ControlP5 cp5;
CheckBox checkbox;

// music display
import ddf.minim.*;


// Data variables
Table table0, table;
String titlePool[][];
int titleIndex[];
int numRows, numTitles, numDays, numMonths;
float minCoutTimes, maxCoutTimes;
float minCoutDuration, maxCoutDuration;

// ArrayList for storing the checkout events
ArrayList<Event> events = new ArrayList<Event>();

// Layout variables 
float riverWidth = 2000;
float riverHeight = 1000;
float riverDepth = 600;
float cellWidth, cellHeight, cellDepth;
float positionX, positionY, positionZ;
int[] colorCreature; 
PShape[] totalObjects2D; 
PShape[] meshes;

// Font
PFont titleFont, labelFont1, labelFont2, footnoteFont;

// Switches for interaction
boolean presentationMode;
boolean drawData, showTitle, showLabel, startRotate, ifMotion;
boolean mouseXIn, mouseYIn,fakeMouseIn;
String mouseDate, mouseTitle;
int mouseCoutTimes, mouseCoutDuration;
int buttonClickCount;
float mouseOnScale, translateScale, rotateScale;
float mouseObjectDistance;
float fakeMouseY, fakeMouseX;
float frameIndex = 0;


// Music display
int frameMarks[] = new int[2]; // frameMarks[0] store position, frameMarks[1] count frame 
AudioPlayer player;   
Minim minim = new Minim(this);  


// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

void setup() {

  fullScreen(P3D, SPAN);
  //size(1200, 900, P3D);
  cursor(CROSS); // change mouse to cross
  smooth();

  // move camera to 6000 pixels in front of the objects
  cam = new PeasyCam(this, 6000);

  // &&&&&&&&&&&&&&&&&&   Load data   &&&&&&&&&&&&&&&&&&&&

  // titles
  table0 = loadTable("BKCD_typeTitlePublish.csv", "header");
  numTitles = table0.getRowCount();
  println("Titles: " + numTitles);

  // checkout events
  table = loadTable("DayCoutBKCD.csv", "header");
  numRows = table.getRowCount();
  println("Rows: " + numRows);

  // from 2005/08 to 2016/01
  numMonths = 126; // 5+10*12+1 
  numDays = 3780; // 30Day*126Month 

  // min, max of checkout times/duration
  minCoutTimes = 1;
  maxCoutTimes = 219;
  minCoutDuration = 0;
  maxCoutDuration = 1074;

  titlePool = new String[numTitles][2]; 
  titleIndex = new int[numTitles]; // titleIndex[index]

  // ### titlePool[type][title] ###
  for (int i=0; i<numTitles; i++) {
    titlePool[i][1] = table0.getString(i, 1);
    titlePool[i][0] = table0.getString(i, 0);
    //println("<" + titlePool[i] + ">");
    //println("<" + titleIndex[i] + ">");
  }

  // ### event class ### 
  // 6 attributes: type,title,date,coutTimes,coutDuration,index
  for (int i=0; i<numRows; i++) {
    String type = table.getString(i, 0);
    String title = table.getString(i, 1);
    String date = table.getString(i, 2);
    int coutTimes = table.getInt(i, 3);
    int coutDuration = table.getInt(i, 4);
    int index = 0;

    // match the event index with the title from the titlePool
    for (int j=0; j<numTitles; j++) {
      if (title.equals(titlePool[j][1])) {
        index = j;
      }
    }

    // put data into the new event-class in same order
    // put new event-class into events-arraylist
    events.add(new Event(type, title, date, coutTimes, coutDuration, index));
  }
  println("Number of events: " + events.size());


  // &&&&&&&&&&&&&&&&&&   setting for display   &&&&&&&&&&&&&&&&&&&&

  presentationMode = true;
  drawData = true;
  showTitle = true;
  showLabel = false;
  startRotate = false;
  ifMotion = true;

  // cell setting
  cellWidth = riverWidth/(numDays-1);
  cellHeight = riverHeight/(numTitles-1);  

  // load font
  titleFont = loadFont("Carlito-Bold-100.vlw");
  labelFont1 = loadFont("KohinoorDevanagari-Light-48.vlw");
  labelFont2 = loadFont("Verdana-Bold-48.vlw");
  footnoteFont = createFont("stan0758.ttf", 15);

  // draw total objects
  // setup the model for once
  totalObjects2D = createObjects();  

  // &&&&&&&&&&&&&&&&&&   setting for interaction cp5   &&&&&&&&&&&&&&&&&&&&

  buttonClickCount = 0;
  cp5 = new ControlP5(this);

  // check box
  checkbox = cp5.addCheckBox("checkBox")
    .setPosition(10, 10)
    .setColorForeground(color(180))
    .setColorBackground(color(80))
    .setColorActive(color(255))
    .setColorLabel(color(200))
    .setSize(10, 10)
    .setItemsPerRow(1)
    .setSpacingColumn(20)
    .setSpacingRow(15)
    .addItem("Label", 0)
    .addItem("Rotate", 50)
    .addItem("Motion", 100)
    ;

  // button
  cp5.addButton("Change View")
    .setPosition(10, 85)
    .setSize(55, 10)
    .setColorForeground(color(180))
    .setColorBackground(color(80))
    .setColorActive(color(255))
    ;

  // display with PeasyCam
  cp5.setAutoDraw(false);  // prevent auto draw
}

// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

void draw() {

  // set background color
  background(0);

  // draw River box
  drawRiver(riverWidth, riverHeight, riverDepth);

  // draw Data
  if (drawData == true) drawData(totalObjects2D);

  // show rulerX, labels
  pushMatrix();
  translate(-riverWidth/2, -riverHeight/2, 0);
  if (showLabel == true) showRulerX();
  if (showLabel == true) showLabel();
  popMatrix();

  // show title
  pushMatrix();
  translate(-riverWidth/2, -riverHeight/2, 5000);
  if (showTitle == true) showTitle();
  popMatrix();

  // rotate
  if (startRotate == true) startRotateX();

  // cP5 with Peasy
  gui();

  // &&&&&&&&&&&&&&&&&&   presentation mode   &&&&&&&&&&&&&&&&&&&&
  if (presentationMode == true) {
    presentation();
    //println(presentationMode);
  }

  // show camera's distance
  //println("distance  = "+cam.getDistance());
  println("frameCount  " + frameCount);
  //println("camPosition  " + cam.getPosition()[0]+"  "+cam.getPosition()[1]+"  "+cam.getPosition()[2]);


  // &&&&&&&&&&&&&&&&&&   setting for interaction cp5   &&&&&&&&&&&&&&&&&&&&
  // saveFrame to make an animation
  //saveFrame("line-######.png");
}