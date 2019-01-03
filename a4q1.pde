int[] position = { 0, 0, 0 };
int facing = 0;
int count = 0;
boolean a,d;
float turn=0;
float b=0;
PImage texture0, texture1, texture2, texture3,texture4,texture5;
float rotationX = 1;
float rotationY = 1;
float velocityX = 1;
float velocityY = 1;
float pos=0.4;
Can s;

void setup() {
  size(800, 640, P3D);
  colorMode(RGB, 1);
  strokeWeight(3.5);
  frustum(-float(width)/height, float(width)/height, 1, -1, 2, 9);
  resetMatrix();
  textureMode(NORMAL);
  texture0 = loadImage("assets/3490.jpg");
  texture1 = loadImage("assets/Floor.jpg");
  texture2 = loadImage("assets/sphere1.jpg");
  texture3 = loadImage("assets/box1.png");
  texture4 = loadImage("assets/tex1.png");
  texture5 = loadImage("assets/tex2.png");
  textureWrap(REPEAT);
  s=new Can(0.3, 0.4, 32, texture3);
}

void draw() {
  background(1);
  turn();
  translate(0, -1.5, -2);
  rotateY(-turn * PI/2);
  translate(-position[0], 0, -position[2]);
  
  walls_and_exhibits();

  for (int z = -3; z <=3; z++) {
    for (int x = -3; x <= 3; x++) {
      
      // floor
      if ((x + z) % 2 == 0) {
       beginShape(QUADS);
       texture(texture1);
      vertex(x-0.5, 0, z-0.5,0,0);
      vertex(x+0.5, 0, z-0.5,1,0);
      vertex(x+0.5, 0, z+0.5,1,1);
      vertex(x-0.5, 0, z+0.5,0,1);
      endShape();
      } 
      
      else {
      beginShape(QUADS);
       texture(texture1);
      vertex(x-0.5, 0, z-0.5,0,0);
      vertex(x+0.5, 0, z-0.5,0,1);
      vertex(x+0.5, 0, z+0.5,1,1);
      vertex(x-0.5, 0, z+0.5,1,0);
      endShape();
      }
    }
  }
}


void keyPressed() {
  switch (key) {
  case 'w':
 position[0] += (facing % 2) * (facing % 4 == 1 ? -1 : 1);
 if(position[2]==1||position[2]==-1)
 {
   if(position[0]==1||position[0]==-1)
   {
   position[0] -= (facing % 2) * (facing % 4 == 1 ? -1 : 1); //<>//
   }
 }
   if(position[0]==-4)
   position[0]=-3;
   if(position[0]==4)
   position[0]=3;
 position[2] += ((facing + 1) % 2) * (facing % 4 == 0 ? -1 : 1);
  if(position[0]==1||position[0]==-1)
 {
   if(position[2]==1||position[2]==-1)
   {
   position[2] -= ((facing + 1) % 2) * (facing % 4 == 0 ? -1 : 1);
   }
 }
   if(position[2]==-4)
   position[2]=-3;
   if(position[2]==4)
   position[2]=3;
    break;
    
  case 'a':
    b+=1;
    facing = (facing + 1) % 4;
    a=true;
    d=false;
    break;
    
  case 's':
   position[0] -= (facing % 2) * (facing % 4 == 1 ? -1 : 1); 
    if(position[2]==1||position[2]==-1)
 {
   if(position[0]==1||position[0]==-1)
   {
   position[0] += (facing % 2) * (facing % 4 == 1 ? -1 : 1);
   }
 }
  if(position[0]==-4)
   position[0]=-3;
  if(position[0]==4)
   position[0]=3;
   position[2] -= ((facing + 1) % 2) * (facing % 4 == 0 ? -1 : 1); 
   if(position[0]==1||position[0]==-1)
 {
   if(position[2]==1||position[2]==-1)
   {
   position[2] += ((facing + 1) % 2) * (facing % 4 == 0 ? -1 : 1);
   }
 }
   if(position[2]==-4)
   position[2]=-3;
   if(position[2]==4)
   position[2]=3;
    break;
    
  case 'd':
    b-=1;
    facing = (facing + 3) % 4;
    d=true;
    a=false;
    break;
  }
}

void turn()
{
  if(a&&turn<=b)
    turn+=0.05;
  if(a&&turn>b)
      turn=floor(turn);
   if (d&&turn>=b)
    turn-=0.05;
   if(d&&turn<b)
      turn=ceil(turn);
}



void walls_and_exhibits()
{
  pushMatrix();
  translate(1, pos, -1);
  rotateX( radians(-rotationX) );  
  rotateY( radians(270 - rotationY) );
  
  s.display(); //interactive can
  popMatrix();
  rotationX += velocityX;
  rotationY += velocityY;
  velocityX *= 0.95;
  velocityY *= 0.95;
//interactions
  if(mousePressed&&mouseY>height/2&&mouseX>width/3){
    velocityX += (mouseY-pmouseY)*0.1 ;
  }
  if (mousePressed&&mouseY<height/2&&mouseX>width/3)
  {
    velocityY -= (mouseX-pmouseX)*0.05 ;
  }
  if(mousePressed&&mouseX<width/3){
    if(pos>=0.4&&pos<=2)
  pos-=(mouseY-pmouseY)*0.005 ;
  if(pos<0.4)
  pos=0.4;
  if(pos>2)
  pos=2;
  }
  
  //three other cubes
 pushMatrix();
  translate(-1, 0.3, -1);
  scale(2.5);
 hand_code_cube(texture4);
  popMatrix();
   pushMatrix();
  translate(1, 0.3, 1);
  scale(2.5);
 hand_code_cube(texture2);
  popMatrix();
   pushMatrix();
  translate(-1, 0.3, 1);
  scale(2.5);
 hand_code_cube(texture5);
  popMatrix();
  
  
  //walls
  pushMatrix();
  translate(0,0,-3.5);

  beginShape(QUADS);
   texture(texture0);
      vertex(-3.5, 0, 0,0,0);
      vertex(-3.5, 5, 0,0,1);
      vertex(3.5, 5, 0,0.7,1);
      vertex(3.5, 0, 0,0.7,0);
      endShape();
  popMatrix();
  pushMatrix();
  translate(0,0,3.5);
  fill(1,0,0);
  beginShape(QUADS);
      texture(texture0);
      vertex(-3.5, 0, 0,0,0);
      vertex(-3.5, 5, 0,0,1);
      vertex(3.5, 5, 0,0.7,1);
      vertex(3.5, 0, 0,0.7,0);
      endShape();
  popMatrix();


pushMatrix();
rotateY(PI/2);
  translate(0,0,-3.5);
  fill(1,0,0);
  beginShape(QUADS);
    texture(texture0);
      vertex(-3.5, 0, 0,0,0);
      vertex(-3.5, 5, 0,0,1);
      vertex(3.5, 5, 0,0.7,1);
      vertex(3.5, 0, 0,0.7,0);
      endShape();
  popMatrix();
  
  pushMatrix();
rotateY(-PI/2);
  translate(0,0,-3.5);
  fill(1,0,0);
  beginShape(QUADS);
     texture(texture0);
      vertex(-3.5, 0, 0,0,0);
      vertex(-3.5, 5, 0,0,1);
      vertex(3.5, 5, 0,0.7,1);
      vertex(3.5, 0, 0,0.7,0);
      endShape();
  popMatrix();




}


void hand_code_cube(PImage a)
{
strokeWeight(0.4);
pushMatrix(); 

beginShape(QUADS);
 texture(a);
  
  vertex(-0.1,-0.1,0.1,0,0);
  vertex(-0.1,0.1,0.1,0,1);
  vertex(0.1,0.1,0.1,1,1);
  vertex(0.1,-0.1,0.1,1,0);
  

  vertex(0.1,-0.1,0.1,0,0);
  vertex(0.1,-0.1,-0.1,0,1);
  vertex(0.1,0.1,-0.1,1,1);
  vertex(0.1,0.1,0.1,1,0);


  vertex(0.1,-0.1,-0.1,0,0);
  vertex(-0.1,-0.1,-0.1,0,1);
  vertex(-0.1,0.1,-0.1,1,1);
  vertex(0.1,0.1,-0.1,1,0);


  vertex(-0.1,-0.1,-0.1,0,0);
  vertex(-0.1,-0.1,0.1,0,1);
  vertex(-0.1,0.1,0.1,1,1);
  vertex(-0.1,0.1,-0.1,1,0);


  vertex(-0.1,0.1,0.1,0,0);
  vertex(0.1,0.1,0.1,0,1);
  vertex(0.1,0.1,-0.1,1,1);
  vertex(-0.1,0.1,-0.1,1,0);

  vertex(0.1,-0.1,0.1,0,0);
  vertex(-0.1,-0.1,0.1,0,1);
  vertex(-0.1,-0.1,-0.1,1,1);
  vertex(0.1,-0.1,-0.1,1,0);
  endShape();
popMatrix(); 

}









class Can{

float r;
float h;
int detail;
PImage tex;

Can(float r_, float h_, int detail_, PImage tex_){
r=r_;
h=h_;
detail=detail_;
tex=tex_;
}


void display() {
  beginShape(QUAD_STRIP);
  noStroke();
  texture(tex);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    normal(x, 0, z);
    vertex(x * r, -h/2, z * r, u, 0);
    vertex(x * r, +h/2, z * r, u, 1);    
  }
  endShape(); 
}


}
