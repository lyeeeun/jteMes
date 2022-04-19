package jin.mes.mapper.ship.rlesMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.ship.rlesMgt.RlesMgtDto;

@Mapper
public interface RlesMgtMapper {
	public List<RlesMgtDto> selectPackageList(RlesMgtDto rlesMgtDto);
	public int rowCount(RlesMgtDto rlesMgtDto);
	
	public List<RlesMgtDto> selectPackageWork(RlesMgtDto rlesMgtDto);
	public int selectPackageWorkCount(RlesMgtDto rlesMgtDto);
	
	public List<RlesMgtDto> selectPackagePlanList(RlesMgtDto rlesMgtDto);
	public int selectPackagePlanCount(RlesMgtDto rlesMgtDto);
	
	public void insertPackageWork(RlesMgtDto rlesMgtDto);
	public void updatePackageStock(RlesMgtDto rlesMgtDto);
	
	public void deleteQmBadItemInfo(RlesMgtDto rlesMgtDto);
	public void deleteQmPkgItemInfo(RlesMgtDto rlesMgtDto);
	public void deleteBadItemInfo(RlesMgtDto rlesMgtDto);
	public void deletePackageWork(RlesMgtDto rlesMgtDto);
	public void deleteBundle(RlesMgtDto rlesMgtDto);
	
	public List<RlesMgtDto> selectRtlBundleList(RlesMgtDto rlesMgtDto);
	
	public void insertBundleList(String pkgWorkId, int bundleQty, String bundleUnit);
	public void updateBundleList(String pkgWorkId, int bundleQty, String bundleUnit);
	public void deleteBundleList(String pkgWorkId, int bundleQty, String bundleUnit);
	
	public void updatePkgPlanState(RlesMgtDto rlesMgtDto);
	
}
