package kr.co.itcall.jte.common.mvc;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class PageInfo<T> implements Serializable{
	
	private static final long serialVersionUID = 7990107934067716847L;
	
	private List<T> content = new ArrayList<T>();
	private PageRequestVo pageRequestVo;
	private long total;
	
	public PageInfo(List<T> content, PageRequestVo pageRequestVo, long total) {
		if(content == null) {
			this.pageRequestVo = pageRequestVo;
			this.total = 0;
		}
		else {
			this.content.addAll(content);
			this.pageRequestVo = pageRequestVo;
			
			
			this.total = !content.isEmpty() && pageRequestVo != null && pageRequestVo.getOffset() + pageRequestVo.getRows() > total
					? pageRequestVo.getOffset() + content.size() : total;
		}
	}
	
	public int getTotalPages() {
		return getSize() == 0 ? 1 : (int) Math.ceil((double) total / (double) getSize());
	}
	
	public Integer getSize() {
		return pageRequestVo == null ? 0 : pageRequestVo.getRows();
	}
	
	public long getTotalElements() {
		return total;
	}
	
	public boolean hasNext() {
		return getNumber() + 1 < getTotalPages();
	}
	
	public int getNumber() {
		return pageRequestVo == null ? 0 : pageRequestVo.getPage();
	}
	
	public boolean isLast() {
		return !hasNext();
	}
	
	public List<T> getContent() {
		return Collections.unmodifiableList(content);
	}
}
