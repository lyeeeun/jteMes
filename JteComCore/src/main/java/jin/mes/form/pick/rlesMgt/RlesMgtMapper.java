package jin.mes.form.pick.rlesMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.pick.rlesMgt.RlesMgtDto;

@Mapper
public interface RlesMgtMapper {
	public List<RlesMgtDto> selectRlesPlansList(RlesMgtDto rlesMgtDto);
	public int selectRlesPlansCount(RlesMgtDto rlesMgtDto);
	
	public void updateRlesWork(RlesMgtDto rlesMgtDto);
	public void insertRlesWork(RlesMgtDto rlesMgtDto);
	public void updateRlesStock(RlesMgtDto rlesMgtDto);
	
}
