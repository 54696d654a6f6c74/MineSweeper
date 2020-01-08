enum State
{
  Closed,
  Opened,
  Flagged,
}

class Tile
{
  final float CLOSED_R = 255;
  final float CLOSED_G = 185;
  final float CLOSED_B = 0;
  
  final float HOVER_R = 255;
  final float HOVER_G = 230;
  final float HOVER_B = 0;
  
  final float OPENED_R = 0;
  final float OPENED_G = 255;
  final float OPENED_B = 0;
  
  final float STROKE_WEIGHT = 2;
  
  public int val;
  PVector pos;
  float size;
  
  boolean bomb = false;
  State state = State.Closed;
  
  boolean highlighted = false;
  
  Tile[] neighbours;
  
  Tile(float x, float y, float tileSize)
  {
    size = tileSize;
    pos = new PVector(x, y);
  }
  
  public void InitNeighbours(Tile[] neighbours)
  {
    this.neighbours = neighbours;
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
    strokeWeight(STROKE_WEIGHT);
    checkMouse();
    if(highlighted)
      fill(HOVER_R, HOVER_G, HOVER_B);
    else fill(CLOSED_R, CLOSED_G, CLOSED_B);
    
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
      highlighted = true;
    }
    else highlighted = false;
  }
  
  public void Open()
  {
    state = State.Opened;
  }
  
  public void CalcValue()
  {
    val = 0;
    for(Tile n : neighbours)
    {
      if(n.bomb)
        val++;
    }
  }
}
