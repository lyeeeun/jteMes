package jin.mes.form.perform.prodStaMgt.workProdStaMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.perform.prodStaMgt.workProdStaMgt.WorkProdStaMgtDto;

@Mapper
public interface WorkProdStaMgtMapper {
	public List<WorkProdStaMgtDto> selectWorkProdStaList(WorkProdStaMgtDto workProdStaMgtDto);
	public int selectWorkProdStaCount(WorkProdStaMgtDto workProdStaMgtDto);
}
