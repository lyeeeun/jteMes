package jin.mes.form.perform.prodStaMgt.workProdStaMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class WorkProdStaMgtService {

	@Resource
	WorkProdStaMgtMapper workProdStaMgtMapper;

	public PageInfo<WorkProdStaMgtDto> getWorkProd(WorkProdStaMgtDto workProdStaMgtDto, PageRequestVo pageRequestVo){
		List<WorkProdStaMgtDto> workProdList = null;
		int rowCount = 0;

		if(!workProdStaMgtDto.getPagingYN().equals("N")) {
			workProdStaMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			workProdStaMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}

		try {
			rowCount = workProdStaMgtMapper.selectWorkProdStaCount(workProdStaMgtDto);
			if (rowCount > 0) {
				workProdList = workProdStaMgtMapper.selectWorkProdStaList(workProdStaMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (workProdList == null) {
			workProdList = new ArrayList<WorkProdStaMgtDto>();
		}
 		return new PageInfo<WorkProdStaMgtDto>(workProdList, pageRequestVo, rowCount);
	}
}
