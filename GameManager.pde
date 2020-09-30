enum GameState
{
  WIN,
  LOSS,
  GAME,
  MAIN_MENU
}

class GameManager
{
  int gridWidth = 20;
  int gridHeight = 20;
  int mineCount = 50;
  
  GameState gameState;
  
  Grid gameGrid;
  
  Button restartButton;
  PlayButton playButton;
  TextField gridWidthField;
  TextField gridHeightField;
  TextField mineCountField;
  
  GameManager()
  {
    gameState = GameState.MAIN_MENU;
    
    float txtFieldYOff = 50f;
    float playBtnW = 150f;
    float playBtnYOff = 60;
    
    gridWidthField = new TextField(50, height/2 - txtFieldYOff, width/3-50, 40f, "Width");
    gridHeightField = new TextField(width/3 + 25, height/2 - txtFieldYOff, width/3 - 50, 40f, "Height");
    mineCountField = new TextField(width - width/3 , height/2 - txtFieldYOff, width/3 - 50, 40f, "Mines");
    playButton = new PlayButton(width/2 - playBtnW/2, height / 2 + playBtnYOff, playBtnW, 50, "P L A Y");
  }
  
  public void Update()
  {
    if(gameState == GameState.GAME)
    {
      DisplayGame();
    }
    else if(gameState == GameState.WIN)
    {
      DisplayRestart();
      DisplayGame();
    }
    else if(gameState == GameState.LOSS)
    {
      DisplayGame();
      DisplayRestart();
    }
    else if(gameState == GameState.MAIN_MENU)
    {
      DisplayMenu();
    }
  }
  
  void DisplayGame()
  {
    gameGrid.Display();
  }
  
  void DisplayRestart()
  {
    
  }
  
  void Restart()
  {
    gameGrid.Uncover();
  }
  
  void DisplayMenu()
  {
    playButton.Display();
    gridWidthField.Display();
    gridHeightField.Display();
    mineCountField.Display();
  }
  
  void CreateGrid(boolean withMines)
  {
    if(withMines)
      gameGrid = new Grid(gridWidth, gridHeight, mineCount);
    else gameGrid = new Grid(gridWidth, gridHeight);
  }
  
  public void GameStart()
  {
    if(gridWidthField.text != "" &&
    gridHeightField.text != "" &&
    mineCountField.text != "")
    {
      gridWidth = parseInt(gridWidthField.text);
      gridHeight = parseInt(gridHeightField.text);
      mineCount = parseInt(mineCountField.text);
      
      CreateGrid(true);
      gameState = GameState.GAME;
    }
  }
  
  boolean Won(Tile[][] grid, int totalBombs)
  {
    int countUnopened = 0;
    int countFlagged = 0;
    
    for(int y = 0; y < gridHeight; y++)
    {
      for(int x = 0; x < gridWidth; x++)
      {
        if(grid[y][x].state != State.OPENED && !grid[y][x].bomb)
          countUnopened++;
        if(grid[y][x].state == State.FLAGGED && grid[y][x].bomb)
          countFlagged++;
      }
    }
    return countUnopened == 0 || countFlagged == totalBombs;
  }
}
