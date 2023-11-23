int[][] mine = new int[9][9];

void setup() {
  size(450, 450);
  
  // 初始化地雷陣列
  for (int i = 0; i < 9; i++) 
    mine[i][0] = 9;

  // 隨機交換地雷位置
  for (int k = 0; k < 1000; k++) {
    int i = int(random(9)), j = int(random(9));
    int i2 = int(random(9)), j2 = int(random(9));
    int temp = mine[i][j];
    mine[i][j] = mine[i2][j2];
    mine[i2][j2] = temp;
  }

  // 設置地雷數字
  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) {
      if (mine[i][j] == 9) {
        addNumber(i - 1, j - 1);
        addNumber(i - 1, j);
        addNumber(i - 1, j + 1);
        addNumber(i, j - 1);
        addNumber(i, j);
        addNumber(i, j + 1);
        addNumber(i + 1, j - 1);
        addNumber(i + 1, j);
        addNumber(i + 1, j + 1);
      }
    }
  }
}

void addNumber(int i, int j) {
  if (i < 0 || j < 0 || i >= 9 || j >= 9) 
    return;  // 超過範圍 不做事
  if (mine[i][j] != 9) 
    mine[i][j]++;
}

void draw() {
  for (int i = 0; i < 9; i++) {  // y
    for (int j = 0; j < 9; j++) {  // x
      if (mine[i][j] == 9) 
        fill(255, 128, 128);
      else 
        fill(255);
      rect(j * 50, i * 50, 45, 45);

      if (mine[i][j] != 0) {
        fill(0); 
        text("" + mine[i][j], j * 50 + 23, i * 50 + 23, 45, 45);
      }
    }
  }
}
