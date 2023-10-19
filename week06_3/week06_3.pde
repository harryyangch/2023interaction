void setup(){
  size(800,500);
  textSize(64);
}
String line="Input: ";
void draw(){
  text(line,100,100);
}
void keyPressed(){
  if(key>='A'&& key<='Z') line+=key;
  if(key>='a'&& key<='z') line+=key;
}
