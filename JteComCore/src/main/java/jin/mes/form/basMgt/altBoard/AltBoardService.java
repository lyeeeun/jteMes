package jin.mes.form.basMgt.altBoard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import jin.mes.common.cache.CacheUtil;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.CodeUtil;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import kr.co.itcall.jte.spring.config.exception.SystemException;
import kr.co.itcall.jte.util.DownLoadView;
import lombok.extern.slf4j.Slf4j;

@Service("altBoardService")
@Transactional("transactionManager")
@Slf4j
public class AltBoardService {

	private static final String BOARD_BASE_UPLOAD_PATH = "board/upload/";
	private static final int FILE_UPLOAD_COUNT_LIMIT = 3;
	private static final String FILE_UPLOAD_ALOW_EXT_PATTERN_SYS_FLAG_KEY = "sys.flag.upfileExtPatten";
	private static final String FILE_UPLOAD_ALOW_EXT_PATTERN = "JPEG,JPG,PNG,ZIP,7Z,TXT,GIF,PDF,TIF";

	private static final String MAX_POP_BOARD_LIMIT_KEY = "sys.flag.popAltMaxCnt";
	private static final int MAX_POP_BOARD_LIMIT_DEF = 3; // 팝업공지 개수 최대값

	@Resource(name="messageSourceAccessor")
	protected MessageSourceAccessor messageSourceAccessor;

	@Value("#{app['common.nfs.root']}") // : /NAS_BIZ/data/
	private String nfsRootPath;
	
	@Value("#{biz['board.alt.file.upload.alow.exts']?:'"+FILE_UPLOAD_ALOW_EXT_PATTERN+"'}")
	private String uploadExtAllowedPattern;
	
	@Resource
	protected AltBoardMapper altBoardMapper;
	
	/**
	 * 게시판 리스트를 가지고 온다.
	 * 
	 */
	@Transactional(readOnly=true)
	public PageInfo<AltBoardDto> getBoardList(AltBoardDto altBoardDto, PageRequestVo pageRequestVo) {
		List<AltBoardDto> userList = null;
		int rowCount = 0;

		// Page Setting
		altBoardDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		altBoardDto.setLastIndex(pageRequestVo.getBlockLastPage());

		log.debug("Board Info = 【{}】", altBoardDto);

		try {
			rowCount = altBoardMapper.selectBoardListCount(altBoardDto);
			if (rowCount > 0) {
				userList = altBoardMapper.selectBoardList(altBoardDto); // not registerd user
			}
		} catch (Exception e) {
			log.error("SearchError message[{}], cause[{}], localizedMessage[{}] {}", e.getMessage(), e.getCause(), e.getLocalizedMessage(), e);
			throw new SystemException(e);
		}

		if (userList == null) {
			userList = new ArrayList<AltBoardDto>();
		}
		return new PageInfo<AltBoardDto>(userList, pageRequestVo, rowCount);
	}
	
	/**
	 * 
	 * @param bdSeq
	 * @return
	 */
	// @MaskingTargetMethod(isAddLog=true,columnName="userId",sessionName="biznaruBoardInfo")
	public AltBoardDto getBoard(long bdSeq) {
		AltBoardDto altBoardDto = altBoardMapper.selectBoard(bdSeq);
		return altBoardDto;
	}

	/**
	 * 
	 * @param altBoardDto
	 * @param multipartHttpServletRequest 
	 * @return
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	public int addBoard(AltBoardDto altBoardDto, MultipartHttpServletRequest multipartHttpServletRequest) throws IllegalStateException, IOException {

		// 파일 저장처리 후 altBoardDto에 결과셋팅.
		checkOverflowPop(altBoardDto); // 로그인 시 처리하는 팝업인 경우 최대 Active POP 개수를 조회하여 3개 이상인 경우 실패처리한다.
		altBoardDto = saveUploadFiles(new AltBoardDto(), altBoardDto, multipartHttpServletRequest);

		int result = altBoardMapper.insertBoard(altBoardDto);
		return result;
	}
	
	/**
	 * 
	 * @param altBoardDto
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	public int setBoard(AltBoardDto altBoardDto) throws IllegalStateException, IOException {

		checkOverflowPop(altBoardDto); // 로그인 시 처리하는 팝업인 경우 최대 Active POP 개수를 조회하여 3개 이상인 경우 실패처리한다.
		
		int result = altBoardMapper.updateBoard(altBoardDto);
		
		return result;
	}
	
	/**
	 * 
	 * @param altBoardDto
	 * @param multipartHttpServletRequest 
	 * @return
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	public int setBoard(AltBoardDto altBoardDto, MultipartHttpServletRequest multipartHttpServletRequest) throws IllegalStateException, IOException {

		checkOverflowPop(altBoardDto); // 로그인 시 처리하는 팝업인 경우 최대 Active POP 개수를 조회하여 3개 이상인 경우 실패처리한다.

		/*** 0. 기존정보 조회 ***/
		AltBoardDto oldAltBoardDto = altBoardMapper.selectBoard(altBoardDto.getBdSeq());
		/*** 1. 파일 저장처리 후 altBoardDto에 저장된 파일정보결과가 셋팅된다.(순서가 바뀌면 안됨) : 삭제대상 파일이 있으면 해당 파일은 삭제한다(removeFilesPath) ***/
		altBoardDto = saveUploadFiles(oldAltBoardDto, altBoardDto, multipartHttpServletRequest);
		
		/*** 2. DB에 정보 업데이트 ***/
		int result = altBoardMapper.updateBoard(altBoardDto);
		
		return result;
	}

	public int resetBoard(AltBoardDto altBoardDto, MultipartHttpServletRequest multipartHttpServletRequest) {

		// 파일 저장처리 후 altBoardDto에 결과셋팅.

		int result = 0;
		altBoardDto.setBdBfSeq(altBoardDto.getBdSeq());
		result = altBoardMapper.insertBoard(altBoardDto); // 수정된것은 신규로 등록하며, 이전 게시글의 SEQ를 BD_BF_SEQ에 넣어준다.
		altBoardDto.setEfctFnsDt(new Date());
		result = altBoardMapper.updateBoard(altBoardDto); // 이전 게시글은 더이상 조회되지 않게 EFCT_FNS_DT를 지금날짜로 꺾어준다.
		// 제목, 본문등의 업데이트는 실제 업데이트가 아니며, insert 후 플레그 꺽는것임.
		return result;
	}

	public void removeBoard(long bdSeq) {
		altBoardMapper.deleteBoard(bdSeq);
	}

	public boolean fileDownloadCheck(long bdSeq, String filePath, ModelMap model) {
		model.addAttribute("msg", messageSourceAccessor.getMessage("errors.board.file.not.exist", "다운로드 받을 파일이 서버에 존재하지 않습니다."));
		return new File(this.nfsRootPath + filePath).canRead();
	}

	/**
	 * NFS에 저장된 파일의 실제 RealFullPath를 반환한다.
	 * @param bdSeq
	 * @param fileNm
	 * @param modelAndView
	 * @return
	 */
	public ModelAndView fileDownload(long bdSeq, String filePath, ModelAndView modelAndView) {
		// "실제위치 파일경로".substring(this.nfsRootPath.length())
		String fileNm = filePath;
		AltBoardDto altBoardDto = altBoardMapper.selectBoard(bdSeq);
		log.info("altBoardDto.getBdFilesPath([{}]).contains([{}]) = [{}]", altBoardDto.getBdFilesPath(), filePath, altBoardDto.getBdFilesPath().contains(filePath));
		log.info("new File(this.nfsRootPath + filePath).canRead()[{}] = [{}]", this.nfsRootPath + filePath, new File(this.nfsRootPath + filePath).canRead());
		if(altBoardDto!=null && StringUtils.isNotEmpty(altBoardDto.getBdFilesPath()) && altBoardDto.getBdFilesPath().contains(filePath) && new File(this.nfsRootPath + filePath).canRead()) {
			fileNm = altBoardDto.getListBdFileNm().get(altBoardDto.getListBdFilePath().indexOf(filePath));
			modelAndView.addObject("filePath", this.nfsRootPath + filePath);
			modelAndView.setView(new DownLoadView(fileNm)); // 파일명을 지정해줘야 한다. 아니면 서버에 있는 파일명코드가 파일명으로 지정되어 다운로드 된다.
			return modelAndView;
		}
		throw new BusinessException(messageSourceAccessor.getMessage("errors.board.file.download", new Object[]{bdSeq, fileNm})) ; // 게시글[{0}]이 존재하지 않거나 첨부된 파일[{1}]이 없습니다.
	}


	private AltBoardDto saveUploadFiles(AltBoardDto oldAltBoardDto, AltBoardDto altBoardDto, MultipartHttpServletRequest multipartHttpServletRequest) throws IllegalStateException, IOException {
		int mergeFileCnt = oldAltBoardDto.getBdFilesCnt();
		String[] mergeFileNames = new String[FILE_UPLOAD_COUNT_LIMIT];
		String[] mergeFilePaths = new String[FILE_UPLOAD_COUNT_LIMIT];
		for (int i = 0; i < mergeFileCnt; i++) {
			mergeFileNames[i] = oldAltBoardDto.getListBdFileNm().get(i);
			mergeFilePaths[i] = oldAltBoardDto.getListBdFilePath().get(i);
		}
		String[] removeFilePaths = altBoardDto.getRemoveFilesPath();
		if(removeFilePaths!=null) {
			for (String removeFilePath : removeFilePaths) {
				for (int i = 0; i < mergeFilePaths.length; i++) {
					if(StringUtils.isNotEmpty(mergeFilePaths[i]) && mergeFilePaths[i].equals(removeFilePath)) {
						--mergeFileCnt;
						mergeFileNames[i] = null;
						mergeFilePaths[i] = null;
					}
				}
			}
		}
		// 삭제 대상이 있으면 먼저 삭제하고, 잔존한 파일카운트를 먼저 셋팅한다.
		
		
//		int newFileCnt = 0;
//		String newFileNames = "";
//		String newFilePaths = "";
		
		String basePath = new StringBuffer().append(this.nfsRootPath).append(BOARD_BASE_UPLOAD_PATH).append(new SimpleDateFormat("yyyy-MM").format(new Date())).append("/").toString();
		File dir = new File(basePath);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		Map<String, List<MultipartFile>> multiFileMap = multipartHttpServletRequest.getMultiFileMap();
		for (String key : multiFileMap.keySet()) {
			for (MultipartFile multiFile : multiFileMap.get(key)) {
//				++newFileCnt;
				String filename = multiFile.getOriginalFilename().replaceAll("[:\\\\/%*?:|\"<>]", "");
				String targetFile = basePath + System.currentTimeMillis() + "." + FilenameUtils.getExtension(filename);
				String fileExt = FilenameUtils.getExtension(filename);

				
				String uploadExtAllowedPattern = CacheUtil.getCode(FILE_UPLOAD_ALOW_EXT_PATTERN_SYS_FLAG_KEY, this.uploadExtAllowedPattern).getCdVal().toUpperCase();
				String[] arrUploadExtAllowedPattern = uploadExtAllowedPattern.split(",");
				Arrays.sort(arrUploadExtAllowedPattern);
				if(StringUtils.isEmpty(fileExt) || Arrays.binarySearch(arrUploadExtAllowedPattern, fileExt.toUpperCase())<0) {
//				if (!StringUtils.isEmpty(fileExt) && !"JPEG".equalsIgnoreCase(fileExt)
//						&& !"JPG".equalsIgnoreCase(fileExt) && !"TIF".equalsIgnoreCase(fileExt)
//						&& !"PDF".equalsIgnoreCase(fileExt) && !"GIF".equalsIgnoreCase(fileExt)) {
					log.error("요청된 업로드파일[{}]은 지정된 업로드 파일형식[{}]이 아닙니다.", filename, uploadExtAllowedPattern);
					throw new BusinessException(messageSourceAccessor.getMessage("errors.board.file.format.invalid", new Object[] {filename, uploadExtAllowedPattern})); // 지정된 파일형식만 업로드가 가능합니다.\n업로드가능형식 : [{0}]
				}
				for (int i = 0; i <= 3; i++) { // 시스템에서 주어지는 파일명이 동일하면 3번 다른이름으로 재시도 해보고 실패처리한다.
					if(i>=3) {
						log.error("업로드 중인 파일이름[{}]에 해당하는 NFS의 실제 저장파일명[{}]이 이미 존재합니다.", filename, targetFile);
						throw new BusinessException(messageSourceAccessor.getMessage("errors.board.file.upload.duplicate", new Object[] {filename})) ; // 업로드 대상파일[{1}]이 이미 존재하여 업로드 할 수 없습니다.\n잠시후 다시 시도해 주십시오.
					}
					if(new File(targetFile).exists()) {
						try {
							Thread.sleep(1);
						} catch (InterruptedException e) {
							log.error("sleep Error[{}] {}", e.getMessage(), e);
						}
						targetFile = basePath + System.currentTimeMillis() + "." + FilenameUtils.getExtension(filename);
					} else {
						break;
					}
				}
				log.debug("업로드 파일 대상 beforeFileCount[{}], filename[{}], originalFilename[{}], MultipartFileInfo[{}]", mergeFileCnt, multiFile.getName(), filename, multiFile);
				multiFile.transferTo(new File(targetFile));
//				newFileNames+=","+filename;
//				newFilePaths+=","+targetFile.substring(this.nfsRootPath.length());
				int nowFileNum = mergeFileCnt;
				for (int i = 0; i < mergeFileNames.length; i++) {
					if(StringUtils.isEmpty(mergeFileNames[i])) {
						mergeFileNames[i] = filename;
						mergeFilePaths[i] = targetFile.substring(this.nfsRootPath.length());
						++nowFileNum;
						break;
					}
				}
				if(nowFileNum==mergeFileCnt+1) {
					mergeFileCnt = nowFileNum;
					log.info("업로드 파일 완료 afterFileCount[{}], filename[{}], originalFilename[{}], savedRealFilename[{}], MultipartFileInfo[{}]", mergeFileCnt, multiFile.getName(), filename, targetFile, multiFile);
				} else {
					log.error("업로드 파일개수[{}]가 초과했거나, 접근방식에 문제가 있습니다. filename[{}], originalFilename[{}], MultipartFileInfo[{}]", mergeFileCnt, multiFile.getName(), filename, multiFile);
				}
			}
		}

		if(removeFilePaths!=null) {
			for (String removeFile : removeFilePaths) {
				try {
					new File(this.nfsRootPath + removeFile).delete();
					log.info("존재하는 첨부파일작업을 완료 후 삭제대상 파일[{}]을 삭제했습니다.", removeFile);
				} catch (Exception e) {
					log.error("존재하는 첨부파일작업을 완료 후 삭제대상 파일[{}]을 삭제하는 중 오류[{}]가 발생했습니다. 삭제가 실패한 경우 게시판 작업은 실패하지 않습니다. : cause[{}], localizedMessage[{}]", removeFile, e.getMessage(), e.getCause(), e.getLocalizedMessage());
				}
			}
		}
		List<String> listFileNm = new ArrayList<String>();
		List<String> listFilePath = new ArrayList<String>();
		for (int i = 0; i < mergeFileNames.length; i++) {
			if(StringUtils.isNotEmpty(mergeFileNames[i]) && StringUtils.isNotEmpty(mergeFilePaths[i])) {
				listFileNm.add(mergeFileNames[i]);
				listFilePath.add(mergeFilePaths[i]);
			}
		}
		altBoardDto.setBdFilesCnt(mergeFileCnt);
		altBoardDto.setListBdFileNm(listFileNm);
		altBoardDto.setListBdFilePath(listFilePath);
		return altBoardDto;
	}

	private boolean checkOverflowPop(AltBoardDto altBoardDto) {
		// 파일 저장처리 후 altBoardDto에 결과셋팅.
		if(altBoardDto!=null && StringUtils.isNotEmpty(altBoardDto.getBdDivCd()) && altBoardDto.getBdUseYn().equalsIgnoreCase("Y") && altBoardDto.getBdDivCd().equals("POP")) {
			// 로그인 시 처리하는 팝업인 경우 최대 Active POP 개수를 조회하여 3개 이상인 경우 실패처리한다.
			AltBoardDto searchAltBoardDto = new AltBoardDto();
			searchAltBoardDto.setBdDivCd("POP");
			searchAltBoardDto.setBdUseYn("Y");
			int nowPopCnt = 0;
			
			int maxPopBoardLimit = Integer.parseInt(CacheUtil.getCode(MAX_POP_BOARD_LIMIT_KEY, MAX_POP_BOARD_LIMIT_DEF).getCdVal());
			if((nowPopCnt = altBoardMapper.selectBoardListCount(searchAltBoardDto))>=maxPopBoardLimit) {
				throw new BusinessException("최대 팝업공지 개수["+maxPopBoardLimit+"]가 초과되었습니다.\n기존 팝업공지중인 게시물을 먼저 내려주세요.\n현재 팝업 공지 개수 = " + nowPopCnt);
			}
		}
		return true;
	}
}
