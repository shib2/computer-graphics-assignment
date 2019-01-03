
void setup() {
  size(800,600, P3D);
  surface.setResizable(true);
  colorMode(RGB, 1.0f);
  background(0);
  hint(DISABLE_OPTIMIZED_STROKE);
}
int x=-1;
color c=-16775683;//default color
int count=0;
PVector[] tris=new PVector[5];//I used an Arraylist to store PVectors arrays. In each PVector array, The first three PVectors form a triangle.
//the fourth and fifth PVectors are use to be a kind of descriptor.
//e.g. the fifth PVector.x is stored the scale data for triangles. fifth PVector.y is stored rotate data for trigngles
int index=0;//how many triangles in the arraylist
int[] colors={-16775683,-16711871,-65536,-16711681,-65287,-219,-16742012,-6684545,-7633138,-7698558};//10 colors
int currColor=0;
ArrayList<PVector[]> list = new ArrayList<PVector[]>();//the arraylist to store the PVector arrays
boolean hit=false;
int currTri;//current selected triangle's index in the arraylist
boolean select=false;
int verIndx1=-1,verIndx2=-1;
boolean ver=false;//boolean for hit vertexs
float [] view=new float[3];//the tranlsation data for the view. The index 0 is scale and index 1 and index 2 are translate.

//function to determin whether a point in a triangle
boolean inTri(PVector p,PVector p0,PVector p1,PVector p2){
  
  float s = p0.y * p2.x - p0.x * p2.y + (p2.y - p0.y) * p.x + (p0.x - p2.x) * p.y;
  float t = p0.x * p1.y - p0.y * p1.x + (p0.y - p1.y) * p.x + (p1.x - p0.x) * p.y;

    if ((s < 0) != (t < 0))
        return false;

    float A = -p1.y * p2.x + p0.y * (p2.x - p1.x) + p0.x * (p1.y - p2.y) + p1.x * p2.y;
    if (A < 0.0)
    {
        s = -s;
        t = -t;
        A = -A;
    }
    return s > 0 && t > 0 && (s + t) <= A;
}


void colorPanel(int j ){
for (int i=0;i<10;i++)
{
  strokeWeight(2);
  stroke(0);
  fill(colors[i]);
  rect(i*width/10,height-width/10,width/10,width/10);
}
if(j>-1&&j<10)
{
  strokeWeight(2);
  stroke(1);
  noFill();
  rect(j*width/10,height-width/10,width/10,width/10);
}
}

void draw(){
clear();
colorPanel(x);

//translate(width/2,(height-width/10)/2);
surface.setSize(int(800*(1+view[0])),int(600*(1+view[0])));//resize the window
scale(1+view[0]);//scale the view
//translate(-width/2,-(height-width/10)/2);
translate(view[2],view[1]);//translate the view

for(int i=0;i<index;i++)
{
   if(list.get(i)[3].y==0)
   strokeWeight(1);
   else
   strokeWeight(3);
   stroke(1);
  fill(colors[int(list.get(i)[3].x)]);

  pushMatrix();

  float rotatex=list.get(i)[0].x+list.get(i)[1].x+list.get(i)[2].x;
  float rotatey=list.get(i)[0].y+list.get(i)[1].y+list.get(i)[2].y;
  translate(rotatex/3,rotatey/3);
  rotate(radians(3.75*list.get(i)[4].y));//rotate selected triangle around its center
  scale(1+list.get(i)[4].x);//scale selected triangle
  translate(-rotatex/3,-rotatey/3);

  
  
beginShape(TRIANGLE);
vertex(list.get(i)[0].x,list.get(i)[0].y);
vertex(list.get(i)[1].x,list.get(i)[1].y);
vertex(list.get(i)[2].x,list.get(i)[2].y);
endShape();
  
popMatrix();
}
}


void mousePressed(){
if(mouseY>height-width/10)
{
  x=int(mouseX/(width/10));

  currColor=mouseX/(width/10);
}

if(mouseY<height-width/10)
{

PVector curr=new PVector(mouseX/(1+view[0])-view[1],mouseY/(1+view[0])-view[2]); //<>//
int i=0;
int k=0;
int j=0;
int q=0;
boolean close=false;
boolean last=false;//this boolean is used to determine When click outside of a triangle, whether draw a new triangle or deselecte a selected triangle.
hit=false;
ver=false;
for(i=0;i<index;i++)//determine whether hitting a vertex
{
  for(int n=0;n<3;n++)
  {
  if(list.get(i)[n].dist(curr)<=3)
  {
  verIndx1=i;
  verIndx2=n;
  ver=true;
  hit=true;
  print("hit vertex  ");
  break;
    
  }
  
  
  }
 
  if(inTri(curr,list.get(i)[0],list.get(i)[1],list.get(i)[2]))//determine whether hit a triangle
 {
 print("hit triangle  ");
 hit=true;
 select=true;
 ver=false;
 currTri=i;
 //change the outline of the selected triangle and deselecte other triangles
  list.set(i,setPVectorY(list.get(i),3,1));
  for(int o=0;o<list.size();o++)
  {
    if(o!=i)
     list.set(o,setPVectorY(list.get(o),3,0));
  }
break;
 }
 
  if(!ver){
   hit=false;
   select=false;
   ver=false;
   currTri=-1;
   last=false;

  if(list.get(i)[3].y!=0){
    last=true;
 list.set(i,setPVectorY(list.get(i),3,0));
  }
  if(!last){
   for(k=0;k<3;k++)
   {
     if(list.get(i)[k].dist(curr)<=7&&!ver)//combine the vertex
     {
       print("combining vertex");
     q=i;
     j=k;
     close=true;
     break;
     
     }//end if
   }//end for
 }//end if
 }//end else if
 
}//end for

if(!select&&!last&&!ver)
{
  if(count%3==0)
  {
   
    if(!close)
    tris[0]=new PVector(mouseX/(1+view[0])-view[1],mouseY/(1+view[0])-view[2]);//store the first point for a new triangle
    else
    tris[0]=list.get(q)[j];
    count++;
    print("first point  ");
  }
  else if (count%3==1)
  {
   if(!close)
    tris[1]=new PVector(mouseX/(1+view[0])-view[1],mouseY/(1+view[0])-view[2]);
    else
    tris[1]=list.get(q)[j];
    count++;
    print("second point  ");
  }
  else if (count%3==2)
  {
    if(!close)
    tris[2]=new PVector(mouseX/(1+view[0])-view[1],mouseY/(1+view[0])-view[2]);
    else
    tris[2]=list.get(q)[j];
    
    count=0;
    print("third point  ");
    tris[3]=new PVector(currColor,0);
    
    tris[4]=new PVector(0,0);
 
    list.add(index,tris);//add the triangle into the arraylist
    index++;
    tris=new PVector[5];
  }
}
}//end if
}

void mouseDragged() {

//drag triangle
  if (hit&&select&&currTri!=-1) {
    for(int i=0;i<3;i++){
    list.set(currTri,setPVectorX(list.get(currTri),i,list.get(currTri)[i].x+ (mouseX - pmouseX)/(1+view[0])));
    list.set(currTri,setPVectorY(list.get(currTri),i,list.get(currTri)[i].y+ (mouseY - pmouseY)/(1+view[0])));
    }
  }
  //drag vertex
  else if(hit&&ver){
    PVector a=list.get(verIndx1)[verIndx2];
  for(int j=0;j<list.size();j++)
  {
    for(int k=0;k<3;k++)
    {
    if(list.get(j)[k]==a)
    {
    list.set(j,setPVectorX(list.get(j),k,list.get(j)[k].x+(mouseX - pmouseX)/(1+view[0])));
    list.set(j,setPVectorY(list.get(j),k,list.get(j)[k].y+(mouseY - pmouseY)/(1+view[0])));
    }
    }
  }
  }
}

void mouseReleased() {
  hit = false;
}

void keyPressed() {
  if(key=='c'&&select)
    {
    list.set(currTri,setPVectorX(list.get(currTri),4,list.get(currTri)[4].x+0.1));
  }
  
  if(key=='c'&&!select)
  {
    view[0]+=0.1;
  }
  
  if(key=='v'&&select&&list.get(currTri)[4].x>-1)
  {
 list.set(currTri,setPVectorX(list.get(currTri),4,list.get(currTri)[4].x-0.1));
}

  if(key=='v'&&!select&&view[0]>-1)
  {
   view[0]-=0.1;
  }

  if(key=='e'&&select)
  {
  list.set(currTri,setPVectorY(list.get(currTri),4,list.get(currTri)[4].y+1));
  }
  
  if(key=='r'&&select)
  {
  list.set(currTri,setPVectorY(list.get(currTri),4,list.get(currTri)[4].y-1));
  }
  
  if(key=='w'&&select){
    for(int i=0;i<3;i++){
   list.set(currTri,setPVectorY(list.get(currTri),i,list.get(currTri)[i].y-2));
    }
  }
  
    if(key=='w'&&!select){

    view[1]-=2;
      
  }
  
   if(key=='a'&&select){
    for(int i=0;i<3;i++){
   list.set(currTri,setPVectorX(list.get(currTri),i,list.get(currTri)[i].x-2));
    }
    
  }
  
   if(key=='a'&&!select){
  view[2]-=2;
  }
  
   if(key=='s'&&select){
    for(int i=0;i<3;i++){
  
    list.set(currTri,setPVectorY(list.get(currTri),i,list.get(currTri)[i].y+2));
    }
  }
  
   if(key=='s'&&!select){

      view[1]+=2;
  }
  
   if(key=='d'&&select){
    for(int i=0;i<3;i++){
   list.set(currTri,setPVectorX(list.get(currTri),i,list.get(currTri)[i].x+2));
    }
  }
  
   if(key=='d'&&!select){

      view[2]+=2;
  }
  
  if(key=='z')
  {
  view=new float[3];
  }
}

//The function I created to change x value of a PVector which located in a PVector array is an arraylist
PVector[] setPVectorX(PVector[] a, int index,float x){
  PVector[]b=new PVector[a.length];
  for(int i =0;i<a.length;i++)
  {
    if (i!=index)
    {
      b[i]=a[i];
    }
    else
    {
      b[i]=new PVector(x,a[i].y);
    }

  }
  return b;

}
//The function I created to change y value of a PVector which located in a PVector array is an arraylist
PVector[] setPVectorY(PVector[] a, int index,float y){
  PVector[]b=new PVector[a.length];
  for(int i =0;i<a.length;i++)
  {
    if (i!=index)
    {
      b[i]=a[i];
    }
    else
    {
      b[i]=new PVector(a[i].x,y);
    }
  }
  return b;
}
