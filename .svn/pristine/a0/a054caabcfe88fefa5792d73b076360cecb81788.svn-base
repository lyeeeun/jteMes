package jin.mes.common.attach;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import jin.mes.mapper.common.attach.AttachMgtMapper;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

//@Profile("default")
//@Service("facilMgtService")
@Service
public class AttachMgtService {

	@Resource
	AttachMgtMapper attachMgtMapper;
	
	//첨부파일 조회
	public List<AttachMgtDto> getAttachFiles(AttachMgtDto attachMgtDto) {
		List<AttachMgtDto> attachMgtList = new ArrayList<AttachMgtDto>();
		try {
			attachMgtList = attachMgtMapper.selectAttchMgtList(attachMgtDto);
		}catch(Exception ex) {
			throw new BusinessException("첨부파일 조회 에러(Service) : " + ex.getMessage());
		}
		return attachMgtList;
	}
	
	//첨부파일 임시공간 저장
	public HashMap<String, List> attachFilesTempSave(MultipartHttpServletRequest attachfiles) {
		
		//첨부파일 리턴 값
		HashMap<String,List> resultAttach = new HashMap<String, List>();
		
		try {
			//첨부파일 리턴 List
			List<AttachMgtDto> attachList = new ArrayList<AttachMgtDto>();
			
			String basePath = new StringBuffer().append("D://FRONTSTORAGE").append(new SimpleDateFormat("//yyyy-MM-dd").format(new Date())).append("/").toString();
			File dir = new File(basePath);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			Map<String, List<MultipartFile>> multiFileMap = attachfiles.getMultiFileMap();
			for (String key : multiFileMap.keySet()) {
				for (MultipartFile multiFile : multiFileMap.get(key)) {
					AttachMgtDto returnAttach = new AttachMgtDto();
					
					String fileName = multiFile.getOriginalFilename();
					//String fileExt = FilenameUtils.getExtension(fileName);
					//int fileSize = (int)multiFile.getSize();
					String targetFile = basePath + System.currentTimeMillis() + "." + FilenameUtils.getExtension(fileName);
					multiFile.transferTo(new File(targetFile));
					
					returnAttach.setAttachOrigin(fileName);
					returnAttach.setAttachPath(targetFile);
					attachList.add(returnAttach);
				}
				resultAttach.put("attachFiles", attachList);
			}
		} catch (Exception e)  {
			throw new BusinessException("첨부파일 임시저장 에러(Service) : " + e.getMessage());
		}
		return resultAttach;
	}
	
	//첨부파일 삭제(FRONT)
	public HashMap<String, AttachMgtDto> attachFilesTempDelete(AttachMgtDto attachMgtDto){
		HashMap<String,AttachMgtDto> resultAttach = new HashMap<String, AttachMgtDto>();
		try {
			//신규등록인 경우 FRONTSTORAGE 경로 삭제
			if(attachMgtDto.getAttachStatus().equals("NEW")) {
				File file = new File(attachMgtDto.getAttachPath());
				if(file.exists()) {
					file.delete();
				}	
			}
			resultAttach.put("attachFiles", attachMgtDto);
		} catch (Exception e) {
			throw new BusinessException("첨부파일 FRONT 삭제(Service) : " + e.getMessage());
		}
		return resultAttach;
	}
	
	//첨부파일 저장(임시공간 > 실저장장소)
	public List<AttachMgtDto> attachFilesSave(List<AttachMgtDto> attachMgtList, String attachTarget, String attachTargetCode){
		//저장결과 리턴
		List<AttachMgtDto> attachList= new ArrayList<AttachMgtDto>();
		try {
			
			//BACKSTORAGE 경로
			String backPath = new StringBuffer().append("D://BACKSTORAGE").append("//"+attachTarget).append(new SimpleDateFormat("//yyyy-MM-dd").format(new Date())).append("/").toString();
			
			for(AttachMgtDto attachMgtDto : attachMgtList) {
				if(attachMgtDto.getAttachStatus().equals("NEW")) {
					AttachMgtDto attachFile = new AttachMgtDto();
					
					//FRONTSTORAGE에 저장된 파일 경로 읽어옴
					File frontFile = new File(attachMgtDto.getAttachPath());
					
					//파일원본명
					String fileOrigin = attachMgtDto.getAttachOrigin();
					attachFile.setAttachOrigin(fileOrigin);
					
					//파일확장자
					String fileExt = FilenameUtils.getExtension(fileOrigin);
					attachFile.setAttachExt(fileExt);
					
					//파일 저장명
					String fileName = FilenameUtils.getBaseName(fileOrigin) + System.currentTimeMillis() + "." + fileExt;
					attachFile.setAttachFilename(fileName);
					
					//파일경로 지정
					attachFile.setAttachPath(backPath);
					
					//파일사이즈
					float fileSize = frontFile.length();
					attachFile.setAttachSize(fileSize);
					
					//디렉토리 생성
					File dir = new File(backPath);
					if(!dir.exists()) {
						dir.mkdirs();
					}
					
					//파일 전체경로
					String backFile = backPath + fileName;
					
					//파일을 저장하는 대상정보 입력
					attachFile.setAttachTarget(attachTarget);
					attachFile.setAttachCode(attachTargetCode);
					attachFile.setCreatorId(JteUtils.getUserId());
					
					//DB 저장 수행
					attachMgtMapper.insertAttchMgt(attachFile);
					
					//FRONTSTORAGE > BACKSTORAGE
					if(frontFile.exists()) {
						frontFile.renameTo(new File(backFile));
					}
					
					//결과값 담기 
					attachList.add(attachFile);
				}
			}
		} catch (Exception e) {
			throw new BusinessException("첨부파일 BACK 저장 에러(Service) : " + e.getMessage());
		}
		return attachList;
	}
	
	//첨부파일 삭제(BACK)
	public int attachFilesDelete(List<AttachMgtDto> attachMgtList){
		//저장결과 리턴
		int intResult = -1; 
		
		try {
			//삭제수행
			for(AttachMgtDto attachMgtDto : attachMgtList) {
				File file = new File(attachMgtDto.getAttachPath());
				if(file.exists()) {
					//DB 삭제 수행
					attachMgtMapper.deleteAttchMgt(attachMgtDto);
					
					//파일삭제
					file.delete();
				}	
			}
			
			//삭제 완료 리턴값
			intResult = 0;
		} catch (Exception e) {
			intResult = -1;
			throw new BusinessException("첨부파일 BACK 삭제 에러(Service) : " + e.getMessage());
		}
		return intResult;
	}
	
	//첨부파일 체크(필요한가?)
	public boolean attachFilesDownloadCheck( AttachMgtDto attachMgtDto) {
		return new File(attachMgtDto.getAttachPath()).canRead();
	}

	//첨부파일 다운로드
	public AttachMgtDto attachFilesDownload(AttachMgtDto attachMgtDto) {
		AttachMgtDto rtnAttachMgt = attachMgtMapper.selectAttchMgtList(attachMgtDto).get(0);
		File filePath = new File(rtnAttachMgt.getAttachPath() +  rtnAttachMgt.getAttachFilename());
		if(filePath.exists()) {
			return rtnAttachMgt;
		}else {
			throw new BusinessException("첨부파일 다운로드 에러(Service) : ");
		}	
	}
}
