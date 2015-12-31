class Defaultweapon extends Player
{
  int infinity;
  int ammo;
  float x, y;
  char shootButton;
  
  Defaultweapon(float gunX, float gunY, char shoot)
  {
    this.ammo = 9999;
    this.x = gunX;
    this.y = gunY;
    this.shootButton = shoot;
  }
  
  void drawWeapon()
  {
    //TEST!
    ellipse(x,y,100,100);
    println(shootButton);
  }
  
  void shoot()
  {
    if(input[shootButton] == true)
    {
      println("shooting");
      fill(255);
      rect(x-20,y,40,-height);
    }
  }
  
  void die()
  {
  }
}
