import java.util.ArrayList;

ArrayList<Random_mover> list_movers;
ArrayList<PVector> Used;
ArrayList<PVector> Rem;
float space = 6.0;
float magnitude = 8.0;
float W = 3.0;

/*
Bhallage Na 
Mara Jabo
*/

void setup(){
    size(960, 540);
    background(255);
    randomSeed(109);
    list_movers = new ArrayList<Random_mover>();
    Used = new ArrayList<PVector>();
    Rem = new ArrayList<PVector>();
    for(float i = space/2.0; i<width; i+=space)
        for(float j = space/2.0; j<height; j+=space){
            Rem.add(new PVector(i, j));
        }
    frameRate(240);
}

void draw(){
    background(255);
    if(frameCount % 10 == 1) add_mover();
    for(int i = 0; i<list_movers.size(); i++){
        Random_mover temp = list_movers.get(i);
        temp.update();
        temp.draw();
    }
}

void add_mover(){
    int i;
    int cnt = 0;
    while(Rem.size() > 0 && cnt < 20){
        i = (int) random(Rem.size());
        if(safe(Rem.get(i))) {
            list_movers.add(new Random_mover(Rem.get(i).x, Rem.get(i).y));
            Rem.remove(i);
            break;
        }
        else {
            Rem.remove(i);
        }
        cnt++;
    }
    return;
}

boolean between(float a, float b, float c){
    return (a <= b && b < c);
}

boolean safe(PVector p){
    for(int i = 0; i<Used.size(); i++){
        PVector temp = Used.get(i);
        if(PVector.sub(temp, p).mag() < space)
           return false;
        }
    return true;
}
