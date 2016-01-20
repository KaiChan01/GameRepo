class Bullet extends GameObject
{
  float transX;
  float transY;
  
  Bullet(float x, float y, float posX, float posY)
  {
    speed = 4*size;
    this.position.x = posX;
    this.position.y = posY;
    this.transX = x;
    this.transY = y;
  }
  
  void drawObject()
  {
    
    fill(255,170,100);
    pushMatrix();
    translate(transX,transY);
    pushMatrix();
    translate(position.x,position.y);
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
    if(position.y > 0)
    {
      Objects.remove(this);
    }
  }
}
