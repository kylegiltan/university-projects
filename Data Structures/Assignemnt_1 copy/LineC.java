public class LineC implements Line{

  private Point left;
  private Point right;

  public LineC(Point l, Point r){
    this.left = l;
    this.right = r;
  }
  public Point getLeft(){
    return this.left;
  }
  public Point getRight(){
    return this.right;
  }
  public double length(){
    double x_distance = this.right.getX() - this.left.getX();
    double y_distance = this.right.getY() - this.left.getY();
    double distance = Math.sqrt((y_distance * y_distance) + (x_distance * x_distance));
    return distance;
  }
  public Point midPoint(){
    double x_mid = (this.left.getX() + this.right.getX()) / 2;
    double y_mid = (this.left.getY() + this.right.getY()) / 2;
    return new PointC (x_mid, y_mid);
  }
  public Line move(double dx, double dy){
    Point new_l = this.left.move(dx,dy);
    Point new_r = this.right.move(dx,dy);
    return new LineC(new_l, new_r);
  }
  public String toString(){
    return "Left point:" + this.left.toString() + "Right point:" + this.right.toString();
  }
  public boolean equals(Line other){
    return other.getLeft().equals(this.getLeft()) && (other.getRight().equals(this.getRight()));
  }
  public static void main(String[] args){
    Point left = new PointC(1.0,3.4);
    Point right = new PointC(3.4,1.2);
    Line L1 = new LineC(left,right);
    System.out.println("The line is" + L1);
  }
}
