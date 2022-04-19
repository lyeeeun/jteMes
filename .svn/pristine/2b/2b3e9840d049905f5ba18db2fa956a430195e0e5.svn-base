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
public class PmsPartDtlPk extends PmsBasePk {

	private static final long serialVersionUID = -7297047393131119037L;

	public PmsPartDtlPk(String nationId, String companyId, String areaId, String engineModel, String plateNo) {
		super(nationId, companyId, areaId, engineModel);
		this.plateNo = plateNo;
	}

	/**
	 * Plate Number : 엔진별 장비리스트 고유번호 (여러엔진모델이 존재할 경우 중복될 수 있음. 동일엔진 여러개는 모델이 같으므로 1개만 존재함)
	 */
	@Column(name="plate_no", length=20, nullable=false)
	private String plateNo;

}
