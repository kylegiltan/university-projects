public class CircleC implements Circle{

  private Point center;
  private double radius;

  public CircleC(Point p, double r){
    this.center = p;
    this.radius = r;
  }

  public Point getCenter(){
    return this.center;
  }

  public double getRadius(){
    return this.radius;
  }


  public double getArea(){
    return Math.PI * radius * radius;
  }
  public Circle move(double dx, double dy){
    Point new_center = this.center.move(dx, dy);
    return new CircleC(new_center, this.radius);
  }

  public boolean equals(Circle other){
    return other.getCenter().equals(this.center) && (other.getRadius() == this.radius);
  }

  public String toString(){
    return "Center:" + this.center + "Radius:" + this.radius;
  }

  public static void main(String[] args){
  Point p1 = new PointC(2.0, 2.1);
  Circle c1 = new CircleC(p1, 5.0);
  System.out.println("The new circle c1:" + c1);
  Circle c2 = c1.move(0.3,2.0);
  System.out.println("The new circle c2 is : " + c2);
  System.out.println("The area of c2 is: " + c2.getArea());

  }

}
