class mySphere{
  float radious;
  float angle;
  float angleIncrement;
  boolean stopRotation;
  
  mySphere(float radious, float angleIncrement){
    this.radious = radious;
    this.angle = random(360);
    this.angleIncrement = angleIncrement;
    this.stopRotation = false;
  }
  
  float getRadious(){
    return this.radious;
  }
  
  float getAngle(){
    return this.angle;
  }
  
  void updateAngle(){
    if (this.stopRotation)return;
    angle+=angleIncrement;
    if(angle>=360) angle=0;
  }
  
  void stopRotation(boolean status){
    this.stopRotation = status;
  }
  
  void paint(){
    rotateY(radians(angle));
    sphere(radious);
    updateAngle();
  }

}
