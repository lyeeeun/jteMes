package jin.mes.form.basMgt.devtol.syslogMgt;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.charset.Charset;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.spring.config.exception.SystemException;
import kr.co.itcall.jte.util.DownLoadView;

@Controller
@RequestMapping("/form/basMgt/devtol/syslogMgt")
public class SysCtrlController extends BaseController {
	
	private static final int MAX_READ_COUNT = 10000; // 1만byte
	private static final int MAX_DOWNLOAD_FILE_SIZE = 10000000; // 10MB
	
	@Resource(name="messageSourceAccessor")
	protected MessageSourceAccessor messageSourceAccessor;
	
	@Value("#{app['app.mes.svr.addr.list']?:''}") // PROTOCOL HTTP / PORT 8080
	private String mesSvrAddrs;
	
//	@GetMapping({"", "/", "/form", "/form/"})
//	public String formView(HttpServletRequest request) {
//		request.getRequestURI();
//		return "/form/sysLog/sysCtrl/sysCtrlForm"; // for JSP
//		// return "tlf/form/sysLog/sysCtrl/sysCtrlForm"; // for Thymeleaf
//	}
	
	// @PreAuthorize("isAuthenticated()")
	@PreAuthorize(("hasAuthority('auth.sysLog.sysCtrl.bas')"))
	@PostMapping("/getDir")
	public ResponseEntity<Object> getFilesInfo(@RequestParam(name="searchValue", defaultValue=".") String dir
			, @RequestParam(name="index", defaultValue="0") long index
			, @RequestParam(name="searchType", defaultValue="UTF-8") String charset
			, @RequestParam(name="page", defaultValue="1") long page
			, @RequestParam(name="take", defaultValue="25") long take
			, @RequestParam(name="rows", defaultValue="25") long rows
			, @RequestParam(name="svrAddr", defaultValue="") String svrAddr
			, HttpServletResponse response, ModelMap map) {
		String connectedSvrAddr = null;
		try {
			connectedSvrAddr = InetAddress.getLocalHost().toString();
		} catch (UnknownHostException e1) {
			connectedSvrAddr = InetAddress.getLoopbackAddress().toString();
		}
		if(!StringUtils.isEmpty(svrAddr) && !connectedSvrAddr.contains(svrAddr)) {
			
			response.setHeader("Location", "url....");
			response.setStatus(302);
			return null; // "";
			// return "redirect:https://"+omSvrAddrs+"/om/sysLog/sysCtrl/getDir";
			// redirect...
		}
		String result = "N";
		List<Map<String, Object>> subList = new ArrayList<Map<String, Object>>();
		Map<String, Object> fileMap = null;
		Path path = Paths.get(dir);
		try {
			Map<String, Object> pathInfoMap = Files.readAttributes(path, "*", LinkOption.NOFOLLOW_LINKS);
			fileMap = new HashMap<String, Object>();
			for (String key : pathInfoMap.keySet()) {
				String value = pathInfoMap.get(key) + "";
				fileMap.put(key, value);
			}
			try {
				String fileName = path.getFileName().toString();
				if(fileName.equals(".")) {
					path = path.toAbsolutePath().getParent();
					fileName = path.getFileName().toString();
				}
				String pathStr = path.toAbsolutePath().toString().replaceAll("\\\\", "/");
						// path.getFileName().toFile().getAbsolutePath().replaceAll("\\\\", "/");
//				if(pathStr.endsWith("/"+fileName+"/"+fileName)) {
//					pathStr = pathStr.substring(0, pathStr.lastIndexOf(fileName));
//				}
				fileMap.put("name", fileName);
				fileMap.put("path",pathStr);
				pathStr = path.toAbsolutePath().getParent().toString().replaceAll("\\\\", "/");
				fileMap.put("upPath", pathStr);
			} catch (Exception e) {
				fileMap.put("name",null);
				fileMap.put("path",null);
			}
			fileMap.put("type", new StringBuffer().append("?HWRX[")
					.append(Files.isDirectory(path)?"D":Files.isSymbolicLink(path)?"S":Files.isRegularFile(path)?"F":"_")
					.append(Files.isHidden(path)?"H":"_")
					.append(Files.isWritable(path)?"W":"_")
					.append(Files.isReadable(path)?"R":"_")
					.append(Files.isExecutable(path)?"X":"_")
					.append("]").toString());
			fileMap.put("owner", Files.getOwner(path).toString());
			map.addAttribute("info", fileMap);
			map.addAttribute("svrInfo", connectedSvrAddr);
		} catch (IOException e) {
			fileMap.put("type", "UNKNOWN");
			fileMap.put("owner", e.getMessage());
			map.addAttribute("info", fileMap);
			map.addAttribute("svrInfo", connectedSvrAddr);
		}
		if(Files.isDirectory(path) || Files.isSymbolicLink(path)) {
			DirectoryStream<Path> directoryStream;
			try {
				directoryStream = Files.newDirectoryStream(path);
				int num = 0;
				for (Path subPath : directoryStream) {
					num++;
					if(num<=page*take-rows || num>page*take)
						continue;
					fileMap = new HashMap<String, Object>();
					fileMap.put("num", num-page*take+rows);
					try {
						Map<String, Object> subPathInfoMap = Files.readAttributes(subPath, "*", LinkOption.NOFOLLOW_LINKS);
						for (String key : subPathInfoMap.keySet()) {
							String value = subPathInfoMap.get(key) + "";
							fileMap.put(key, value);
						}
						fileMap.put("name",subPath.getFileName().toString());
						fileMap.put("path",subPath.toAbsolutePath().toString().replaceAll("\\\\", "/"));
								// subPath.getFileName().toFile().getAbsolutePath().replaceAll("\\\\", "/"));
						if(Files.isReadable(subPath)) {
							fileMap.put("owner", Files.getOwner(subPath).toString());
							fileMap.put("sizeView", String.format("%,d", Files.size(subPath)));
							fileMap.put("type", new StringBuffer().append("?HWRX[")
							.append(Files.isDirectory(subPath)?"D":Files.isSymbolicLink(subPath)?"S":Files.isRegularFile(subPath)?"F":"_")
							.append(Files.isHidden(subPath)?"H":"_")
							.append(Files.isWritable(subPath)?"W":"_")
							.append(Files.isReadable(subPath)?"R":"_")
							.append(Files.isExecutable(subPath)?"X":"_")
							.append("]").toString());
						} else {
							fileMap.put("owner", "UNKNOWN");
							fileMap.put("sizeView", "UNKNOWN");
							fileMap.put("type", "Forbidden");
						}
					} catch (IOException e) {
						fileMap.put("type", "UNKNOWN");
						fileMap.put("owner", e.getMessage());
						fileMap.put("cause", e.getCause());
						fileMap.put("locMsg", e.getLocalizedMessage());
						fileMap.put("trace", e.getStackTrace());
					}
					subList.add(fileMap);
				}
				/*** For Paging ***/
				map.addAttribute("rows", subList);
				map.addAttribute("count", num);
				map.addAttribute("records", num);
				map.addAttribute("page", page);
				result = "D";
			} catch (IOException e) {
				map.addAttribute("error", e.getMessage());
				map.addAttribute("cause", e.getCause());
				map.addAttribute("locMsg", e.getLocalizedMessage());
				map.addAttribute("trace", e.getStackTrace());
				map.addAttribute("rows", subList);
				result = "E";
			}

		} else if(Files.isReadable(path)) {
			RandomAccessFile file = null;
			try {
				file = new RandomAccessFile(path.toFile(), "r");
				byte[] bt = new byte[MAX_READ_COUNT];
				int readed = 0;
				if(index==-1 || index+MAX_READ_COUNT>=file.length()) {
					index=file.length()-MAX_READ_COUNT;
				}
				if(index<0) {
					index=0;
				}
				file.seek(index);
				readed=file.read(bt, 0, MAX_READ_COUNT);
				if(readed>0) {
					map.addAttribute("contents", new String(bt, 0, readed, Charset.forName(charset)));
				} else {
					map.addAttribute("contents", String.format("Empty or End of File[%s]. start read file index = [%d]. file size is [%d].", path.toAbsolutePath().toString().replaceAll("\\\\", "/"), index, Files.size(path)));
				}
				map.addAttribute("file", path.toAbsolutePath().toString().replaceAll("\\\\", "/"));
				map.addAttribute("index", index);
				map.addAttribute("readed", readed);
				map.addAttribute("size", Files.size(path));
				map.addAttribute("sizeView", String.format("%,d", Files.size(path)));
			} catch (Exception e) {
				map.addAttribute("error", e.getMessage());
				map.addAttribute("cause", e.getCause());
				map.addAttribute("locMsg", e.getLocalizedMessage());
				map.addAttribute("trace", e.getStackTrace());
				throw new SystemException(String.format("대상 파일[%s]은 접근불가 이거나, 이외 오류입니다.\n[%s, %s, %s]", dir, e.getMessage(), e.getCause(), e.getLocalizedMessage()));
			} finally {
				if(file!=null) try { file.close(); } catch (IOException e) { e.printStackTrace(); }
			};
			result = "F";
		} else {
			try {
				map.addAttribute("trace", Files.getAttribute(path, "*", LinkOption.NOFOLLOW_LINKS));
				map.addAttribute("error", "접근불가 이거나 이외 오류입니다.");
				map.addAttribute("cause", path.toString());
				map.addAttribute("locMsg", String.format("파일[%s]의 읽기 권한 = [%s]", path.getFileName(), Files.isReadable(path)));
			} catch (IOException e) {
				map.addAttribute("error", e.getMessage());
				map.addAttribute("cause", e.getCause());
				map.addAttribute("locMsg", e.getLocalizedMessage());
				map.addAttribute("trace", e.getStackTrace());
				throw new SystemException(String.format("대상 경로[%s]는 접근불가 이거나, 이외 오류입니다.\n[%s, %s, %s]", dir, e.getMessage(), e.getCause(), e.getLocalizedMessage()));
			}
			result = "P";
		}
		
		map.addAttribute("result", result);
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	@PreAuthorize(("hasAuthority('auth.sysLog.sysCtrl.download')"))
	@RequestMapping("/download/check")
	public ResponseEntity<Object> download(@RequestParam("filePath") String filePath, ModelMap model) {
		model.addAttribute("filePath", filePath);
		Path path = Paths.get(filePath);
		try {
			boolean result = Files.exists(path) && Files.isReadable(path) && !Files.isDirectory(path) && !Files.isSymbolicLink(path) && Files.size(path)<=MAX_DOWNLOAD_FILE_SIZE;
			if(result) {
				model.addAttribute("result", result);
				model.addAttribute("msg", "파일을 다운로드 할 수 있습니다.");
			} else {
				model.addAttribute("msg", String.format("파일[%s]이 존재하지 않거나 읽을 수 없거나, 최대다운로드 SIZE[%,d]가 초과되었습니다.", filePath, MAX_DOWNLOAD_FILE_SIZE));
			}
		} catch (IOException e) {
			throw new SystemException(String.format("다운로드 할 수 없는 파일[%s]이거나, 최대다운로드 SIZE[%,d]가 초과되었습니다.\n[%s, %s, %s]", filePath, MAX_DOWNLOAD_FILE_SIZE, e.getMessage(), e.getCause(), e.getLocalizedMessage()));
		}
		return new ResponseEntity<Object>(model, HttpStatus.OK);
	}

	@PreAuthorize(("hasAuthority('auth.sysLog.sysCtrl.download')"))
	@RequestMapping("/download")
	public ModelAndView download(/*@RequestParam("fileNm") String fileNm, @RequestParam("filePath") String filePath, */HttpServletRequest request) {
		try {
			/*** submit()로 form에서 직접 호출할때 발생하는 문제를 해결함. 파일을 직접 지정할때 파일명이 한글일 경우 깨지는 증상을 다운로드/업로드에 별도 구한한다. ***/
			String fileNm = new String(request.getParameter("fileNm").getBytes(Charset.forName("8859_1")), Charset.forName("UTF-8"));
			String filePath = new String(request.getParameter("filePath").getBytes(Charset.forName("8859_1")), Charset.forName("UTF-8"));
			// 파일다운로드 해줄때...new String(fileName.getBytes("euc-kr"),"8859_1"); ... 위에는 파일 다운로드 요청들어올때...
			ModelAndView modelAndView = new ModelAndView();
			Path path = Paths.get(filePath);
			try {
				if(Files.exists(path) && Files.isReadable(path) && !Files.isDirectory(path) && !Files.isSymbolicLink(path) && Files.size(path)<=MAX_DOWNLOAD_FILE_SIZE) {
					modelAndView.addObject("filePath", filePath);
					modelAndView.setView(new DownLoadView(fileNm)); // 파일명을 지정해줘야 한다. 아니면 서버에 있는 파일명코드가 파일명으로 지정되어 다운로드 된다.
					return modelAndView;
				}
			} catch (IOException e) {
				throw new SystemException(String.format("다운로드 할 수 없는 파일[%s]이거나, 최대다운로드 SIZE[%,d]가 초과되었습니다.\n[%s, %s, %s]", filePath, MAX_DOWNLOAD_FILE_SIZE, e.getMessage(), e.getCause(), e.getLocalizedMessage()));
			}
			throw new SystemException(String.format("파일[%s]이 존재하지 않거나 읽을 수 없거나, 최대다운로드 SIZE[%,d]가 초과되었습니다.", filePath, MAX_DOWNLOAD_FILE_SIZE));
		}catch (Exception e) {
			throw new SystemException("잘못된 접근입니다.");
		}
	}

	@PreAuthorize(("hasAuthority('auth.sysLog.sysCtrl.download')"))
	@RequestMapping("/removeFile")
	public ResponseEntity<Object> removeFile(@RequestParam("path") String targetPath, ModelMap model) {
		model.addAttribute("filePath", targetPath);
		Path path = Paths.get(targetPath);
		try {
			model.addAttribute("result", Files.exists(path) && Files.isWritable(path));
			model.addAttribute("msg", "삭제는 아직 지원하지 않습니다.");
			Files.delete(path);
		} catch (Exception e) {
			throw new SystemException(String.format("삭제할 수 없는 파일/디렉토리[%s]입니다.\n[%s, %s, %s]", targetPath, e.getMessage(), e.getCause(), e.getLocalizedMessage()));
		}
		return new ResponseEntity<Object>(model, HttpStatus.OK);
	}

	@PreAuthorize(("hasAuthority('auth.sysLog.sysCtrl.download')"))
	@RequestMapping("/uploadFile")
	public ResponseEntity<Object> uploadFile(@RequestParam("targetPath") String targetPath, MultipartHttpServletRequest multipartHttpServletRequest, ModelMap model) {
		model.addAttribute("fileUpPath", targetPath);
		Path path = Paths.get(targetPath);
		int fileUploadCount = 0;
		try {
			model.addAttribute("result", Files.exists(path) && Files.isWritable(path));
			model.addAttribute("msg", String.format("대상 디렉토리[%s]에 업로드는 아직 지원하지 않습니다.", targetPath));
			if(!StringUtils.isEmpty(model)) {
				throw new SystemException(String.format("대상 디렉토리[%s]에 업로드는 아직 지원하지 않습니다.", targetPath));
			}
			Map<String, List<MultipartFile>> multiFileMap = multipartHttpServletRequest.getMultiFileMap();
			for (String key : multiFileMap.keySet()) {
				for (MultipartFile multiFile : multiFileMap.get(key)) {
//					++newFileCnt;
					String filename = multiFile.getOriginalFilename(); // .replaceAll("[:\\\\/%*?:|\"<>]", "");
					String targetFile = (targetPath + "/" + filename).replaceAll("//", "/");
					// String fileExt = FilenameUtils.getExtension(filename);

					if(new File(targetFile).exists()) {
						throw new SystemException(messageSourceAccessor.getMessage("errors.board.file.upload.duplicate", new Object[] {filename})) ; // 업로드 대상파일[{1}]이 이미 존재하여 업로드 할 수 없습니다.\n잠시후 다시 시도해 주십시오.
					}
					multiFile.transferTo(new File(targetFile));
					model.addAttribute("save", targetFile);
					++fileUploadCount;
				}
			}
		} catch (Exception e) {
			throw new SystemException(String.format("대상 디렉토리[%s]에 업로드 할 수 없습니다.\n[%s, %s, %s]", targetPath, e.getMessage(), e.getCause(), e.getLocalizedMessage()));
		}
		if(fileUploadCount<=0) {
			throw new SystemException(String.format("대상 디렉토리[%s]에 업로드 할 파일이 없습니다.\n업로드할 파일을 첨부해주세요.", targetPath));
		}
		return new ResponseEntity<Object>(model, HttpStatus.OK);
	}

	@PreAuthorize(("hasAuthority('auth.sysLog.sysCtrl.download')"))
	@RequestMapping("/runCmd")
	public ResponseEntity<Object> runCmd(@RequestParam("path") String targetPath, @RequestParam("cmd") String cmd, ModelMap model) {
		model.addAttribute("filePath", targetPath);
		Runtime runtime = Runtime.getRuntime();
		Process process = null;
		try {
			process = runtime.exec("cd " + targetPath);
			process.exitValue();
			process = runtime.exec(cmd);
			StringBuffer sb = new StringBuffer();
			BufferedInputStream bi = new BufferedInputStream(process.getInputStream());
			byte read = -1;
			while ((read=(byte) bi.read())>=0) {
				sb.append(read);
			}
			model.addAttribute("data", sb.toString());
			model.addAttribute("result", process.exitValue());
		} catch (IOException e) {
			model.addAttribute("data", String.format("대상 디렉토리[%s]에서 명령[%s]을 실행할 수 없습니다.\n[%s, %s, %s]", targetPath, cmd, e.getMessage(), e.getCause(), e.getLocalizedMessage()));
		} finally {
			if(process!=null)process.destroy();
		}
		return new ResponseEntity<Object>(model, HttpStatus.OK);
	}

}
