package kr.co.itcall.jte.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownLoadView extends AbstractView{
	
	private String fileName;
	
	public DownLoadView(){
		this(null);
	}
	public DownLoadView(String fileName) {
		super.setContentType("application/octet-stream");
		// super.setContentType("application/download;charset=utf-8");
		this.fileName = fileName;
	}
	
	@Override
	protected void renderMergedOutputModel(Map<String,Object> model, HttpServletRequest request,HttpServletResponse response) throws Exception{
		File file = new File((String)model.get("filePath"));
		String fileName = null;
		if(StringUtils.isEmpty(this.fileName)) { 
			fileName = new String(file.getName().getBytes("euc-kr"),"8859_1");
		}else {
			fileName = new String(this.fileName.getBytes("euc-kr"),"8859_1");
		}

        response.setContentType(super.getContentType());
        response.setContentLength((int)file.length());
        //response.setCharacterEncoding("euc-kr");
        response.setHeader("Content-Transfer-Encoding", "binary");
        
        response.setHeader("Content-Disposition", "attachment;fileName=\""+ fileName +"\";");
        
        response.setHeader("Set-Cookie", "fileDownload=true; path=/");

        OutputStream out = response.getOutputStream();


        FileInputStream fis = null;

        try{
        	fis = new FileInputStream(file);
            FileCopyUtils.copy(fis,out);
        }finally{
        	if(fis != null) fis.close();
        }
        out.flush();
	}
}
