package com;

import java.io.File;

public class FindxslFile {

	public static void main(String[] args) {

		File   fl = new File("C:\\Users\\ssahoo43\\D_Drive\\eAppAutomation");
		FindxslFile obj = new FindxslFile();
		obj.getFiles(fl);
		
	}
	
	public void getFiles(File fileName) {
		File[] filesinDir = fileName.listFiles();
		for(File fl: filesinDir) {
			if(fl.isDirectory()) {
				getFiles(fl);	
			}
			else if(fl.getName().contains(".xlsx"))
			System.out.println(fl.getAbsolutePath());
		}
	}

}
