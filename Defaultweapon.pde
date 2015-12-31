class Defaultweapon extends Player
{
  int infinity;
  int ammo;
  
  float x, y;
  char shootButton;
  
  //shooting reference point
  float gX;
  float gY;
  
  Defaultweapon(float gunX, float gunY, char shoot, float gX)
  {
    this.ammo = 9999;
    this.x = gunX;
    this.y = gunY;
    this.shootButton = shoot;
    this.gY = 8*size;
    this.gX = gX;
  }
  
  void drawWeapon()
  {
    //TEST!
    pushMatrix();
    translate(x,y);
    fill(100,170,255);
    beginShape();
    //Start point
    vertex(gX,-gY-10);
    vertex(gX+0,-gY);
    vertex(gX+10,-gY);
    vertex(gX+10,-gY-10);
    vertex(gX+20,-gY+5);
    vertex(gX+20,-gY+20);
    vertex(gX+10,-gY+30);
    
    //leftside
    vertex(gX,-gY+30);
    vertex(gX-10,-gY+20);
    vertex(gX-10,-gY+5);
    vertex(gX,-gY-10);
    vertex(gX,-gY);
    endShape();
    
    fill(0,255,255);
    beginShape();
    vertex(gX+5,-30);
    vertex(gX+10,-25);
    vertex(gX+5,-20);
    vertex(gX,-25);
    vertex(gX+5,-30);
    endShape();
    popMatrix();
  }
  
  int shoot(int cd)
  { 
    if(input[shootButton] == true && cd > 10)
    {
      pushMatrix();
      translate(x,y);
      rect(gX,-gY,10,-height);
      popMatrix();
      
      cd = 0;
      println(cd);
    }
    return cd;
  }
  
  void die()
  {
  }
}
