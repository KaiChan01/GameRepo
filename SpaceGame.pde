/* Assignment 2 
   Author: Ka Yu Chan
   Date: 26/12/15
*/

//For saving score
PrintWriter highScoreFile;

//Sounds
import ddf.minim.*;
Minim minim;

AudioPlayer Menu;
AudioPlayer BGM;
AudioPlayer select;
AudioPlayer helpTrigger;
AudioPlayer gun;
AudioPlayer laser;
AudioPlayer Charge;
AudioPlayer release;

ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<GameObject> Objects = new ArrayList<GameObject>();
ArrayList<Score> HighScore = new ArrayList<Score>();

boolean startGame;

//Game status
boolean finished;
boolean animation;
boolean boss;
boolean bossSpawned;
boolean help;
boolean finalScore;

boolean inputName;

/* Stage of game
   0 = reset variables
   1 = Menu
   2 = Main game
   3 = Game over
   4 = Input name
   5 = Confirm name
   6 = Display scores
   7 =
*/
int stage;

//Check cannon
boolean cannonFire;

//for spawning a few things
int newStars;
int spawn;
int spawnNum;

//Number of bosses defeated
int bossNum;

boolean spawnOne;
PVector playerPos;
float tempPos;

//Player name if highscore is beaten
String name;
String tempName;
String tempName2;
int score;
int tempScore;
int tempScore2;
int index;

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
  startGame = true;
  
  spaceFont = createFont("airstrike.ttf", width/(10*size));
  
  minim = new Minim(this);
  loadSound();
  
  stage = 0;
}

void draw()
{ 
  background(0);
  drawStars();
  
  switch (stage)
  { 
    //Setup variables
    case 0:
    {
      startGame();
      stage = 1;
      break;
      //startGame = false;
    }
  
  //Menu
    case 1:
    {
      menu();
      break;
    }
    
    //Main game, draw, collision etc
    case 2:
    {
      if(finished == false)
      {
        Menu.pause();
        BGM.loop();
        finished = true;
      }
      
      if(score > 10000*bossNum)
      {
        boss = true;
      }
    
      if(boss == false)
      {
        spawn();
      }
    
      if(boss == true && bossSpawned == false)
      {
        boss();
        bossSpawned = true;
      }
    
      //Player info and draw
      playerInfo();
      objectMethods();
      
      //Collision
      checkBullet();
      checkLaser();
      playerCollision();
      
      break;
    }
    
    //GameOver
    case 3:
    {
      GameOver();
      deleteAll();
      break;
    }
    
    //Enter name
    case 4:
    {
        nameConfirm();
        break;
    }
    
    case 5:
    {
      saveScore();
      break;
    }
    
    case 6:
    {
      displayScore();
      deleteAll();
    }
  }
  
  //Toggle help menu
  if(help == true && stage < 3)
  {
    helpMenu();
  }
}

void startGame()
{ 
  animation = false;
  spawnOne = false;
  inputName = false;
  help = false;
  boss = false;
  bossSpawned = false;
  finalScore = false;
  
  playerPos = new PVector(0,0);
  bossNum = 1;
  
  name = "";
  
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
  
  Menu.rewind();
  BGM.rewind();
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
      stage = 2;
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
      tempPos = playerPos.y;
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

void boss()
{
  GameObject Boss = new Boss();
  Objects.add(Boss);
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
  text("+" + (bossNum-1)*1000, 5*size,(25*size));
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
        
        if(enemy instanceof Boss)
        {
          Boss e = (Boss) enemy;
          if(e.eyeHitbox.dist(bullet.position) < (size)+(100*size/2))
          {
            ((BulletHit3) bullet).damage3((Boss)enemy);
            e.hit = true;
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
          if(player.position.dist(object.position) < (7*size)+(5*size/2))
          {
            ((Collide) object).apply((Player)player);
          }
        }
        
        if(object instanceof Enemy || object instanceof Enemy2)
        {
          if(player.position.dist(object.position) < (7*size)+(25*size/2))
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
        
        //Checking if explosion of bomb hits the player
        if(object instanceof Boss)
        {
          Player p = (Player) player;
          Boss e = (Boss) object;
          if(e.bombMode == true)
          {
            println(e.lockOn.dist(p.position));
            println((7*size)+e.explosion);
            if(e.lockOn.dist(p.position) < (7*size)+e.explosion)
            {
              p.health--;
            } 
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
          
          if(enemy instanceof Boss)
          {
            Boss e = (Boss) enemy;
            if( ((e.position.x+(100*size/2)))-p.position.x-map(p.charge, 0, p.maxCharge, 0, size) > 0 &&
                (p.position.x+map(p.charge, 0, p.maxCharge, 0, size))- (e.position.x-(100*size/2))> 0 &&
                 p.position.y > e.position.y)
            {
              e.health -= map(p.charge, 0, p.maxCharge, 0 ,5);
              e.hit = true;
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
  //Final score = score + number of boss defeated, since bossNum = 1 at the beginning I have to minus one at the end
  if(finalScore == false)
  {
    score = score + (1000*(bossNum-1));
    finalScore = true;
  }
  
  //If score is greater than any Highscores, over write
  for(int i = 0; i < HighScore.size() ; i++)
  {
    if(score > HighScore.get(i).score)
    {
      fill(102,255,255);
      stroke(102,255,255);
      textAlign(CENTER);
      text("You beat one of the previous Highscore!", width/2, height/2);
      text("Please enter your name.", width/2, height/2+10*size);
      
      inputName = true;
      
      fill(255,52,255);
      stroke(255,52,255);
      text(name,width/2,height/2+30*size);
    }
    else
    {
      stage = 6;
    }
  } 
}
  
void loadSound()
{
  BGM = minim.loadFile ("BGM.wav");
  Menu = minim.loadFile ("menu.wav");
  select = minim.loadFile ("select.wav");
  helpTrigger = minim.loadFile ("help.wav");
  gun = minim.loadFile ("Gun.wav");
  laser = minim.loadFile("Laser.wav");
  Charge = minim.loadFile("charge.wav");
  release = minim.loadFile("Release.wav");
}

void keyPressed()
{
  input[keyCode] = true;
  
  //tried using input['H'] but it's too fast
  if(key == 'h' && inputName == false)
  {
    helpTrigger.rewind();
    help = !help;
    helpTrigger.play();
  }
  
  if(inputName == true)
  {
    if(name.length() <= 3 && stage < 4)
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
        if(name.length() < 3 && key != ENTER)
        {
          name = name + key;
        }
      }
    }
    
    if(key == ENTER && stage == 3)
    {
      if(name.length() < 1)
      {
        name = "AAA";
      }
      stage = 4;
    }
      
    if(stage == 4)
    {
      if(key == 'y')
      {
        stage = 5;
      }
        
      if(key == 'n')
      {
        stage = 3;
      }
    }
  }
  
  if(stage == 6 && key == 'r')
  {
    deleteScore();
    stage = 0;
  }
}

void nameConfirm()
{
  fill(204,0,204);
  stroke(204,0,204);
  textAlign(CENTER);
  text(name + ", is this correct? Y/N", width/2,height/2+30*size);
}

void saveScore()
{
  //Going from bottom to top
  for(int i = HighScore.size()-1; i > -1; i--)
  {
    if(score > HighScore.get(i).score)
    {
      index = i;
    }
  }
  
  tempName = HighScore.get(index).name;
  tempScore = HighScore.get(index).score;
  
  for(int i = index; i < HighScore.size()-1; i++)
  {
    tempName2 = HighScore.get(i+1).name;
    tempScore2 = HighScore.get(i+1).score;
    
    HighScore.get(i+1).score = tempScore;
    HighScore.get(i+1).name = tempName;
    
    tempName = tempName2;
    tempScore = tempScore2;
  }
  
  HighScore.get(index).name = name;
  HighScore.get(index).score = score;
  
  highScoreFile = createWriter("data/Highscore.csv");
  
  for(int i = 0; i < HighScore.size(); i++)
  {
    highScoreFile.println(HighScore.get(i).name + " " + HighScore.get(i).score);
  }
  highScoreFile.flush();
  highScoreFile.close();
  
  stage = 6;
}

void deleteAll()
{
  for(int i = Objects.size()-1; i > -1; i--)
  {
    Objects.remove(i);
  }
}

void deleteScore()
{
  for(int i = HighScore.size()-1; i > -1; i--)
  {
    HighScore.remove(i);
  }
}
  

void displayScore()
{
  fill(204,0,204);
  stroke(204,0,204);
  
  if(inputName == false)
  {
    text("Sorry, you lose!", width/2,height/2-50*size);
  }
  
  textAlign(CENTER);
  text("Top 5 highscores",width/2,height/2-10*size);
  
  //Display highscore
  for(int i = 0; i < HighScore.size() ; i++)
  {
    text(HighScore.get(i).name + "  " + HighScore.get(i).score, width/2, height/2+((10*size)*(i+1)));
  }
  
  //text("Press 'R' to restart OR 'ESC' to quit", width/2, height/2+70*size);
  
}

void keyReleased()
{
  input[keyCode] = false;
}

