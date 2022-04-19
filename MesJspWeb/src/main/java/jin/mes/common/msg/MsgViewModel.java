package jin.mes.common.msg;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import kr.co.itcall.jte.spring.config.jpa.JpaBizModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "cw_msg_view"/* , schema="public" */)
@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
/**
 * <pre>
 * <b>jin.mes.common.msg</b>
 * <b>MsgViewModel.java</b>
 * <p>Descriptions : </p>
 * </pre>
 * 
 * @author  : khaeng@nate.com
 * @Date    : 2019. 11. 27.
 * @Version :
 */
public class MsgViewModel extends JpaBizModel implements Serializable {

	private static final long serialVersionUID = 5129107148347651916L;

	@EmbeddedId
	private MsgViewPk msgViewPk;

	@Column
	@NotNull
	private String msgView;
	
	@Transient
	private List<MsgViewModel> msgList;

}
