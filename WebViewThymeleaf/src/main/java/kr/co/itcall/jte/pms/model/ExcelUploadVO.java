package kr.co.itcall.jte.pms.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ExcelUploadVO {
	
	private String nationId;
	
	private String areaId;
	
	private String companyId;
	
	private String engineModel;
	
	private MultipartFile file;
}
