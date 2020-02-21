class grass{
 int x = width;
 int h = 20;
 int w = h*4;
 grass(){
 }
 void show(){
  image(Grass,x,gr,w,-h); 
 }
 void update(){
  x+=velocity; 
 }
  
  
}
