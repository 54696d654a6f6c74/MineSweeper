class Color
{
  public float R, G, B, A;
  
  Color(float r, float g, float b, float a)
  {
    R = r;
    G = g;
    B = b;
    A = a;
  }
  
  Color(float r, float g, float b)
  {
    this(r, g, b, 255f);
  }
  
  Color(float brightness)
  {
    this(brightness, brightness, brightness, 255f);
  }
}
