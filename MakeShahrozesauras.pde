class MakeShahrozesauras
{
  Creatures shahroze_leg1;
    Creatures shahroze_leg2;
    Creatures shahroze_leg1_femur;
    Creatures shahroze_leg2_femur;
    Creatures shahroze_torso;
     float speed = -100*360*DEGTORAD;
    RevoluteJoint joint1;
    RevoluteJoint joint2;
    RevoluteJoint joint3;
    RevoluteJoint joint4;
   float torque_list[][] = new float[num_moves][9];
    int i =0;
    int fitness_score=0;
    boolean dead=false;
    float fitness_value=0;
  MakeShahrozesauras(float x_coord,float y_coord)
  {
   
    
    shahroze_leg1 = new Creatures(x_coord,height-y_coord,5,30);
  shahroze_leg2 = new Creatures(30+x_coord,height-y_coord,5,30);
  shahroze_leg1_femur = new Creatures(x_coord,height-y_coord+65,5,30);
  shahroze_leg2_femur = new Creatures(30+x_coord,height-y_coord+65,5,30);
  shahroze_torso = new Creatures(15+x_coord,height-70-y_coord,30,50);
  Jointer l1_t = new Jointer(shahroze_leg1.body,shahroze_torso.body,-25,-45,0,150*DEGTORAD);
  Jointer l2_t=new Jointer(shahroze_leg2.body,shahroze_torso.body,25,-45,-150*0,150*DEGTORAD);
  Jointer l1_f=new Jointer(shahroze_leg1_femur.body,shahroze_leg1.body,150*0,-25,-150*DEGTORAD,0);
  Jointer l2_f=new Jointer(shahroze_leg2_femur.body,shahroze_leg2.body,150*0,-25,-150*DEGTORAD,0);
  l1_f.rjd.enableMotor=true;
  l1_f.rjd.motorSpeed=-speed;
  l1_f.rjd.enableLimit=true;
  l1_t.rjd.enableMotor=true;
  l1_t.rjd.motorSpeed=speed;
  l1_t.rjd.enableLimit=true;
  l2_f.rjd.enableMotor=true;
  l2_f.rjd.motorSpeed=speed;
  l2_f.rjd.enableLimit=true;
  l2_t.rjd.enableMotor=true;
  l2_t.rjd.motorSpeed=speed;
  l2_t.rjd.enableLimit=true;
  
  joint1 = (RevoluteJoint) pbox.world.createJoint(l1_t.rjd);
  joint2 = (RevoluteJoint) pbox.world.createJoint(l2_t.rjd);
  joint3 = (RevoluteJoint) pbox.world.createJoint(l1_f.rjd);
  joint4 = (RevoluteJoint) pbox.world.createJoint(l2_f.rjd);
  
  
  }
  //how to walk for f** sake!!!!!
void randomizeGenes()
{
  for(int i = 0;i<num_moves;i++)
    {
      if(random(1)<0.01)
      {
      torque_list[i][0]=random(10,20)*1000;
      }
      else
      {
    torque_list[i][0]=random(0,5)*1000;
      }
    if(random(1)<0.01)
      {
      torque_list[i][1]=random(10,20)*1000;
      }
      else
      {
    torque_list[i][1]=random(0,5)*1000;
      }
    if(random(1)<0.01)
      {
      torque_list[i][2]=random(10,20)*1000;
      }
      else
      {
    torque_list[i][2]=random(0,5)*1000;
      }
      
   if(random(1)<0.01)
      {
      torque_list[i][3]=random(10,20)*1000;
      }
      else
      {
    torque_list[i][3]=random(0,5)*1000;
      }
    torque_list[i][4]=(int)random(1,6);
    torque_list[i][5]=(int)random(1,6);
    torque_list[i][6]=(int)random(1,6);
    torque_list[i][7]=(int)random(1,6);
    torque_list[i][8]= random(1);
    
   }
}
void display()
{
  
  shahroze_leg1.display(10,60);
  shahroze_leg2.display(10,60);
  shahroze_leg1_femur.display(10,60);
  shahroze_leg2_femur.display(10,60);
  shahroze_torso.display(60,100);

    

}
void walk()
{ if(i!=num_moves-1){
  if(torque_list[i][8]>0.2)
   {
  if(joint1.getJointSpeed()<1*DEGTORAD && joint1.getJointSpeed()>=-10)
    {
      if(i!=num_moves-1){
    joint1.setMotorSpeed(-joint1.getMotorSpeed()*torque_list[i][4]);
    joint1.setMaxMotorTorque(torque_list[i][0]);
      }
    }
    if(joint2.getJointSpeed()<=1*DEGTORAD && joint2.getJointSpeed()>=-10)
    { if(i!=num_moves-1){
    joint2.setMotorSpeed(-joint2.getMotorSpeed()*torque_list[i][5]);
    joint2.setMaxMotorTorque(torque_list[i][1]);
    }
    }
    if(joint3.getJointSpeed()<=1*DEGTORAD && joint3.getJointSpeed()>=-10)
    {
       if(i!=num_moves-1){
    joint3.setMotorSpeed(-joint3.getMotorSpeed()*torque_list[i][6]);
    joint3.setMaxMotorTorque(torque_list[i][2]);
       }
    }
    if(joint4.getJointSpeed()<=1*DEGTORAD && joint4.getJointSpeed()>=-10)
    {
       if(i!=num_moves-1){
    joint4.setMotorSpeed(-joint4.getMotorSpeed()*torque_list[i][7]);
    joint4.setMaxMotorTorque(torque_list[i++][3]);
       }
    }
    
   }
   else{
   i++;
        }
}
    
  if(i==num_moves-1)
  {dead= true;
    Vec2 pos = pbox.getBodyPixelCoord(shahroze_torso.body);
    fitness_score=((int)pos.x);
  }
}
void destroy()
{
  pbox.destroyBody(shahroze_leg1.body);
  pbox.destroyBody(shahroze_leg2.body);
  pbox.destroyBody(shahroze_leg1_femur.body);
  pbox.destroyBody(shahroze_leg2_femur.body);
}
}
