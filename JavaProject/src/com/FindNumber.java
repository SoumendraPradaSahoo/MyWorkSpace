package com;

class Test{
int a;
public int b;
private int c;
protected int d;

void setC(int temp){
	this.c = temp;
}

void getC() {
	System.out.println(this.c);
}
}
class ExtendedTest extends Test{
}
class FindNumber{
public static void main(String[] args) {
	Test ob=new Test();
	ob.a=10;
	ob.b=20;
	ob.d=40;
	System.out.println(ob.a);
	System.out.println(ob.b);
	ob.setC(30);
	ob.getC();
	System.out.println(ob.d);
	ExtendedTest ob1 = new ExtendedTest();
	ob1.a=90;
	ob1.d=55;
	ob1.setC(60);
	ob1.getC();
	System.out.println(ob1.a + " " + ob1.d);
	
}
}
