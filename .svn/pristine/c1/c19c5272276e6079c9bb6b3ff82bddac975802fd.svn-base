package jin.mes.form.basMgt.devtol.userConn;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.mapper.basMgt.devtol.userConn.UserConnMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

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
		} catch (Exception e) {
			throw new BusinessException("사용자 접속이력 조회 에러입니다. : " + e.getMessage());
		}
		if (userConnList == null) {
			userConnList = new ArrayList<UserConnDto>();
		}
		return new PageInfo<UserConnDto>(userConnList, pageRequestVo, rowCount);
	}
	
	/* 접속이력 저장 */
	@Transactional
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
