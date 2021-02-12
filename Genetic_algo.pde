import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
//mutate function shoul mutate only some of genes i think, no the whole fkn creature
//add more genes maybe
final float DEGTORAD = PI/180.0;
Box2DProcessing pbox;
Platform my_platform;
Platform obstacle_one;
Platform obstacle_two;
MakeShahrozesauras winner_baby;
float mutation_rate=0.01;//full mutation of the baby
final int babies_length = 100;//multiple of 10 
final int top_select=2;//babies_length/top_select
int best_fitness;
int best_baby;
int i =0;
boolean start_show=false;
boolean runned_once=false;
boolean run_once2=false;
final int num_moves=400;//even number
int generation =0;
ArrayList<MakeShahrozesauras> mating_pool;
MakeShahrozesauras babies[] = new MakeShahrozesauras[babies_length];

void setup()
{ 
  createNewWorld();
  size(1080,640);
  //createFreshBabies(babies);
  babies[0]= new MakeShahrozesauras(200,160);
  babies[0].randomizeGenes();
  //LOOOOOOOP
 
 runBabies();
  createNewWorld();
  
  winner_baby = new MakeShahrozesauras(200,160);
  winner_baby.torque_list=babies[getBestBaby()].torque_list;

  
 
  
}
void draw()
{ 
  frameRate(4000);
  smooth();
  pbox.step();
  background(255);
  my_platform.display(width,10);
  obstacle_one.display(100,100);
  obstacle_two.display(50,200);
  if(start_show)
  {
    
    winner_baby.display();
    winner_baby.walk();
    if(winner_baby.dead)
    {
      println("BEST OF GENERATION--  "+generation+" IS "+winner_baby.fitness_score);
      
     //SelectTop();
     selectFromPool();
     crossoverTwo();
   mutateTwo();
   createNewWorld();
   start_show=false;
   generation++;
   i=0;
   runned_once=false;
   
   runBabies();
   createNewWorld();
     winner_baby = new MakeShahrozesauras(200,160);
  winner_baby.torque_list=babies[getBestBaby()].torque_list;
  
    }
  }

  


}
int getBestFitness()
{ best_fitness=0;
  for(int i=0;i<babies_length;i++)
  {
    //println(babies[i].fitness_score);
    best_fitness=max(best_fitness,babies[i].fitness_score);
  }
  return best_fitness;
}
int getBestBaby()
{ best_baby=0;
  for(int i=0;i<babies_length;i++)
  {
    if(babies[best_baby].fitness_score<babies[i].fitness_score)
    {
    best_baby=i;
    }
  }
  return best_baby;
}
void runBabies()
{
   while(true)
  { if(generation!=0&&!run_once2)
     {
    float temp_torque_list[][] = new float[num_moves][9];
    temp_torque_list = babies[0].torque_list;
    babies[0]= new MakeShahrozesauras(200,160);
    babies[0].torque_list=temp_torque_list;
    run_once2=true;
     }
   pbox.step();
   babies[i].walk();
  if(babies[i].dead&&i!=babies_length-1)
  {
    createNewWorld();
 
  if(generation==0){
    babies[++i]= new MakeShahrozesauras(200,160);
    babies[i].randomizeGenes();
  }
  else{
    float temp_torque_list[][] = new float[num_moves][9];
    temp_torque_list = babies[++i].torque_list;
    babies[i]= new MakeShahrozesauras(200,160);
    babies[i].torque_list=temp_torque_list;
    
  }
    
    
  }
  if((babies[i].dead&&i==babies_length-1)&&!runned_once)
  {
    runned_once=true;
    
    start_show=true;
    
    break;
  
   
  }
  
}
}
void createNewWorld()
{
  pbox = new Box2DProcessing(this);
  pbox.createWorld();
  pbox.setGravity(0,-10);
  my_platform = new Platform(width/2,height-10,width/2,5);
  obstacle_one=new Platform(270,height-10,50,50);
  obstacle_two=new Platform(750,height-10,25,100);
  
}
void createFreshBabies(MakeShahrozesauras array[])
{
  for(int k = 0;k<babies_length;k++)
  { 
    babies[k]= new MakeShahrozesauras(200,160);
  }
}
void SelectTop()
{  //select top 10% of population...
//not good strategy
//use pool selection
  for(int i = 0;i<babies_length-1;i++)
    {
      
      for(int j =0;j<babies_length-i-1;j++)
      {
        if(babies[j].fitness_score<babies[j+1].fitness_score)
        {
          MakeShahrozesauras temp=new MakeShahrozesauras(200,160);
          temp=babies[j+1];
          babies[j+1]=babies[j];
          babies[j] = temp;
        }
      }
      
    }
     
}
void selectFromPool()
{
  mating_pool = new ArrayList<MakeShahrozesauras>();
  int bestfit = getBestFitness();
  for(int i = 0;i<babies_length;i++)
     {
       babies[i].fitness_value=babies[i].fitness_score/bestfit;
       for(int j=0;j<babies[i].fitness_value*100;j++)
       {
       mating_pool.add(babies[i]);
       }
     }
     
     
}
void crossoverTwo()
{

 for(int i = 0;i<babies_length;i++)
 {
   int parent_one = (int)random(0,mating_pool.size());
   int parent_two=(int)random(0,mating_pool.size());
   //babies[i].dead=false;
   //babies[i].fitness_score=0;
   //babies[i].i=0;
   for(int j=0;j<(num_moves/2)-1;j++)
   {
      babies[i].torque_list[j][0]=mating_pool.get(parent_one).torque_list[j][0];
      babies[i].torque_list[j][1]=mating_pool.get(parent_one).torque_list[j][1];
      babies[i].torque_list[j][2]=mating_pool.get(parent_one).torque_list[j][2];
      babies[i].torque_list[j][3]=mating_pool.get(parent_one).torque_list[j][3];
      babies[i].torque_list[j][4]=mating_pool.get(parent_one).torque_list[j][4];
      babies[i].torque_list[j][5]=mating_pool.get(parent_one).torque_list[j][5];
      babies[i].torque_list[j][6]=mating_pool.get(parent_one).torque_list[j][6];
      babies[i].torque_list[j][7]=mating_pool.get(parent_one).torque_list[j][7];
      babies[i].torque_list[j][8]=mating_pool.get(parent_one).torque_list[j][8];
   }
      for(int j=num_moves/2;j<num_moves;j++)
   {
      babies[i].torque_list[j][0]=mating_pool.get(parent_two).torque_list[j][0];
      babies[i].torque_list[j][1]=mating_pool.get(parent_two).torque_list[j][1];
      babies[i].torque_list[j][2]=mating_pool.get(parent_two).torque_list[j][2];
      babies[i].torque_list[j][3]=mating_pool.get(parent_two).torque_list[j][3];
      babies[i].torque_list[j][4]=mating_pool.get(parent_two).torque_list[j][4];
      babies[i].torque_list[j][5]=mating_pool.get(parent_two).torque_list[j][5];
      babies[i].torque_list[j][6]=mating_pool.get(parent_two).torque_list[j][6];
      babies[i].torque_list[j][7]=mating_pool.get(parent_two).torque_list[j][7];
      babies[i].torque_list[j][8]=mating_pool.get(parent_two).torque_list[j][8];
   }
  
 }
}
void Crossover()
{
 MakeShahrozesauras top[]=new MakeShahrozesauras[babies_length/top_select];
 for(int i =0;i<babies_length/top_select;i++)
 {
   top[i]=babies[i];
 }
 for(int i = 0;i<babies_length;i++)
 {
   int parent_one = (int)random(0,babies_length/top_select);
   int parent_two=(int)random(0,babies_length/top_select);
   //babies[i].dead=false;
   //babies[i].fitness_score=0;
   //babies[i].i=0;
   for(int j=0;j<(num_moves/2)-1;j++)
   {
      babies[i].torque_list[j][0]=top[parent_one].torque_list[j][0];
      babies[i].torque_list[j][1]=top[parent_one].torque_list[j][1];
      babies[i].torque_list[j][2]=top[parent_one].torque_list[j][2];
      babies[i].torque_list[j][3]=top[parent_one].torque_list[j][3];
      babies[i].torque_list[j][4]=top[parent_one].torque_list[j][4];
      babies[i].torque_list[j][5]=top[parent_one].torque_list[j][5];
      babies[i].torque_list[j][6]=top[parent_one].torque_list[j][6];
      babies[i].torque_list[j][7]=top[parent_one].torque_list[j][7];
      babies[i].torque_list[j][8]=top[parent_one].torque_list[j][8];
   }
      for(int j=num_moves/2;j<num_moves;j++)
   {
      babies[i].torque_list[j][0]=top[parent_two].torque_list[j][0];
      babies[i].torque_list[j][1]=top[parent_two].torque_list[j][1];
      babies[i].torque_list[j][2]=top[parent_two].torque_list[j][2];
      babies[i].torque_list[j][3]=top[parent_two].torque_list[j][3];
      babies[i].torque_list[j][4]=top[parent_two].torque_list[j][4];
      babies[i].torque_list[j][5]=top[parent_two].torque_list[j][5];
      babies[i].torque_list[j][6]=top[parent_two].torque_list[j][6];
      babies[i].torque_list[j][7]=top[parent_two].torque_list[j][7];
      babies[i].torque_list[j][8]=top[parent_two].torque_list[j][8];
   }
  
 }
}
void mutate()
{
  for(int i=0;i<babies_length;i++)
  {
    if(random(1)<mutation_rate)
    {
      babies[i].randomizeGenes();
    }
  }
}
void mutateTwo()
{
  for(int i=0;i<babies_length;i++)
  {
    for(int k=0;k<num_moves;k++)
    {
      if(random(1)<mutation_rate)
      {
        if(random(1)<0.01)
      {
      babies[i].torque_list[k][0]=random(10,20)*1000;
      }
      else
      {
    babies[i].torque_list[k][0]=random(0,5)*1000;
      }
    if(random(1)<0.01)
      {
      babies[i].torque_list[k][1]=random(10,20)*1000;
      }
      else
      {
    babies[i].torque_list[k][1]=random(0,5)*1000;
      }
    if(random(1)<0.01)
      {
      babies[i].torque_list[k][2]=random(10,20)*1000;
      }
      else
      {
    babies[i].torque_list[k][2]=random(0,5)*1000;
      }
      
   if(random(1)<0.01)
      {
      babies[i].torque_list[k][3]=random(10,20)*1000;
      }
      else
      {
    babies[i].torque_list[k][3]=random(0,5)*1000;
      }
    babies[i].torque_list[k][4]=(int)random(1,6);
    babies[i].torque_list[k][5]=(int)random(1,6);
    babies[i].torque_list[k][6]=(int)random(1,6);
    babies[i].torque_list[k][7]=(int)random(1,6);
    babies[i].torque_list[k][8]= random(1);
    
      }
    }
  }
}
