package jin.mes.common.scheduler;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class SchedulerMgtDto  extends BaseVo {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -101577993640386400L;
	
	public SchedulerMgtDto(String alarmTarget, String alarmCode, String alarmTitle, String alarmContent, String alarmUrl, 
			String alarmSender, String alarmSendDate, String alarmReceiver, String alarmStatus, String alarmDevice, String creatorId) {
		this.alarmTarget = alarmTarget; 
		this.alarmCode = alarmCode;
		this.alarmTitle = alarmTitle;
		this.alarmContent = alarmContent;
		this.alarmUrl = alarmUrl;
		this.alarmSender = alarmSender;
		this.alarmSendDate = alarmSendDate;
		this.alarmReceiver = alarmReceiver;
		//this.alarmReceiveDate = alarmReceiveDate;
		this.alarmStatus = alarmStatus;
		this.alarmDevice = alarmDevice;
		this.creatorId = creatorId;
	}
	
	private String alarmId;
	private String alarmTarget;
	private String alarmCode;
	private String alarmTitle;
	private String alarmContent;
	private String alarmUrl;
	private String alarmSender;
	private String alarmSenderNm;
	private String alarmSendDate;
	private String alarmReceiver;
	private String alarmReceiverNm;
	private String alarmReceiveDate;
	private String alarmStatus;
	private String alarmDevice;
	private String creatorId;
	private String createdAt;
	private int alarmSeqId;
}
