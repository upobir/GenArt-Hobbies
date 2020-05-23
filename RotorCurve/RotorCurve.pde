SuperRotor r;
boolean first;
float x, y;
ColorCycle c;
int maxsp;
void setup(){
    size(500, 500);
    //int seed = int(random(99999));
    //println(seed);
    randomSeed(51388);
    r = new SuperRotor(12, width/4, 0.5, 0.001, 1.3);
    first = true;
    background(0);
    c = new ColorCycle(50000);
    frameRate(60);
    maxsp = 10;
}


void draw(){
    int sp = maxsp;
    if(maxsp < 120) maxsp += 1;
    while((sp--) != 0)
        work();
}

void work(){
    PVector v = r.getPoint();
    float nx = width/2 + v.x;
    float ny = height/2 + v.y;
    
    if(first){
        first = false;
    }
    else{
        c.Stroke();
        line(x, y, nx, ny);
        c.update();
    }
    
    x = nx;
    y = ny;
    r.update();
}
