//Particle System


class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  boolean pressedFire = false;
  boolean pressedIce = false;

  ParticleSystem(PVector position) {
    origin = position.get();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    float r = random(1);

    if (pressedIce == true && pressedFire == false) {
      particles.add(new Snow(origin));
      particles.add(new Ice(origin));
    }
    if (pressedIce == true && pressedFire == true){
      particles.add(new sWater(origin));
      particles.add(new bWater(origin));     
    }   
    if (pressedFire == true && pressedIce == false){
      particles.add(new Fire(origin));
      particles.add(new Smoke(origin));  
    }
    
  }
    void addParticleSoap() {
    float r = random(1);
    if (mousePressed && mouseX < 125 && mouseX > 65  && mouseY > 210 && mouseY < 335) { 
      particles.add(new Soap(origin));
    } 


  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
  
  void mousePressedParticle()
  {    if (mouseX > 275 && mouseX < 325 && mouseY < 330 && mouseY > 260 && mouseButton == LEFT) { 
      pressedIce = !pressedIce;
    } 
      else if (mouseX > 475 && mouseX < 525 && mouseY < 330 && mouseY > 260 && mouseButton == LEFT){
      pressedFire = !pressedFire;
    }
  }
}