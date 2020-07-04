ChaosGame chaosGame;
int count = 1;

void setup(){
    size(640, 640);
    background(250);
    chaosGame = new ChaosGame(7, width/2, height/2, width*0.6);
}

void draw(){
    if(frameCount % (4*60) == 0) count++;
    
    for(int i = 0; i<count; i++){
        chaosGame.update();
        chaosGame.draw();
    }
}
