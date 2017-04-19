// &&&&&&&&&&&&&&&&&&   draw the space-time cube   &&&&&&&&&&&&&&&&&&&&
void cube(float w, float h, float d) {
  noFill();
  stroke(0);
  strokeWeight(0.5);
  box(w, h, d);
}


// &&&&&&&&&&&&&&&&&&   draw timeline   &&&&&&&&&&&&&&&&&&&&

void timeline() {
  float rulerPositionX, scalePositionY;
  float scaleSizeY;
  rulerPositionX = mouseX;
  scaleSizeY = cubeHeight/(totalDays-1);
  stroke(100);
  strokeWeight(0.6);

  // draw vertical line
  line(rulerPositionX, 0, rulerPositionX, cubeHeight);

  for (int i=0; i<totalDays; i++) {
    strokeWeight(0.4);
    scalePositionY = scaleSizeY * i;

    // add long scale lines for each year
    if ((i+7)%12 ==0) {
      line(rulerPositionX+3.5, scalePositionY, rulerPositionX-3.5, scalePositionY);

      // add year labels
      textAlign(CENTER, TOP);
      textFont(labelFont, 14);
      fill(255, 255, 255, 200);
      text(2005+(i+7)/12, rulerPositionX+5, scalePositionY);
    } else {
      // add short scale lines for each month
      line(rulerPositionX+2, scalePositionY, rulerPositionX-2, scalePositionY);
    }
  }
}

// &&&&&&&&&&&&&&&&&&   show title  &&&&&&&&&&&&&&&&&&&&

void showTitle() {
  smooth();
  pushMatrix();
  textAlign(CENTER, TOP);
  textFont(titleFont, 50);
  fill(0);
  translate(0, 0, cubeDepth/2+10);
  noFill();
  text("Life is Elsewhere", 0, -50);
  //textFont(titleFont2, 15);
  //text("Explore Instagram Data to Examine", 0, 0);
  //text("Temporal Change & Social Contact", 0, 20);
  textFont(titleFont2, 13);
  text("Explore the Instagram Data / to examine the relationship between users' / Temporal Change & Social Contact", 0, 10);
  textFont(labelFont2, 10);
  text("JING YAN", 205, -60);
  textFont(titleFont, 40);

  strokeWeight(1);
  line(-width/2, 30, width/2, 30);
  //rect(-200, -10, 400, 50);
  popMatrix();
}

void showFootnote() {
  smooth();
  textAlign(RIGHT, TOP);
  textFont(labelFont2, 10);
  fill(0);
  text("JING YAN | M259 VISUALIZING INFORMATION", width-10, height-15);
}