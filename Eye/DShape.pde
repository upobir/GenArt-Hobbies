class DShape{
    float M;
    ArrayList<PVector> points;
    DShape(float M, int ptcnt){
        this.M = M;
        points = new ArrayList();
        for(int i = 0; i<ptcnt; i++){
            float angle = (TWO_PI*i)/(float)ptcnt;
            PVector p = PVector.fromAngle(angle);
            p.setMag(M);
            points.add(p);
        }
    }
    
    void draw(color c){
        stroke(c);
        beginShape();
        //noFill();
        for(int i = 0; i<points.size(); i++){
            float x = points.get(i).x;
            float y = points.get(i).y;
            vertex(x, y);
        }
        endShape(CLOSE);
    }
    
    void distort(){
        float off = 100;
        for(int i = 0; i<points.size(); i++){
            float mag = points.get(i).mag();
            //mag += random(-1, 1);
            mag += 0.9*(noise(off)-0.5);
            off += 0.5;
            //if(mag > M+20 || mag < M-20) continue;
            points.get(i).setMag(mag);
        }
    }
}
