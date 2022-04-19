package jin.mes.cform.ship.rlesPlanMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.ship.rlesPlanMgt.NewRlesPlanMgtDto;
@Mapper
public interface NewRlesPlanMgtMapper {
	public List<NewRlesPlanMgtDto> selectPackagePlanList(NewRlesPlanMgtDto rlesPlanMgtDto);
	public int selectPackagePlanCount(NewRlesPlanMgtDto rlesPlanMgtDto);
	public NewRlesPlanMgtDto selectPackageAgg(NewRlesPlanMgtDto rlesPlanMgtDto);
	
	public void insertPackagePlan(NewRlesPlanMgtDto rlesPlanMgtDto);
	public void updatePackagePlan(NewRlesPlanMgtDto rlesPlanMgtDto);
	public void deletePackagePlan(NewRlesPlanMgtDto rlesPlanMgtDto);
}
