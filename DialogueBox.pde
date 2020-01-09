class TextField
{
  float spaceing;
  String input;
  PVector pos;
  float w, h;
  boolean active = false;
  
  TextField(float x, float y, float w, float h)
  {
    pos = new PVector(x, y);
    this.w = w;
    this.h = h;
  }
  
  public void Select()
  {
    active = true;
  }
}
