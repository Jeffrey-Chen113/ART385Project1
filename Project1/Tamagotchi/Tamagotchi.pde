//Stat initiables
float healthBar;
float hungerBar;
float thirstBar;
float activityBar;
float growthBar;

//Stat Millis Statements
int healthMillis;
int hungerMillis;
int thirstMillis;
int activityMillis;
int growthMillis;

// Game states
int state;
int idle=1;
int moving=2;
int foodMachine=3;
int waterMachine=4;
int gameOver=5;

//PlayerStates
int mood;
int healthy=1;
int neutral=2;
int sad=3;

//These are the variables for the emotes
int opac=50;
final int opacUp=1;
final int opacDown=2;
int opacState=opacDown;

//Boolean for MiniGames
boolean waterGame;
boolean foodGame;

//Placement of Player
int xMove;

void preload() {
}

void setup() {
  xMove=750;
  size(1500,500);
  state=idle;
  waterGame=true;
  foodGame=true;
  healthBar=70.0;
  hungerBar=60.0;
  thirstBar=60.0;
  activityBar=60.0;
  growthBar=0.0;
  healthMillis=millis();
  
}

void draw() {
  background(210, 145, 188);
  if (healthBar>0 && growthBar<100){
    stroke(254, 200, 216);
    fill(254, 200, 216);
    rect(-10,250,1520,350);
    stroke(255, 223, 211);
    fill(255, 223, 211);
    rect(240,150,120,200);
    rect(1140,150,120,200);
    fill(255);
    ellipse(xMove,350,100,100);
    
    //Checks if player character is close enough to water/food source
    checkWater();
    checkFood();
    
    textSize(32);
    fill(255, 223, 211);
    text("water",255,150);
    text("food",1165,150);
    
    //Draws the Stats
    fill(255);
    text(nf(healthBar,2,1), 50, 50); 
    text("health",50,100);
    text(nf(hungerBar,2,1), 200, 50);
    text("Hunger",200,100);
    text(nf(thirstBar,2,1), 350, 50); 
    text("Thirst",350,100);
    text(nf(activityBar,2,1), 500, 50);
    text("Activity",500,100);
    text(nf(growthBar,2,1), 650, 50);
    text("Growth",650,100);
    
    //These functions control the stat bar movements based on millis()
    moveHealth();
    moveHunger();
    moveThirst();
    moveActivity();
    moveGrowth();
  }
  else if (healthBar<0.1){
    text("Game Over",width/2,height/2);
  }
  else if (growthBar>99.9){
    text("You Win!",width/2,height/2);
  }
}

void moveHealth(){
  if (hungerBar>70 && thirstBar>70 && activityBar>70 && healthBar!=99){
    happyFace(xMove-100,295);
    if( millis() > healthMillis + 200 ) {  
      healthBar+=0.1;
      healthMillis = millis();
    }
  }
  else if (hungerBar<40 || thirstBar<40 || activityBar<40){
    sadFace(xMove-100,295);
    if( millis() > healthMillis + 200 ) {  
      healthBar-=0.2;
      healthMillis = millis();
    }
  }
  else{
    neutralFace(xMove-100,295);
  }
}
  
void moveHunger(){
  if(millis() > hungerMillis + 300 ) {  
    hungerBar-=0.1;
    hungerMillis = millis();
  }
}

void moveThirst(){
  if(millis() > thirstMillis + 300 ) {  
    thirstBar-=0.2;
    thirstMillis = millis();
  }
}

void moveActivity(){
  if (activityBar>0.1){
    if(millis() > activityMillis + 25 ) {  
      activityBar-=0.1;
      activityMillis = millis();
    }
  }
}

void moveGrowth(){
  if (healthBar>75){
    if( millis() > growthMillis + 100 ) {  
      growthBar+=0.2;
      growthMillis = millis();
    }
  }
}

//Checks if minigames can be played
void checkWater(){
  if (xMove>250 && xMove<350){
    fill(0,255,0);
    ellipse(xMove,350,100,100);
    state=waterMachine;
  }
}
void checkFood(){
  if (xMove>1150 && xMove<1250){
    fill(0,255,0);
    ellipse(xMove,350,100,100);
    state=foodMachine;
  }
}

void keyPressed(){
  if (keyCode == LEFT){
    if (xMove!=140){
      xMove=xMove-5;
      activityBar+=0.5;
      hungerBar-=0.1;
      state=moving;
    }
  }
  if (keyCode == RIGHT){
    if (xMove!=1340){
      xMove=xMove+5;
      activityBar+=0.5;
      hungerBar-=0.1;
      state=moving;
    }
  }
  if (keyCode == UP){
    if (state==foodMachine && foodGame==true && hungerBar<=99.8){
      hungerBar+=1.5;
      foodGame=false;
    }
    if (state==waterMachine && waterGame==true && thirstBar<=99.8){
      thirstBar+=1.5;
      waterGame=false;
    }
  }
  if (keyCode == DOWN){
    if (state==foodMachine && foodGame==false && hungerBar<=99.8){
      hungerBar+=0.5;
      foodGame=true;
    }
    if (state==waterMachine && waterGame==false && thirstBar<=99.8){
      thirstBar+=0.5;
      waterGame=true;
    }
  }
}
void keyReleased(){
  if (keyCode == LEFT){
    if (xMove!=140){
      xMove=xMove-5;
      state=idle;
    }
  }
  if (keyCode == RIGHT){
    if (xMove!=1340){
      state=idle;
    }
  }
}

void sadFace(int x,int y){
  //Outline
  stroke(0);
  fill(0);
  beginShape();
  rect(0+x,30+y,10,50);
  rect(40+x,0+y,180,10);
  rect(20+x,10+y,20,10);
  rect(10+x,20+y,10,10);
  rect(10+x,80+y,10,10);
  rect(20+x,90+y,20,10);
  rect(40+x,100+y,180,10);
  rect(250+x,30+y,10,50);
  rect(240+x,80+y,10,10);
  rect(220+x,90+y,20,10);
  //FaceColour
  //stroke(217,219,186);
  //fill(217,219,186);//Happy
  stroke(152,214,214);
  fill(152,214,214);//Sad
  beginShape();
  rect(40+x,10+y,200,10);
  rect(20+x,20+y,230,10);
  rect(10+x,30+y,240,50);
  rect(20+x,80+y,220,10);
  rect(40+x,90+y,180,10);
  endShape(CLOSE);
  
  //Left Eye
  stroke(0);
  fill(0);
  beginShape();
  rect(70+x,30+y,20,10);
  rect(60+x,40+y,10,10);
  rect(90+x,40+y,10,10);
  rect(70+x,50+y,20,10);
  //Right Eye
  rect(170+x,30+y,20,10);
  rect(160+x,40+y,10,10);
  rect(190+x,40+y,10,10);
  rect(170+x,50+y,20,10);
  //Smile
  rect(105+x,65+y,10,10);
  rect(115+x,75+y,10,10);
  rect(125+x,75+y,10,10);
  rect(135+x,75+y,10,10);
  rect(145+x,65+y,10,10);
  endShape(CLOSE);
  
  //CryEffects
  stroke(0,20,240,opac);
  fill(0,20,240,opac);
  beginShape();
  rect(70+x,70+y,20,10);
  rect(70+x,80+y,10,10);
  rect(170+x,70+y,20,10);
  rect(170+x,80+y,10,10);
  endShape(CLOSE);
  opacityChange(2);
}

//HappyEmote
void happyFace(int x,int y){
  //Outline
  stroke(0);
  fill(0);
  beginShape();
  rect(0+x,30+y,10,50);
  rect(40+x,0+y,180,10);
  rect(20+x,10+y,20,10);
  rect(10+x,20+y,10,10);
  rect(10+x,80+y,10,10);
  rect(20+x,90+y,20,10);
  rect(40+x,100+y,180,10);
  rect(250+x,30+y,10,50);
  rect(240+x,80+y,10,10);
  rect(220+x,90+y,20,10);
  //FaceColour
  stroke(217,219,186);
  fill(217,219,186);//Happy
  beginShape();
  rect(40+x,10+y,200,10);
  rect(20+x,20+y,230,10);
  rect(10+x,30+y,240,50);
  rect(20+x,80+y,220,10);
  rect(40+x,90+y,180,10);
  endShape(CLOSE);
  
  //HappyEmote
  //Left Eye
  stroke(0);
  fill(0);
  beginShape();
  rect(70+x,30+y,20,10);
  rect(60+x,40+y,10,10);
  rect(90+x,40+y,10,10);
  rect(70+x,50+y,20,10);
  //Right Eye
  rect(170+x,30+y,20,10);
  rect(160+x,40+y,10,10);
  rect(190+x,40+y,10,10);
  rect(170+x,50+y,20,10);
  //Smile
  rect(105+x,65+y,10,10);
  rect(115+x,75+y,10,10);
  rect(125+x,75+y,10,10);
  rect(135+x,75+y,10,10);
  rect(145+x,65+y,10,10);
  endShape(CLOSE);
  
  //BlushEffects
  stroke(255,192,203,opac);
  fill(255,192,203,opac);
  beginShape();
  //LeftCheek
  rect(30+x,60+y,10,10);
  rect(40+x,70+y,10,10);
  rect(50+x,60+y,10,10);
  rect(60+x,70+y,10,10);
  //RightCheek
  rect(200+x,60+y,10,10);
  rect(190+x,70+y,10,10);
  rect(220+x,60+y,10,10);
  rect(210+x,70+y,10,10);
  endShape(CLOSE);
  opacityChange(5);
}
//NeutralFace
void neutralFace(int x,int y){
  //Outline
  stroke(0);
  fill(0);
  beginShape();
  rect(0+x,30+y,10,50);
  rect(40+x,0+y,180,10);
  rect(20+x,10+y,20,10);
  rect(10+x,20+y,10,10);
  rect(10+x,80+y,10,10);
  rect(20+x,90+y,20,10);
  rect(40+x,100+y,180,10);
  rect(250+x,30+y,10,50);
  rect(240+x,80+y,10,10);
  rect(220+x,90+y,20,10);
  //FaceColour
  stroke(217,219,186);
  fill(217,219,186);//Happy
  beginShape();
  rect(40+x,10+y,200,10);
  rect(20+x,20+y,230,10);
  rect(10+x,30+y,240,50);
  rect(20+x,80+y,220,10);
  rect(40+x,90+y,180,10);
  endShape(CLOSE);
  
  //HappyEmote
  //Left Eye
  stroke(0);
  fill(0);
  beginShape();
  rect(70+x,30+y,20,10);
  rect(60+x,40+y,10,10);
  rect(90+x,40+y,10,10);
  rect(70+x,50+y,20,10);
  //Right Eye
  rect(170+x,30+y,20,10);
  rect(160+x,40+y,10,10);
  rect(190+x,40+y,10,10);
  rect(170+x,50+y,20,10);
  //Smile
  rect(115+x,75+y,10,10);
  rect(125+x,75+y,10,10);
  rect(135+x,75+y,10,10);
  endShape(CLOSE);
  
  //BlushEffects
  stroke(255,192,203,opac);
  fill(255,192,203,opac);
  beginShape();
  //LeftCheek
  rect(30+x,60+y,10,10);
  rect(40+x,70+y,10,10);
  rect(50+x,60+y,10,10);
  rect(60+x,70+y,10,10);
  //RightCheek
  rect(200+x,60+y,10,10);
  rect(190+x,70+y,10,10);
  rect(220+x,60+y,10,10);
  rect(210+x,70+y,10,10);
  endShape(CLOSE);
  opacityChange(4);
}

void opacityChange(int emotion){
  if (opacState==opacDown){
    opac=opac+emotion;
    println(opac);
  }
  if (opac>=250 && opacState==opacDown){
    opacState=opacUp;
    println(opac);
  }
  if (opacState==opacUp){
    opac=opac-emotion;
    println(opac);
  }
  if (opac<=50 && opacState==opacUp){
    opacState=opacDown;
    println(opac);
  }
}
