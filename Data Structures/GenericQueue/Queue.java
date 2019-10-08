// file: Queue.java
// author: Bob Muller
// date: January 30, 2014
//
// An API for a simple first-in-first-out (FIFO) Queue ADT.
//
public interface Queue<T> {
    public void enqueue(T info);
    public T dequeue();
    public boolean isEmpty();
    public int size();
}
