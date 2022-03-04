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
