Dino d; //<>// //<>// //<>// //<>// //<>//
obstacle o;
int displayspeed = 1;
int gr;
float velocity = -4;
int frames = 0;
int[] arc = {7, 4, 3, 2};
int pop = 10000;
int gen = 0;
int activationselection = 1;
int maxSpeed = -15;
ArrayList<obstacle> obstacles =  new ArrayList<obstacle>();
ArrayList<Dino> dinos = new ArrayList<Dino>();
ArrayList<Dino> dead = new ArrayList<Dino>();
PImage ovve = loadImage("https://img.itch.zone/aW1hZ2UvNTA5MzIwLzI2NDIzNTEucG5n/347x500/kwmG6Z.png");
PImage hinder = loadImage("https://upload.wikimedia.org/wikipedia/commons/7/7e/Rock-paper-scissors_%28rock%29.png");
PImage aeroplane;
PImage Grass;
PImage backdrop;
NN temp;
void settings() {
  size(500, 500, P2D);
  d = new Dino();
  temp = NN.deserialize();
  println(temp.fitness);
  for (int i = 0; i < pop; i++) {
    dinos.add(new Dino());
    //dinos.get(i).mutate();
  }
  gr = height/2;
  aeroplane = loadImage("Obstacle.png");
  Grass = loadImage("grass2.png");
  backdrop = loadImage("Backdrop.png");
}
void setup() {
  
}
void loadnn(){
  pop = 1;
  dinos.clear();
  dinos.add(new Dino());
 for(int i = 0;i < dinos.size();i++)
    dinos.get(i).nn = temp; 
}
int score = 0;
float speed = 80;
int n = 0;
boolean saved = false;
ArrayList<obstacle> outofframe = new ArrayList<obstacle>();
ArrayList<grass> g = new ArrayList<grass>();
boolean play = false;
void draw() {
  background(0);
  if (play) {
    image(backdrop, 0, 0, width, height);
    if (score>100&&!saved) {
      NN.serialize(dinos.get(0).nn);
      saved = true;
    }
    for (grass s : g)s.show();
    if (random(1)<0.01) {
      g.add(new grass());
    }
    for (int asd = 0; asd < displayspeed; asd++) {

      frames++;
      if (frames%speed == 0) {
        score++;
      }
      if (frames%speed == 0||frames==1) {
        obstacles.add(new obstacle());
        //println((obstacles.get(obstacles.size()-1).i==0));
        n++;
      }
      for (grass s : g)s.update();
      fill(255);
      obstacle k = d.closest();
      for (int i = dinos.size()-1; i >-1; i--) {
        //dinos.get(i).Draw();
        dinos.get(i).Update();
        if (dinos.get(i).collide(k)) {
          dinos.get(i).fitness = frames;
          dinos.get(i).nn.fitness = frames;
          //println(dinos.get(i).fitness);
          dead.add(dinos.get(i));
          dinos.get(i).kill();
          dinos.remove(dinos.get(i));
          //println("DEAD");
        }
      }
      for (int i = obstacles.size()-1; i >= 0; i--) {
        obstacles.get(i).Update();

        if (obstacles.get(i).x<0) { 
          obstacles.remove(i);
        }
      }
      if (velocity>maxSpeed)velocity-=0.01f;
      else velocity-=0.0001f;
      if (dead.size()==pop) {
        nextgen();
      }
    }
    text(dinos.size(), 20, 20);
    text(dead.size(), 20, 40);
    text(gen, 20, 60);
    text(score, width-100, 20);
    text("Club penguin is KIL", 20, height-20);
    for (Dino d : dinos)d.Draw();
    //dinos.get(0).Draw();
    for (obstacle o : obstacles) o.Draw();
  }
  else{
    text("Load nn: press L",width/2,height/2);
    text("Fresh network: press P",width/2,height/2-20);
  }
}

void keyPressed() {
  println(char(keyCode));
  if (keyCode==' '){ d.Jump(); println("space");}
  if (keyCode==DOWN) if (displayspeed>1)displayspeed--;
  if (keyCode == UP) displayspeed++;
  if (keyCode=='1') displayspeed=1;
  if(key=='p'&&!play){
    println('p');
    play=true;
  }
  if(key == 'l'&&!play){
    println('l');
    loadnn();
    play=true;
  }
}
void nextgen() {
  dinos.clear();
  Dino best = new Dino();
  for (Dino d : dead) {
    if (d.score>best.score) {
      best=d; 
      //println(d.fitness);
    }
  }
  NN.serialize(best.nn);
  //println(best.fitness+"||"+frames);
  for (int i = 0; i < pop; i++) {
    dinos.add(best.Cross(dead.get(i)));
  }
  dead.clear();
  obstacles.clear();
  g.clear();
  frames = 0;
  velocity = -4;
  score= 0;
  gen++;
  saved = false;
}
