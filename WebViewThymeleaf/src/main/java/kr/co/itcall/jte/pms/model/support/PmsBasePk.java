package kr.co.itcall.jte.pms.model.support;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.MappedSuperclass;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * <pre>
 * <b>kr.co.itcall.jte.pms.model.support</b>
 * <b>PmsBasePk.java</b>
 * <p>Descriptions : PMS의 기본분류 정보(공통)</p>
 * ex) 설치엔진별 : Columbia_Axia_Termonorte_Engine01~10
 * ex) 설치모델별 : Columbia_Axia_Termonorte_20H35DFV
 * </pre>
 * 
 * @author  : khaeng@nate.com
 * @Date    : 2019. 5. 26.
 * @Version :
 */
@Data
@EqualsAndHashCode(callSuper=false)
@Embeddable
@MappedSuperclass
@NoArgsConstructor
public class PmsBasePk implements Serializable {

	public PmsBasePk(String nationId, String companyId, String areaId, String engineModel) {
		this.nationId = nationId;
		this.companyId = companyId;
		this.areaId = areaId;
		this.engineModel = engineModel;
	}

	private static final long serialVersionUID = 1470110785170331942L;

	/**
	 * 1. 최상위 국가코드
	 * ex) Columbia
	 */
	@Column(name="nation_id", length=15, nullable=false)
	private String nationId;

	/**
	 * 2. 상위 회사코드
	 * ex) Axia
	 */
	@Column(name="company_id", length=15, nullable=false)
	private String companyId;

	/**
	 * 3. 중위 지역코드
	 * ex) Termonorte
	 */
	@Column(name="area_id", length=15, nullable=false)
	private String areaId;

	/**
	 * 4. 하위 엔진모델
	 * ex) 20H35DFV
	 */
	@Column(name="engine_model", length=15, nullable=false)
	private String engineModel;

}
