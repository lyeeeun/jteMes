package jin.mes.form.basMgt.menuMgt.menuInfo;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.mapper.basMgt.menuMgt.menuInfo.MenuInfoMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class MenuInfoService {
	
	@Resource
	MenuInfoMapper menuInfoMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public List<MenuInfoDto> getMenuTree(MenuInfoDto menuInfoDto){
		List<MenuInfoDto> menuInfoList = null;
		try {
			menuInfoList = menuInfoMapper.selectMenuTree(menuInfoDto);
		} catch (Exception e) {
			throw new BusinessException("메뉴조회 에러입니다.(tree) : " + e.getMessage());
		}
		if (menuInfoList == null) {
			menuInfoList = new ArrayList<MenuInfoDto>();
		}
		return menuInfoList;
	}
	
	public PageInfo<MenuInfoDto> getMenuList(MenuInfoDto menuInfoDto, PageRequestVo pageRequestVo){
		List<MenuInfoDto> menuList = null;
		int rowCount = 0;

		// Page Setting
		menuInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		menuInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = menuInfoMapper.selectMenuListCount(menuInfoDto);
			if (rowCount > 0) {
				//List
				menuList = menuInfoMapper.selectMenuList(menuInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("메뉴조회 에러입니다.(List) : " + e.getMessage());
		}
		if (menuList == null) {
			menuList = new ArrayList<MenuInfoDto>();
		}
		return new PageInfo<MenuInfoDto>(menuList, pageRequestVo, rowCount);
	}
	
	@Transactional
	public int setMenuSave(MenuInfoDto menuInfoDto){
		int resultInt = -1;
		try {
			menuInfoDto.setCreatorId(JteUtils.getUserId());
			menuInfoDto.setUpdatorId(JteUtils.getUserId());
			
			if(menuInfoDto.getAction().equals("C")) {//사용자 등록
				//메뉴입력
				resultInt = menuInfoMapper.insertMenuInfo(menuInfoDto);
			
				//다국어 저장
				if(menuInfoDto.getMsgList() != null && menuInfoDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(menuInfoDto.getMsgList(), "mn", menuInfoDto.getMenuId());
				}
			}else if(menuInfoDto.getAction().equals("U")){//사용자 변경
				//메뉴수정
				resultInt = menuInfoMapper.updateMenuInfo(menuInfoDto);
				
				//다국어 저장
				if(menuInfoDto.getMsgList() != null && menuInfoDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(menuInfoDto.getMsgList(), "mn", menuInfoDto.getMenuId());
				}
			}else if(menuInfoDto.getAction().equals("LOCK")){//사용자 잠금/해제
				if(menuInfoDto.isLock()) {
					menuInfoDto.setLock(false);
				}else {
					menuInfoDto.setLock(true);
				}
				//메뉴잠금수정	
				resultInt = menuInfoMapper.updateMenuInfo(menuInfoDto);
			}else if(menuInfoDto.getAction().equals("D")){//사용자 잠금/해제
				if(menuInfoDto.isDel()) {
					menuInfoDto.setDel(false);
				}else {
					menuInfoDto.setDel(true);
				}
				//메뉴 삭제(isDel)	
				resultInt = menuInfoMapper.updateMenuInfo(menuInfoDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("메뉴 입력 에러  : " + e.getMessage());
		}
		
		return resultInt;
	}
}