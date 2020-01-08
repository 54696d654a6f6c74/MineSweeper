class Grid
{
  final float BUFFER = 20; // pixels to buffer from closest edges
 
  Tile[][] grid;
  
  int w, h;
  boolean wider;
  boolean swapped = false; // if one screen is wider but grid was too big to fit in it
  float offset;
  
  Grid(int w, int h)
  {
    this.w = w;
    this.h = h;
    grid = new Tile[h][w];
    
    if(width > height)
      wider = true;
    else wider = false;
    
    float tileSize = calcTileSize();
    calcOffset(tileSize);
    
    for(int y = 0; y < h; y++)
    {
      for(int x = 0; x < w; x++)
      {
        float xPos = (x * tileSize);
        float yPos = (y * tileSize);
        grid[y][x] = new Tile(xPos, yPos, tileSize);
      }
    }
  }
  
  public void Display() //<>//
  {
    pushMatrix();
    fill(255);
    stroke(0);
    strokeWeight(3);
    
    if((wider && !swapped) || (!wider && swapped))
      translate(offset, BUFFER);
    else if((!wider && !swapped) || (wider && swapped))
      translate(BUFFER, offset);
    
    for(int y = 0; y < h; y++)
    {
      for(int x = 0; x < w; x++)
      {
        grid[y][x].Display(); //<>//
      }
    }
    popMatrix();
  }
  
  public void OpenTile(int x, int y)
  {
    
  }
  
  void calcValues()
  {
    
  }
  
  void calcOffset(float tileSize)
  {
    if((wider && !swapped) || (!wider && swapped))
    {
      float gridWidth = w * tileSize;
      offset = abs(width - gridWidth) * .5f;
    }
    else if((!wider && !swapped) || (wider && swapped))
    {
      float gridHeight = h * tileSize;
      offset = abs(height - gridHeight) * .5f;
    }
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
}
