package kr.co.itcall.jte.rms.model;

import lombok.Getter;
import lombok.Setter;

@Getter@Setter
public class PageVO {

	private int page;

	private int rows;
	
	private String sort;
	
	private String order;
	
	private String searchGubun;
	
	private String searchText;
}
