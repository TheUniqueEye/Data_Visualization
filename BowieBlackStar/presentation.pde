// &&&&&&&&&&&&&&&&&&   presentation mode   &&&&&&&&&&&&&&&&&&&&
void presentation() {
  int totalPhase = 4200;
  int timestamp_title = 40; // 40
  int timestamp_general = 490; // 490
  int timestamp_label = 2900; //2900
  int timestamp_detail = 3500; // 3500
  float eachLabelPhase = 50;
  float eventPhase = 20;
  float detailPhase = 100;
  int cameraSpeed = 10000;
  float cameraPositionX;
  CameraState state;
  Rotation rotn;
  Vector3D npos;
  Vector3D axisY, axisX;
  axisY = new Vector3D(0, 1, 0);
  axisX = new Vector3D(0, 0, 1);



  // &&&&&&&&&&&&&&&&&&   start over    &&&&&&&&&&&&&&&&&&&&
  if (frameCount % totalPhase == 0) {
    cam.reset(1000);
    cam.setDistance(6000, 1000);
    showTitle = false;
  }

  // &&&&&&&&&&&&&&&&&&   title view  &&&&&&&&&&&&&&&&&&&&
  if (frameCount % totalPhase <timestamp_title) {
    ifMotion = false;
    showTitle = true;
    showLabel = false;
    println("frameCount = "+frameCount+"   title");
  }

  // &&&&&&&&&&&&&&&&&&   general view   &&&&&&&&&&&&&&&&&&&&
  if (frameCount % totalPhase == timestamp_title) {
    cam.setDistance(3100, cameraSpeed);
  }

  if (frameCount % totalPhase >=timestamp_title && frameCount % totalPhase <timestamp_general) {
    showTitle = false;
    startRotateX();
    println("rotate");
  }

  // &&&&&&&&&&&&&&&&&&   label view   &&&&&&&&&&&&&&&&&&&&
  if (frameCount % totalPhase == timestamp_general) {
    ifMotion = true;
    cam.setDistance(1600, cameraSpeed);
  }

  if (frameCount % totalPhase >=(timestamp_general+10) && frameCount % totalPhase <timestamp_label) {
    startRotateY();
    showLabel = true;
    // select each title automatically
    float totalLabelPhase = (frameCount - timestamp_general) % (numTitles * eachLabelPhase);
    if ((totalLabelPhase % eachLabelPhase) == (eachLabelPhase-1)) frameIndex ++;
    if (totalLabelPhase == (numTitles * eachLabelPhase -1)) frameIndex = 0;
    println("label");
  }

  // &&&&&&&&&&&&&&&&&&   detail view   &&&&&&&&&&&&&&&&&&&&
  if (frameCount % totalPhase == timestamp_label) {
    cam.setDistance(500, cameraSpeed);
  }
  if (frameCount % totalPhase >=timestamp_label && frameCount % totalPhase <timestamp_detail) {
    showLabel = false;
    if ((frameCount - timestamp_label) % eventPhase ==(eventPhase-1)) {
      fakeMouseX = random(0, 800);
      fakeMouseY = random(0, 600);
      print("fakeMouseX ", fakeMouseX);
      print(" fakeMouseY ", fakeMouseY);
    }
    println("detail");
  }

  // &&&&&&&&&&&&&&&&&&   specific angle   &&&&&&&&&&&&&&&&&&&&
  if (frameCount % totalPhase == timestamp_detail) {
    cameraPositionX = -riverWidth*0.5;
   // cameraPositionX = (frameCount - timestamp_detail) * (riverWidth/(detailPhase));
    npos = new Vector3D(cameraPositionX, 0, 10);
    //cam.rotateY(radians(-85));
    //cam.rotateZ(radians(50));




    rotn = new Rotation(axisY, radians(-85));
    rotn = rotn.applyTo(new Rotation(axisX, radians(50)));
    //RotationOrder rotationOrder = new RotationOrder("XYZ", Vector3D.plusI,Vector3D.plusJ,Vector3D.plusK);
    //rotn = new Rotation(rotationOrder, cam.getRotation[0],cam.getRotations[1],cam.getRotations[2]);
    state = new CameraState(rotn, npos, 0);
    cam.setState(state,2000);

    //cam.lookAt(cameraPositionX, 0, 10, 100, 20000);
  }

  if (frameCount % totalPhase >=timestamp_detail && frameCount % totalPhase <totalPhase) {
    
    float totalLabelPhase = (frameCount - timestamp_detail) % (numTitles * eachLabelPhase);
    if ((totalLabelPhase % eachLabelPhase) == (eachLabelPhase-1)) frameIndex ++;
    if (totalLabelPhase == (numTitles * eachLabelPhase -1)) frameIndex = 0;
    
    
    showLabel = true;
    cameraPositionX = (frameCount - timestamp_detail) * (riverWidth/(detailPhase));
    if ((frameCount - timestamp_detail)%50 == 49) {
      //cam.rotateY(radians(-85));
      //cam.rotateX(radians(130));
      cam.lookAt(cameraPositionX, 0, 10, 100, 32000);
      println("123123");
    }


    //cam.lookAt(cameraPositionX, 0, 10, 100, 2000);
    //npos = new Vector3D(cameraPositionX, 0, 10);
    //rotn = new Rotation(axisY, radians(-85));
    //rotn = rotn.applyTo(new Rotation(axisX, radians(30)));
    //state.setCenter();
    //cam.setState(state);
    println("angle");
  }
}

/*
 if (frameCount % totalPhase == timestamp_detail) {
 cameraPositionX = -riverWidth*0.5;
 npos = new Vector3D(cameraPositionX, 0, 10);
 rotn = new Rotation(axisY, radians(-85));
 rotn = rotn.applyTo(new Rotation(axisX, radians(30)));
 state = new CameraState(rotn, npos, 0);
 cam.setState(state);
 }
 
 if (frameCount % totalPhase >=timestamp_detail && frameCount % totalPhase <totalPhase) {
 showLabel = true;
 cameraPositionX = (frameCount - timestamp_detail) * (riverWidth/detailPhase);
 npos = new Vector3D(cameraPositionX, 0, 10);
 rotn = new Rotation(axisY, radians(-85));
 rotn = rotn.applyTo(new Rotation(axisX, radians(30)));
 state = new CameraState(rotn, npos, 0);
 cam.setState(state);
 println("angle");
 }
 
 */