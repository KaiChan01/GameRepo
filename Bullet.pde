class Bullet extends GameObject
{
  float transX;
  float transY;
  
  Bullet(float x, float y, float posX, float posY)
  {
    super(posX,posY);
    
    speed = 4*size;
    
    this.transX = x;
    this.transY = y;
  }
  
  void drawObject()
  {
    fill(0,255,0);
    stroke(0,200,0);
    pushMatrix();
    translate(position.x,position.y);
    pushMatrix();
    translate(transX,transY);
    rect(0,0,2*size,-10*size);
    popMatrix();
    popMatrix();
  }
  
  void move()
  {
    position.add(0.0f,-speed,0);
  }
  
  void die()
  {
    if(this.position.y < -height)
    {
      Objects.remove(this);
    }
  }
}
