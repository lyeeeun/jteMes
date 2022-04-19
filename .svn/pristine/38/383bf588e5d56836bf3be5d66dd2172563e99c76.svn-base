package kr.co.itcall.jte.pms.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.itcall.jte.pms.model.ExcelFileVO;
import kr.co.itcall.jte.pms.model.ExcelUploadVO;

@Service
public class ExcelFileServiceImpl implements ExcelFileService {
	
	@Autowired
	PmsService pmsService;
	
	@Override
	public String excelUploadOrder(ExcelUploadVO excelUploadVO, File destFile) {
		String strResult = "ERROR";
		try {
			ExcelFileVO excelFileVO = new ExcelFileVO();
			excelFileVO.setFilePath(destFile.getAbsolutePath());
	
			//조회할 엑셀 필드명(맞춰줌)
			excelFileVO.setOutputColumns("pmsCd01","pmsCd02","pmsCd03","pmsCd04","pmsCd05",
					"descTech","descOrder","gapRunHour","descEtc","plateNo","pmsQty","pmsUnit");
			
			//엑셀에서 데이터가  위치한 자리
			excelFileVO.setStartRow(4);
			
			List<Map<String, String>> excelContent = excelRead(excelFileVO);
			strResult = pmsService.setExcelOrderSave(excelContent,excelUploadVO);
			
		}catch(Exception e) {
			e.printStackTrace();
			strResult = "ERROR";
		}
		return strResult;
	};

	@Override
	public String excelUploadParts(ExcelUploadVO excelUploadVO, File destFile) {
		String strResult = "ERROR";
		try {
			ExcelFileVO excelFileVO = new ExcelFileVO();
			excelFileVO.setFilePath(destFile.getAbsolutePath());
	
			//조회할 엑셀 필드명(맞춰줌)
			excelFileVO.setOutputColumns("nationId","areaId","companyId","engineModel","plateNo",
					"platePart","siteCd","drawNo","typeCd","materialNo","uCode",
					"prodStd","engineAmt","amtUnit","stockYn","limitTime");
			
			//엑셀에서 데이터가  위치한 자리
			excelFileVO.setStartRow(4);
			
			
			List<Map<String, String>> excelContent = excelRead(excelFileVO);
	
			strResult = pmsService.setExcelPartsSave(excelContent, excelUploadVO);
			
		}catch(Exception e) {
			e.printStackTrace();
			strResult = "ERROR";
		}
		return strResult;
	};
	
	public static List<Map<String, String>> excelRead(ExcelFileVO excelFileVO) {
		//엑셀 파일 자체
		//엑셀파일을 읽어 들인다.
		//FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.
		Workbook wb = getWorkbook(excelFileVO.getFilePath());
		
		//엑셀 파일에서 첫번째 시트를 가지고 온다.
		Sheet sheet = wb.getSheetAt(0);
		
		System.out.println("Sheet 이름: "+ wb.getSheetName(0)); 
		System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
		
		//sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
		int numOfRows = sheet.getPhysicalNumberOfRows();
		int numOfCells = 0;
		
		Row row = null;
		Cell cell = null;
		
		String cellName = "";
		Map<String, String> map = null;
		/*
		 * 각 Row를 리스트에 담는다.
		 * 하나의 Row를 하나의 Map으로 표현되며
		 * List에는 모든 Row가 포함될 것이다.
		 */
		List<Map<String, String>> result = new ArrayList<Map<String, String>>(); 
		
		
		//Cell의 수가 몇 개 인지 헤더 Cell의 수를 센다.
		numOfCells = sheet.getRow(2).getLastCellNum();
		
		/**
		 * 각 Row만큼 반복을 한다.
		 */
		for(int rowIndex = excelFileVO.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
			/*
			 * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
			 * 하나의 Row는 여러개의 Cell을 가진다.
			 */
			row = sheet.getRow(rowIndex);

			if(row != null) {
				/*
				 * 데이터를 담을 맵 객체 초기화
				 */
				map = new HashMap<String, String>();
				
				//cell의 수 만큼 반복한다.
				for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
					/*
					 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
					 */
					cell = row.getCell(cellIndex);
					/*
					 * 현재 Cell의 이름을 가져온다
					 * 이름의 예 : A,B,C,D,......
					 */
					//cellName = getName(cell, cellIndex);
					cellName = getValue(sheet.getRow(2).getCell(cellIndex));
					
					/*
					 * 추출 대상 컬럼인지 확인한다
					 * 추출 대상 컬럼이 아니라면, 
					 * for로 다시 올라간다
					 */
					if( !excelFileVO.getOutputColumns().contains(cellName) ) {
						continue;
					}
					/*
					 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
					 */
					map.put(cellName, getValue(cell));
					
				}
				result.add(map);
			}
		}
		return result;
	}

	/**
	 * 
	 * 엑셀파일을 읽어서 Workbook 객체에 리턴한다.
	 * XLS와 XLSX 확장자를 비교한다.
	 * 
	 * @param filePath
	 * @return
	 * 
	*/
	public static Workbook getWorkbook(String filePath) {
		
		/*
		 * FileInputStream은 파일의 경로에 있는 파일을
		 * 읽어서 Byte로 가져온다.
		 * 
		 * 파일이 존재하지 않는다면은
		 * RuntimeException이 발생된다.
		 */
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(filePath);
		} catch (FileNotFoundException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
		
		Workbook wb = null;
		
		/*
		 * 파일의 확장자를 체크해서 .XLS 라면 HSSFWorkbook에
		 * .XLSX라면 XSSFWorkbook에 각각 초기화 한다.
		 */
		if(filePath.toUpperCase().endsWith(".XLS")) {
			try {
				wb = new HSSFWorkbook(fis);
			} catch (IOException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}
		else if(filePath.toUpperCase().endsWith(".XLSX")) {
			try {
				wb = new XSSFWorkbook(fis);
			} catch (IOException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}
		
		return wb;
		
	}

	public static String getName(Cell cell, int cellIndex) {
		int cellNum = 0;
		if(cell != null) {
			cellNum = cell.getColumnIndex();
		}
		else {
			cellNum = cellIndex;
		}

		return CellReference.convertNumToColString(cellNum);
	}

	public static String getValue(Cell cell) {
		String value = "";
		
		if(cell == null) {
			value = "";
		}
		else {
			if( cell.getCellType() == Cell.CELL_TYPE_FORMULA ) {
				value = cell.getCellFormula().trim();
			}
			else if( cell.getCellType() == Cell.CELL_TYPE_NUMERIC ) {
				value = cell.getNumericCellValue() + "";
			}
			else if( cell.getCellType() == Cell.CELL_TYPE_STRING) {
				value = cell.getStringCellValue() + "";
			}
			else if( cell.getCellType() == Cell.CELL_TYPE_BOOLEAN ) {
				value = cell.getBooleanCellValue() + "";
			}
			else if( cell.getCellType() == Cell.CELL_TYPE_ERROR ) {
				value = cell.getErrorCellValue() + "";
			}
			else if( cell.getCellType() == Cell.CELL_TYPE_BLANK ) {
				value = "";
			}
			else {
				value = cell.getStringCellValue();
			}
		}
		
		if(value.trim() == "-") {
			value = "";
		}
		
		return value;
	}
}
