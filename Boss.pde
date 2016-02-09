class Boss extends GameObject
{
  color colour;
  
  int status;
  PVector eyePos;
  
  boolean idleMode;
  boolean shootMode;
  boolean alive;
  
  boolean bombMode;
  boolean aim;
  
  boolean hit;
  
  PVector lockOn;
  PVector eyeHitbox;
  
  int aimSpeed;
  int ammo;
  int explosion;
  int charge;
  int transparent;
  
  float bomb;
  float angle;
  int rotate;
  int pattern;
  
  Boss()
  {
    super(width/2, -100*size);
    this.health = 1000*bossNum;
    this.speed = 0.5;
    this.aimSpeed = 4;
    this.idleMode = false;
    this.shootMode = true;
    this.bombMode = false;
    this.ammo = 500;
    this.rotate = 0;
    this.pattern = int(random(1,6));
    this.bomb = 20*size;
    this.charge = 0;
    this.hit = false;
    this.transparent = 255;
    this.alive = true;
    
    this.explosion = 0;
    
    MoveDOWN.mult(speed);
    MoveUP.mult(aimSpeed);
    MoveLEFT.mult(aimSpeed);
    MoveRIGHT.mult(aimSpeed);
  }
  
  
  void drawObject()
  {
    if(hit == false)
    {
      colour = color(255,transparent);
    }
    else
    {
      colour = color(255,150,150,transparent);
    }
    
    eyePos = new PVector(map(playerPos.x, 0, width, -30*size, +30*size), 65*size);
    eyeHitbox = new PVector(position.x,position.y+35*size);
    
    if(playerPos.x > width/2)
    {
      eyePos.y = map(playerPos.x, width/2, width, 65*size, 50*size);
    }
    else if(playerPos.x < width/2)
    {
      eyePos.y = map(playerPos.x, 0, width/2, 50*size, 65*size);
    }
    
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
        bombMode = true;
        aim = true;
        lockOn = new PVector(map(playerPos.x, 0, width, (width/2)-30*size, (width/2)+30*size), eyePos.y);
      }
    }
    
    pushMatrix();
    translate(position.x,position.y);
    
    stroke(255, transparent);
    fill(0,51,51,transparent);
    ellipse(0,0, width+50*size, 100*size);
    fill(colour);
    ellipse(0,35*size, 100*size, 100*size);
    fill(152,0,0,transparent);
    
    //60 is the edge of the eye,
    ellipse(eyePos.x, eyePos.y, 40*size,40*size);
    
    strokeWeight(2*size);
    stroke(102,0,0,transparent);
    line(eyePos.x-19*size, eyePos.y, eyePos.x+19*size, eyePos.y);
    line(eyePos.x-13*size, eyePos.y-13*size, eyePos.x+13*size, eyePos.y+13*size);
    line(eyePos.x-13*size, eyePos.y+13*size, eyePos.x+13*size, eyePos.y-13*size);
    line(eyePos.x, eyePos.y-19*size, eyePos.x, eyePos.y+19*size);
    strokeWeight(1);
    
    fill(0,transparent);
    ellipse(eyePos.x, eyePos.y, 20*size,20*size);
    popMatrix();
    
    if(shootMode == true && idleMode == false && alive == true)
    {
      shoot();
    }
    
    if(idleMode == false && bombMode == true && alive == true)
    {
      bomb();
    }
    
    hit =false;
  }
  
  void shoot()
  {
    EnemyBullet b = new EnemyBullet(int(position.x+eyePos.x), int(position.y+eyePos.y), rotate -= pattern);
    Objects.add(b);
    
    ammo--;
    
    if(ammo < 0)
    {
      ammo = 500;
      idleMode = true;
      shootMode = false;
    }
  }
  
  void bomb()
  {
    if(aim == true)
    {
      stroke(255,0,0,transparent);
      fill(255,0,0, 200);
      
      line(map(playerPos.x, 0, width, (width/2)-30*size, (width/2)+30*size), eyePos.y, lockOn.x, lockOn.y);
      ellipse(lockOn.x, lockOn.y, bomb,bomb);
      
      if(lockOn.x >= playerPos.x)
      {
        lockOn.add(MoveLEFT);
      }
      else
      {
        lockOn.add(MoveRIGHT);
      }
      
      if(lockOn.y >= playerPos.y)
      {
        lockOn.add(MoveUP);
      }
      else
      {
        lockOn.add(MoveDOWN);
      }
      
      if(lockOn.dist(playerPos) < 7*size)
      {
        aim = false;
      }
    }
    else
    {
      stroke(255,0,0,transparent);
      fill(255,0,0, 200);
      line(map(playerPos.x, 0, width, (width/2)-30*size, (width/2)+30*size), eyePos.y, lockOn.x, lockOn.y);
      ellipse(lockOn.x, lockOn.y, bomb,bomb);
      charge++;
      
      if(charge >= 25)
      { 
        if(bomb > 0);
        {
          bomb--;
        }
      
        if(bomb == 0);
        {
          explosion += 2;
          fill(242,156,44,transparent);
          ellipse(lockOn.x, lockOn.y, explosion,explosion);
          
          if(explosion % 10 == 0)
          {
            fill(255,99,71,transparent);
            ellipse(lockOn.x+random(-50*size, 50*size),lockOn.y+random(-50*size, 50*size), explosion/10,explosion/10);
          }
        
          if(explosion == 100*size)
          {
            explosion = 0;
            bomb = 20*size;
            idleMode = true;
            bombMode = false;
          }
        }    
      }
    }
  }
  
  void move()
  {
    if(position.y < 0)
    {
      position.add(MoveDOWN);
      
      if(position.y == 0)
      {
        MoveDOWN.mult(aimSpeed);
      }
    }
  }
  
  void die()
  {
    if(health <= 0)
    {
      alive = false;
      transparent -= 2;
      if(transparent <= 0)
      {
        //Ready to spawn a new one 
        boss = false;
        bossSpawned = false;
        
        bossNum += 1;
        Objects.remove(this);
      }
    }
  }
  
}
