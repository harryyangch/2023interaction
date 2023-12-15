int[][] maze=new int[10][10];
boolean[][]visited=new boolean[10][10];
boolean testVisible(int i,int j){
  if(i<0||j<0||i>=10||j>=10) return true;
  return visited[i][j];
}
int [][] wallH=new int[10][9];
int [][] wallW=new int[9][10];
void genMaze2(int i,int j,int ii,int jj){
  if(i==ii) wallH[i][min(j,jj)]=1;
  if(j==jj) wallW[min(i,ii)][j]=1;
  genMaze(ii,jj);
}

void genMaze(int i,int j){
  if(i==9&&j==9) return;
  visited[i][j]=true;
  println(i,j);
  while(true){
    if(testVisible(i+1,j)==false) {genMaze2(i,j,i+1,j);return;}
    if(testVisible(i-1,j)==false) {genMaze2(i,j,i-1,j);return;}
    if(testVisible(i,j+1)==false) {genMaze2(i,j,i,j+1);return;}
    if(testVisible(i,j-1)==false) {genMaze2(i,j,i,j-1);return;}
    if(testVisible(i+1,j)&&testVisible(i-1,j)&&testVisible(i,j+1)&&testVisible(i,j-1)) break;
  }
}
void setup(){
  size(500,500);
  genMaze(0,0);
  for(int i=0;i<9;i++){
    for(int j=0;j<9;j++){
      print(" "+wallH[i][j]);
    }
    println();
  }
}

void draw(){
  for(int i=0;i<10;i++){
    for(int j=0;j<9;j++){
      if(wallH[i][j]==0) line(50+i*50,j*50,50+i*50,50+j*50);
    }
  }
  for(int i=0;i<9;i++){
    for(int j=0;j<10;j++){
      if(wallW[i][j]==0) line(i*50,50+j*50,50+i*50,50+j*50);
    }
  }

  /*
  for(int i=0;i<10;i++){
    for(int j=0;j<10;j++){
      if(visited[i][j]) fill(125);
      else fill(0);
      rect(j*50,i*50,50,50);
    }
  }*/
}
