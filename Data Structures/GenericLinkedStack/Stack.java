// file: Stack.java
// author: Bob Muller
// date: January 27, 2014
//
// This file contains an API for a generic (or polymorphic) stack.
//
public interface Stack<T> {
    public void push(T info);
    public T pop();
    public boolean isEmpty();
    
}
