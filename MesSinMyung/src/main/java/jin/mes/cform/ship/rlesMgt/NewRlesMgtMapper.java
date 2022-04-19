package jin.mes.cform.ship.rlesMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewRlesMgtMapper {
	public List<NewRlesMgtDto> selectPackageList(NewRlesMgtDto rlesMgtDto);
	public int rowCount(NewRlesMgtDto rlesMgtDto);
	
	public List<NewRlesMgtDto> selectPackageWork(NewRlesMgtDto rlesMgtDto);
	public int selectPackageWorkCount(NewRlesMgtDto rlesMgtDto);
	
	public List<NewRlesMgtDto> selectPackagePlanList(NewRlesMgtDto rlesMgtDto);
	public int selectPackagePlanCount(NewRlesMgtDto rlesMgtDto);
	
	public void insertPackageWork(NewRlesMgtDto rlesMgtDto);
	public void updatePackageStock(NewRlesMgtDto rlesMgtDto);
	
	public void deleteQmBadItemInfo(NewRlesMgtDto rlesMgtDto);
	public void deleteQmPkgItemInfo(NewRlesMgtDto rlesMgtDto);
	public void deleteBadItemInfo(NewRlesMgtDto rlesMgtDto);
	public void deletePackageWork(NewRlesMgtDto rlesMgtDto);
	public void deleteBundle(NewRlesMgtDto rlesMgtDto);
	
	public List<NewRlesMgtDto> selectRtlBundleList(NewRlesMgtDto rlesMgtDto);
	
	public void insertBundleList(String pkgWorkId, int bundleQty, String bundleUnit);
	public void updateBundleList(String pkgWorkId, int bundleQty, String bundleUnit);
	public void deleteBundleList(String pkgWorkId, int bundleQty, String bundleUnit);
	
	public void updatePkgPlanState(NewRlesMgtDto rlesMgtDto);
	
}
