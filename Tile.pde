enum State
{
  Closed,
  Opened,
  Flagged,
}

class Tile
{
  public int val;
  PVector pos;
  float size;
  
  boolean bomb = false;
  State state = State.Closed;
  
  Tile(float x, float y, float tileSize)
  {
    pos = new PVector(x, y);
    size = tileSize;
  }
  
  public void Display()
  {
    ShowBorder(); //<>//
    if(state == State.Opened)
    {
      ShowVal();
    }
    else if(state == State.Flagged)
    {
      ShowFlag();
    }
  }
  
  void ShowVal()
  {
    
  }
  
  void ShowFlag()
  {
    
  }
  
  void ShowBorder()
  {
    rect(pos.x, pos.y, size, size);
  }
  
  void Open()
  {
    
  }
}
