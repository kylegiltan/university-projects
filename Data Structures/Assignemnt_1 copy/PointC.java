
//
// This file contains an implementation of the Point ADT.
//
public class PointC implements Point {
    // Instance variables, record the state.
    //
    private double x;
    private double y;

    public PointC(double x, double y) {
        this.x = x;
        this.y = y;
    }

    public double getX() { return this.x; }
    public double getY() { return this.y; }

    public Point move(double dx, double dy) {
        return new PointC(this.getX() + dx, this.getY() + dy);
    }

    public boolean equals(Point other) {
       return this.getX() == other.getX() && this.getY() == other.getY();
    }

    public String toString() {
        return "(" + this.x + ", " + this.y + ")";
    }

    public static void main(String[] args) {

        Point p = new PointC(0.2, 0.3);
        Point q = new PointC(0.2, 0.3);



        if (q.equals(p))
            System.out.println("They were equal.");
        else
            System.out.println("They were not equal.");
    }


}
