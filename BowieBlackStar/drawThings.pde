// &&&&&&&&&&&&&&&&&&   draw object   &&&&&&&&&&&&&&&&&&&&

// draw one Pentahedral for a single checkout event
// use the input of checkout times and duration to determine the size

PShape drawCreature(float l, float h, int[] colorRGB) {
  PShape mesh = createShape();
  stroke(colorRGB[0], colorRGB[1], colorRGB[2]);
  //lights();
  
  mesh.beginShape();
  mesh.vertex(h, l/2, l/2); // E
  mesh.vertex(0, 0, l); // B
  mesh.vertex(0, l, l); // C
  mesh.endShape(CLOSE);

  mesh.beginShape();
  mesh.vertex(h, l/2, l/2); // E
  mesh.vertex(0, l, l); // C
  mesh.vertex(0, l, 0); // D
  mesh.endShape(CLOSE);

  mesh.beginShape();
  mesh.vertex(h, l/2, l/2); // E
  mesh.vertex(0, l, 0); // D
  mesh.vertex(0, 0, 0); // A
  mesh.endShape(CLOSE);

  mesh.beginShape();
  mesh.vertex(h, l/2, l/2); // E
  mesh.vertex(0, 0, 0); // A
  mesh.vertex(0, 0, l); // B
  mesh.endShape(CLOSE);

  mesh.beginShape();
  mesh.vertex(0, 0, 0); // A
  mesh.vertex(0, 0, l); // B
  mesh.vertex(0, l, l); // C
  mesh.vertex(0, l, 0); // D
  mesh.endShape(CLOSE);

  return mesh;
}

// &&&&&&&&&&&&&&&&&&   draw point   &&&&&&&&&&&&&&&&&&&&

void drawPoint() {
  fill(255); 
  point(0, 0, 0);
}

// &&&&&&&&&&&&&&&&&&   draw river   &&&&&&&&&&&&&&&&&&&&

void drawRiver(float w, float h, float d) {
  noFill();
  stroke(255);
  strokeWeight(0.5);
  box(w, h, d);
}

// &&&&&&&&&&&&&&&&&&   draw rulerX   &&&&&&&&&&&&&&&&&&&&
// as timeline

void showRulerX() {
  float rulerPositionY, scalePositionX;
  float scaleSizeX;
  rulerPositionY = mouseY;
  scaleSizeX = riverWidth/(numMonths-1);
  stroke(255);
  strokeWeight(0.6);

  // draw horizontal line
  line(0, rulerPositionY, riverWidth, rulerPositionY);

  for (int i=0; i<numMonths; i++) {
    strokeWeight(0.4);
    scalePositionX = scaleSizeX * i;

    // add long scale lines for each year
    if ((i+7)%12 ==0) {
      line(scalePositionX, rulerPositionY+3.5, scalePositionX, rulerPositionY-3.5);

      // add year labels
      textAlign(CENTER, TOP);
      textFont(labelFont1, 14);
      fill(255, 255, 255, 200);
      text(2005+(i+7)/12, scalePositionX, rulerPositionY+5);
    } else {
      // add short scale lines for each month
      line(scalePositionX, rulerPositionY+2, scalePositionX, rulerPositionY-2);
    }
  }
}