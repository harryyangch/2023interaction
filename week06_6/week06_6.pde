import processing.sound.*;

SoundFile dadada,good,over;
void setup(){
  size(300,300);
  dadada=new SoundFile(this,"dadada.mp3");
  good=new SoundFile(this,"good.mp3");
  over=new SoundFile(this,"over.mp3");
}
void draw(){
  text("press 1,2,3",100,100);
}
void keyPressed(){
  if(key=='1') dadada.play();
  if(key=='2') good.play();
  if(key=='3') over.play();
}
