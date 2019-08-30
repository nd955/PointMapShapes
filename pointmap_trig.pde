int numShapes = 20;
ArrayList<MovingShape> shapes = new ArrayList();
int n = 3;
PVector pBound = new PVector(1920, 1080);
PVector vBound = new PVector(.01, .01);

void setup() {
  size(1920, 1080);
  background(color(255));
  for(int i = 0; i < numShapes; i++) {
    shapes.add(new MovingShape(n, pBound, vBound));
  }
}

void draw() {
  for(MovingShape s : shapes) {
    s.draw();
    s.update();
  }
}

PVector createRandomPoint(float xBound, float yBound) {
  PVector point = new PVector(random(0,xBound), random(0,yBound));
  return point;
}

class MovingShape {
  ArrayList<PVector> positions;
  ArrayList<PVector> velocities;
  int vertices;

  color col;
  
  MovingShape(int vertices, PVector positionBound, PVector velocityBound) {
    this.vertices = vertices;
    positions = new ArrayList();
    velocities = new ArrayList();
    
    for(int i = 0; i < vertices; i++) {
      positions.add(createRandomPoint(positionBound.x, positionBound.y));
      velocities.add(createRandomPoint(velocityBound.x, velocityBound.y));
    }
    
    this.col = color(random(0,255),random(0,255),random(0,255),random(0,255));
  }
  
  void draw() {
    stroke(this.col);
    fill(this.col);
    beginShape();
      for(int i = 0; i < vertices; i++) {
        vertex(positions.get(i).x, positions.get(i).y);
      }
    endShape(CLOSE);
  }
  
  void update() {
    for(int i = 0; i < vertices; i++) {
      positions.get(i).add(velocities.get(i));
      velocities.get(i).add(new PVector(cos(positions.get(i).y), sin(positions.get(i).x)));
      
      if(positions.get(i).x < 0 || positions.get(i).x > pBound.x) {
        velocities.get(i).x *= -1;
      }
      if(positions.get(i).y < 0 || positions.get(i).y > pBound.y) {
        velocities.get(i).y *= -1;
      }
    }
  }
}
