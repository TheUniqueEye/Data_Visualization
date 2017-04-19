// Let's draw a ruler as timeline!
// It will keep follow your mouse move.

void drawRuler() {
  stroke(255);

  float rulerPositionY, scalePositionX;
  float scaleSize;
  rulerPositionY = mouseY;
  scaleSize = (width - 2 * horizontalMargin)/(numRows - 1);

  // draw a horizontal line first
  strokeWeight(0.6);
  line(0, rulerPositionY, width, rulerPositionY);

  for (int i=0; i<numRows; i++) {
    strokeWeight(0.4);
    scalePositionX = horizontalMargin + scaleSize * i;

    // add long scale lines for each year
    if ((i+7)%12 ==0) {
      line(scalePositionX, rulerPositionY+3.5, scalePositionX, rulerPositionY-3.5);

      // add year labels
      textAlign(CENTER, TOP);
      textFont(labelFont1, 8);
      fill(255, 255, 255, 80);
      text(2005+(i+7)/12, scalePositionX, rulerPositionY+5);
    } else {
      // add short scale lines for each month
      line(scalePositionX, rulerPositionY+2, scalePositionX, rulerPositionY-2);
    }
  }
}