int state=0;//0:white 1:red 2:blue
void setup(){
  size(400,400);
  textSize(50);
}
int x=50,y=50;
void draw(){
  if(state==0){//第0關 白色 
    background(255);
    fill(0); text("Click to start",80,200);
    
  }else if(state==1){//第1關 紅色
    background(255,0,0);
    fill(255); rect(300,50,50,50);
    fill(128); rect(x,y,50,50);
    
  }else if(state==2){//第二關 藍色
    background(0,0,255);
  }
}
void mousePressed(){
  if(state==0) state=1;
}
void keyPressed(){
  if(state==1&&keyCode==RIGHT){
    x+=10;
    if(x==300) state=2;
  }
}
