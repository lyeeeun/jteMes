package jin.mes.cform.mtrl.invenMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mtrl.invenMgt.KwangjinInvenHisDto;
import jin.mes.cform.mtrl.invenMgt.KwangjinInvenMgtDto;


@Mapper
public interface KwangjinInvenMgtMapper {
	//자재관리
	public List<KwangjinInvenMgtDto> selectInvenMgt(KwangjinInvenMgtDto kwangjinInvenMgtDto);
	
	public int selectInvenMgtCount(KwangjinInvenMgtDto kwangjinInvenMgtDto);
	
	
	public List<KwangjinInvenHisDto> selectItemHisList(KwangjinInvenHisDto kwangjinInvenHisDto);
	
	public int selectItemHisCount(KwangjinInvenHisDto kwangjinInvenHisDto);
	
	public List<KwangjinInvenHisDto> selectMtrlHisList(KwangjinInvenHisDto kwangjinInvenHisDto);
	
	public int selectMtrlHisCount(KwangjinInvenHisDto kwangjinInvenHisDto);
}
