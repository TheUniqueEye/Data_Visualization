//Function to get max value from a 2d array
float max2D(float[][] array2D) {
  float max = 0;
  for (int i=0; i<array2D.length; i++) {
    for (int j=0; j<array2D[i].length; j++) {
      if (array2D[i][j] > max) {
        max = array2D[i][j];
      }
    }
  }
  return max;
}

//Function to get min value from a 2d array
float min2D(float[][] array2D) {
  float max = max2D(array2D);
  float min = max;
  for (int i=0; i<array2D.length; i++) {
    for (int j=0; j<array2D[i].length; j++) {
      if (array2D[i][j] < min) {
        min = array2D[i][j];
      }
    }
  }
  return min;
}