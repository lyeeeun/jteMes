package jin.mes.cform.qualMgt.qualPec.shipPectMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.cform.ship.rlesMgt.NewRlesMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class NewShipPectMgtService {
	
	@Resource
	NewShipPectMgtMapper newPackageBadMapper;
	
	 public PageInfo<NewRlesMgtDto> getPackageBadList(NewRlesMgtDto rlesMgtDto, PageRequestVo pageRequestVo){
	    	List<NewRlesMgtDto> packageList = null;
			int rowCount = 0;

			rlesMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			rlesMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

			try {
				rowCount = newPackageBadMapper.selectPackageBadCount(rlesMgtDto);
				if (rowCount > 0) {
					packageList = newPackageBadMapper.selectPackageBadList(rlesMgtDto);
				}
			} catch (Exception e) {
				log.error(e.toString());
			}

			if (packageList == null) {
				packageList = new ArrayList<NewRlesMgtDto>();
			}
			return new PageInfo<NewRlesMgtDto>(packageList, pageRequestVo, rowCount);
		}
}
