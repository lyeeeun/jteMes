package jin.mes.form.mfgMgt.wrkinWrkerMgt.SinMyung;

import javax.annotation.Resource;

import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.mfgMgt.wrkinWrkerMgt.WrkinWrkerMgtServiceImpl;
import jin.mes.mapper.mfgMgt.wrkinWrkerMgt.WrkinWrkerMgtMapper;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Profile({"SinMyung", "SinMyungDev"})
@Primary
@Service
public class WrkinWrkerMgtServiceImpl_SinMyung extends WrkinWrkerMgtServiceImpl{
	@Resource
	WrkinWrkerMgtMapper prodWorkMapper;
	
	// 작업정보 입력/수정
	@Transactional
	@Override
	public String setProdWorkSave(WrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			asgnDto.setCreatorId(JteUtils.getUserId());
			//생산지시
			if (asgnDto.getAction().equals("C")) {// 작업정보 등록
				// 작업정보 입력
				prodWorkMapper.insertProdWork(asgnDto);
				returnKey = asgnDto.getProdWorkId();
			} else if (asgnDto.getAction().equals("U")) {// 작업정보 수정
				// 작업정보 수정
				prodWorkMapper.updateProdWork(asgnDto);
				returnKey = asgnDto.getProdAsmId();
			}
			//작업정보
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보  입력 에러" + e.getMessage());
		}
		return returnKey;
	}
}