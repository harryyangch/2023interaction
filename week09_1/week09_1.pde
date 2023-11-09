PImage img;
void setup(){
  size(800,600);
  img=loadImage("keyboard.png");
}
void draw(){
  image(img,0,600-266);
}
