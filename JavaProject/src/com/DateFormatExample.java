package com;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateFormatExample {

	public static void main(String[] args) {
		DateFormat fmt = new SimpleDateFormat("MMddyyyy");
		String dt = "08032019";
		try {
		Date date = fmt.parse(dt);
		DateFormat fmt1 = new SimpleDateFormat("ddMMyy");
		String temp = fmt1.format(date);
		System.out.println(temp);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
