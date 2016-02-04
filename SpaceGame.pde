/* Assignment 2 
   Author: Ka Yu Chan
   Date: 26/12/15
*/

//Sounds
import ddf.minim.*;
Minim minim;

AudioPlayer Menu;
AudioPlayer BGM;
AudioPlayer select;
AudioPlayer helpTrigger;
AudioPlayer gun;

ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<GameObject> Objects = new ArrayList<GameObject>();
ArrayList<Score> HighScore = new ArrayList<Score>();

//Game status
boolean start;
boolean gameOver;
boolean animation;
boolean inputName;
boolean help;

boolean finished;

//Check cannon
boolean cannonFire;

//for spawning a few things
int newStars;
int spawn;
int spawnNum;
boolean spawnOne;
float playerPos;
float tempPos;

//Player name if highscore is beaten
String name;
int score;

//Loading some font
PFont spaceFont;

//used in relation to screen size
float size;

//Key input, 512 was not enough memory, for example the windows button was arrayoutofbounds
boolean[] input = new boolean[1000];

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
  inputName = false;
  help = false;
  
  name = "";
  
  minim = new Minim(this);
  loadSound();
  
  finished = false;
  
  //Player start with 0
  score = 0;
  
  //Making initial Stars
  for(int i = 0; i < 100; i++)
  {
    Star star = new Star((random(0,width)), (random(0,height)));
    stars.add(star);
  }
  
  //Making player test
  GameObject one = new Player(width/2,height+(30*size),'W','S','A','D','J','K');
  Objects.add(one);
  
  //Read highscore once
  ReadHighScore();
}

void draw()
{  
  background(0);
  drawStars();
  
  //Moving other objects  
  if(start == false)
  {
    menu();
  }
  else
  {
    
    if(finished == false)
    {
      Menu.pause();
      BGM.loop();
      finished = true;
    }
    
    playerInfo();
    spawn();
    objectMethods();
    
    checkBullet();
    checkLaser();
    playerCollision();
    
    if(gameOver == true)
    {
      GameOver();
    }
  }
  
  //Toggle help menu
  if(help == true && inputName == false)
  {
    helpMenu();
  }
}

void drawStars()
{
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
}

void menu()
{
  Menu.play();
  
  textAlign(CENTER);
  textFont(spaceFont);
  fill(127,0,255);
  stroke(150,150,20);
  
  //Will change name
  textSize(50*size);
  text("SPACE BATTLE",width/2,height/2);
  
  textSize(width/(20*size));
  fill(0,102,204);
  text("press 'H' for help", width/2, 7*(height/10));
  
  if(  mouseX > width/3 
    && mouseX < width-(width/3) 
    && mouseY > (7*(height/10)+32) 
    && mouseY < (9*height/10)+32)
  {
    fill(0,255,255);
    
    if(mousePressed == true)
    { 
      select.play();
      start = true;
      animation= true;
    }
  }
  
  textSize(width/(10*size));
  text("Start", width/2, 9*(height/10));
}

void spawn()
{
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
}

//Drawing player first
void objectMethods()
{
  for(int i = Objects.size()-1; i > -1; i--)
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
}

void playerInfo()
{
  textAlign(LEFT);
  fill(204,0,204);
  stroke(204,0,204);
  textSize(25);
  text("Health: ", 5*size,height-(30*size));
  text("Lives: ", 5*size,height-(8*size));
  text("Score: " + score, 5*size,(15*size));
  textAlign(RIGHT);
  text("Ammo",width-(40*size),height-(15*size));
  
  rectMode(CENTER);
  fill(82,82,82);
  stroke(82,82,82);
  rect(width-15*size, height/2+70*size, 20*size, 100*size); 
  
  //Showing cannon charge
  fill(169,169,169);
  stroke(169,169,169);
  rect(width-15*size, height/2+70*size, 15*size, 95*size);
}

//Chec if bullet hit Enemy
void checkBullet()
{
  for(int i = 0; i < Objects.size(); i++)
  {
    GameObject bullet = Objects.get(i);
    if(bullet instanceof Bullet)
    {
      for(int j = 0; j < Objects.size(); j++)
      {
        GameObject enemy = Objects.get(j);
        if(enemy instanceof Enemy)
        {
          if(enemy.position.dist(bullet.position) < (size)+(34*size/2))
          {
            ((BulletHit) bullet).damage((Enemy)enemy);
          }
        }
        
        if(enemy instanceof Enemy2)
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

void playerCollision()
{
  for(int i = 0; i < Objects.size(); i++)
  {
    GameObject player = Objects.get(i);
    if(player instanceof Player)
    {
      for(int j = 0; j < Objects.size(); j++)
      {
        GameObject object = Objects.get(j);
        if(object instanceof EnemyBullet)
        {
          if(player.position.dist(object.position) < (16*size)+(5*size/2))
          {
            ((Collide) object).apply((Player)player);
          }
        }
        
        if(object instanceof Enemy || object instanceof Enemy2)
        {
          if(player.position.dist(object.position) < (16*size)+(25*size/2))
          {
            ((Collide) object).apply((Player)player);
          }
        }
        
        if(object instanceof LiveUp || object instanceof GunPowerUp)
        {
          if(player.position.dist(object.position) < (16*size)+(10*size/2))
          {
            ((Collide) object).apply((Player)player);
          }
        }
      }
    }
  }
}

//check if laser hits
void checkLaser()
{
  if(cannonFire == true)
  {
    for(int i = 0; i < Objects.size(); i++)
    {
      GameObject player = Objects.get(i);
      if(player instanceof Player)
      {
        Player p = (Player) player;
        for(int j = 0; j < Objects.size(); j++)
        {
          GameObject enemy = Objects.get(j);
          if(enemy instanceof Enemy)
          {
            if( ((enemy.position.x+(25*size/2)))-p.position.x-map(p.charge, 0, p.maxCharge, 0, size) > 0 &&
                (p.position.x+map(p.charge, 0, p.maxCharge, 0, size))- (enemy.position.x-(25*size/2))> 0 &&
                 p.position.y > enemy.position.y)
            {
              Enemy e = (Enemy) enemy;
              e.health -= map(p.charge, 0, p.maxCharge, 0 ,20);
            }
          }
          
          if(enemy instanceof Enemy2)
          {
            if( ((enemy.position.x+(30*size/2)))-p.position.x-map(p.charge, 0, p.maxCharge, 0, size) > 0 &&
                (p.position.x+map(p.charge, 0, p.maxCharge, 0, size))- (enemy.position.x-(30*size/2))> 0 &&
                 p.position.y > enemy.position.y)
            {
              Enemy2 e = (Enemy2) enemy;
              e.health -= map(p.charge, 0, p.maxCharge, 0 ,15);
            }
          }
        }
      }
    }
  }   
}

void helpMenu()
{
  stroke(0,51,102);
  fill(0, 220);
  rectMode(CENTER);
  rect(width/2,height/2,width-80*size,height-40*size);
  textSize(16*size);
  fill(0,255,255);
  textAlign(CENTER);
  text("CONTROLS AND TIPS",width/2,40*size);
  text("*Help Menu does not pause the game!!*",width/2,220*size);
  textSize(10*size);
  textAlign(LEFT);
  text("W - Move up",(70*size),(80*size));
  text("A - Move left",(70*size),(100*size));
  text("S - Move Down",(70*size),(120*size));
  text("D - Move left",(70*size),(140*size));
  
  text("J - Shoot",(250*size),(80*size));
  text("K - Hold to Charge cannon",(250*size),(100*size));
  text("- Ammo for Machine Gun", (260*size),(142*size));
  text("- Restore one live (MAX 3)", (260*size),(174*size));
  
  //Showing power ups
  pushMatrix();
  translate(245*size,140*size);
  stroke(51,255,153);
  fill(255,0,0);
  ellipse(0,0,15*size,15*size);
  fill(51,255,51);
  text("M",0,0);
  popMatrix();
  
  pushMatrix();
  translate(245*size,170*size);
  stroke(51,255,153);
  fill(255,255,0);
  ellipse(0,0,15*size,15*size);
  fill(25,51,0);
  text("1Up",0,0);
  popMatrix();
  
  rectMode(CORNER);
}

void ReadHighScore()
{
  String[] s = loadStrings("Highscore.csv");
  for(String playerScore: s)
  {
    Score score = new Score(playerScore);
    HighScore.add(score);
  }
}

void GameOver()
{
  //If score is greater than any Highscores, over write
  for(int i = 0; i < HighScore.size() ; i++)
  {
    if(score > HighScore.get(i).score)
    {
      text("You beat one of the previous Highscore", 100, 100);
      enterName();
      
      HighScore.get(i).score = score;
      i = HighScore.size();
    }
  }
     
  
  //Display highscore
  for(int i = 0; i < HighScore.size() ; i++)
  {
    text(HighScore.get(i).name + "   " + HighScore.get(i).score, 100,100);
  } 
}

void enterName()
{
  inputName = true;
}
  
void loadSound()
{
  BGM = minim.loadFile ("BGM.wav");
  Menu = minim.loadFile ("menu.wav");
  select = minim.loadFile ("select.wav");
  helpTrigger = minim.loadFile ("help.wav");
  gun = minim.loadFile ("Gun.wav");
}

void keyPressed()
{
  input[keyCode] = true;
  
  //tried using input['H'] but it's too fast
  if(key == 'h')
  {
    helpTrigger.rewind();
    help = !help;
    helpTrigger.play();
  }
  
  if(inputName == true)
  {
    if(name.length() <= 3)
    {
      if(key == BACKSPACE)
      {
        if(name.length() > 0)
        {
          name = name.substring(0, name.length()-1);
        }
      }
      else
      {
        if(name.length() < 3)
        {
          name = name + key;
          println(name);
        }
      }
    }
  }
}

void keyReleased()
{
  input[keyCode] = false;
}

