ArrayList<Site> sites;

void setup() {
  size(1000, 1000);
  sites = new ArrayList<Site>();
  for (int i = 0; i < 25; i++) {
    sites.add(new Site());
  }

  // TESTER
  Site s1 = new Site(300.23, 2.345);
  Site s2 = new Site(1.23, 4.56, color(255, 0, 0));
  Site s3 = new Site(s2);
  Site s4 = new Site();

  float x = s1.getX();
  float y = s2.getY();
  println(x, y);

  color c = s1.getColor();
  println("color", red(c), green(c), blue(c));

  float dist = s1.distFrom(300.0, 200.0);
  println("dist of s1 from 300, 200: ", dist);

  println("s3 highlighted?", s3.isHighlighted());
  s3.setHighlight(true);
  println("s3 highlighted?", s3.isHighlighted());
  s3.setHighlight(false);
  println("s3 highlighted?", s3.isHighlighted());

  println(s1.toString());
  s1.setX(1.0);
  s1.setY(2.0);
  s1.setColor(color(3, 4, 5));

  println(s1);
  println(s2);
  println(s3);
  println(s4);

  voronoiDiagram(); // draw the diagram
}


void draw() {
}

// get the nearest site of at a specific pixel
Site getNearestSite(float x, float y) {
  float min = Float.MAX_VALUE;
  Site currentSite = new Site(0, 0);
  for (Site s : sites) {
    if (dist(x, y, s.getX(), s.getY()) < min) {
      min = dist(x, y, s.getX(), s.getY());
      currentSite = s;
    }
  }
  return currentSite;
}

// draw points of the site
void drawSites() { 
  strokeWeight(8);
  for (Site s : sites) {
    point(s.getX(), s.getY());
  }
}

// draw the voronoi diagram by looping through each pixel
void voronoiDiagram() {
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      set(x, y, getNearestSite(x, y).getColor());
    }
  }
  updatePixels();
  drawSites();
}

void mousePressed() {
  // if users click right mouse => add sites
  if (mouseButton == RIGHT) {
    sites.add(new Site(mouseX, mouseY));
  }
  voronoiDiagram();

  // if useres click left mouse => remove sites
  if (mouseButton == LEFT) {
    if (sites.size() > 1) {
      sites.remove(getNearestSite(mouseX, mouseY));
      for (Site s : sites) {
        s.setHighlight(false);
      }
    }
  }
  voronoiDiagram();
}

void mouseMoved() {
  Site s = getNearestSite(mouseX, mouseY);
  // check if the site is highlighted or not
  // if the sites is not highlighted, set highlight other sites
  // to false and only that site to true
  if (!s.isHighlighted()) {
    for (Site si : sites) {
      si.setHighlight(false);
    }
    s.setHighlight(true);
    voronoiDiagram();
  }
}


class Site {
  private float x;
  private float y;
  private color col;
  private boolean highlight;


  // workhorse constructor
  Site(float x, float y, color col) {
    this.x = x;
    this.y = y;
    this.col = col;
  }

  // constructor with specified locations, random color
  Site(float x, float y) {
    this(x, y, color(random(255), random(255), random(255)));
  }

  // copy constructor
  Site(Site other) {
    this.x = other.x;
    this.y = other.y;
    this.col = other.col;
  }

  // constructor with random location and color
  Site() {
    this.x = random(width);
    this.y = random(height);
    this.col = color(random(255), random(255), random(255));
  }

  // set the color of the site
  public void setColor(color col) {
    this.col = col;
  }

  // return the color of the site
  public color getColor() {
    if (isHighlighted()) {
      return color(255);
    }
    return this.col;
  }

  // set the site to true or false
  public void setHighlight(boolean highlight) {
    this.highlight = highlight;
  }

  // return true if the site is highlighted
  public boolean isHighlighted() {
    return this.highlight;
  }

  // set X location of a site
  public void setX(float x) {
    this.x = x;
  }

  // return the x value of the location
  public float getX() {
    return this.x;
  }

  // set the Y location of a site
  public void setY(float y) {
    this.y = y;
  }

  // get the Y value of a site
  public float getY() {
    return this.y;
  }

  // calculate the distance from the Site to 
  // the specified location
  public float distFrom(float x, float y) {
    return dist(this.x, this.y, x, y);
  }

  String toString() {
    return "(" + this.x + ", " + this.y + ")"
      + ", r=" + red(col) + ", g=" + green(col)
      + ", b=" + blue(col) + ", " + (isHighlighted() ? "highlighted" : "not highlighted");
  }
}
