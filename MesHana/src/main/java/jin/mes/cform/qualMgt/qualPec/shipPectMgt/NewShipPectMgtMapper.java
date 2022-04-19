package jin.mes.cform.qualMgt.qualPec.shipPectMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.ship.rlesMgt.NewRlesMgtDto;

@Mapper
public interface NewShipPectMgtMapper {

	public List<NewRlesMgtDto> selectPackageBadList(NewRlesMgtDto rlesMgtDto);
	public int selectPackageBadCount(NewRlesMgtDto rlesMgtDto);
}
