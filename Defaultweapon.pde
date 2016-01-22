class Defaultweapon extends GameObject
{
  int infinity;
  
  float x, y;
  char shootButton;
  
  Defaultweapon(float shipX, float shipY, char shoot, float gX)
  {
    super(gX,8*size);

    this.shootButton = shoot;
    
    this.x = shipX;
    this.y = shipY;
  }
  
  void drawObject()
  { 
    //TEST!
    pushMatrix();
    translate(x,y);
    fill(100,170,255);
    beginShape();
    //Start point
    vertex(position.x,-position.y);
    vertex(position.x+(size),-position.y);
    vertex(position.x+(size),-position.y-(2*size));
    vertex(position.x+(3*size),-position.y+size);
    vertex(position.x+(3*size),-position.y+(4*size));
    vertex(position.x+(size),-position.y+(6*size));
    
    //leftside
    vertex(position.x-(size),-position.y+(6*size));
    vertex(position.x-(3*size),-position.y+(4*size));
    vertex(position.x-(3*size),-position.y+size);
    vertex(position.x-(size),-position.y-(2*size));
    vertex(position.x-(size),-position.y);
    vertex(position.x,-position.y);
    endShape();
    
    fill(0,255,255);
    
    beginShape();
    vertex(position.x,-6*size);
    vertex(position.x+(size),-5*size);
    vertex(position.x,-4*size);
    vertex(position.x-size,-5*size);
    vertex(position.x,-6*size);
    endShape();
    popMatrix();
  }
  
  int shoot(int cd)
  { 
    if(input[shootButton] == true && cd > 10)
    {
      Bullet bullet = new Bullet(x , y, position.x ,-position.y);
      Objects.add(bullet);
      cd = 0;
    }
    return cd;
  }
  
  void move()
  {
  }
  
  void die()
  {
  }
}
