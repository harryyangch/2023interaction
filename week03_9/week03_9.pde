void setup(){
  size(300,300);
  colorMode(HSB,360,100,100);
}
float h,s,b;
void choose(){
  h=random(360);
  s=random(100);
  b=random(100);
}
void draw(){
  background(203,63,65);
  for(int i=0;i<5;i++){
    for(int j=0;j<5;j++){
      fill(h,s,b);
      ellipse(30+j*60,30+i*60,60,60);
    }
  }
}
