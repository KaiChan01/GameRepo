class Player extends GameObject
{
  //Fields for players
  float bombs;
  char up;
  char down;
  char left;
  char right;
  char shoot; 
  char bomb; 
  char drop;
  float startY;
  
  Player()
  {
    super(width/2, height/2);
  }
  
  Player(float newX, float newY, char upKey, char downKey, char leftKey, char rightKey, char shootKey, char bombKey, char dropKey)
  {
    super(newX, newY);
    
    //Read in again at some point
    this.startY = newY;
    
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
    this.speed = size;
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
    popMatrix();
  }
  
  void guns()
  {
  }
  
  void move()
  {   
    MoveUP.mult(speed);
    MoveDOWN.mult(speed);
    MoveLEFT.mult(speed);
    MoveRIGHT.mult(speed);
    
    if(start == true && animation == false)
    {
      if(input[up] == true)
      {
        position.add(MoveUP);
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
  
  void startAnimation()
  {
    if(start == true)
    {
      println(animation);
      if(position.y > height-(height/4) && animation == true)
      {
        println("yay");
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
  
  void die()
  {
  }
}
