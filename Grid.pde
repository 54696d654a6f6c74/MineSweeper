class Grid
{
  final float BUFFER = 100; // pixels to buffer from closest edges
 
  Tile[][] grid;
  Tile highlighed;
  
  int w, h, mineCount;
  boolean wider;
  boolean swapped = false; // if one screen is wider but grid was too big to fit in it
  boolean first = true;
  
  Grid(int w, int h)
  {
    this.w = w;
    this.h = h;
    //mineCount = mines;
    grid = new Tile[h][w];
    
    if(width > height)
      wider = true;
    else wider = false;
    
    float tileSize = calcTileSize();
    float offset = calcOffset(tileSize);
    createTile(tileSize, offset);
  }
  
  Grid(int w, int h, int mines)
  {
    this(w, h);
    mineCount = mines;
    addMinesAtRandom(mines);
    calcTileValue();
  }
  
  void createTile(float tileSize, float offset)
  {
    for(int y = 0; y < h; y++)
    {
      for(int x = 0; x < w; x++)
      {
        float xPos = (x * tileSize);
        float yPos = (y * tileSize);
        if((wider && !swapped) || (!wider && swapped))
        {
          xPos += offset;
          yPos += BUFFER;
        }
        else if((!wider && !swapped) || (wider && swapped))
        {
          xPos += BUFFER;
          yPos += offset;
        }
        grid[y][x] = new Tile(xPos, yPos, tileSize);
      }
    }
  }
  
  void addMinesAtRandom(int mineCount)
  {
    ArrayList<Tile> allTiles = new ArrayList<Tile>();
    for (int y = 0; y < h; y++)
    {
      for(int x = 0; x < w; x++)
      {
        if(!grid[y][x].bomb)
          allTiles.add(grid[y][x]);
      }
    }
    
    int count = mineCount;
    while (count > 0)
    {
      int index = floor(random(0, allTiles.size()));
      allTiles.get(index).bomb = true;
      allTiles.remove(index);
      
      count--;
    }
  }
  
  void calcTileValue()
  {
    for(int y = 0; y < h; y++)
    {
      for(int x = 0; x < w; x++)
      {
        ArrayList<Tile> neighbours = getNeighbours(x, y);
        grid[y][x].InitNeighbours(neighbours.toArray(new Tile[neighbours.size()]));
        grid[y][x].CalcValue();
      }
    }
  }
  
  public void Display()
  {
    highlighed = null;
    for(int y = 0; y < h; y++)
    {
      for(int x = 0; x < w; x++)
      {
        grid[y][x].Display();
        if(grid[y][x].highlighted)
          highlighed = grid[y][x];
      }
    }
  }
  
  public void Uncover()
  {
    for(int y = 0; y < h; y++)
    {
      for(int x = 0; x < w; x++)
      {
        grid[y][x].state = State.OPENED;
      }
    }
  }
  
  float calcOffset(float tileSize)
  {
    if((wider && !swapped) || (!wider && swapped))
    {
      float gridWidth = w * tileSize;
      float offset = abs(width - gridWidth) * .5f;
      return offset;
    }
    else if((!wider && !swapped) || (wider && swapped))
    {
      float gridHeight = h * tileSize;
      float offset = abs(height - gridHeight) * .5f;
      return offset;
    }
    println("Failed to calculate offset, retunring 0");
    return 0;
  }
  
  float calcTileSize()
  {
    // Find if width or height is bigger
    float sizeByHeight = (height - BUFFER*2) / h;
    float sizeByWidth = (width - BUFFER*2) / w; 
    
    if(wider && sizeByHeight * w < width)
      return sizeByHeight;
    else if(!wider && sizeByWidth * h < height)
      return sizeByWidth;
    else if(wider)
    {
      swapped = true;
      return sizeByWidth;
    }
    else
    {
      swapped = true;
      return sizeByHeight;
    }
  }
  
  ArrayList<Tile> getNeighbours(int x, int y)
  {
    PVector[] arr = 
    {
      new PVector(x-1, y  ),
      new PVector(x+1, y  ),
      new PVector(x  , y-1),
      new PVector(x  , y+1),
      new PVector(x-1, y+1),
      new PVector(x-1, y-1),
      new PVector(x+1, y+1),
      new PVector(x+1, y-1)
    };
    
    ArrayList<PVector> neighbourIndecies = new ArrayList<PVector>();
    neighbourIndecies.addAll(Arrays.asList(arr));
    
    for(PVector n : arr)
    {
      if(n.x < 0 || n.y < 0)
      {
        neighbourIndecies.remove(n);
        continue;
      }
      if(n.x >= w || n.y >= h)
      {
        neighbourIndecies.remove(n);
        continue;
      }
    }
    
    ArrayList<Tile> neighbours = new ArrayList<Tile>();
    for(PVector pv : neighbourIndecies)
    {
      neighbours.add(grid[floor(pv.y)][floor(pv.x)]);
    }
    
    return neighbours;
  }
}
