package jin.mes.common.scheduler;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.userMgt.userAuth.UserAuthDto;
import jin.mes.form.facilMgt.facilCorMgt.FacilCorMgtDto;

@Mapper
public interface SchedulerMgtMapper {
	
	public List<FacilCorMgtDto> selectGageInfo(FacilCorMgtDto facilCorMgtDto);
	public List<UserAuthDto> selectEqmtManager(UserAuthDto userAuthDto);
	
}
