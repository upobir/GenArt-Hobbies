class Random_mover{
    ArrayList<PVector> List;
    int failCount;
    boolean active;
    
    Random_mover(float x, float y){
        List = new ArrayList<PVector>();
        List.add(new PVector(x, y));
        active = true;
        failCount = 0;
    }
    
    void update(){
        if(!active) return;     
        PVector last = List.get(List.size()-1);
        float angle = random(0, 2*PI);
        float mag = magnitude;
        PVector v = new PVector(mag*cos(angle), mag*sin(angle));
        PVector new_p = PVector.add(last, v);
        if(!(between(0, new_p.x, width) && between(0, new_p.y, height))){
            fail();
            return;
        }
        if(!safe(new_p)){
            fail();
            return;
        }
        List.add(new_p);
        Used.add(new_p);
        failCount = 0;
        return;
    }
    
    void fail(){
        failCount++;
        if(failCount == 10) active = false;
    }
    
    void draw(){
        stroke(255, 0, 0);
        strokeWeight(W);
        for(int i = 1; i<List.size(); i++){
            PVector p1 = List.get(i-1);
            PVector p2 = List.get(i);
            line(p1.x, p1.y, p2.x, p2.y);
        }
    }
}
