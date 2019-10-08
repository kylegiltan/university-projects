// file: GLStack.java
// author: Bob Muller
// date: January 27, 2014
//
// This file contains a linked implementation of generic (or polymorphic)
// stacks.
//
// run this program by:
//
// > javac GLStack.java
// > java GLStack gettysburg.txt
//
public class GLStack<T> implements Stack<T> {

    // Instance vars.
    //
    private Node top;
    private int N;

    // This inner class is defined recursively. It implements a
    // chain of Nodes each containing a stack value of type T.
    //
    private class Node {
        T info;
        Node next;

        private Node(T info, Node next) {
            this.info = info;
            this.next = next;
        }
        private T getInfo() { return this.info; }
        private Node getNext() { return this.next; }
    }

    // A constructor of GLStacks.
    //
    public GLStack() {
        this.top = null;
        this.N = 0;
    }

    // No possibility of overflow, the runtime system can give
    // us a virtually unlimited sequence of new Nodes.
    //
    public void push(T info) {
        this.top = new Node(info, this.top);
        this.N++;
    }

    public boolean isEmpty() { return this.N == 0; }

    public T pop() {
        if (this.isEmpty())
            throw new java.util.NoSuchElementException("Stack Underflow.");
        else {
            T info = this.top.getInfo();
            this.top = this.top.getNext();
            this.N--;
            return info;
        }
    }

    

    public static void main(String[] args) {
        Stack<String> myStack = new GLStack<String>();
        Stack<Integer> intStack = new GLStack<Integer>();

        intStack.push(90);
        intStack.push(88);

        System.out.println(intStack.pop());
        System.out.println(intStack.pop());

    }
}
