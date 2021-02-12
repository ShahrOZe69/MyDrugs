class Platform{
  Body body;
  //constructor

  Platform(float x,float y,float w,float h)
  {
    makeBody(x,y,w,h);
  
  }

  void makeBody(float x,float y,float w,float h){
  BodyDef bd= new BodyDef();
  bd.type = BodyType.STATIC;
  bd.position.set(pbox.coordPixelsToWorld(x,y));
  //create body
  body = pbox.createBody(bd);
  //shape
  PolygonShape platform= new PolygonShape();
  platform.setAsBox(pbox.scalarPixelsToWorld(w),pbox.scalarPixelsToWorld(h));
  //fixture
  FixtureDef fd=new FixtureDef();
  fd.shape = platform;
  //fixture physics
  fd.density=1;
  fd.restitution=0.3;
  fd.friction = 0.6;
  body.createFixture(fd); 
  }
  void display(float twice_w,float twice_h){
    Vec2 pos = pbox.getBodyPixelCoord(body);
    pushMatrix();
    translate(pos.x,pos.y);
    fill(175);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,twice_w,twice_h);  
    popMatrix();
  }
  
  
}
