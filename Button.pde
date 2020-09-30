class Button
{
  color idleColor = color(255, 185, 0);
  color highlightedColor = color(255, 230, 0);
  color textColor = color(245);
  
  PVector pos;
  float w, h;
  String text;
  boolean highlighted = false;

  Button(float x, float y, float w, float h, String text)
  {
    pos = new PVector(x, y);
    this.w = w;
    this.h = h;
    this.text = text;
  }

  void checkMouse()
  {
    float mx = mouseX;
    float my = mouseY;

    if (
      mx < pos.x + w &&
      mx > pos.x &&
      my < pos.y + h &&
      my > pos.y
      )
    {
      highlighted = true;
    } else highlighted = false;
  }

  void Display()
  {
    checkMouse();
    stroke(0);
    if (!highlighted)
      fill(idleColor);
    else fill(highlightedColor);
    rect(pos.x, pos.y, w, h);

    textAlign(CENTER);
    float fontSize = 25;
    textSize(fontSize);
    fill(textColor);
    text(text, pos.x, pos.y + (h-fontSize) * .5f, w, h);
  }
  
  public void Click()
  {
    print("Button clicked");
  }
}

class RestartButton extends Button
{
  // This is not redundant, java is just dumb, like WTF?
  RestartButton(float x, float y, float w, float h, String text)
  {
    super(x, y, w, h, text);
    
  }
  
  public void Click()
  {
    gm.Restart();
  }
}

class PlayButton extends Button
{
  
  PlayButton(float x, float y, float w, float h, String text)
  {
    super(x, y, w, h, text);
  }
  
  public void Click()
  {
    gm.GameStart();
  }
}
