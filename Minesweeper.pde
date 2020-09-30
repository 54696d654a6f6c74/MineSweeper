import java.util.Arrays;

int gridWidth = 20;
int gridHeight = 20;
int mines = 50;

GameManager gm;

void setup()
{
  size(800, 600);    
  gm = new GameManager();
}

void draw()
{
  background(0);
  gm.Update();
  
  //translate(0, 0, 100); use this func to implement zoom
}

void keyPressed()
{
  if(gm.gridWidthField.focus)
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
    if(gm.gameGrid.highlighed != null)
    {
      if(mouseButton == LEFT &&
      (gm.gameGrid.highlighed.state != State.OPENED &&
      gm.gameGrid.highlighed.state != State.FLAGGED))
      {
        gm.gameGrid.highlighed.Open(); //<>//
      }
      else if(mouseButton == RIGHT)
        gm.gameGrid.highlighed.Flag();
    }
  }
  
  else if(gm.gameState == GameState.MAIN_MENU)
  {
    gm.gridWidthField.checkMouse();
    gm.gridHeightField.checkMouse();
    gm.mineCountField.checkMouse();
    
    if(gm.playButton.highlighted)
      gm.playButton.Click();
  }
  
  else if(gm.gameState == GameState.LOSS || gm.gameState == GameState.WIN)
  {
    if(gm.restartButton.highlighted)
      gm.restartButton.Click();
  }
}
