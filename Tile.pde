enum State
{
  Closed,
  Opened,
  Flagged,
}

class Tile
{
  final float HOVER_R = 255;
  final float HOVER_G = 0;
  final float HOVER_B = 0;
  
  final float OPENED_R = 0;
  final float OPENED_G = 255;
  final float OPENED_B = 0;
  
  public int val;
  PVector pos;
  float size;
  
  boolean bomb = false;
  State state = State.Closed;
  
  boolean mouse = false;
  
  Tile(float x, float y, float tileSize)
  {
    pos = new PVector(x, y);
    size = tileSize;
  }
  
  public void Display()
  {
    ShowBox(); //<>//
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
  
  void ShowBox()
  {
    stroke(0);
    strokeWeight(3);
    checkMouse();
    if(mouse)
      fill(HOVER_R, HOVER_G, HOVER_G);
    else fill(255);
    
    if(state == State.Opened)
      fill(OPENED_R, OPENED_G, OPENED_B);
    rect(pos.x, pos.y, size, size);
  }
  
  void checkMouse()
  {
    float mx = mouseX;
    float my = mouseY;
    
    if(
      mx < pos.x + size &&
      mx > pos.x &&
      my < pos.y + size &&
      my > pos.y
    )
    {
      mouse = true;
    }
    else mouse = false;
  }
  
  void mouseClicked()
  {
    if(mouse)
    {
      state = State.Opened;
    }
  }
  
  public void Open()
  {
    
  }
}
