package jin.mes.common.msg;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface MsgViewRepository extends JpaRepository<MsgViewModel, MsgViewPk> {

	@Query(value = "SELECT msg FROM MsgViewModel msg WHERE msg.msgViewPk.langCd = :langCd"/* , nativeQuery = true */)
	public List<MsgViewModel> findAllByLangCd(@Param("langCd") String langCd);

	/**
	 * <pre>
	 * 1. 개요 : msgId로 msgView 찾기.
	 * 2. 처리내용 : 지정된 언어와 상관없이 모든 언어로 셋티오딘 msgView을 찾는다.
	 * </pre>
	 * @Method : findByMsgViewPkMsgId
	 * @param msgId
	 * @return
	 */
	public List<MsgViewModel> findByMsgViewPkMsgId(String msgId);

}
