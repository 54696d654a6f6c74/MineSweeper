import java.util.Arrays;

int gridWidth = 20;
int gridHeight = 20;
int mines = 50;

Grid grid;
GameManager gm;
Button test;
TextField testField;

void setup()
{
  size(800, 600, P3D);    
  grid = new Grid(gridWidth, gridHeight, mines);
  test = new Button(70, 50, 100, 100, "Fuck");
  testField = new TextField(70, 50, 300, 50, "Fuck");
  gm = new GameManager();
  //gm.CreateGrid(gridWidth, gridHeight, mines);
}

void draw()
{
  background(0);
  //translate(0, 0, 100); use this func to implement zoom
  //grid.Display();
  //testField.Display();
  //test.Display();
  gm.Update();
  smooth();
}

void keyTyped()
{
  if(testField.focus)
  {
    testField.KeyTyped();
  }
  else if(gm.gridWidthField.focus)
    gm.gridWidthField.KeyTyped();
  else if(gm.gridHeightField.focus)
    gm.gridHeightField.KeyTyped();
  else if(gm.mineCountField.focus)
    gm.mineCountField.KeyTyped();
}

void mouseReleased()
{
  if(gm.gameState == GameState.GAME)
  {
    if(mouseButton == LEFT && (gm.gameGrid.highlighed.state != State.OPENED && gm.gameGrid.highlighed.state != State.FLAGGED))
    {
      gm.gameGrid.highlighed.Open();
    }
    else if(mouseButton == RIGHT)
    {
      gm.gameGrid.highlighed.Flag();
    }
  }
  
  gm.gridWidthField.checkMouse();
  gm.gridHeightField.checkMouse();
  gm.mineCountField.checkMouse();
  
  if(gm.playButton.highlighted)
  {
    gm.playButton.Click();
  }
  
  testField.checkMouse();
  
  if(test.highlighted)
  {
    test.Click();
  }
  else
  {
    if(grid.highlighed != null){
      if(mouseButton == LEFT && (grid.highlighed.state != State.OPENED && grid.highlighed.state != State.FLAGGED))
        grid.highlighed.Open();
      else if(mouseButton == RIGHT)
        grid.highlighed.Flag();
    }
  }
}
