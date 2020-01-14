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
  size(800, 600);    
  grid = new Grid(gridWidth, gridHeight, mines);
  test = new Button(70, 50, 100, 100, "Fuck");
  testField = new TextField(70, 50, 300, 50, "Fuck");
  //gm = new GameManager();
  //gm.CreateGrid(gridWidth, gridHeight, mines);
}

void draw()
{
  background(0);
  //grid.Display();
  testField.Display();
  //test.Display();
  smooth();
}

void keyTyped()
{
  if(testField.focus)
  {
    testField.KeyTyped();
  }
}

void mouseReleased()
{
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
