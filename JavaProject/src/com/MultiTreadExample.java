package com;

class Dog extends Thread{
	public void run() {
		for (int i=0;i<11;i++) {
		System.out.println("Dog Barking");
		}
	}
}


class Cat extends Thread{
	public void run() {
		for (int i=0;i<11;i++) {
		System.out.println("cat Meaow");
		}
	}
}

public class MultiTreadExample {

	public static void main(String[] args) {
		Dog d = new Dog();
		Cat c= new Cat();
		d.start();
		c.start();

	}

}
