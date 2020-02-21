class Dino { //<>// //<>// //<>// //<>// //<>//
  int x = (int)(width*0.3);
  float y = height/2;
  int h = 50;
  int hc = h/2;
  int w = (int)(h );
  float g = 1;
  float v = 0;
  float acc = 14;
  boolean jumping = false;
  int cf = 0;
  boolean crouching = false;
  int n = 0;
  int delay = 10;
  int score = 0;
  int fitness;
  NN nn = new NN(arc, activationselection);
  Dino() {
    nn.mutate();
    nn.mutate();
  }

  void crouch() {
    h = hc;
    n = 0;
    crouching = true;
  }
  void Draw() {
   
    image(ovve,x, y, w, -h);
    //rect(x, y, w, -h);
  }
  boolean collide(obstacle i) {

    if (i.x <= x+w&&i.x+i.w >= x) {
      if (i.y>=y-h&&i.y-i.h<=y) {
        fill(255);
        return true;
      }
    }

    fill(255);
    return false;
  }
  void uncrouch() { 
    h = hc*2;
    n = 0;
  }
  obstacle closest() {
    obstacle closest = new obstacle();
    for (obstacle o : obstacles) {
      if (abs(closest.x-x)>abs(o.x-x)) {
        closest = o;
      }
    }
    return closest;
  }
  void kill() {
    score =  frames;
  }
  void Update() {
    if(y >gr)y = gr;
    obstacle closest = closest();
    float rx = map(x, 0, width, 0, 1);
    float ry = map(y, 0, height, 0, 1);
    float rcy = map(closest.y, 0, height, 0, 1);
    float rcx = map(closest.x, 0, width, 0, 1);
    float rv = map(velocity, -4, maxSpeed, 0, 1);
    float[] ans = nn.ff(new float[]{rx, ry, rcy, rcx, rv,v/12,h/50});
    switch(largest(ans)){
     case 0:
     Jump();
     break;
     case 1:
     crouch();
     break;
    }
    y += v;
    if (y<=gr) {
      v+= g;
    } else {
      v = 0;
    }
     if (n>=delay) crouching = false;
    if (crouching)n++;
    if (!crouching)uncrouch();
  }
  void jumping() {
  }
  void Jump() {
    if (y>=gr) {
      v-=acc;
    }
  }
  Dino Cross(Dino B) {
    Dino d = new Dino();
    d.nn.IH = Matrix.nCross(this.nn.IH, B.nn.IH, this.fitness, B.fitness);
    for (int i = 0; i < this.nn.HH.length; i++) {
      d.nn.HH[i] = Matrix.nCross(this.nn.HH[i], B.nn.HH[i], this.fitness, B.fitness);
    }
    d.nn.HO = Matrix.nCross(this.nn.HO, B.nn.HO, this.fitness, B.fitness);
    d.mutate();
    d.mutate();
    return d;
  }
  void mutate() {
    this.nn.mutate();
  }
}
int largest(float[] a){
  float[] temp = new float[]{a[0],a[1],0.5};
 int index = 0;
 for(int i = 0; i < a.length; i++){
   if(temp[i]>temp[index])index = i; 
 }
 return index;
}
