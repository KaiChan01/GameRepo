/* Assignment 2 
   Author: Ka Yu Chan
   Date: 26/12/15
*/
int spawn;
int spawnNum;
boolean spawnOne;

float playerPos;
float tempPos;

//Loading some font
PFont spaceFont;

ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<GameObject> Objects = new ArrayList<GameObject>();

int newStars;
boolean start;
boolean gameOver;
boolean animation;
boolean help;

//used in relation to screen size
float size;

boolean[] input = new boolean[512];

void setup()
{
  size(900,510);
  background(0);
  
  //size is equal to 5
  size = (width-height) / 168;
  
  spaceFont = createFont("airstrike.ttf", width/(10*size));
  start = false;
  gameOver = false;
  animation = false;
  spawnOne = false;
  help = false;
  
  //Making initial Stars
  for(int i = 0; i < 100; i++)
  {
    Star star = new Star((random(0,width)), (random(0,height)));
    stars.add(star);
  }
  
  //Making player test
  GameObject one = new Player(width/2,height+(30*size),'W','S','A','D','J','K','L');
  Objects.add(one);
}

void draw()
{  
  background(0);
  
  for(int i = 0; i < stars.size(); i++)
  {
    Star StarMethods = stars.get(i);
    
    StarMethods.drawObject();
    StarMethods.move();
    StarMethods.die();
  }
  
  //Keep drawing stars
  newStars = int(random(0,6));
  if(newStars == 5)
  {
     Star star = new Star((random(0,width)), 0);
     stars.add(star);
  }
  
  //Moving other objects  
  if(start == false)
  {
    menu();
    if(help == true)
    {
      helpMenu();
    }
  }
  else
  {
    playerInfo();
    
    if(animation == false)
    {
      //Enemies spawn
      spawn = int(random(0,500));
      if(spawn == 20 && spawnOne == false)
      {
        tempPos = playerPos;
        spawnOne = true;
        spawnNum = 5;
      }
   
      if(spawnOne == true)
      {
        if(frameCount%60 == 0)
        {
          GameObject a = new Enemy(tempPos, -50*size);
          Objects.add(a);
          spawnNum --;
        }
          
        if(spawnNum < 1)
        {
          spawnOne = false;
        }
      }
      
      //Spawning second type of enemy
      if(spawn == 50)
      {
        GameObject b = new Enemy2(int(random(0,width)), int(-50*size));
        Objects.add(b);
      }
    }
    
    for(int i = 0; i < Objects.size(); i++)
    {
      GameObject ObjectsMethods = Objects.get(i);
    
      ObjectsMethods.drawObject();
      ObjectsMethods.move();
      
      if((Objects.get(i)) instanceof Player)
      {
        Player a = (Player) Objects.get(i);
        a.guns();
        if(animation == true)
        {
          a.startAnimation();
        }
      }
      
      ObjectsMethods.die();
    }
    println(Objects.size());
    
    checkBullet();
    LivePower();
    CheckEnemyBullet();
    playerCollision();
    checkBullet2();
    
    //Toggle help menu
    if(help == true)
    {
      helpMenu();
    }
  }
}

void menu()
{
  textAlign(CENTER);
  textFont(spaceFont);
  fill(100,100,220);
  stroke(150,150,20);
  
  //Will change name
  text("SPACE BATTLE",width/2,height/10);
  
  if(  mouseX > width/3 
    && mouseX < width-(width/3) 
    && mouseY > (7*(height/10)+32) 
    && mouseY < (9*height/10)+32)
  {
    fill(0,255,255);
    
    if(mousePressed == true)
    {
      start = true;
      animation= true;
    }
  }
    text("Start", width/2, 9*(height/10));
}

void playerInfo()
{
  textAlign(LEFT);
  fill(204,0,204);
  stroke(204,0,204);
  textSize(25);
  text("Health: ", 5*size,height-(10*size));
  textAlign(RIGHT);
  text("Ammo: ",width-(20*size),height-(5*size));
}

void checkBullet()
{
  for(int i = 0; i < Objects.size(); i++)
  {
    GameObject enemy = Objects.get(i);
    if(enemy instanceof Enemy)
    {
      for(int j = 0; j < Objects.size(); j++)
      {
        GameObject bullet = Objects.get(j);
        if(bullet instanceof Bullet)
        {
          if(enemy.position.dist(bullet.position) < (size)+(34*size/2))
          {
            ((BulletHit) bullet).damage((Enemy)enemy);
          }
        }
      }
    }
  }
}

void checkBullet2()
{
  for(int i = 0; i < Objects.size(); i++)
  {
    GameObject enemy = Objects.get(i);
    if(enemy instanceof Enemy2)
    {
      for(int j = 0; j < Objects.size(); j++)
      {
        GameObject bullet = Objects.get(j);
        if(bullet instanceof Bullet)
        {
          if(enemy.position.dist(bullet.position) < (size)+(25*size/2))
          {
            ((BulletHit2) bullet).damage2((Enemy2)enemy);
          }
        }
      }
    }
  }
}

void CheckEnemyBullet()
{
  for(int i = 0; i < Objects.size(); i++)
  {
    GameObject player = Objects.get(i);
    if(player instanceof Player)
    {
      for(int j = 0; j < Objects.size(); j++)
      {
        GameObject eBullet = Objects.get(j);
        if(eBullet instanceof EnemyBullet)
        {
          if(player.position.dist(eBullet.position) < (16*size)+(5*size/2))
          {
            ((EnemyHit) eBullet).hit((Player)player);
          }
        }
      }
    }
  }
}

void playerCollision()
{
  for(int i = 0; i < Objects.size(); i++)
  {
    GameObject player = Objects.get(i);
    if(player instanceof Player)
    {
      for(int j = 0; j < Objects.size(); j++)
      {
        GameObject enemy = Objects.get(j);
        if(enemy instanceof Enemy || enemy instanceof Enemy2)
        {
          if(player.position.dist(enemy.position) < (16*size)+(25*size/2))
          {
            ((Collide) enemy).apply((Player)player);
          }
        }
      }
    }
  }
}

void LivePower()
{
  for(int i = 0; i < Objects.size(); i++)
  {
    GameObject player = Objects.get(i);
    if(player instanceof Player)
    {
      for(int j = 0; j < Objects.size(); j++)
      {
        GameObject live = Objects.get(j);
        if(live instanceof LiveUp)
        {
          if(player.position.dist(live.position) < (16*size)+(10*size/2))
          {
            ((Collide) live).apply((Player)player);
          }
        }
      }
    }
  }
}

void helpMenu()
{
  stroke(0,51,102);
  fill(0);
  rectMode(CENTER);
  rect(width/2,height/2,width-80*size,height-40*size);
  textSize(16*size);
  fill(0,0,204);
  textAlign(CENTER);
  text("CONTROLS AND TIPS",width/2,40*size);
  textSize(10*size);
  textAlign(LEFT);
  text("W - Move up",(50*size),(60*size));
  text("A - Move left",(50*size),(80*size));
  text("S - Move Down",(50*size),(100*size));
  text("D - Move left",(50*size),(120*size));
  rectMode(CORNER);
}

void keyPressed()
{
  input[keyCode] = true;
  
  //tried using input['H'] but it's too fast
  if(key == 'h')
  {
    help = !help;
  }
}

void keyReleased()
{
  input[keyCode] = false;
}

