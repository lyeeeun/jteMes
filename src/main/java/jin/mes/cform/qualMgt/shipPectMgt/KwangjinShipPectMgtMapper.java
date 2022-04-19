package jin.mes.cform.qualMgt.shipPectMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.pick.rlesMgt.RlesMgtDto;

@Mapper
public interface KwangjinShipPectMgtMapper {

	public List<RlesMgtDto> selectPackageBadList(RlesMgtDto rlesMgtDto);
	public int selectPackageBadCount(RlesMgtDto rlesMgtDto);
}
