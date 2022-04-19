package kr.co.itcall.jte.pms.model.support;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@Embeddable
@NoArgsConstructor
public class PmsTechOrderPk extends PmsBasePk {

	public PmsTechOrderPk(String nationId, String companyId, String areaId, String engineModel, String pmsCd01, String pmsCd02, String pmsCd03, String pmsCd04, String pmsCd05) {
		// "Columbia", "Axia", "Termonorte", "20H35DFV", "engine01", "DFE", "FIV", "003", "14", "H"
		super(nationId, companyId, areaId, engineModel);
		this.pmsCd01 = pmsCd01;
		this.pmsCd02 = pmsCd02;
		this.pmsCd03 = pmsCd03;
		this.pmsCd04 = pmsCd04;
		this.pmsCd05 = pmsCd05;
	}

	private static final long serialVersionUID = -2205666073520125011L;

	@Column(name="pms_cd_01", length=3, nullable=false)
	private String pmsCd01;

	@Column(name="pms_cd_02", length=3, nullable=false)
	private String pmsCd02;

	@Column(name="pms_cd_03", length=3, nullable=false)
	private String pmsCd03;

	@Column(name="pms_cd_04", length=2, nullable=false)
	private String pmsCd04;

	@Column(name="pms_cd_05", length=1, nullable=false)
	private String pmsCd05;

}
