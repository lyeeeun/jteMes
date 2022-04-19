package kr.co.itcall.jte.common.mvc;

import java.io.Serializable;

import org.apache.commons.lang3.StringUtils;

public class PageRequestVo implements Serializable{

	private static final long serialVersionUID = 6585861695752074808L;
	
	private Integer totalPage;
	private Integer page;
	private Integer rows;
	private Long total;
	private int firstPage;
	private int lastPage;
	private String pagingYN;
	
	public Integer getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getRows() {
		return rows;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	public Long getTotal() {
		return total;
	}
	public void setTotal(Long total) {
		this.total = total;
	}
	public String getPagingYN() {
		return pagingYN;
	}
	
	public void setPagingYN(String pagingYN) {
		this.pagingYN = pagingYN;
	}
	
	public int getOffset() {
		return page * rows;
	}
	
	public int getBlockFirstPage() {
		//페이징 없는 경우 추가 - jkkim
		if(StringUtils.isEmpty(getPagingYN()) || getPagingYN().equals("Y")) {
			return (getPage() * getRows()) + 1;
		}
		return 0;
		
	}
	
	public int getBlockLastPage() {
		//페이징 없는 경우 추가 - jkkim
		if(StringUtils.isEmpty(getPagingYN()) || getPagingYN().equals("Y")) {
			return (getPage() +1) * getRows();
		}
		return 0;
	}
	public int getFirstPage() {
		firstPage = getBlockFirstPage();
		
		return firstPage;
	}
	
	public int getLastPage() {
		lastPage = getBlockLastPage();
		
		return lastPage;
	}
	
}
