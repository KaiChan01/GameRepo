class Player extends GameObject
{
  //Fields for player
  int cannon;
  int charge;
  int maxCharge;
  
  char up;
  char down;
  char left;
  char right;
  char shoot; 
  char cannonKey; 
  float startY;
  
  int weaponType;
  int shootReady;
  int ammo;
  int exhaust;
  boolean sound;
  
  int invincFrame;
  int invincColour;
  int coolDown1;
  int coolDown2;

  Player(float newX, float newY, char upKey, char downKey, char leftKey, char rightKey, char shootKey, char cannonKey)
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
    this.cannonKey = cannonKey;
    
    this.health = 100;
    this.lives = 3;
    
    this.maxCharge = 150;
    this.cannon = 3;
    this.charge = 0;
    
    this.speed = 2*size;
    this.shootReady = 11;
    this.sound = false;
    
    //Just for animation
    this.exhaust = 1;
    
    this.coolDown1 = shootReady;
    this.coolDown2 = shootReady;
    this.invincFrame = 50;
    
    MoveDOWN.mult(speed);
    MoveLEFT.mult(speed);
    MoveRIGHT.mult(speed);
  }
  
  void drawObject()
  {
    if(invincFrame == 50)
    {
      this.invincColour = 255;
    }
    else
    {
      this.invincColour = 150;
    }
    
    fill(map(health, 100, 0, 0, 255),map(health, 0, 100, 0, 255), 0);
    stroke(70,100,255);
    //Drawing health
    rectMode(CORNER);
    rect(5*size,height-(28*size),health,5*size);
    
    //Cannon
    rectMode(CORNER);
    fill(map(charge, 0, maxCharge, 200, 0), map(charge, 0, maxCharge, 255, 0), 200);
    rect(width-15*size+(15*size/2), height/2+70*size+(95*size/2), -15*size, map(charge, 0 , maxCharge, 0, -95*size));
    
    //Showing ammo
    if(weaponType == 0)
    {
      fill(255);
      text("---------",width-(40*size),height-(5*size));
    }

    if(weaponType == 1)
    {
      fill(map(ammo, 10000, 0, 0, 255), map(ammo, 0, 10000, 0, 255), map(ammo, 0, 10000, 0, 255));
      text(ammo, width-(40*size),height-(5*size));
    }
    
    //Drawing the Main ship
    rectMode(CORNER);
    //player ship
    pushMatrix();
    shipRender(position.x, position.y, 1);
    popMatrix();
    
    //For swawning Enemy and boss
    playerPos = new PVector(position.x, position.y);
    
    //drawing ships that represent lives
    for(int i = 0; i < lives; i++)
    {
      
      pushMatrix();
      shipRender(55*size+(i*(15*size)),height-(10*size), 0.3);
      popMatrix();
    }
    
    if(invincFrame < 50)
    {
      invincFrame++;
    }
    
    stage = 2;
  }
  
  void shipRender(float x, float y, float scale)
  {
    translate(x, y);
    scale(scale);
    //Exhaust
    fill(100, invincColour);
    stroke(100, invincColour);
    rect((12*size),(4*size),(3*size),(14*size));
    rect(-(12*size),(4*size),-(3*size),(14*size));
    rect(-size,10*size,2*size,2*size);
    
    fill(150,0,0, invincColour);
    stroke(150,0,0, invincColour);
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
    fill(100,100,255, invincColour);
    ellipse(0,0,3*size,10*size);
    
    fill(255,150);
    ellipse(0,0,7*size,7*size);
  }
  
  void move()
  {   
    
    if(stage == 2 && animation == false)
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
  }
  
  void exhaustAnimation()
  {
    pushMatrix();
    translate(position.x,position.y);
    fill(51,153,255);
    triangle((12*size),20*size,15*size,20*size,(12*size+15*size)/2, 25*size);
    triangle(-(12*size),20*size,-15*size,20*size,-(12*size+15*size)/2, 25*size);
    
    //center flame
    triangle(-size,12*size,size,12*size, 0, 20*size);
    popMatrix();
  }
  
  void startAnimation()
  {
    if(stage == 2)
    {
      if(position.y > height-(height/4) && animation == true)
      {
          position.add(MoveUP);
          exhaustAnimation();
      }
    }
    
    if(position.y < height-(height/4)+size)
    {
      animation = false;
      MoveUP.mult(speed);
    }
  }
  
  void guns()
  {
    //If ammo = 0, use defualt weapon
    if(ammo <= 0)
    {
      weaponType = 0;
    }
    
    //Upgrade weapon
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
    
      if(stage == 2 && animation == false)
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
    
    //Upgraded weapon
    if(weaponType == 1)
    {
      coolDown1 = shootReady;
      
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
      
      if(stage == 2 && animation == false)
      { 
        if(input[shoot] == true)
        {
          if(sound == false)
          {
            laser.play();
            sound = true;
          }
          
          //laser.isPlaying() is always true if laser.play() is not surround by an if statement to stop it from playing
          if(laser.isPlaying() == false)
          {
            laser.rewind();
            sound = false;
          }
          
          ammo--;
        }
        else
        {
          laser.pause();
          laser.rewind();
        }
          
        coolDown1 = defaultweapon1.shoot(coolDown1);
        coolDown1 = defaultweapon2.shoot(coolDown1);
        coolDown1 = defaultweapon3.shoot(coolDown1);
        coolDown1 = defaultweapon4.shoot(coolDown1);
      }
    }
    
    //Big cannon
    if(cannon > 0)
    {
      if(input[cannonKey] == true && animation == false)
      {
        cannonFire = false;
        if(charge < maxCharge)
        {
          Charge.play( int(map(charge, 0 , maxCharge, 0 , Charge.length() )));
          charge++;
        }
        
        stroke(0,102,204);
        fill(0,255,255);
        ellipse(position.x, position.y-(20*size), map(charge, 0, maxCharge, 0, 50), map(charge, 0, maxCharge, 0, 50));
        stroke(0,255,255);
        fill(255);
        ellipse(position.x, position.y-(20*size), map(charge, 0, maxCharge, 0, 40), map(charge, 0, maxCharge, 0, 40));
        }
      }
      
      if(charge > 0 && input[cannonKey] == false)
      {
        //Sounds
        Charge.pause();
        release.play( int(map(charge, maxCharge , 0, 0 , release.length() )));
        
        
        cannonFire = true;
        charge -= 2;
        stroke(0,102,204);
        fill(0,255,255);
        ellipse(position.x, position.y-(20*size), map(charge, 0, maxCharge, 0, 50), map(charge, 0, maxCharge, 0, 50));
        stroke(0,255,255);
        fill(255);
        ellipse(position.x, position.y-(20*size), map(charge, 0, maxCharge, 0, 40), map(charge, 0, maxCharge, 0, 40));
        rectMode(CORNERS);
        rect(position.x-map(charge, 0, maxCharge, 0, 2*size), position.y-(20*size), position.x+map(charge, 0, maxCharge, 0, 2*size), -height);
        
        if(charge <= 0)
        {
          cannonFire = false;
        }
      }
    }
  
  void die()
  { 
    if(health <= 0)
    {
      health = 100;
      lives -= 1;
    }
    
    if(lives == 0)
    {
      stage = 3;
      Objects.remove(this);
    }
  }
}
