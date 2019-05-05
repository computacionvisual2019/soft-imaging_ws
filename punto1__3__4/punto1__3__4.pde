// Este codigo corresponde a los puntos 1, 3 y 4 del taller 1:
//    Conversión a escala de grises.
//    (solo para imágenes) Despliegue del histograma.
//    (solo para imágenes) Segmentación de la imagen a partir del histograma.


PGraphics dogColorPG, dogGreyPG, histoPG, dogGreySegPG;
PImage colorImg, greyImg, greySegImg; 


int w, h, mouseX1, mouseY1, mouseX2, mouseY2;
int[] histogram;
float r, g, b, p;


void setup() {
  size(1200, 900);

  colorImg = loadImage("colorfull.jpg");
  colorImg.loadPixels();
  w = colorImg.width;
  h = colorImg.height;

  greyImg = createImage(w, h, RGB);
  greyImg.loadPixels();
  
  greySegImg = createImage(w, h, RGB);
  greySegImg.loadPixels();

  histogram = new int[256];

  for (int i = 0; i < w*h; i++) {  
    r = red(colorImg.pixels[i]);
    g = green(colorImg.pixels[i]);
    b = blue(colorImg.pixels[i]);  
    p = (0.2126*r+0.7152*g+0.0722*b);  //  Algoritmo LUMA                                       
    greyImg.pixels[i] = color(p, p, p);  
    histogram[int(p)] ++ ;
  }

  fill(0);
  textSize(23);
  dogColorPG = createGraphics(w, h);
  text("Real image", 170, 40);
  dogGreyPG = createGraphics(w, h);
  text("Gray scale (LUMA)", 500, 40);
  histoPG = createGraphics(256, 256);
  text("Histogram", 880, 40);
  dogGreySegPG = createGraphics(w, h);
  text("Gray scale (LUMA) Seg", 470, h + 130);
  
}

void draw() {
  dogColorPG.beginDraw();
  dogColorPG.image(colorImg, 0, 0);
  dogColorPG.endDraw();
  image(dogColorPG, 100, 80);
  
  dogGreyPG.beginDraw();
  dogGreyPG.image(greyImg, 0, 0);
  dogGreyPG.endDraw();
  image(dogGreyPG, 150 + greyImg.width , 80);
  
  histoPG.beginDraw();
  histoPG.background(236);
  for (int i = 0; i < 256; i ++) {
    float aux = map(histogram[i], 0, max(histogram), 0, 255);
    if(shadow != 0 && (((mouseX1 <= (200 + 2 * greyImg.width) + i) && ((200 + 2 * greyImg.width) + i <= mouseX2)) || (mouseX1 >= (200 + 2 * greyImg.width) + i) && ((200 + 2 * greyImg.width) + i >= mouseX2))){
      histoPG.stroke(color(0,153,204,50));
    } else {
      histoPG.stroke(0);
    }  
    histoPG.line(i, 254-aux, i, 254);
  }
  histoPG.endDraw();
  image(histoPG, 200 + 2 * greyImg.width , 100);
  
  
  dogGreySegPG.beginDraw();
  if(isOneClick == 1){ 
    greySegImg = createImage(w, h, RGB);
    greySegImg.loadPixels();
    for (int i = 0; i < colorImg.pixels.length; i++) {  
      r = red(colorImg.pixels[i]);
      g = green(colorImg.pixels[i]);
      b = blue(colorImg.pixels[i]);  
      p = int((0.2126*r+0.7152*g+0.0722*b));
      int mouseX1A = (mouseX1 - (200 + 2 * greyImg.width));
      int mouseX2A = (mouseX2 - (200 + 2 * greyImg.width));
      if(((mouseX2A > p) && (p > mouseX1A)) || ((mouseX2A < p) && (p < mouseX1A)) ){
        greySegImg.pixels[i] = color(p, p, p);
      } else {
        greySegImg.pixels[i] = color(255, 255, 255);  
      }  
    }
  } else {
    greySegImg = createImage(w, h, RGB);
    greySegImg.loadPixels();
    for (int i = 0 ; i < colorImg.pixels.length; i++) {  
      r = red(colorImg.pixels[i]);
      g = green(colorImg.pixels[i]);
      b = blue(colorImg.pixels[i]);  
      p = (0.2126*r+0.7152*g+0.0722*b);
      greySegImg.pixels[i] = color(p, p, p);
       
    }
  }
  dogGreySegPG.image(greySegImg, 0, 0);
  dogGreySegPG.endDraw();
  image(dogGreySegPG, 150 + greyImg.width , 160 + greyImg.height);
  
}

int isOneClick = 0;
int shadow = 0;

void mouseMoved() {
  if (isOneClick == 1) {
    mouseX2 = mouseX;
    mouseY2 = mouseY;
    shadow = 200;
  } else {
    shadow = 0;  
  }
}

void mouseClicked() {
  if (isOneClick == 0) {
    isOneClick = 1;
    mouseX1 = mouseX;
    mouseY1 = mouseY;
  } else {
    isOneClick = 0;
  }
}
