class SplashText{
  PImage[] images;
  int imageCount;
  int frame;
  
  SplashText(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[17];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + i + ".GIF";
      images[i] = loadImage(filename);
    }
    
    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + (imageCount-i) + ".GIF";
      images[i] = loadImage(filename);
    }
    
  }

  void display(float xpos, float ypos) {
    frame = (frame+1) % imageCount;
    fill(0);
    rect(0,0,width,height);
    image(images[frame], xpos, ypos);
    
  }
  
}
