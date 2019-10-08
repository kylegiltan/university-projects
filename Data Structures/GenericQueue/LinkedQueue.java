// file: LinkedQueue.java
// author: Bob Muller
// date: January 30, 2014
//
// A linked implement for a simple Queue ADT. See the file Queue.java
// for the API.
//
public class LinkedQueue<T> implements Queue<T> {

    // Instance variables
    //
    private Node front;
    private Node back;
    private int N;

    public LinkedQueue() {
        this.front = null;
        this.back = null;
        this.N = 0;
    }

    private class Node {
        private T info;
        private Node next;

        private Node(T info) {
            this.info = info;
            this.next = null;
        }
        private T getInfo()    { return this.info; }
        private Node getNext() { return this.next; }
    }

    public void enqueue(T info) {
        Node temp = new Node(info);
        if(this.isEmpty())
            this.front = temp;
        else
            this.back.next = temp;
        this.back = temp;
        this.N++;
    }

    public T dequeue() {
        if (this.isEmpty())
            throw new java.util.NoSuchElementException("Queue is empty.");
        T frontValue = this.front.getInfo();
        this.front = this.front.getNext();
        this.N--;
        if(this.isEmpty())
            this.back = null;
        return frontValue;
    }



    public boolean isEmpty() { return this.N == 0; }
    public int size()        { return this.N; }

    public static void main(String[] args) {

        Queue<Double> qs = new LinkedQueue<Double>();
        Queue<Integer> q2 = new LinkedQueue<Integer>();

        qs.enqueue(0.9);
        qs.enqueue(1.3);

        System.out.println("first = " + qs.dequeue() + ", second = " + qs.dequeue());
    }
}
