float eyeX = 2.3, eyeY = 2.1, eyeZ = -0.3, centerX = 0, centerY = 0.3, centerZ = -2, upX = 0, upY = 1, upZ = 0;
boolean perspective = false;
float a=0;
float b=0;
float c=0;
float d=PI/24;
float e=0;
boolean[] bools=new boolean[11];
boolean back;

Claw claw=new Claw ();

void setup() {
  size(640, 640, P3D);
  hint(DISABLE_OPTIMIZED_STROKE);
}

void draw() {
  
background(151,151,254);
  if (perspective)
    frustum(-1, 1, 1, -1, 1, 8);
  else
    ortho(-1, 1, 1, -1, 1, 8);
resetMatrix();
stroke(255,255,255);
camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
pushMatrix();
translate(-0.8,-0.8,-2);
drawPrizes();
popMatrix();
claw.display();
claw.update();
    }




void drawPrizes()
{
sphere(0.05);
translate(0,-0.12,0);
sphere(0.07);
}






class Claw{

Claw(){}


void update(){
if(bools[0]&&d<PI/4)
  d += PI/96;
if(bools[1]&&d>PI/24)
  d -= PI/96;
if(bools[2])
  a+=PI/80;
if(bools[3]&&b<0.45)
  b+=0.01;
if(bools[4])
  c += PI/40;
if(bools[5])
  a-=PI/80;
if(bools[6]&&b>-0.45)
  b-=0.01;
if(bools[7])
  c -= PI/40;
if(bools[8]&&e<0.5)
  e+=0.01;
if(bools[9]&&e>0)
  e-=0.01;
if(bools[10])
  sequence();
  
}


void sequence ()
{if(!back){
  if(d<PI/4)
  d += PI/96;
  else if(e<0.5)
  e+=0.01;
  if(d>=PI/4&&e>=0.5)
  back=true;
}
else{
 if(d>PI/24)
 d -= PI/96;
else if(e>0)
e-=0.01;
if(d<=PI/24&&e<=0)
{
back=false;
bools[10]=false;
}
}
}

void hand_code_cube()
{
fill(0);
stroke(255);
pushMatrix(); 

beginShape(QUADS);

  fill(255,0,0);
  vertex(-0.1,-0.1,0.1);
  vertex(-0.1,0.1,0.1);
  vertex(0.1,0.1,0.1);
  vertex(0.1,-0.1,0.1);
  
fill(0,255,0);
  vertex(0.1,-0.1,0.1);
  vertex(0.1,-0.1,-0.1);
  vertex(0.1,0.1,-0.1);
  vertex(0.1,0.1,0.1);

 fill(0,0,255);
  vertex(0.1,-0.1,-0.1);
  vertex(-0.1,-0.1,-0.1);
  vertex(-0.1,0.1,-0.1);
  vertex(0.1,0.1,-0.1);

fill(0,255,255);
  vertex(-0.1,-0.1,-0.1);
  vertex(-0.1,-0.1,0.1);
  vertex(-0.1,0.1,0.1);
  vertex(-0.1,0.1,-0.1);

 fill(255,0,255);
  vertex(-0.1,0.1,0.1);
  vertex(0.1,0.1,0.1);
  vertex(0.1,0.1,-0.1);
  vertex(-0.1,0.1,-0.1);

 fill(255,255,0);
  vertex(0.1,-0.1,0.1);
  vertex(-0.1,-0.1,0.1);
  vertex(-0.1,-0.1,-0.1);
  vertex(0.1,-0.1,-0.1);
  endShape();
popMatrix(); 

}

 
 
void display(){
pushMatrix();
translate(0,0.9,-2);
hand_code_cube();//hand code highest black cube
popMatrix();
pushMatrix();
translate(0,0.775,-1.98);
rotateY(a);
fill(52,52,53);
box(0.05,0.05,0.9);//gary bar

translate(0,-0.075,b);
fill(0,0,255);
box(0.1);//blue cube
translate(0,-0.305-0.5*e,0);
fill(225,255,55);
box(0.01,0.5+e,0.01);//yellow chain
translate(0,-0.303-0.5*e,0);
fill(255,0,0);
rotateY(c);
box(0.1);// red cube

fill(180,180,200);
scale(1,-1,1);//upside down y-direction in order to rotate easier
translate(-0.03,0.085,0);
rotateZ(d);
//left partical claw
box(0.025,0.085,0.025);
pushMatrix();
translate(0,0.043,0);
sphere(0.02);
translate(0.015,0.043,0);
rotateZ(-PI/6);
box(0.025,0.085,0.025);
popMatrix();
//right partical claw
rotateZ(-d);
translate(0.06,0,0);
rotateZ(-d);
box(0.025,0.09,0.025);
pushMatrix();
translate(0,0.043,0);
sphere(0.02);
translate(-0.015,0.043,0);
rotateZ(PI/6);
box(0.025,0.085,0.025);
popMatrix();
popMatrix();
  }//end display
}//end Claw class


void keyPressed() {
  switch (key) {
   case '1':
    eyeX=2;
    eyeY=0;
    eyeZ=0;
    centerX=0;
    centerY=0.3;
    centerZ=-2;
    upX=0;
    upY=1;
    upZ=0;
    break;
   case '2':
    eyeX=2.3;
    eyeY=2.1;
    eyeZ=-0.3;
    centerX=0;
    centerY=0.3;
    centerZ=-2;
    upX=0;
    upY=1;
    upZ=0;
    break;
   case '3':
    eyeX=2.6;
    eyeY=-2.7;
    eyeZ=-6.3;
    centerX=0;
    centerY=0.3;
    centerZ=-2;
    upX=0;
    upY=1;
    upZ=0;
    break;
  
  case 'x':
    bools[0]=!bools[0];
    if(bools[1])
    bools[1]=!bools[1];
    break;
  case 'c':
    bools[1]=!bools[1];
    if(bools[0])
    bools[0]=!bools[0];
    break;
  case 'q':
    bools[2]=!bools[2];
    if(bools[5])
    bools[5]=!bools[5];
    break;
  case 'e':
    bools[3]=!bools[3];
    if(bools[6])
    bools[6]=!bools[6];
    break;
  case 's':
    bools[4]=!bools[4];
    if(bools[7])
    bools[7]=!bools[7];
    break;
  case 'w':
    bools[5]=!bools[5];
    if(bools[2])
    bools[2]=!bools[2];
    break;
  case 'r':
   bools[6]=!bools[6];
   if(bools[3])
   bools[3]=!bools[3];
   break;
  case 'd':
    bools[7]=!bools[7];
    if(bools[4])
    bools[4]=!bools[4];
    break;
   case 'z':
    bools[8]=!bools[8];
    if(bools[9])
    bools[9]=!bools[9];
    break;
   case 'a':
    bools[9]=!bools[9];
    if(bools[8])
    bools[8]=!bools[8];
    break;
  case 'o':
    perspective = false;
    break;
   case 'p':
    perspective = true;
    break;
    case ' ':
    bools[10]=true;
    if(bools[8])
    bools[8]=!bools[8];
    if(bools[9])
    bools[9]=!bools[9];
    break;
    
  }
  println("\n");
  println("eye    = (", eyeX+"," , eyeY+"," , eyeZ+"," , ")"); 
  println("center = (", centerX+"," , centerY+"," , centerZ+"," , ")"); 
  println("up     = (", upX+"," , upY+"," , upZ+"," , ")"); 
}
