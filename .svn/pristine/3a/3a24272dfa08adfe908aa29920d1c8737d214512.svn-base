package jin.mes.form.basMgt.codMgt.baseCodeMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.mapper.basMgt.codMgt.baseCodeMgt.BaseCodeMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class BaseCodeMgtService {

    @Resource
    protected BaseCodeMgtMapper baseCodeMgtMapper;
    
    @Autowired
    protected MsgMgtServiceImpl msgService;
    /**
     * 코드 리스트를 가지고 온다.
     * 
     * @param map - 리스트 조회 조건, PageRequestVo - 페이징 처리를 위한 객체
     * 
     * @return PageInfo - 코드 리스트를 포함한 PageInfo객체
     */
    public PageInfo<BaseCodeMgtDto> readCode(BaseCodeMgtDto baseCodeMgtDto, PageRequestVo pageRequestVo){
    	List<BaseCodeMgtDto> histList = null;
		int rowCount = 0;

		// Page Setting
		baseCodeMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		baseCodeMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = baseCodeMgtMapper.codeCount(baseCodeMgtDto);
			if (rowCount > 0) {
				histList = baseCodeMgtMapper.readCode(baseCodeMgtDto); // not registerd user
			}
		} catch (Exception e) {
			throw new BusinessException("기초코드 조회  에러 : " + e.getMessage());
		}

		if (histList == null) {
			histList = new ArrayList<BaseCodeMgtDto>();
		}
		return new PageInfo<BaseCodeMgtDto>(histList, pageRequestVo, rowCount);
    }

    /**
     * 코드를 변경 한다.
     * 
     * @param BaseSetMgtDto - 변경 할 코드의 DTO
     * 
     * @return void
     */
    @Transactional
	public int codeUpdate(BaseCodeMgtDto baseCodeMgtDto){
        int result = 0;

        try {
        	baseCodeMgtDto.setLoginId(JteUtils.getUserId());
            result = baseCodeMgtMapper.codeUpdate(baseCodeMgtDto);
            
          //다국어 저장
            if(baseCodeMgtDto.getMsgList() != null && baseCodeMgtDto.getMsgList().size() > 0) {
				result = msgService.pgSaveMsg(baseCodeMgtDto.getMsgList(), "bc", baseCodeMgtDto.getCdId());
			}
        }
        catch(Exception ex){
        	result = -1;
        	throw new BusinessException("기초코드 변경 에러 : " + ex.getMessage());
        }
        return result;
    }

    /**
     * 코드를 추가 한다.
     * 
     * @param codeDto - 추가 될 코드의 DTO
     * 
     * @return void
     */
    @Transactional
	public int codeAdd(BaseCodeMgtDto baseCodeMgtDto){
        int result = 0;

        try {
        	baseCodeMgtDto.setLoginId(JteUtils.getUserId());
            result = baseCodeMgtMapper.codeAdd(baseCodeMgtDto);
            
            //다국어 저장
  			if(baseCodeMgtDto.getMsgList() != null && baseCodeMgtDto.getMsgList().size() > 0) {
  				result = msgService.pgSaveMsg(baseCodeMgtDto.getMsgList(), "bc", baseCodeMgtDto.getCdId());
  			}
        }
        catch(Exception ex){
        	throw new BusinessException("기초크드 입력 에러 : " + ex.getMessage());
        }
        
        return result;
    }

    /**
     * 코드를 삭제 한다.
     * 
     * @param cdGroupId - 삭제 될 코드의 그룹 ID, cdId - 삭제 될 코드의 ID
     * 
     * @return String - viewName
     */
    public int codeDelete(List<BaseCodeMgtDto> baseCodeList){
        int result = 0;
        
        try {
        	baseCodeList.forEach(x -> {
            	baseCodeMgtMapper.codeDelete(x.getCdId(), JteUtils.getUserId());
            });
        } catch(Exception e) {
        	result = -1;
        	throw new BusinessException("기초코드 삭제 에러 : " + e.getMessage());
        }
        
        return result;
    }
    
}
