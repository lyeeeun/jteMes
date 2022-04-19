package jin.mes.form.mfgMgt.analsMgt;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import jin.mes.form.mfgMgt.analsMgt.AnalsMgtDto;

@Mapper
public interface AnalsMgtMapper {
	public List<AnalsMgtDto> selectRoutingSheet(AnalsMgtDto analsMgtDto);
}
