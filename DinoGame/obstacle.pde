class obstacle {
  int x = width;
  int y = gr;
  int h = 50;
  int w = (int)(h * 0.5);
  int i = 0;
  PImage img;
  obstacle() {
    y = gr;
    i = (int)random(3);

    switch(i) {
    case 0:
      img = hinder;
      y=y;
      break;
    case 1:
      y = y -90;
      w = w * 3;
      img = aeroplane;
      break;
    case 2:
      w = w * 3;
      img = aeroplane;
      y=y-30;
      break;
    }
    x = width;
  }


  void Draw() {
    image(img, x, y, w, -h);
  }

  void Update() {
    x+=velocity;
  }
}
