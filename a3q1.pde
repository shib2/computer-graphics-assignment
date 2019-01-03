Ball[] balls =  { 
  new Ball(100, 100, 60), 
  new Ball(300, 300, 60),
  new Ball(500, 500, 60),
  new Ball(400, 100, 60),
  new Ball(100, 500, 60) 
};

color from = color(255, 255, 0);
color to = color(255, 0, 0);
boolean hit;
int index;
float a=0;
boolean b=false;

void setup() {
  size(640, 640,P3D); 
}


void draw() {
 clear();
if(b==false)
  a+=0.005;
  else
  a-=0.005;
if(a>0.99)
  b=true;
if(a<0.01)
b=false;

  for (int i=0;i<balls.length;i++) {
     balls[i].update();
     balls[i].display(a);
     balls[i].checkBoundary();
  }
  for(int i=0;i<balls.length;i++)
  {
    for(int j=0;j<balls.length;j++)
    {
      if(j!=i)
  balls[i].check2dCollision(balls[j]);
    }
  }

}



class Ball {
  PVector position;
  PVector velocity;
  boolean hitt;
  float radius, m;

  Ball(float x, float y, float r_) {
    position = new PVector(x, y);
    velocity = PVector.random2D();
    velocity.mult(4);
    radius = r_;
    m = 10;
    hitt=false;
  }

  void update() {
    if(!hitt)
    position.add(velocity);
    else
    position.add(mouseX-pmouseX,mouseY-pmouseY);
  }

  void checkBoundary() {
    if (position.x > width-radius) {
      position.x = width-radius;
      velocity.x *= -1;
    } else if (position.x < radius) {
      position.x = radius;
      velocity.x *= -1;
    } else if (position.y > height-radius) {
      position.y = height-radius;
      velocity.y *= -1;
    } else if (position.y < radius) {
      position.y = radius;
      velocity.y *= -1;
    }
  }



  void check2dCollision(Ball other) {
    
    PVector dis = PVector.sub(other.position, position);

    float disMag = dis.mag();

    if (disMag < 2*radius) {
      //move them equally to the 2*radius distance position
      PVector normal = dis.copy().normalize().mult(((2*radius-disMag)/2)+velocity.mag()+other.velocity.mag());
      other.position.add(normal);
      position.sub(normal);
      
      float sin = sin(dis.heading());
      float cos = cos(dis.heading());

      //exchange the normal velocity, in this case, the masses are the same, just simplely exchange.
      PVector velo1=new PVector(cos * other.velocity.x + sin * other.velocity.y,cos * velocity.y - sin * velocity.x);
      PVector other_velo1=new PVector(cos * velocity.x + sin * velocity.y,cos * other.velocity.y - sin * other.velocity.x);

      // update velocity
      velocity.set(new PVector(cos * velo1.x - sin * velo1.y,cos * velo1.y + sin * velo1.x));
      other.velocity.set(new PVector(cos * other_velo1.x - sin * other_velo1.y,cos * other_velo1.y + sin*other_velo1.x));
    }
  }

  void display(float a) {
    noStroke();
    color interA = lerpColor(from, to, a);
    fill(interA);
    ellipse(position.x, position.y, radius*2, radius*2);
  }
}


void mousePressed() {
for(int i=0;i<balls.length;i++){
if(dist(mouseX,mouseY,balls[i].position.x,balls[i].position.y)<balls[i].radius){
println("HIT!");
hit=true;
index=i;
i=balls.length;
}
else {
    println("missed");
    index=-1;
    hit = false;
  }

}
}


void mouseDragged() {
if (hit&&index!=-1) {
PVector mx= new PVector(mouseX, mouseY);
PVector pmx= new PVector(pmouseX, pmouseY);
PVector dir=PVector.sub(mx, pmx);
  balls[index].velocity.set(dir);
  }
}

void mouseReleased() {
  hit = false;
}
