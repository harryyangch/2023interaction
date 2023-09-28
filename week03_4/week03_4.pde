void setup(){
  size(500,500);
  for(int i=0;i<20;i++){
    x[i]=random(500);
    y[i]=random(500);
    dx[i]=random(-1,+1);//dx=random(-1,+1);//亂數往哪裡跑
    dy[i]=random(-1,+1);//dy=random(-1,+1);//亂數往哪裡跑
  }
}
float[]x=new float[20];//float x=250,y=250;
float[]y=new float[20];
float []dx=new float[20];//float dx=1,dy=1;
float []dy=new float[20];
void draw(){
  background(0);
  for(int i=0;i<20;i++){
  ellipse(x[i],y[i],5,5);
  for(int k=0;k<20;k++){
    stroke(255,0,0);
    if(dist(x[i],y[i],x[k],y[k])<100)
      line(x[i],y[i],x[k],y[k]);
  }
  x[i]+=dx[i];
  y[i]+=dy[i];
  if(x[i]<0||x[i]>500)dx[i]=-dx[i];
  if(y[i]<0||y[i]>500)dy[i]=-dy[i];
  }
}
