// &&&&&&&&&&&&&&&&&&   camera rotate   &&&&&&&&&&&&&&&&&&&&

void startRotateX() {
  cam.rotateX(radians(1)*0.8);
}

void startRotateY() {
  cam.rotateY(radians(1)*0.3);
}

// &&&&&&&&&&&&&&&&&&   CP5 event control   &&&&&&&&&&&&&&&&&&&&

void controlEvent(ControlEvent theEvent) {
  
  if (theEvent.isFrom(checkbox)) {
    print("got an event from "+checkbox.getName()+"\t\n");
    println(checkbox.getArrayValue());
    
    if ((int)checkbox.getArrayValue()[0]==1) showLabel = true; 
    else showLabel = false;
    if ((int)checkbox.getArrayValue()[1]==1) startRotate = true;
    else startRotate = false;
    if ((int)checkbox.getArrayValue()[2]==1) ifMotion = true;
    else ifMotion = false;
  }
  
  // println("name = "+theEvent.getController().getName());
  
  if (theEvent.getController().getName().equals("Change View")) {
    int[] distance = {1600, 500, 3100};
    // println("%3 = "+buttonClickCount%3);
    cam.setDistance(distance[buttonClickCount%3]);
    buttonClickCount++;
  }
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