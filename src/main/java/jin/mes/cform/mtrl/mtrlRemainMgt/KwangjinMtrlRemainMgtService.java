package jin.mes.cform.mtrl.mtrlRemainMgt;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinMtrlRemainMgtService {

	
	@Resource
	KwangjinMtrlRemainMgtMapper kwangjinMtrlRemainMgtMapper;
	
	//자재 관리 조회
	public PageInfo<KwangjinMtrlRemainMgtDto> getMtrlRemainList(KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinMtrlRemainMgtDto> mtrlRemainList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinMtrlRemainMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinMtrlRemainMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = kwangjinMtrlRemainMgtMapper.selectMtrlRemainCount(kwangjinMtrlRemainMgtDto);
			if (rowCount > 0) {
				//List
				mtrlRemainList = kwangjinMtrlRemainMgtMapper.selectMtrlRemainList(kwangjinMtrlRemainMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재 잔량 정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlRemainList == null) {
			mtrlRemainList = new ArrayList<KwangjinMtrlRemainMgtDto>();
		}
		return new PageInfo<KwangjinMtrlRemainMgtDto>(mtrlRemainList, pageRequestVo, rowCount);
	}
	
	//자재 잔량 저장
			@Transactional
			public String setMtrlRemainSave(KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto) {
				String returnKey = "";
				try {
					kwangjinMtrlRemainMgtDto.setCreatorId(JteUtils.getUserId());
					kwangjinMtrlRemainMgtDto.setUpdatorId(JteUtils.getUserId());
					
					if(kwangjinMtrlRemainMgtDto.getAction().equals("C")) { //자재 잔량 등록
					
						//자재 잔량 입력
						kwangjinMtrlRemainMgtMapper.insertMtrlRemain(kwangjinMtrlRemainMgtDto);
						
						returnKey =  kwangjinMtrlRemainMgtDto.getRemainId();
						
					}else if(kwangjinMtrlRemainMgtDto.getAction().equals("U")) { //자재 잔량 수정
						//자재 잔량 수정
						kwangjinMtrlRemainMgtMapper.updateMtrlRemain(kwangjinMtrlRemainMgtDto);
						
						returnKey = kwangjinMtrlRemainMgtDto.getRemainId();
					}else if(kwangjinMtrlRemainMgtDto.getAction().equals("D")) { //자재 잔량 비움 처리
						
						SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
						Date dateTime = new Date();
						String nowDateTime = dateFormat.format(dateTime);
						
						kwangjinMtrlRemainMgtDto.setDisuseDate(nowDateTime);
						
						//자재 잔량 수정
						kwangjinMtrlRemainMgtMapper.updateMtrlRemain(kwangjinMtrlRemainMgtDto);
						
						returnKey = kwangjinMtrlRemainMgtDto.getRemainId();
					}
					
				} catch (Exception e) {
					returnKey = "";
					throw new BusinessException("자재 잔량 입력 에러 : " + e.getMessage());
				}
				return returnKey;
			};
	
	//자재 사용 히스토리 삭제
	@Transactional
	public String setMtrlRemainDelete(List<KwangjinMtrlRemainMgtDto> mtrlRemainList){
		String resultStr = "success";
		try {
			//자재 사용 히스토리 삭제
			for(KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto : mtrlRemainList){
				kwangjinMtrlRemainMgtMapper.deleteMtrlRemain(kwangjinMtrlRemainMgtDto);
			}
		} catch (Exception e) {
			resultStr = "error";
			throw new BusinessException("자재 잔량 삭제 에러  : " + e.getMessage());
		}
		return resultStr;
	}
	
}
