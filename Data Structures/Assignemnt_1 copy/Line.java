/* This is the interface of Line */

public interface Line {


  public Point getLeft();
  public Point getRight();

  public double length();
  public Point midPoint();
  public Line move(double dx, double dy);

  public String toString();
  public boolean equals(Line other);
}
