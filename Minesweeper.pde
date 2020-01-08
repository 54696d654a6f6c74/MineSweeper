import java.util.Arrays;

int gridWidth = 15;
int gridHeight = 15;
int mines = 15;

Grid grid;

void setup()
{
  size(800, 600);
  grid = new Grid(gridWidth, gridHeight, mines);
}

void draw()
{
  background(0);
  grid.Display(); //<>//
  smooth();
}

void mouseClicked()
{
  if(mouseButton == LEFT && (grid.highlighed.state != State.Opened && grid.highlighed.state != State.Flagged))
    grid.highlighed.Open();
  else if(mouseButton == RIGHT)
    grid.highlighed.Flag();
}
