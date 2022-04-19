package jin.mes.form.basMgt.codMgt.msgMgt;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import jin.mes.common.msg.MsgViewModel;
import jin.mes.common.msg.MsgViewPk;


public interface MsgMgtRepository extends JpaRepository<MsgViewModel, String>{
	
	@Modifying
	@Query(value="UPDATE MsgViewModel msgViewModel "
			+ "SET msgViewModel.msgView = :msgView "
			+ "WHERE msgViewModel.msgViewPk = :msgViewPk")
	public void updateByMsgViewPk(@Param("msgViewPk") MsgViewPk msgViewPk, @Param("msgView") String msgView);
	
	@Modifying
	@Query(value="DELETE FROM MsgViewModel msgViewModel "
			+ "WHERE msgViewModel.msgViewPk = :msgViewPk")
	public void deleteByMsgViewPk(@Param("msgViewPk") MsgViewPk msgViewPk);
	
	@Modifying
	@Query(value="DELETE FROM MsgViewModel msgViewModel "
			+ "WHERE msgViewModel.msgViewPk.msgId = :msgId")
	public void deleteByMsgId(@Param("msgId") String msgId);

}
