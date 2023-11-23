void setup(){
  size(600,500);
  for(int i=0;i<4;i++){
    for(int j=0;j<6;j++){
      value[i][j]=int(random(40));
    }
  }
}
int [][]value=new int[4][6];
void draw(){
  background(255);
  for(int i=0;i<4;i++){//y
    for(int j=0;j<6;j++){//x
      fill(#F5B4B4); rect(j*100,i*100,100,100);
      fill(0); text(value[i][j],j*100+25,i*100+50);
    }
  }
}
