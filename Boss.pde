class Boss extends GameObject
{
  int status;
  
  float eyeY;
  
  boolean idleMode;
  boolean shootMode;
  boolean laserMode;
  int ammo;
  int rotate;
  int pattern;
  
  Boss()
  {
    super(width/2, -100*size);
    this.health = 10000;
    this.speed = 0.5;
    this.idleMode = false;
    this.shootMode = true;
    this.laserMode = false;
    this.ammo = 500;
    this.rotate = 0;
    this.pattern = 5;
    
    MoveDOWN.mult(speed);
  }
  
  
  void drawObject()
  {
    status = int(random(0,30));
    
    if(idleMode == true)
    {
      if(status == 2)
      {
        idleMode = false;
        shootMode = true;
        pattern = int(random(1,6));
      }
      
      if(status == 1)
      {
        idleMode = false;
        laserMode = true;
      }
    }
    
    if(playerPos.x > width/2)
    {
      eyeY = map(playerPos.x, width/2, width, 65*size, 50*size);
    }
    else if(playerPos.x < width/2)
    {
      eyeY = map(playerPos.x, 0, width/2, 50*size, 65*size);
    }
    
    pushMatrix();
    translate(position.x,position.y);
    
    stroke(255);
    fill(0,51,51);
    ellipse(0,0, width+50*size, 100*size);
    fill(255);
    ellipse(0,35*size, 100*size, 100*size);
    fill(152,0,0);
    //60 is the edge of the eye, -40 should be right
    ellipse(map(playerPos.x, 0, width, -30*size, 30*size), eyeY, 40*size,40*size);
    
    strokeWeight(2*size);
    stroke(102,0,0);
    line(map(playerPos.x, 0, width, -30*size, 30*size)-19*size, eyeY, map(playerPos.x, 0, width, -30*size, 30*size)+19*size, eyeY);
    line(map(playerPos.x, 0, width, -30*size, 30*size)-13*size, eyeY-13*size, map(playerPos.x, 0, width, -30*size, 30*size)+13*size, eyeY+13*size);
    line(map(playerPos.x, 0, width, -30*size, 30*size)-13*size, eyeY+13*size, map(playerPos.x, 0, width, -30*size, 30*size)+13*size, eyeY-13*size);
    line(map(playerPos.x, 0, width, -30*size, 30*size), eyeY-19*size, map(playerPos.x, 0, width, -30*size, 30*size), eyeY+19*size);
    strokeWeight(1);
    
    fill(0);
    ellipse(map(playerPos.x, 0, width, -30*size, 30*size), eyeY, 20*size,20*size);
    popMatrix();
    
    if(shootMode == true && idleMode == false)
    {
      shoot();
    }
    
    if(idleMode == false && laserMode == true)
    {
      laser();
    }
  }
  
  void shoot()
  {
    EnemyBullet b = new EnemyBullet(int(position.x+map(playerPos.x, 0, width, -30*size, 30*size)), int(position.y+eyeY), rotate -= pattern);
    Objects.add(b);
    
    ammo--;
    
    if(ammo < 0)
    {
      ammo = 500;
      idleMode = true;
      shootMode = false;
    }
  }
  
  void laser()
  {
    
  }
  
  void move()
  {
    if(position.y < 0)
    {
      position.add(MoveDOWN);
    }
  }
  
  void die()
  {
    bossNum += 1;
  }
  
}