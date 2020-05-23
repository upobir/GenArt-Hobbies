DShape ds;
float H;

void setup(){
    size(720, 720);
    background(255);
    ds = new DShape(290, 360);
    H = 20;
    frameRate(30);
}

void draw(){
    pushMatrix();
    translate(width/2, height/2);
    ds.distort();
    colorMode(HSB, 100);
    color c = color(H, 77, 65, 10);
    H += 0.1;
    ds.draw(c);
    popMatrix();
}
