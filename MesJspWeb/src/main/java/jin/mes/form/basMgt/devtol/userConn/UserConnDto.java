package jin.mes.form.basMgt.devtol.userConn;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class UserConnDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = -3114219623756912236L;
	
	//생성자
	public UserConnDto(String connId, String userId, String connStdt, String connEddt, String connTime, String connIp, String connDevice) {
		this.connId = connId;
		this.userId = userId;
		this.connStdt = connStdt;
		this.connEddt = connEddt;
		this.connTime = connTime;
		this.connIp = connIp;
		this.connDevice = connDevice;
	}
	
	private String connId;
	private String userId;
	private String userNm;
	private String connStdt;
	private String connEddt;
	private String connTime;
	private String connIp;
	private String connDevice;
}
