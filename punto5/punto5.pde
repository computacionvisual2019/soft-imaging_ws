//Este codigo corresponde al punto 5 del taller 1: //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
//    (solo para video) Medición de la eficiencia computacional para las operaciones realizadas.


import processing.video.*;  
Movie colorMovie;
PGraphics colorPG, grayPG, blurredPG, sharpenPG;
PImage grayMovie, blurredMovie, sharpenMovie;


int w, h;
float r, g, b, p;

float [][] blurred = { { 0.0625, 0.125, 0.0625 }, 
                     { 0.125, 0.25, 0.125 }, 
                     { 0.0625, 0.125, 0.0625 } }; 
                     
//float [][] edges = { { -1, -1, -1 }, 
//                   { -1, 8, -1 }, 
//                   { -1, -1, -1 } }; 

float [][] sharpen = { { 0, -1, 0 }, 
                     { -1, 5, -1 }, 
                     { 0, -1, 0 } }; 

//float [][] emboss = { { 0, 1, 0 }, 
//                    { 1, -4, 1}, 
//                    { 0, 1, 2 } }; 
                   

void setup() {
  size(1300, 800);
  //frameRate(10);


  colorMovie = new Movie(this, "demo2.mp4");
  colorMovie.play();  
  w = 640;
  h = 360;


  grayMovie = createImage(w, h, RGB);
  blurredMovie = createImage(w, h, RGB);
  sharpenMovie = createImage(w, h, RGB);


  colorPG = createGraphics(w, h);
  grayPG = createGraphics(w, h);
  blurredPG = createGraphics(w, h);
  sharpenPG = createGraphics(w, h);
}

void draw() {
  colorPG.beginDraw();
  colorPG.image(colorMovie, 0, 0);
  colorPG.endDraw();
  image(colorPG, 0, 0);


  grayPG.beginDraw();
  grayMovie.loadPixels();
  colorMovie.loadPixels();
  grayMovie = toGray(colorMovie, grayMovie);
  grayPG.image(grayMovie, 0, 0);
  grayPG.endDraw();
  image(grayPG, 700, 0);


  blurredPG.beginDraw();
  toBlurr();
  blurredPG.image(blurredMovie, 0, 0);
  blurredPG.endDraw();
  image(blurredPG, 0, h);


  sharpenPG.beginDraw();
  toSharpen();
  sharpenPG.image(sharpenMovie, 0, 0);
  sharpenPG.endDraw();
  image(sharpenPG, 700, h);

  println(frameRate);
}


void movieEvent(Movie m) { 
  m.read();
}


PImage toGray (PImage original, PImage modified) {
  for (int i = 0; i < original.pixels.length; i++) {  
    r = red(original.pixels[i]);
    g = green(original.pixels[i]);
    b = blue(original.pixels[i]);       
    p = (0.2126*r+0.7152*g+0.0722*b);  //  Algoritmo LUMA    
    modified.pixels[i] = color(p, p, p);
    grayMovie.updatePixels();
  }
  return modified;
}


color convolucion(int x, int y, float[][] matrix, int matrixsize, PImage img, int divisor) {
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++) {
    for (int j= 0; j < matrixsize; j++) {
      //ver el pixel que se va a modificar
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      // asegurar que no se sale del margen
      loc = constrain(loc, 0, img.pixels.length-1);
      // aplicar la convolucion del filtro
      rtotal += (red(img.pixels[loc]) * matrix[i][j]) / divisor;
      gtotal += (green(img.pixels[loc]) * matrix[i][j]) / divisor;
      btotal += (blue(img.pixels[loc]) * matrix[i][j]) / divisor;
    }
  }
  // ver que si este en el rango
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}


void toBlurr(){
  blurredMovie = colorMovie.copy();
  int matrixsize = blurred.length;
  blurredMovie.loadPixels();
  int divisor = 1;
  for (int x = 0; x < blurredMovie.width; x++) {
    for (int y = 0; y < blurredMovie.height; y++) {
      color c = convolucion(x, y, blurred, matrixsize, blurredMovie, divisor);
      int loc = x + y*blurredMovie.width;
      blurredMovie.pixels[loc] = c;
    }
  }
  blurredMovie.updatePixels();
}


void toSharpen(){
  sharpenMovie = colorMovie.copy();
  int matrixsize = sharpen.length;
  sharpenMovie.loadPixels();
  for (int x = 0; x < sharpenMovie.width; x++) {
    for (int y = 0; y < sharpenMovie.height; y++) {
      color c = convolucion(x, y, sharpen, matrixsize, sharpenMovie, 1);
      int loc = x + y*sharpenMovie.width;
      sharpenMovie.pixels[loc] = c;
    }
  }
  sharpenMovie.updatePixels();
}
