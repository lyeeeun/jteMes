package kr.co.itcall.jte.pms.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Where;
import org.springframework.data.domain.Pageable;

import kr.co.itcall.jte.pms.model.support.PmsTechOrderPk;
import kr.co.itcall.jte.spring.config.jpa.JpaHistModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "pms_tech_order_hist")
@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class PmsTechOrderHistModel extends JpaHistModel implements Serializable {

	private static final long serialVersionUID = -4992162190897054731L;

	public PmsTechOrderHistModel(PmsTechOrderPk pmsTechOrderPk, String engineId) {
		this.pmsTechOrderPk = pmsTechOrderPk;
		this.engineId = engineId;
	}
	//엔진 생성자
	public PmsTechOrderHistModel(PmsTechOrderPk pmsTechOrderPk,String engineId, String lastWorkNoti,
			LocalDateTime atFixedDate, int atFixedHour, int runningHour, boolean isRecently) {
		this.pmsTechOrderPk = pmsTechOrderPk;
		this.engineId = engineId;
		this.lastWorkNoti = lastWorkNoti;
		this.atFixedDate = atFixedDate;
		this.atFixedHour = atFixedHour;
		this.runningHour = runningHour;
		this.isRecently = isRecently;
	}
	//실린더 생성자
		public PmsTechOrderHistModel(PmsTechOrderPk pmsTechOrderPk,String parentId, String engineId, String lastWorkNoti,
				LocalDateTime atFixedDate, int atFixedHour, int runningHour, boolean isRecently) {
			this.pmsTechOrderPk = pmsTechOrderPk;
			this.parentId = parentId;
			this.engineId = engineId;
			this.lastWorkNoti = lastWorkNoti;
			this.atFixedDate = atFixedDate;
			this.atFixedHour = atFixedHour;
			this.runningHour = runningHour;
			this.isRecently = isRecently;
		}
	@Id
	@GeneratedValue(generator = "sq_pms_tech_order_hist_seq")
	@SequenceGenerator(name = "sq_pms_tech_order_hist_seq", sequenceName = "sq_pms_tech_order_hist_seq", initialValue = 1, allocationSize = 1)
	@Column(name="seq_no")
	private Long seqNo;

	@Embedded
	private PmsTechOrderPk pmsTechOrderPk;

	/**
	 * 설치된 엔진일련번호 또는 ID : 모델은 상관없음.
	 * ex) Columbia_Axia_Termonorte_Engine01~10중에 Engine03 이런 값임.
	 */
	@Column(name="engine_id", length=15, nullable=false)
	private String engineId;
	
	@Column(name="parent_id", length=15)
	private String parentId;
	
	@Column(name="work_noti", length=1000)
	private String lastWorkNoti;

	@Column(name="at_fixed_date", nullable=false)
	private LocalDateTime atFixedDate;

	@Column(name="at_fixed_hour", nullable=false)
	private int atFixedHour;
	
	@Column(name="running_hour", nullable = false)
	private int runningHour;
	
	@Column(name="is_recently", nullable=false)
	private boolean isRecently;
	
	//일괄 등록/수정을 하기 위함(All/Eng/Cyl)
	@Transient
	private String multiSave;
	
	//일괄 등록/수정을 하기 위함 (parentId) 
	@Transient
	private String[] parentList;
	
	//일괄 등록/수정을 하기 위함 (engineId)
	@Transient
	private String[] engineList;
		
	//경과시간 (rms.runningHour - hist.runningHour)
	@Transient
	private int runTime;
	
	//남은시간 or 초과시간 (hist.atFixedHour - runTime) 
	@Transient
	private int runAlarm;
	
}
