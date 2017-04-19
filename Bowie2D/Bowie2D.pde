/* Data Visualization - 2D Matrix (Processing 3)
 Based on Rodger's 2D Matrix Demo  
 
 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 ::::::: How does Dead Rock Star Stay Alive :::::::::::::::::::::::
 ::::::::::::::::::::::::::::::::::::::::::::code: Jing Yan :::::::
 ::::::::::::::::::::theuniqueeye@gmail.com ::::::::::::::::::::::*/
 

// &&&&&&&&&&&&   HEY! here are all the switches   &&&&&&&&&&&&&&&&&&&
// C/c for CD; B/b for Book; T/t for title; N/n for normalization; L/l for label
// you press once to switch on and press again to switch off
// I am sorry there are a lot to remember. 

// ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// Layout variables 
float horizontalMargin = 10;
float verticalMargin = 20;

// 2D matrix table related variables
Table table0, table1, table2;
int numRows, numColumns;
int numBooks, numCDs;
float[][] dataMatrix;
String[] titlePool;
float maxValue, minValue;

// ### NOTE ### Because the checkout times for books are much smaller than the CDs.
// You can only get a general feeling of comparison by using maxValue of both CD and books.
// In order to exaimne more clearly the pattern for Books, I define this variable.
// It's used in normalization of Books' data. Press key N/n to have a try!
float maxValueBook; 

// width and height for each cell
float cellWidth, cellHeight;

// position to draw the square
float positionX, positionY;

// some switches for interaction
boolean showCDs, showBooks, showTitle, showLabel;

// font for different text
PFont titleFont, labelFont1, labelFont2;

// ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

void setup() {

  // setup the size of the window
  size(1080, 720);
  smooth();

  // Load checkout times for both CD and Book
  table0 = loadTable("DB_title.csv", "header");
  table1 = loadTable("CD_CoutMonth.csv", "header");
  table2 = loadTable("BK_CoutMonth.csv", "header");

  // load font
  titleFont = loadFont("Carlito-Bold-72.vlw");
  labelFont1 = loadFont("KohinoorDevanagari-Light-48.vlw");
  labelFont2 = loadFont("WaseemLight-48.vlw");

  // Row: each different item from book and CD
  // Column: every month from 2005/8 to 2015/1
  numColumns = 42; 
  numRows = 114; // 5+9*12+1
  numBooks = 11;
  numCDs = 31;

  showCDs = false;
  showBooks = false;
  showTitle = true;
  showLabel = false;

  dataMatrix = new float[numRows][numColumns];
  titlePool = new String[numColumns];
  println("Rows: " + numRows + " Columns: " + numColumns);

  // ### NOTE ###  titlePool 
  // store every title in titlePool
  for (int i=0; i<numColumns; i++) {
    titlePool[i] = table0.getString(i, 0);
  }

  // Select by title to pick out each related row
  // then get the month and cout values from that row 

  for (int i=0; i<numColumns; i++) {
    for (TableRow row : table1.findRows(titlePool[i], 1)) { 
      String date = row.getString(3);
      int year = Integer.parseInt(date.substring(0, 4));
      int month = Integer.parseInt(date.substring(5, 7));
      int j = (year-2006)*12 + month + 4;
      if (j<=numRows) dataMatrix[j][i] = row.getInt(4);
    }

    for (TableRow row : table2.findRows(titlePool[i], 1)) { 
      String date = row.getString(3);
      int year = Integer.parseInt(date.substring(0, 4));
      int month = Integer.parseInt(date.substring(5, 7));
      int j = (year-2006)*12 + month + 4;
      if (j<=numRows) dataMatrix[j][i] = row.getInt(4);
    }
  }

  //turn the variable into month-format
  //same as the month-format in CD.csv data
  //String month= str(2005+(i+7)/12)+"/"+nf((i+8)%12, 2, 0);

  //### NOTE ### Try to keep the timeline evenly distribute. Not used yet.
  //if (row!=null) { 
  // dataMatrix[i][j] = table1.getFloat(j,i+1) + table2.getFloat(j,i+1);
  //} else {
  // dataMatrix[i][j] = 0;
  //}

  maxValue = max2D(dataMatrix);
  minValue = min2D(dataMatrix);
  maxValueBook = maxValue;

  println("Max Value is " + maxValue);
  println("Min Value is " + minValue);
  pixelDensity(displayDensity());
}

// ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

void draw() {

  //refresh the canvas every frame
  background(0);

  // draw 2D matrix for Books & CDs 
  // show title and 
  if (showCDs == true) showCDs();
  if (showBooks == true) showBooks();
  if (showTitle == true) showTitle();
  if (showLabel == true) showLabel();

  // draw Ruler examine the timeline
  drawRuler();
}