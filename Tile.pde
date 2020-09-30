enum State
{
  IDLE,
  OPENED,
  FLAGGED,
}

class Tile
{
  final color IDLE = color(255, 185, 0);
  final color HOVER = color(255, 230, 0);
  final color OPENED = color(50, 255, 50);
  final color BOMB = color(255, 0, 0);
  
  final color[] VALUES = {
    color(0,  0,  255),  // 1
    color(0,  150,0),    // 2
    color(135,0,  0),    // 3
    color(0,  0,  40),   // 4
    color(40, 0, 15),    // 5
    color(70, 0, 95),    // 6
    color(60),           // 7
    color(0),            // 8
  };
  
  final float STROKE_WEIGHT = 2;
  
  public int val;
  PVector pos;
  float size;
  
  boolean bomb = false;
  State state = State.IDLE;
  
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
    ShowBox();
    if(state == State.OPENED && val > 0)
    {
      ShowVal();
    }
    else if(state == State.FLAGGED)
    {
      ShowFlag();
    }
  }
  
  void ShowVal()
  {
    if(!bomb)
    {
      stroke(0);
      color col = VALUES[val-1];
      fill(col);
      textSize(size*.5f);
      textAlign(CENTER);
      text(""+val, pos.x, pos.y + (size*.5f) * .5f, size, size);
    }
  }
  
  void ShowFlag()
  {
    stroke(200,0,0);
    float off = size * 0.2f;
    float size = this.size - off;
    PVector flagPos = new PVector(pos.x + off, pos.y + off);
    line(flagPos.x, flagPos.y, pos.x+size, pos.y+size);
    line(pos.x+size, flagPos.y, flagPos.x, pos.y+size);
  }
  
  void ShowBox()
  {
    stroke(0);
    strokeWeight(STROKE_WEIGHT);
    checkMouse();
    if(highlighted)
      fill(HOVER);
    else fill(IDLE);
    
    if(state == State.OPENED)
      if(!bomb)
        fill(OPENED);
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
  
  public void Open() //<>//
  {
    if(gm.gameGrid.first)
    {
      if(bomb)
      {
        gm.gameGrid.addMinesAtRandom(1);
        bomb = false;
        gm.gameGrid.calcTileValue();
      }
      gm.gameGrid.first = false;
    }
    else if(gm.gameState != GameState.WIN &&
    gm.gameState != GameState.LOSS)
    {
      if(bomb)
        gm.gameState = GameState.LOSS;
    }
    state = State.OPENED;
    for(Tile n : neighbours)
    {
      if(n.val == 0 && !n.bomb && n.state != State.OPENED)
      {
        n.openZeroTile();
      }
    }
  }
  
  protected void openZeroTile()
  {
    state = State.OPENED;
    for(Tile n : neighbours)
    {
      if(!n.bomb && n.state != State.OPENED)
      {
        if(n.val == 0)
          n.openZeroTile();
        else n.Open();
      }
    }
  }
  
  
  public void Flag()
  {
    if(state == State.IDLE)
      state = State.FLAGGED;
    else if(state == State.FLAGGED)
      state = State.IDLE;
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
