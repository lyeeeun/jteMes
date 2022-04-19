package jin.mes.form.basMgt.menuMgt.menuAuth;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.menuMgt.menuInfo.MenuInfoDto;
import jin.mes.mapper.basMgt.menuMgt.menuAuth.MenuMgtMapper;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

/**<pre>
 * <b>jin.mes.form.operMgt.authInfo</b>
 * <b>AuthInfoServiceImpl.java</b>
 * <p>Descriptions : 권한베이스 서비스
 *    1.queryDsl과 기본 jpa를 사용하였다.
 *    2.CustomQueryDslSupport를 extends를 사용한다.(공통사용되는 queryDsl 부분 따로 정리) 
 * </p>
 * </pre>

 * @author  : rlawhdrn456@jintech2ng.co.kr
 * @Date    : 2020. 1. 7.
 * @Version : 
 */
@Service
public class MenuMgtServiceImpl {
	
	@Resource
	MenuMgtMapper menuMgtMapper;
	
	public List<MenuInfoDto> getMenuRoleTree(MenuInfoDto menuInfoDto){
		List<MenuInfoDto> menuInfoList = null;
		try {
			menuInfoList = menuMgtMapper.selectMenuRoleTree(menuInfoDto);
		} catch (Exception e) {
			throw new BusinessException("메뉴조회 에러입니다.(tree)  : " + e.getMessage());
		}
		if (menuInfoList == null) {
			menuInfoList = new ArrayList<MenuInfoDto>();
		}
		return menuInfoList;
	}
	
	@Transactional
	public int setMenuRoleSave(MenuInfoDto menuInfoDto){
		int resultInt = -1;
		try {
			menuInfoDto.setCreatorId(JteUtils.getUserId());
			menuInfoDto.setUpdatorId(JteUtils.getUserId());
			
			if(menuInfoDto.getAction().equals("C")) {//메뉴권한 등록
				resultInt = menuMgtMapper.insertMenuRole(menuInfoDto);
			}else if(menuInfoDto.getAction().equals("D")){//메뉴권한 삭제
				resultInt = menuMgtMapper.deleteMenuRole(menuInfoDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("메뉴 입력 에러  : " + e.getMessage());
		}
		
		return resultInt;
	}
	
}
