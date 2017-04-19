// &&&&&&&&&&&&&&&&&&   key control   &&&&&&&&&&&&&&&&&&&&
void keyPressed() {
  if (key=='P' || key =='p') 
    println("camera diatance: " + cam.getDistance());
  if (key=='S' || key =='s') selectMode=!selectMode;
  if (key=='M' || key =='m') showMap=!showMap;
  if (key=='R' || key =='r') rotateY=!rotateY;
  if (key=='T' || key =='t') showTitle=!showTitle;
  if (key=='C' || key =='c') colorMode=!colorMode;
  if (key=='1' || key =='1') save=!save;
}

// &&&&&&&&&&&&&&&&&&   ControlP5  &&&&&&&&&&&&&&&&&&&&

void controlEvent(ControlEvent theEvent) {

  if (theEvent.isFrom(checkbox)) {
    print("got an event from "+checkbox.getName()+"\t\n");
    println(checkbox.getArrayValue());

    if ((int)checkbox.getArrayValue()[1]==1) showMap = true; 
    else showMap = false;
    if ((int)checkbox.getArrayValue()[0]==1) rotateY = true;
    else rotateY = false;
    if ((int)checkbox.getArrayValue()[2]==1) colorMode = true;
    else colorMode = false;
  }

  // println("name = "+theEvent.getController().getName());
  /*
  if (theEvent.getController().getName().equals("Change View")) {
    int[] distance = {1600, 500, 3100};
    // println("%3 = "+buttonClickCount%3);
    cam.setDistance(distance[buttonClickCount%3]);
    buttonClickCount++;
  }*/
}

// &&&&&&&&&&&&&&&&&&   CP5 with PeasyCam   &&&&&&&&&&&&&&&&&&&&

void gui() {
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  showFootnote();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}