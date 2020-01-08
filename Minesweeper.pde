Grid grid;

void setup()
{
  size(800, 600);
  grid = new Grid(15, 15);
}

void draw()
{
  background(0);
  grid.Display(); //<>//
  smooth();
}
