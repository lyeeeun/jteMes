package jin.mes.cform.qualMgt.shipPectMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.form.pick.rlesMgt.RlesMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class KwangjinShipPectMgtService {
	
	@Resource
	KwangjinShipPectMgtMapper kwangjinShipPectMgtMapper;
	
	 public PageInfo<RlesMgtDto> getPackageBadList(RlesMgtDto rlesMgtDto, PageRequestVo pageRequestVo){
	    	List<RlesMgtDto> packageList = null;
			int rowCount = 0;

			rlesMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			rlesMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

			try {
				rowCount = kwangjinShipPectMgtMapper.selectPackageBadCount(rlesMgtDto);
				if (rowCount > 0) {
					packageList = kwangjinShipPectMgtMapper.selectPackageBadList(rlesMgtDto);
				}
			} catch (Exception e) {
				log.error(e.toString());
			}

			if (packageList == null) {
				packageList = new ArrayList<RlesMgtDto>();
			}
			return new PageInfo<RlesMgtDto>(packageList, pageRequestVo, rowCount);
		}
}
