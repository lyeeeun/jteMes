package jin.mes.form.basMgt.authMgt.authInfo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


public interface AuthInfoRepository extends JpaRepository<AuthInfoModel, String>{
	
	@Modifying
	@Query(value="DELETE FROM AuthInfoModel authInfoModel "
			+ "WHERE authInfoModel.authId = :authId ")
	public void deleteByAuthId(@Param("authId") String authId);
	
	@Modifying
	@Query(value="UPDATE AuthInfoModel authInfoModel " +
	"SET authInfoModel.description = :#{#authInfo.description}, " +
	"authInfoModel.reqSvcUri = :#{#authInfo.reqSvcUri} " +
	"WHERE authInfoModel.authId = :#{#authInfo.authId}")
	public void updateAuthInfo(@Param("authInfo") AuthInfoModel authInfo);

}
