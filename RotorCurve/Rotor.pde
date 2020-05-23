class Rotor{
    PVector v;
    float angspeed;
    Rotor(float len, float initang, float speed){
        angspeed = speed;
        v = new PVector(len, 0);
        //println(v.x);
        //println(v.y);
        v.rotate(initang);
    }
    
    void update(){
        v.rotate(angspeed);
        //println(v.x);
        //println(v.y);
    }
}

class SuperRotor{
    Rotor rotors[];
    SuperRotor(int cnt, float len, float lenscale, float angspeed, float angscale){
        rotors = new Rotor[cnt];
        for(int i = 0; i<cnt; i++){
            float speed = random(angspeed);
            rotors[i] = new Rotor(len, random(2*PI), speed);
            len *= lenscale;
            angspeed *= angscale;
        }
    }
    
    void update(){
        for(int i = 0; i<rotors.length; i++)
            rotors[i].update();
    }
    
    PVector getPoint(){
        PVector ret = new PVector(0.0, 0.0);
        for(int i = 0; i<rotors.length; i++){
            ret.add(rotors[i].v);
        }
        return ret;
    }
}
