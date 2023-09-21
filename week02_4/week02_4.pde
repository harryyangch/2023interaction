PImage img,imgBox;
void setup(){
  size(600,600);
  img=loadImage("princess");
  imgBox=loadImage("box.png");
}
void draw(){
  imageMode(CENTER);
  if(nousePressed){
    image(imgBox,mouseX,mouseY);
  }else{
    image(img,300,300,220,300);
  }
}
