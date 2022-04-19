package jin.mes.cform.devtol.schReg;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.facilMgt.mtrltoolMgt.KwangjinMtrltoolMgtDto;

@Mapper
public interface KwangjinSchRegMapper {
	public List<KwangjinMtrltoolMgtDto> toolVerifCheckAlarm(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto);
}
