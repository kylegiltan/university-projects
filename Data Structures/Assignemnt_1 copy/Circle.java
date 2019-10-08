public interface Circle{

  public Point getCenter();
  public double getRadius();
  public double getArea();
  public Circle move(double dx, double dy);
  public boolean equals(Circle other);
  public String toString();

}
