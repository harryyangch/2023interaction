void setup(){
  size(400,400);
}
int[][] card=new int[8][11];
color[] C={#FF5555,#FFAA00,#55AA55,#5555FF};
void draw(){
  background(255);
  for(int i=0;i<8;i++){
    for(int j=0;j<11;j++){
      fill(C[i%4]);
      rect(j*32,i*50,32,50);
    }
  }
}
