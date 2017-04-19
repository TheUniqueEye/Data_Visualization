// &&&&&&&&&&&&&&&&&&   show label   &&&&&&&&&&&&&&&&&&&&
// showing labelY and make labelY's color interact with the mouse move
// blue for CD, and red for book

void showLabel() {
  for (int i=0; i<numTitles; i++) {
    textAlign(RIGHT, TOP);
    textFont(labelFont2, 15);
    float positionY = i * cellHeight;
    boolean mouseYIn = mouseY<(positionY+cellHeight/2) && mouseY>(positionY-cellHeight/2);
    if (mouseYIn && (titlePool[i][0].equals("acbk"))) fill(255, 0, 0);
    else if (mouseYIn && (titlePool[i][0].equals("accd"))) fill(0, 245, 255);
    else fill(255);
    text(titlePool[i][1], -10, positionY-5);
  }
}

// &&&&&&&&&&&&&&&&&&   show title  &&&&&&&&&&&&&&&&&&&&

void showTitle() {
  textAlign(CENTER, TOP);
  textFont(titleFont, 40);
  fill(255, 255, 255);
  text("H O W  D O E S  D E A D  R O C K  S T A R  S T A Y  A L I V E", riverWidth/2, riverHeight/2-20);
  fill(255, 255, 255, 100);
  textFont(titleFont, 32);
  text("| DAVID BOWIE's CD and Book Checkout Events per Month |", riverWidth/2, riverHeight/2+25);
  textFont(labelFont1, 20);
  fill(255, 255, 255);
  text("JING YAN", riverWidth/2+440, riverHeight/2-50);
  textFont(titleFont, 40);
  text(":", riverWidth/2-433, riverHeight/2+18);
}

void showFootnote(){
  textAlign(RIGHT, TOP);
  textFont(footnoteFont, 8);
  fill(255);
  text("JING YAN | M259 VISUALIZING INFORMATION", width-10, height-15);
}