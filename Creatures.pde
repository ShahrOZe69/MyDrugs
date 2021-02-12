class Creatures{
  Body body;
  //constructor
  Creatures(float x,float y,int w,int h)
  {

    makeBody(x,y,w,h);
  
  }

  void makeBody(float x,float y,int w,int h){
  BodyDef bd= new BodyDef();
  bd.type = BodyType.DYNAMIC;
  bd.position.set(pbox.coordPixelsToWorld(x,y));
  //create body
  body = pbox.createBody(bd);
  //shape
  PolygonShape leg_r1= new PolygonShape();
  leg_r1.setAsBox(pbox.scalarPixelsToWorld(w),pbox.scalarPixelsToWorld(h));
  //fixture
  FixtureDef fd=new FixtureDef();
  fd.shape = leg_r1;
  //fixture physics
  fd.density=1;
  fd.restitution=0.3;
  fd.friction = 0.2;
  body.createFixture(fd); 
  }
  void display(int w,int h){
    Vec2 pos = pbox.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    rect(0,0,w,h);  
    popMatrix(); 
  }
  
  
}
