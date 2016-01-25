class Player extends GameObject
{
  //Fields for player
  float bombs;
  char up;
  char down;
  char left;
  char right;
  char shoot; 
  char bomb; 
  char drop;
  float startY;
  
  int weaponType;
  int shootReady;
  int ammo;
  int exhaust;
  
  int invincFrame;
  int coolDown1;
  int coolDown2;
  
  Player()
  {
  }
  
  Player(float newX, float newY, char upKey, char downKey, char leftKey, char rightKey, char shootKey, char bombKey, char dropKey)
  {
    super(newX, newY);
    
    //Read in again at some point
    this.startY = newY;
    this.weaponType = 0;
    this.up = upKey;
    this.down = downKey;
    this.left = leftKey;
    this.right = rightKey;
    this.shoot = shootKey;
    this.bomb = bombKey;
    this. drop = dropKey;
    this.health = 100;
    this.lives = 3;
    this.bombs = 3;
    this.speed = 2*size;
    this.shootReady = 11;
    
    //Just for animation
    this.exhaust = 1;
    
    this.coolDown1 = shootReady;
    this.coolDown2 = shootReady;
    
    this.invincFrame = 25;
  }
  
  void drawObject()
  {
    pushMatrix();
    translate(position.x, position.y);
    
    //Exhaust
    fill(100);
    stroke(100);
    rect((12*size),(4*size),(3*size),(14*size));
    rect(-(12*size),(4*size),-(3*size),(14*size));
    rect(-size,10*size,2*size,2*size);
    
    fill(150,0,0);
    stroke(150,0,0);
    beginShape();
    //Right side of ship
    vertex(0,-4*size);
    vertex(2*size,-3*size);
    vertex(2*size,2*size);
    vertex(6*size,0);
    //-100 is the highest point of ship
    vertex(2*size,-20*size);
    vertex(4*size,-20*size);
    vertex(10*size,2*size);
    //80 is the widest
    vertex(16*size,10*size);
    vertex(16*size,14*size);
    vertex(4*size,14*size);
    vertex(6*size,2*size);
    vertex(2*size,6*size);
    vertex(2*size,10*size);

    //Left side
    vertex(-2*size,10*size);
    vertex(-2*size,6*size);
    vertex(-6*size,2*size);
    //60 is the lowest
    vertex(-4*size,14*size);
    vertex(-16*size,14*size);
    vertex(-16*size,10*size);
    vertex(-10*size,2*size);
    vertex(-4*size,-20*size);
    vertex(-2*size,-20*size);
    vertex(-6*size,0);
    vertex(-2*size,2*size);
    vertex(-2*size,-3*size);
    endShape();
    
    //Cockpit
    fill(100,100,255);
    ellipse(0,0,3*size,10*size);
    
    playerPos = position.x ;
    popMatrix();
    
    if(invincFrame < 25)
    {
      invincFrame++;
    }
  }
  
  void move()
  {   
    this.MoveUP.mult(speed);
    this.MoveDOWN.mult(speed);
    this.MoveLEFT.mult(speed);
    this.MoveRIGHT.mult(speed);
    
    if(start == true && animation == false)
    {
      if(input[up] == true)
      {
        position.add(MoveUP);
        exhaustAnimation();
      }
     
      if(input[down] == true)
      {
        position.add(MoveDOWN);
      }
     
      if(input[left] == true)
      {
        position.add(MoveLEFT);
      }
     
      if(input[right] == true)
      {
        position.add(MoveRIGHT);
      }
      
      if(position.x < 0+16*size)
      {
        position.x = 0+16*size;
      }
    
      if(position.x > width-16*size)
      {
        position.x = width-16*size;
      }
    
      if(position.y < 0+20*size)
      {
        position.y = 0+20*size;
      }
    
      if(position.y > height-18*size)
      {
        position.y = height-18*size;
      }
    }

    MoveUP = new PVector(0,-1);
    MoveDOWN = new PVector(0, 1);
    MoveLEFT = new PVector(-1, 0);
    MoveRIGHT = new PVector(1, 0);
    
  }
  
  void exhaustAnimation()
  {
    pushMatrix();
    translate(position.x,position.y);
    fill(51,153,255);
    triangle((12*size),20*size,15*size,20*size,(12*size+15*size)/2, 25*size);
    triangle(-(12*size),20*size,-15*size,20*size,-(12*size+15*size)/2, 25*size);
    triangle(-size,12*size,size,12*size, 0, 20*size);
    popMatrix();
  }
  
  void startAnimation()
  {
    if(start == true)
    {
      if(position.y > height-(height/4) && animation == true)
      {
        exhaustAnimation();
        for(int i = 0; i < startY/1000; i++)
        {
          position.add(MoveUP);
        }
      }
    }
    
    if(position.y < height-(height/4)+size)
    {
      animation = false;
    }
  }
  
  void guns()
  {
    if(ammo <= 0)
    {
      weaponType = 0;
    }
    
    
    if(ammo > 0)
    {
      weaponType = 1;
    }
    
    if(weaponType == 0)
    {
      //Draw 2 guns
      Defaultweapon defaultweapon1 = new Defaultweapon(weaponType, position.x, position.y, shoot, 15*size, 8*size, 0);
      Defaultweapon defaultweapon2 = new Defaultweapon(weaponType, position.x, position.y, shoot, -15*size, 8*size, 0);
    
      defaultweapon1.drawObject();
      defaultweapon2.drawObject();
    
      if(start == true && animation == false)
      {
        coolDown1 = defaultweapon1.shoot(coolDown1);
        coolDown2 = defaultweapon2.shoot(coolDown2);
      }
      
      if(coolDown1 < shootReady)
      {
        coolDown1++;
        coolDown2++;
      }
    }
    
    if(weaponType == 1)
    {
      //Draw 2  normal guns
      Defaultweapon defaultweapon1 = new Defaultweapon(weaponType, position.x, position.y, shoot, 14*size, 9*size, 0);
      Defaultweapon defaultweapon2 = new Defaultweapon(weaponType, position.x, position.y, shoot, -14*size, 9*size, 0);
      
      //Draw 2 angled guns
      Defaultweapon defaultweapon3 = new Defaultweapon(weaponType, position.x, position.y, shoot, 20*size, size, 0.2f);
      Defaultweapon defaultweapon4 = new Defaultweapon(weaponType, position.x, position.y, shoot, -20*size, size, -0.2f);
      
      defaultweapon1.drawObject();
      defaultweapon2.drawObject();
    
      defaultweapon3.drawObject();
      defaultweapon4.drawObject();
      
      if(start == true && animation == false)
      {
        if(input[shoot] == true)
        {
          ammo--;
        }
        
        println(ammo);
        
        coolDown1 = defaultweapon1.shoot(coolDown1);
        coolDown1 = defaultweapon2.shoot(coolDown1);
        coolDown1 = defaultweapon3.shoot(coolDown1);
        coolDown1 = defaultweapon4.shoot(coolDown1);
      }
    }
  }
  
  void die()
  {
    fill(255);
    rect(5*size,height-(8*size),health,5*size);
    if(health <= 0)
    {
      health = 100;
      lives -= 1;
    }
    
    if(lives == 0)
    {
      Objects.remove(this);
      gameOver = true;
    }
  }
}
