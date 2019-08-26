package com;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelDemo {

	public static void main(String[] args) throws IOException {
		FileInputStream excelFile = new FileInputStream(new File("C:\\Users\\ssahoo43\\D_Drive\\eAppBHFAutomation\\Test Case\\eApp Test Data.xlsx"));
		XSSFWorkbook workbook = new XSSFWorkbook(excelFile);
		XSSFSheet TestCase_Sheet = workbook.getSheet("TestData");
		workbook.close();
		excelFile.close();
		Row currentRow = TestCase_Sheet.getRow(113);
		int testcaseno = 4;
		
		try{
			if (currentRow.getCell(testcaseno) != null){
				switch (currentRow.getCell(testcaseno).getCellTypeEnum()) {
				case NUMERIC:
					
					
				break;
				case STRING:
					
					
				break;
				case BOOLEAN :
				
					
	            break;
				case FORMULA :
					System.out.println(currentRow.getCell(testcaseno).getCellTypeEnum());
					FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator();
					CellValue cellValue = evaluator.evaluate(currentRow.getCell(testcaseno)); 
					System.out.println(cellValue.getStringValue());
	            break;
				default:
					System.out.println(currentRow.getCell(testcaseno).getCellTypeEnum());
					break;
				
				}
			}}
			catch (Exception e) {
				System.out.print(e.getMessage());
			}
	}

}
