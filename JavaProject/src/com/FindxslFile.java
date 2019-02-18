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
		for(int i=0;i<filesinDir.length;i++) {
			if(filesinDir[i].isDirectory()) {
				getFiles(filesinDir[i]);	
			}
			else if(filesinDir[i].getName().contains(".xlsx"))
			System.out.println(filesinDir[i].getAbsolutePath());
		}
	}

}
