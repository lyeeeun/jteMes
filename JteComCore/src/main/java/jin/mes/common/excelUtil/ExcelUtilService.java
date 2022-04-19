package jin.mes.common.excelUtil;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
//import org.apache.poi.hssf.usermodel.DVConstraint;
//import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.DataValidation;
import org.apache.poi.ss.usermodel.DataValidationConstraint;
import org.apache.poi.ss.usermodel.DataValidationConstraint.OperatorType;
import org.apache.poi.ss.usermodel.DataValidationHelper;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtMapper;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ExcelUtilService {

	@Resource
	ItemMgtMapper itemMgtMapper;
	
	@Resource
	ExcelUtilMapper excelUtilMapper;
	
	/**
	 *업로드한 엑셀파일을 과일 리스트로 만들기
	 * @param excelFile
	 * @return 생성한 과일 리스트
	 */
	public void uploadExcelFile(MultipartFile excelFile, String menuId){
		
		try {
			OPCPackage opcPackage = OPCPackage.open(excelFile.getInputStream());
			XSSFWorkbook workbook = new XSSFWorkbook(opcPackage);
			
			// 첫번째 시트 불러오기
			XSSFSheet sheet = workbook.getSheetAt(0);
			
			ExcelUtilDto excelUtilDto = new ExcelUtilDto();
			excelUtilDto.setMenuId(menuId);
			excelUtilDto.setAction("U");
			
			
				
			
		
			excelUtilDto.setColumnList(excelUtilMapper.selectTableInfo(excelUtilDto));
			
			String className = "";
			String methodName = "";
			Object obj = null;
			Method method = null;
			
			if(!StringUtils.isEmpty(excelUtilDto.getColumnList().get(0))) {
				className = "jin.mes." + excelUtilDto.getColumnList().get(0).getRtlSystemSvc();
				methodName = excelUtilDto.getColumnList().get(0).getRtlSystemMethod();
				Class<?> cls = Class.forName(className); // 다음과 같이하면 클래스를 로딩
				obj = cls.newInstance(); // 해당 클래스 인스턴스 생성
				method = cls.getMethod(methodName, ExcelUtilDto.class); // 메소드 로딩( 메소드의 인자값이 String 하나가 들어가 있다)
			}
			
			
			
			boolean cellNullFlag = false;
			for(int i=1; i<sheet.getLastRowNum() + 1; i++) {
				List<ExcelUtilDto> valueList = new ArrayList<ExcelUtilDto>();
				
				XSSFRow row = sheet.getRow(i);
				
				// 행이 존재하기 않으면 패스
				if(null == row) {
					continue;
				}
				
				int index = 0;
				for(ExcelUtilDto excelDto : excelUtilDto.getColumnList()) {
					excelUtilDto.setTableId(excelDto.getTableId());
					
					XSSFCell cell = row.getCell(index);
					
					//자동 키 부여되는 PK 제외, 표시 여부 체크 된 것만 Excel Data Input
					if(!excelDto.isAutoKeyYn() && excelDto.isCheckYn()) {
						// Not Null Column 인데, NULL 값 들어올 경우 해당 Row는 입력하지 않는다.
						if(!excelDto.isNullAble()) {
							if(cell == null) {
								cellNullFlag = true;
								break;
							}
						}
						
						if(excelDto.getColumnType().indexOf("char") != -1 || excelDto.getColumnType().indexOf("text") != -1) {
							excelDto.setStringValue(cell.getStringCellValue());
							//excelUtilDto.getValueList().add(excelDto);
						} else if(excelDto.getColumnType().indexOf("int") != -1 || excelDto.getColumnType().indexOf("long") != -1) {
							excelDto.setIntValue((int) cell.getNumericCellValue());
						} else if(excelDto.getColumnType().indexOf("float") != -1 || excelDto.getColumnType().indexOf("double") != -1) {
							excelDto.setFloatValue(cell.getNumericCellValue());
						} else if(excelDto.getColumnType().indexOf("date") != -1) {
							excelDto.setStringValue(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cell.getDateCellValue()));
						}
						index++;
					}
					
					valueList.add(excelDto);
					
				};
			
				// Not Null Column에  Null 값이 포함되었을 경우, 해당 Row에 대한 Insert를 방지한다.
				if(cellNullFlag) {
					continue;
				}
				
				excelUtilDto.setValueList(valueList);
				
				excelUtilMapper.insertExcelData(excelUtilDto);
				
				
				if(method != null) {
					method.invoke(obj, excelUtilDto);
				}
			}
		
			
			

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void downloadExcelFile(HttpServletRequest request, HttpServletResponse response, ExcelUtilDto excelUtilDto) {
		try{
			String home = System.getProperty("user.home");
			
			SXSSFWorkbook workbook = new SXSSFWorkbook();
			// 시트 생성
			SXSSFSheet sheet = (SXSSFSheet)workbook.createSheet(excelUtilDto.getMenuId());
			 
			 // 테이블 헤더용 스타일
			 // CellStyle headStyle = workbook.createCellStyle();
			excelUtilDto.setColumnList(excelUtilMapper.selectTableInfo(excelUtilDto));
			
			Font boldFont = workbook.createFont();
			boldFont.setBold(true);
			
			CellStyle dateTimeCellStyle = workbook.createCellStyle();
			CreationHelper createHelper = workbook.getCreationHelper();
			dateTimeCellStyle.setDataFormat(createHelper.createDataFormat().getFormat("yyyy-MM-dd HH:mm:ss"));
			dateTimeCellStyle.setBorderTop(XSSFCellStyle.BORDER_THIN);
			dateTimeCellStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			dateTimeCellStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
			dateTimeCellStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			//CellStyle numericCellStyle = workbook.createCellStyle();
			
			
			CellStyle baseCellStyle = workbook.createCellStyle();
			
			baseCellStyle.setBorderTop(XSSFCellStyle.BORDER_THIN);
			baseCellStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			baseCellStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
			baseCellStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			CellStyle headerCellStyle = workbook.createCellStyle();
			
			headerCellStyle.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());
			headerCellStyle.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
			headerCellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			headerCellStyle.setFont(boldFont);
			headerCellStyle.setBorderTop(XSSFCellStyle.BORDER_THIN);
			headerCellStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			headerCellStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
			headerCellStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			
			// 헤더 생성
			Row headerRow = sheet.createRow(0);
			// 기준 Row 생성
			Row defaultRow = sheet.createRow(1);
			
			int index=0;
			for(ExcelUtilDto column : excelUtilDto.getColumnList()) {
				if(!column.isAutoKeyYn() && column.isCheckYn()) {
					headerRow.createCell(index).setCellValue(column.getColumnNm());
					headerRow.getCell(index).setCellStyle(headerCellStyle);
					
					if(column.isListYn()) {
						String[] baseCodeList = excelUtilMapper.selectCodeList(column.getCdId());
						
						DataValidationHelper validationHelper = sheet.getDataValidationHelper();
						CellRangeAddressList regions = new CellRangeAddressList(1, 1, index, index);  // 적용할 범위
						
						DataValidationConstraint category = validationHelper.createExplicitListConstraint(baseCodeList);
						DataValidation validation = validationHelper.createValidation(category, regions);
						
						validation.setSuppressDropDownArrow(true);
						
						validation.setShowErrorBox(true);
						validation.createErrorBox("ERROR MEESAGE:Invalid Data", "Please provide valid data in the dropdown list.");
						
						sheet.addValidationData(validation);
					}
					//List Yn or rtlTableYn 택1이어야 한다.
					if(column.isRtlTableYn()) {
						String[] rtlTableCodeList = excelUtilMapper.selectRtlTableCodeList(column);
						
						DataValidationHelper validationHelper = sheet.getDataValidationHelper();
						CellRangeAddressList regions = new CellRangeAddressList(1, 1, index, index);  // 적용할 범위
						
						DataValidationConstraint category = validationHelper.createExplicitListConstraint(rtlTableCodeList);
						DataValidation validation = validationHelper.createValidation(category, regions);
						
						validation.setSuppressDropDownArrow(true);
						
						validation.setShowErrorBox(true);
						validation.createErrorBox("ERROR MEESAGE:Invalid Data", "Please provide valid data in the dropdown list.");
						
						sheet.addValidationData(validation);
					}
						
					if(column.getColumnType().indexOf("date") != -1) {
						defaultRow.createCell(index).setCellStyle(dateTimeCellStyle);
						defaultRow.getCell(index).setCellValue(new Date());
						
						DataValidationHelper validationHelper = sheet.getDataValidationHelper();
						CellRangeAddressList regions = new CellRangeAddressList(1, 1, index, index);  // 적용할 범위
						
						DataValidationConstraint dateFormatConst = validationHelper.createDateConstraint(OperatorType.BETWEEN, "=DATE(1900,1,1)", "=DATE(3000,12,31)", "yyyy-MM-dd HH:mm:ss");
						
						DataValidation validation = validationHelper.createValidation(dateFormatConst, regions);
						
						validation.setSuppressDropDownArrow(true);
						
						validation.setShowErrorBox(true);
						validation.createErrorBox("ERROR MEESAGE:Invalid Data", "Please Date in Format yyyy-MM-dd HH:mm:ss");
						
						sheet.addValidationData(validation);
					} else {
						defaultRow.createCell(index).setCellStyle(baseCellStyle);
						
						if(column.getColumnType().indexOf("int") != -1 || column.getColumnType().indexOf("long") != -1 || 
						   column.getColumnType().indexOf("float") != -1 || column.getColumnType().indexOf("double") != -1) {
						defaultRow.getCell(index).setCellType(Cell.CELL_TYPE_NUMERIC);
						
						DataValidationHelper validationHelper = sheet.getDataValidationHelper();
						CellRangeAddressList regions = new CellRangeAddressList(1, 1, index, index);  // 적용할 범위
						
						DataValidationConstraint numericConst = validationHelper.createNumericConstraint(
						DataValidationConstraint.ValidationType.DECIMAL, 
						DataValidationConstraint.OperatorType.BETWEEN,
						String.valueOf(Float.MIN_VALUE), 
						String.valueOf(Float.MAX_VALUE)
						);
						
						DataValidation validation = validationHelper.createValidation(numericConst, regions);
						
						validation.setSuppressDropDownArrow(true);
						
						validation.setShowErrorBox(true);
						validation.createErrorBox("ERROR MEESAGE:Invalid Data", "Please Numeric Data.");
						
						sheet.addValidationData(validation);
						
					}
					}
					
					index++;
				}
			}
			SimpleDateFormat saveDate = new SimpleDateFormat("yyyy-MM-dd");
			
			
			FileOutputStream os = new FileOutputStream(home+ "/Downloads/" + excelUtilDto.getMenuId() + "_" + saveDate.format(new Date()) + ".xlsx");
			// 엑셀 출력
			workbook.write(os);
			
			workbook.close();
			os.close();
			
		} catch (Exception ex) {
			throw new BusinessException(ex.getMessage());
		}

	}
	
	public List<ExcelUtilDto> selectTableInfo(ExcelUtilDto excelUtilDto) {
		List<ExcelUtilDto> tableInfoList = new ArrayList<ExcelUtilDto>();		
		try {
			tableInfoList = excelUtilMapper.selectTableInfo(excelUtilDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tableInfoList;
	}
	
	public int selectIsSet(ExcelUtilDto excelUtilDto) {
		int count = 0;
		try {
			count = excelUtilMapper.selectIsSet(excelUtilDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public void insertExcelSetting(ExcelUtilDto excelUtilDto) {
		try {
			for (ExcelUtilDto setting : excelUtilDto.getColumnList()) {
				excelUtilMapper.insertExcelSetting(setting);	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateExcelSetting(ExcelUtilDto excelUtilDto) {
		try {
			for (ExcelUtilDto setting : excelUtilDto.getColumnList()) {
				excelUtilMapper.updateExcelSetting(setting);	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteExcelSetting(ExcelUtilDto excelUtilDto) {
		try {
			excelUtilMapper.deleteExcelSetting(excelUtilDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public List<ExcelUtilDto> selectTableTestInfo(ExcelUtilDto excelUtilDto) {
		List<ExcelUtilDto> tableInfoList = new ArrayList<ExcelUtilDto>();		
		try {
			tableInfoList = excelUtilMapper.selectTableTestInfo(excelUtilDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tableInfoList;
	}
	
	public void insertOrderMgt(ExcelUtilDto excelUtilDto) {
		try {
			for (ExcelUtilDto setting : excelUtilDto.getColumnList()) {
				excelUtilMapper.insertOrderMgt(setting);	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateOrderMgt(ExcelUtilDto excelUtilDto) {
		try {
			for (ExcelUtilDto setting : excelUtilDto.getColumnList()) {
				excelUtilMapper.updateOrderMgt(setting);	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteOrderMgt(ExcelUtilDto excelUtilDto) {
		try {
			excelUtilMapper.deleteOrderMgt(excelUtilDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//엑셀업로드 - 현재 지닉스 바코드에서만 사용 수정시 지닉스 바코드 엑셀 업로드 확인해볼것
	public List<Map<String, String>> excelUpload(MultipartFile file) {
		List<Map<String, String>> excelContent = null;
		try {
			OPCPackage opcPackage = OPCPackage.open(file.getInputStream());
			XSSFWorkbook workbook = new XSSFWorkbook(opcPackage);
			
			excelContent = excelRead(workbook);
			
		} catch (Exception e) {
			throw new BusinessException("엑셀업로드 에러" + e.getMessage());
		}
		return excelContent;
	}
	
	//엑셀업로드2 - 현재 지닉스 바코드에서만 사용 수정시 지닉스 바코드 엑셀 업로드 확인해볼것
	public static List<Map<String, String>> excelRead(XSSFWorkbook wb) {
		//엑셀 파일 자체
		//엑셀파일을 읽어 들인다.
		//FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.
//		Workbook wb = getWorkbook(path);
		
		//엑셀 파일에서 첫번째 시트를 가지고 온다.
		Sheet sheet = wb.getSheetAt(0);
		
//		System.out.println("Sheet 이름: "+ wb.getSheetName(0)); 
//		System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
		
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
		numOfCells = sheet.getRow(0).getLastCellNum();
		
		
		//header 가져오기
		Row headerRow = sheet.getRow(0);

		
		/**
		 * 각 Row만큼 반복을 한다.
		 */
		for(int rowIndex = 1; rowIndex < numOfRows; rowIndex++) {
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
					cellName = getValue(headerRow.getCell(cellIndex));
					
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
