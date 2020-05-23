class ColorCycle{
    int cur, prv, c[];
    
    ColorCycle(int speed){
        c = new int[3];
        colorMode(RGB, speed);
        c[0] = speed;
        prv = 0;
        cur = 1;
    }
    
    void update(){
        c[cur]++;
        c[prv]--;
        if(c[prv] == 0){
            prv = cur;
            cur = cur+1;
            if(cur == 3) cur = 0;
        }
    }
    
    void Fill(){
        fill(c[0], c[1], c[2]);
    }
    
    void Stroke(){
        stroke(c[0], c[1], c[2]);
    }
}
