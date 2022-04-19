package kr.co.itcall.jte.pms.service;

import java.io.File;

import kr.co.itcall.jte.pms.model.ExcelUploadVO;

public interface ExcelFileService {
	//Order Excel 업로드
	public String excelUploadOrder(ExcelUploadVO excelUploadVO, File destFile);

	//Parts Excel 업로드
	public String excelUploadParts(ExcelUploadVO excelUploadVO, File destFile);
	
}
