int [][] maze = new int[50][50];
boolean [][] visited = new boolean[50][50];
boolean [][] isEnd = new boolean[50][50]; // 新增終點標記
int endI, endJ; // 終點的位置
int userI=0, userJ=0;
boolean gameFinished = false; // 遊戲是否結束的標記
boolean testVisible(int i, int j){ //true: nothing
  if(i<0 || j<0 || i>=50 || j>=50) return true;
  return visited[i][j]; //false 要用它 doing something
}
int [][] wallH = new int[50][49];
int [][] wallW = new int[49][50];
void genMaze2(int i, int j, int ii, int jj){
  if(i==ii) wallH[i][min(j,jj)] = 1;
  if(j==jj) wallW[min(i,ii)][j] = 1;
  genMaze(ii,jj);
}
void genMaze(int i, int j){
  //if(i==9&&j==9) return;
  visited[i][j] = true;
  println(i,j);
  while(true){
    if(testVisible(i+1, j)==false && int(random(2))==0) {genMaze2(i,j,i+1,j);}
    if(testVisible(i-1, j)==false && int(random(2))==0) {genMaze2(i,j,i-1,j);}
    if(testVisible(i, j+1)==false && int(random(2))==0) {genMaze2(i,j,i,j+1);}
    if(testVisible(i, j-1)==false && int(random(2))==0) {genMaze2(i,j,i,j-1);}
    if(testVisible(i+1, j) && testVisible(i-1, j) && testVisible(i,j+1) && testVisible(i,j-1)) break;
  }
}
void setup() {
  size(750, 750);
  genMaze(0, 0);
  // 設定終點的位置，這裡設定在右下角
  endI = 49;
  endJ = 49;
  isEnd[endI][endJ] = true;
}

void draw() {
  background(128, 128, 0);
  for(int i=0; i<50; i++){
    for(int j=0; j<49; j++){
      if(wallH[i][j]==0) line(15+j*15, i*15, 15+j*15, 15+i*15);
    }
  }
  for(int i=0; i<49; i++){
    for(int j=0; j<50; j++){
      if(wallW[i][j]==0) line(j*15, 15+i*15, 15+j*15, 15+i*15);
    }
  }
  
  // 繪製終點
  fill(255, 255, 0);
  rect(endJ*15+8, endI*15+8, 14, 14);

  // 繪製玩家
  fill(255, 0, 0);
  ellipse(userJ*15+8, userI*15+8, 14, 14);

  // 如果遊戲結束，顯示通關畫面
  if (gameFinished) {
    fill(0);
    textSize(32);
    text("congradulation!", width / 2 - 50, height / 2);
  }
}

boolean noCrossWallW(int dI){
  int nextI = userI + dI;
  if(nextI < 0 || nextI >= 50) return false;
  if(dI == -1 && wallW[nextI][userJ] == 1) return true;
  if(dI == +1 && wallW[userI][userJ] == 1) return true;
  return false;
}

boolean noCrossWallH(int dJ){
  int nextJ = userJ + dJ;
  if(nextJ < 0 || nextJ >= 50) return false;
  if(dJ == -1 && wallH[userI][nextJ] == 1) return true;
  if(dJ == +1 && wallH[userI][userJ] == 1) return true;
  return false;
}

void keyPressed() {
  // 方向鍵移動玩家
  if (keyCode == UP && noCrossWallW(-1)) userI--;
  if (keyCode == DOWN && noCrossWallW(+1)) userI++;
  if (keyCode == LEFT && noCrossWallH(-1)) userJ--;
  if (keyCode == RIGHT && noCrossWallH(+1)) userJ++;

  // 檢查是否到達終點
  if (userI == endI && userJ == endJ) {
    gameFinished = true;
  }
}
