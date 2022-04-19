package jin.mes.form.devtol.svcLog;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class SvcLogDto  extends BaseVo {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6573038349336044146L;

	//생성자
	public SvcLogDto(double svcLogTime, String svcLogPart, String svcLogMethod, String svcLogPath, String svcLogPrmt 
			,boolean svcLogSuccess, String svcLogMsg, String svcLogUser, String svcLogResult, String svcLogIp, String svcLogDevice) {
		this.svcLogTime = svcLogTime;
		this.svcLogPart = svcLogPart;
		this.svcLogMethod = svcLogMethod;
		this.svcLogPath = svcLogPath;
		this.svcLogSuccess = svcLogSuccess;
		this.svcLogPrmt = svcLogPrmt;
		this.svcLogMsg = svcLogMsg;
		this.svcLogUser = svcLogUser;
		this.svcLogResult = svcLogResult;
		this.svcLogIp = svcLogIp;
		this.svcLogDevice = svcLogDevice;
	}
	
	private long svcLogId;
	private String svcLogAt;
	private double svcLogTime;
	private String svcLogPart;
	private String svcLogMethod;
	private String svcLogPath;
	private String svcLogPrmt;
	private boolean svcLogSuccess;
	private String svcLogMsg;
	private String svcLogResult;
	private String svcErrUser;
	private String svcErrUserNm;
	private String svcErrAt;
	private String svcErrResult;
	private String svcLogIp;
	private String svcLogDevice;
	private String svcLogUser;
	private String svcLogUserNm;
	
	private String menuGbn;
}
