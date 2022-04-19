package jin.mes.common.msg;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@Embeddable
@NoArgsConstructor
public class MsgViewPk implements Serializable {

	private static final long serialVersionUID = -175657911695373367L;

	public MsgViewPk(String msgId, String langCd) {
		super();
		this.msgId = msgId;
		this.langCd = langCd;
	}

	@Column(length=100, nullable=false)
	private String msgId;

	@Column(length=10, nullable=false)
	private String langCd = "ko";

}
