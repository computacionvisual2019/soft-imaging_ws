// Este codigo corresponde al punto 2 del taller 1:
//    Aplicación de algunas máscaras de convolución.

 
PGraphics dogColorPG, aclaradoPG, blurPG, edgesPG, embossPG; 
PImage colorImg, aclaradoImg, blurImg, edgesImg, embossImg; 


int w, h;
int matrixsize, divisor = 0;
float r, g, b, p;
float [][] sharpen = { { 0, -1, 0 }, 
                     { -1, 5, -1 }, 
                     { 0, -1, 0 } }; 

float [][] blurred = { { 0.0625, 0.125, 0.0625 }, 
                     { 0.125, 0.25, 0.125 }, 
                     { 0.0625, 0.125, 0.0625 } }; 

float [][] edges = { { -1, -1, -1 }, 
                   { -1, 8, -1 }, 
                   { -1, -1, -1 } }; 

float [][] emboss = { { -2, -1, 0 }, 
                    { -1, -1, 1}, 
                    { 0, 1, -2 } }; 

void setup() {
  size(1200, 730);
  colorImg = loadImage("data/colorfull.jpg");
  colorImg.loadPixels();
  w = colorImg.width;
  h = colorImg.height;


  //pasa la imagen a una matriz
  aclaradoImg = loadImage("data/colorfull.jpg");//sharp
  blurImg = loadImage("data/colorfull.jpg");//blurred
  edgesImg = loadImage("data/colorfull.jpg");//edge
  embossImg = loadImage("data/colorfull.jpg");//emboss


  //mascara sharpen
  matrixsize = sharpen.length;
  aclaradoImg.loadPixels();
  for (int x = 0; x < aclaradoImg.width; x++) {
    for (int y = 0; y < aclaradoImg.height; y++) {
      color c = convolucion(x, y, sharpen, matrixsize, aclaradoImg, 1);
      int loc = x + y*aclaradoImg.width;
      aclaradoImg.pixels[loc] = c;
    }
  }
  aclaradoImg.updatePixels();
  
  
  //mascara blurred
  matrixsize = blurred.length;
  blurImg.loadPixels();
  divisor = 1;
  for (int x = 0; x < blurImg.width; x++) {
    for (int y = 0; y < blurImg.height; y++) {
      color c = convolucion(x, y, blurred, matrixsize, blurImg, divisor);
      int loc = x + y*blurImg.width;
      blurImg.pixels[loc] = c;
    }
  }
  blurImg.updatePixels();


  //mascara edges
  matrixsize = edges.length;
  edgesImg.loadPixels();
  divisor = 1;
  for (int x = 0; x < edgesImg.width; x++) {
    for (int y = 0; y < edgesImg.height; y++) {
      color c = convolucion(x, y, edges, matrixsize, edgesImg, divisor);
      int loc = x + y*edgesImg.width;
      edgesImg.pixels[loc] = c;
    }
  }
  edgesImg.updatePixels();
  
  
  //mascara emboss
  matrixsize = emboss.length;
  embossImg.loadPixels();
  divisor = 1;
  for (int x = 0; x < embossImg.width; x++) {
    for (int y = 0; y < embossImg.height; y++) {
      color c = convolucion(x, y, emboss, matrixsize, embossImg, divisor);
      int loc = x + y*embossImg.width;
      embossImg.pixels[loc] = c;
    }
  }
  embossImg.updatePixels();
  
  
  fill(0);
  textSize(23);
  text("Real image", 170, 40);
  dogColorPG = createGraphics(w, h);
  textSize(20);
  text("Convolution mask(Sharp)", 430, 40);
  aclaradoPG = createGraphics(w, h);
  text("Convolution mask(Blur)", 740, 40);
  blurPG = createGraphics(w, h);
  text("Convolution mask(Edges)", 120, 395);
  edgesPG = createGraphics(w, h);
  text("Convolution mask(Emboss)", 420, 395);
  embossPG = createGraphics(w, h);
}

void draw() {
  dogColorPG.beginDraw();
  dogColorPG.image(colorImg, 0, 0);
  dogColorPG.endDraw();
  image(dogColorPG, 100, 50); 


  aclaradoPG.beginDraw();
  aclaradoPG.image(aclaradoImg, 0, 0);
  aclaradoPG.endDraw();
  image(aclaradoPG, 400, 50);


  blurPG.beginDraw();
  blurPG.image(blurImg, 0, 0);
  blurPG.endDraw();
  image(blurPG, 700, 50);


  edgesPG.beginDraw();
  edgesPG.image(edgesImg, 0, 0);
  edgesPG.endDraw();
  image(edgesPG, 100, 400);


  embossPG.beginDraw();
  embossPG.image(embossImg, 0, 0);
  embossPG.endDraw();
  image(embossPG, 400, 400);
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
