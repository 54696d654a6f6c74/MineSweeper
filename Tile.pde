enum State
{
  Idle,
  Opened,
  Flagged,
}

class Tile
{
  final Color IDLE = new Color(255, 185, 0);
  final Color HOVER = new Color(255, 230, 0);
  final Color OPENED = new Color(0, 255, 0);
  final Color BOMB = new Color(255, 0, 0);
  
  final float STROKE_WEIGHT = 2;
  
  public int val;
  PVector pos;
  float size;
  
  boolean bomb = false;
  State state = State.Idle;
  
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
    if(state == State.Opened && val > 0)
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
    if(!bomb)
    {
      stroke(255);
      fill(255);
      text(val, pos.x+size*.5f, pos.y+size*.5f);
    }
  }
  
  void ShowFlag()
  {
    line(pos.x, pos.y, pos.x+size, pos.y+size);
    line(pos.x+size, pos.y, pos.x, pos.y+size);
  }
  
  void ShowBox()
  {
    stroke(0);
    strokeWeight(STROKE_WEIGHT);
    checkMouse();
    if(highlighted)
      fill(HOVER.R, HOVER.G, HOVER.B);
    else fill(IDLE.R, IDLE.G, IDLE.B);
    
    if(state == State.Opened)
      if(!bomb)
        fill(OPENED.R, OPENED.G, OPENED.B);
      else fill(255, 0, 0);
      
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
    state = State.Opened;  // Expand this so it works propery!
    for(Tile n : neighbours)
    {
      if(n.val == 0 && !n.bomb && n.state != State.Opened)
      {
        n.openZeroTile();
      }
    }
  }
  
  protected void openZeroTile()
  {
    state = State.Opened;
    for(Tile n : neighbours)
    {
      if(!n.bomb && n.state != State.Opened)
      {
        if(n.val == 0)
          n.openZeroTile();
        else n.Open();
      }
    }
  }
  
  public void Flag()
  {
    if(state == State.Idle)
      state = State.Flagged;
    else if(state == State.Flagged)
      state = State.Idle;
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
