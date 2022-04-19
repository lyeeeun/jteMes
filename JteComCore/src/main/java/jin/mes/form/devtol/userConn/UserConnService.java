package jin.mes.form.devtol.userConn;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

// @EnableAsync
@Service
public class UserConnService {
	@Resource
	UserConnMapper userConnMapper;
	
	/* 접속이력 조회 */
	public PageInfo<UserConnDto> getUserConnList(UserConnDto userConnDto, PageRequestVo pageRequestVo){
		List<UserConnDto> userConnList = null;
		int rowCount = 0;

		// Page Setting
		userConnDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		userConnDto.setLastIndex(pageRequestVo.getBlockLastPage());
		try {
			//Count
			rowCount = userConnMapper.selectUserConnCount(userConnDto);
			if (rowCount > 0) {
				//List
				userConnList = userConnMapper.selectUserConnList(userConnDto);
			}
		
			

//			Socket socket = new Socket("192.168.1.19", 3308); // 소켓 서버에 접속 
//			System.out.println("socket 서버에 접속 성공!");
//			
//                // OutputStream - 클라이언트에서 Server로 메세지 발송
//                OutputStream out = socket.getOutputStream(); 
//                // socket의 OutputStream 정보를 OutputStream out에 넣은 뒤 
//                PrintWriter writer = new PrintWriter(out, true); 
//                // PrintWriter에 위 OutputStream을 담아 사용
//
//                writer.println("CLIENT TO SERVER"); 
//                // 클라이언트에서 서버로 메세지 보내기
//
//                // InputStream - Server에서 보낸 메세지 클라이언트로 가져옴
//                InputStream input = socket.getInputStream(); 
//                // socket의 InputStream 정보를 InputStream in에 넣은 뒤
//                BufferedReader reader = new BufferedReader(new InputStreamReader(input)); 
//                // BufferedReader에 위 InputStream을 담아 사용
//
//                System.out.println(reader.readLine()); 
//                // 서버에서 온 메세지 확인
//                System.out.println("CLIENT SOCKET CLOSE");
//                
//                socket.close(); // 소켓 종료
		} catch (Exception e) {
			throw new BusinessException("사용자 접속이력 조회 에러입니다. : " + e.getMessage());
		}
		if (userConnList == null) {
			userConnList = new ArrayList<UserConnDto>();
		}
		return new PageInfo<UserConnDto>(userConnList, pageRequestVo, rowCount);
	}
	
	/* 접속이력 저장 */
	// @Transactional
	// @Async
	public String setUserConn(UserConnDto userConnDto){
		String returnKey = "";
		try {
			if(userConnDto.getAction().equals("C")) {//사용자 접속이력 등록
				//사용자 접속시작 저장
				 userConnMapper.insertUserConn(userConnDto);
				 returnKey = userConnDto.getConnId();
			}else if(userConnDto.getAction().equals("U")){//사용자 접속이력 수정
				//사용자 접속종료 저장
				userConnMapper.updateUserConn(userConnDto);
				returnKey = userConnDto.getConnId();
			}
		} catch (Exception e) {
			throw new BusinessException("사용자 접속이력 저장 : " + e.getMessage());
		}
		
		return returnKey;
	}
}
