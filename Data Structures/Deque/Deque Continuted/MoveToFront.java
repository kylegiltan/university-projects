import java.util.Scanner;

public class MoveToFront implements Deques{

    private Node front;
    private Node back;
    private int N;

    public MoveToFront() {
        this.front = null;
        this.back = null;
        this.N = 0;
      }

      private class Node{

        private Node prev;
        private Node next;
        private String value;

        private Node(String value){
          this.value=value;
          this.next=null;
          this.prev=null;
        }
        private String getValue()   { return this.value; }
        private Node getNext() { return this.next; }
        private Node getPrev() { return this.prev; }
      }

  public void pushLeft(String item){
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

  public void pushRight(String item){
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

  public String popLeft(){
        if (this.isEmpty())
            throw new java.util.NoSuchElementException("Queue is empty.");
        String backValue = this.back.getValue();
        this.back = this.back.getPrev();
        this.back.next=null;
        this.N--;
        if(this.isEmpty())
            this.front = null;
        return backValue;
  }

  public String popRight(){
        if (this.isEmpty())
            throw new java.util.NoSuchElementException("Queue is empty.");
        String frontValue = this.front.getValue();
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

  public void MTF(String a){

    for(Node x = this.front; x != null; x = x.next)
    {
      if(this.front.value.equals(a)){
        this.front=this.front.next;
        this.front.prev=null;
        break;
      }
      if(this.back.value.equals(a)){
        this.back=this.back.prev;
        this.back.next=null;
        break;
      }
      if(x.value.equals(a))
        {x.prev.next=x.next;
         x.next.prev=x.prev;}
      }
      this.pushRight(a);
     }


  public static void main(String[] args){

  Scanner scan = new Scanner(System.in);
  MoveToFront newstring = new MoveToFront();


    while(scan.hasNext())
    {
       String token = scan.next();
       if(newstring.isEmpty()){
         newstring.pushRight(token);
       }
       else{newstring.MTF(token);}
     }
     System.out.println(newstring.toString());
     scan.close();
   }
}
