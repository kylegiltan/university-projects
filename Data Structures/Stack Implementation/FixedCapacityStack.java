//author: Ziyuan Meng
//date: September 18, 2017
//An implementation of a simple stack ADT


import java.util.Scanner;

public class FixedCapacityStack implements StringStack {
  private static final int CAPACITY = 100;
  private String[] thestack;
  private int size;

  public FixedCapacityStack(){
    this.thestack = new String[CAPACITY];
    this.size = 0;
  }

  public void push(String s){

    if(this.size < CAPACITY) {
      this.thestack[size++] = s;
    }

  }

  public String pop(){
    String ts = "";
    if(this.size > 0){
      ts = this.thestack[this.size - 1];
      this.thestack[this.size - 1] = null;
      this.size = this.size - 1;
    }
    return ts;
  }

  public int size(){
    return this.size;
  }

  public boolean isEmpty() {
    return this.size == 0;
  }

  public static void main(String[] args){

    StringStack fs = new FixedCapacityStack();
    Scanner scan = new Scanner(System.in);
    while(scan.hasNext()) {
      String name = scan.next();
      fs.push(name);
    }

    while(!fs.isEmpty()) {
      String name = fs.pop();
      System.out.println(name);
    }
    scan.close();
  }

}
