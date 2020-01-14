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
  Button playButtonField;
  TextField gridWidthField;
  TextField gridHeightField;
  TextField mineCountField;
  
  GameManager()
  {
    gameState = GameState.MAIN_MENU;
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
    }
    else if(gameState == GameState.LOSS)
    {
      DisplayRestart();
    }
    else if(gameState == GameState.MAIN_MENU)
    {
      DisplayMenu();
    }
  }
  
  void DisplayGame()
  {
    background(0);
    gameGrid.Display();
  }
  
  void DisplayRestart()
  {
    
  }
  
  void Restart()
  {
    
  }
  
  void DisplayMenu()
  {
    playButtonField.Display();
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
    CreateGrid(false);
    gameState = GameState.GAME;
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
