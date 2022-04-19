package jin.mes.form.perform.prodStaMgt.unworkStaMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.perform.prodStaMgt.unworkStaMgt.UnworkStaMgtDto;

@Mapper
public interface UnworkStaMgtMapper {

	public List<UnworkStaMgtDto> selectUnWorkStaList(UnworkStaMgtDto unworkStaMgtDto);
	
	public int selectUnWorkStaCount(UnworkStaMgtDto unworkStaMgtDto);
}
