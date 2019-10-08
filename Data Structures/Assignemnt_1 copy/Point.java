//
// This file contains an interface for Points.
//
public interface Point {

    // public PointC(double x, double x);

    public double getX();
    public double getY();
    public Point move(double dx, double dy);

    public String toString();
    public boolean equals(Point other);
}
