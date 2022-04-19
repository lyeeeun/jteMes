package jin.mes.common.cache;

import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import jin.mes.form.basMgt.codMgt.baseCodeMgt.BaseCodeMgtDto;
import jin.mes.form.basMgt.codMgt.pageSet.PageSetDto;
import jin.mes.form.basMgt.codMgt.popSet.PopSetDto;
import jin.mes.form.basMgt.menuMgt.menuInfo.MenuInfoDto;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CacheService {
	
	
	@Resource
	protected CacheMapper cacheMapper;
	
	Timer timer;
	
	@PostConstruct
	public void postCacheSet(){
		cacheSet("test");
		int refreshTime = Integer.parseInt(CacheUtil.getCode("cacheRefreshTime","600").getCdVal())*1000;
		
		timer = new Timer();
		
		timer.schedule(
			 new TimerTask() {
				@Override
				public void run() {
					postCacheSet();
				}
			},refreshTime
		);
	}
	
	@Cacheable(cacheNames = "cache_names", key="#prefix")
	//public CacheDto getCacheList(String prefix){
	public void cacheSet(String prefix){
		CacheDto cacheDto = new CacheDto();
		try {
			log.debug("========================= 캐시생성시작 ===========================");
			long beforeTime = System.currentTimeMillis();
			/* 
			 * 1.기초설정
			 * - sys 코드 조회 (1depth 구조) 
			 */
			List<BaseCodeMgtDto> selectedSetList = cacheMapper.selectCacheSet();
			
			/* 
			 * 2.기초코드 
			 * - biz 코드 조회 - 조회 후 하위 코드 매핑해줌.(2depth 구조)
			 */
			
			//biz 코드 조회
			List<BaseCodeMgtDto> selectedCodeList = cacheMapper.selectCacheCode();
			
			//상위코드 반복
			for(int i=0; i < selectedCodeList.size(); i++) {
				//하위코드가 있는것만 수행
				if(selectedCodeList.get(i).isChildYn()) {
					//하위코드를 담을 임시공간 생성
					List<BaseCodeMgtDto> ChildCodeList = new ArrayList<BaseCodeMgtDto>();
					
					//하위코드 반복
					for(int j = i+1; j < selectedCodeList.size(); j++) {
						//하위코드 찾기
						if(selectedCodeList.get(i).getCdId().equals(selectedCodeList.get(j).getUpCdId())) {
							ChildCodeList.add(selectedCodeList.get(j));
						}
						//하위코드 담아주기
						selectedCodeList.get(i).setBaseCodeList(ChildCodeList);
					}
				}
			}
			
			//기초설정 + 기초코드
			selectedSetList.addAll(selectedCodeList);
			
			//코드정보 담기
			cacheDto.setBaseCodeMgtDto(selectedSetList);
			
			/* 
			 * 3. 메뉴
			 * 하이라키 구조
			 */
			
			//메뉴조회
			//cacheDto.setMyMenuVo(cacheMapper.selectCacheMenu());
			
			List<MenuInfoDto> selectedMenuList = cacheMapper.selectCacheMenu();
			
			for(int i=0; i < selectedMenuList.size(); i++) {
				//하위코드가 있는것만 수행
				if(selectedMenuList.get(i).isExpanded()) {
					
					//하위코드를 담을 임시공간 생성
					List<MenuInfoDto> childMenuList = new ArrayList<MenuInfoDto>();
					
					//하위코드 반복
					for(int j = i+1; j < selectedMenuList.size(); j++) {
						//하위코드 찾기
						if(selectedMenuList.get(i).getMenuId().equals(selectedMenuList.get(j).getUpMenuId())) {
							childMenuList.add(selectedMenuList.get(j));

						}
						//하위코드 담아주기
					}
					
					selectedMenuList.get(i).setItems(childMenuList);
				}
			}
			cacheDto.setMenuInfoDto(selectedMenuList);
			
			
			/* 
			 * 4. 페이지 정보
			 */
			List<PageSetDto> pageGridList = cacheMapper.selectCachePageGrid();
			
			List<PageSetDto> pageFieldList = cacheMapper.selectCachePageField();
			
			if(pageGridList.size() > 0) {
				for(PageSetDto pageDto : pageGridList) {
					List<PageSetDto> tempFieldList = new ArrayList<PageSetDto>();
					for(PageSetDto pageDto2 : pageFieldList) {
						if(pageDto.getGridNo().equals(pageDto2.getGridNo())) {
							tempFieldList.add(pageDto2);
						}
					}
					pageDto.setPageFieldList(tempFieldList);
					pageFieldList.removeAll(tempFieldList);
					
					//pageFieldList.stream().filter(p -> p.getGridNo().equals(pageDto.getGridNo())).forEach(f -> pageDto.getPageFieldList().add(f));
					
				}				
			}
			
			cacheDto.setPageSetDto(pageGridList);
			
			
			/* 
			 * 5. 공통팝업 정보
			 */
			
			List<PopSetDto> popGridList = cacheMapper.selectCachePopInfo();
			
			List<PopSetDto> rtnGridList = new ArrayList<PopSetDto>(); 
			
			for(PopSetDto popSetDto : popGridList) {
				List<PopSetDto> childPopGridList = new ArrayList<PopSetDto>();
				if(popSetDto.getUpPopId().equals("def")) {
					popGridList.stream().filter(p -> p.getUpPopId().equals(popSetDto.getPopId())).forEach(f -> childPopGridList.add(f));
					popSetDto.setPopFieldList(childPopGridList);
					rtnGridList.add(popSetDto);
				}
			}
			
			cacheDto.setPopSetDto(rtnGridList);
			
			CacheUtil.cache_body = cacheDto;
			
			long afterTime = System.currentTimeMillis();
			log.debug("호출시간 = [{}]",(afterTime - beforeTime)/1000);
			log.debug("========================= 캐시생성종료 ===========================");
			
		} catch (Exception e) {
			throw new BusinessException("캐시 조회 에러입니다. : " + e.getMessage());
		}
		//return cacheDto;
	}
	
	/* 
	 * 캐시삭제
	 * - 캐시초기화를 위해 사용. 
	 */
	@CacheEvict(value = "cache_names", allEntries = true)
	public void setCacheDelete(){
		timer.cancel();
		postCacheSet();
	}
	
	/*
	 *  캐시 전체 조회 
	 */
	public CacheDto getCacheList() {
		return CacheUtil.cache_body;
	}
}