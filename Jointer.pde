class Jointer
{  RevoluteJointDef rjd = new RevoluteJointDef();
  Jointer(Body bodyA,Body bodyB,float x,float y,float ll,float ul)
  {
  
  rjd.bodyA = bodyA;
  rjd.bodyB = bodyB;
  rjd.enableLimit = true;
  rjd.lowerAngle=ll;
  rjd.upperAngle=ul;
  rjd.referenceAngle=0*DEGTORAD;
  rjd.localAnchorA.set(pbox.scalarPixelsToWorld(0),pbox.scalarPixelsToWorld(25));
  rjd.localAnchorB.set(pbox.scalarPixelsToWorld(x),pbox.scalarPixelsToWorld(y));
  rjd.collideConnected = false;
  
  }
  
}
