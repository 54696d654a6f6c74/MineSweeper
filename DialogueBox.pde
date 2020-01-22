class TextField
{
  final color TEXT_COL = color(0);
  final color BG_COL = color(230);
  final color BORDER_COL = color(255, 100, 0);
  final color TITLE_COL = color(255);
  final color IDLE_BG_COL = color(100);
  final float BORDER_THICKNESS = 5f;
  
  final int LIMIT = 2;
  
  PVector pos;
  float w, h;
  boolean focus = false;
  float textSize;
  
  String title;
  String text = "";
  
  TextField(float x, float y, float w, float h, String title)
  {
    pos = new PVector(x, y);
    this.w = w;
    this.h = h;
    this.title = title;
    //textSize = sqrt(w * h) * .5f;
    textSize = h * .75f; // Could check if h < w but i ain't making verical text boxes
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
      focus = true;
    } else focus = false;
  }
  
  public void Display()
  {
    drawBorder();
    drawBackground();
    showTitle();
    showInput();
  }
  
  void drawBorder()
  {
    stroke(BORDER_COL);
    strokeWeight(BORDER_THICKNESS);
    noFill();
    rect(pos.x, pos.y, w, h);
  }
  
  void drawBackground()
  {
    noStroke();
    if(focus)
      fill(BG_COL);
    else fill(IDLE_BG_COL);
    rect(pos.x, pos.y, w, h);
  }
  
  public void KeyTyped()
  {
    //println(key);    // Fix backsapces
    
    if(key == ESC || key == ENTER)
    {
      focus = false;
      return;
    }
    
    if(keyCode == java.awt.event.KeyEvent.VK_BACK_SPACE && text.length() > 0)
    {
      //println("Backspace");
      text = text.substring(0, text.length()-1);
      return;
    }
    
    if(isNum(key) && text.length() < LIMIT)
    {
      text += key;
    }
  }
  
  void showTitle()
  {
    fill(TITLE_COL);
    textAlign(CORNER);
    textSize(textSize);
    
    float yOff = -BORDER_THICKNESS;
    text(title, pos.x, pos.y + yOff);
  }
  
  void showInput()
  {
    fill(TEXT_COL);
    textSize(textSize);
    float yOff = textSize;
    text(text, pos.x, pos.y + yOff);
  }
  
  boolean isNum(char c)
  {
    if((int)c <= 57 && (int)c >= 48)
      return true;
    return false;
  }
}
