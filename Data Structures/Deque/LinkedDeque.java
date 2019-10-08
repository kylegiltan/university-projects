public class LinkedDeque<T> implements Deque<T>{

    private Node front;
    private Node back;
    private int N;

    public LinkedDeque() {
        this.front = null;
        this.back = null;
        this.N = 0;
      }

      private class Node{

        private Node prev;
        private Node next;
        private T value;

        private Node(T value){
          this.value=value;
          this.next=null;
          this.prev=null;
        }
        private T getValue()   { return this.value; }
        private Node getNext() { return this.next; }
        private Node getPrev() { return this.prev; }
      }

  public void pushLeft(T item){
    Node temp = new Node(item);
        if(this.isEmpty())
            this.front = temp;
        else
            temp.prev=back;
            if (back !=null){
              this.back.next=temp;
            }
        this.back = temp;
        this.N++;
  }

  public void pushRight(T item){
    Node temp = new Node(item);
        if(this.isEmpty())
            this.back = temp;
        else
            temp.next=front;
            if (front !=null){
              this.front.prev=temp;
            }
        this.front = temp;
        this.N++;
  }

  public T popLeft(){
        if (this.isEmpty())
            throw new java.util.NoSuchElementException("Queue is empty.");
        T backValue = this.back.getValue();
        this.back = this.back.getPrev();
        this.back.next=null;
        this.N--;
        if(this.isEmpty())
            this.front = null;
        return backValue;
  }

  public T popRight(){
        if (this.isEmpty())
            throw new java.util.NoSuchElementException("Queue is empty.");
        T frontValue = this.front.getValue();
        this.front = this.front.getNext();
        this.N--;
        if(this.isEmpty())
            this.back = null;
        return frontValue;
  }

  public int size(){return this.N;}

  public boolean isEmpty(){return this.N==0;}

  public String toString(){
    String result = "";
    for (Node x = front; x != null; x = x.next){
      result = result + x.value + " ";
    }
    return result;
  }
  public static void main(String[] args) {

      Deque<Double> qs = new LinkedDeque<Double>();
      Deque<Integer> q2 = new LinkedDeque<Integer>();
      Deque<String> qstring = new LinkedDeque<String>();

      qs.pushLeft(0.9);
      qs.pushRight(1.3);
      qs.pushLeft(5.0);
      q2.pushRight(6);
      q2.pushRight(7);
      q2.pushLeft(3);
      qstring.pushLeft("test 1");
      qstring.pushLeft("test2");
      qstring.pushRight("test 3");

      System.out.println("Double pop right "+qs.popRight());
      System.out.println("Double pop left "+qs.popLeft());
      System.out.println("Double pop left "+qs.popLeft());
      System.out.println("Int pop right "+q2.popRight());
      System.out.println("Int pop right "+q2.popRight());
      System.out.println("Int pop left "+q2.popLeft());
      System.out.println("String pop right "+qstring.popRight());
      System.out.println("String pop left "+qstring.popLeft());
      System.out.println("toString: "+qstring.toString());

    }
}
