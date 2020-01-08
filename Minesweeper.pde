import java.util.Arrays;

int gridWidth = 15;
int gridHeight = 15;

Grid grid;

void setup()
{
  size(800, 600);
  grid = new Grid(gridWidth, gridHeight);
}

void draw()
{
  background(0);
  grid.Display(); //<>// //<>//
  smooth();
}

void mouseClicked()
{
  grid.highlighed.Open();
}
