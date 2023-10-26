void setup(){
  size(400,400);
  background(255);
}
void draw(){
  if(mousePressed) line(mouseX,mouseY,pmouseX,pmouseY);
}
void mouseReleased(){
  background(255);
}
