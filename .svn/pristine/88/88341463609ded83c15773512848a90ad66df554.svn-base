package kr.co.itcall.jte.pms.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import kr.co.itcall.jte.pms.model.support.PmsPartDtlPk;
import kr.co.itcall.jte.spring.config.jpa.JpaBizModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * <pre>
 * <b>kr.co.itcall.jte.pms.model</b>
 * <b>PmsPartDtlModel.java</b>
 * <p>Descriptions : 국가/회사/지역/(엔진) 별 정비대상 장비상세리스트 + 보유내역 포함.</p>
 * </pre>
 * 
 * @author  : khaeng@nate.com
 * @Date    : 2019. 5. 24.
 * @Version :
 */
@Entity
@Table(name = "pms_part_dtl")
@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class PmsPartDtlModel extends JpaBizModel implements Serializable {

	private static final long serialVersionUID = -6681389725145478507L;
	
	public PmsPartDtlModel(PmsPartDtlPk pmsPartDtlPk, String platePart, String siteCd, String drawNo, String typeCd, String materialNo,
			String uCode, String prodStd, int engineAmt, String amtUnit, char stockYn, int limitTime) {
		this.pmsPartDtlPk = pmsPartDtlPk;
		this.platePart = platePart;
		this.siteCd = siteCd;
		this.drawNo = drawNo;
		this.typeCd = typeCd;
		this.materialNo = materialNo;
		this.uCode = uCode;
		this.prodStd = prodStd;
		this.engineAmt = engineAmt;
		this.amtUnit = amtUnit;
		this.stockYn = stockYn;
		this.limitTime = limitTime;
	}
	
	@EmbeddedId
	private PmsPartDtlPk pmsPartDtlPk;
	
	/**
	 * 항목(타이틀 성격)
	 */
	@Column(name="plate_part", length=50, nullable=false)
	private String platePart;

	/**
	 * Site code
	 */
	@Column(name="site_cd", length=15, nullable=false)
	private String siteCd;

	/**
	 * 도면번호
	 */
	@Column(name="draw_no", length=25, nullable=false)
	private String drawNo;

	/**
	 * 표준/대응
	 */
	@Column(name="type_cd", length=10)
	private String typeCd;

	/**
	 * 자재번호
	 */
	@Column(name="material_no", length=25, nullable=false)
	private String materialNo;

	/**
	 * U-CODE
	 */
	@Column(name="u_code", length=25)
	private String uCode;

	/**
	 * 품명 및 규격
	 */
	@Column(name="prod_std", length=100)
	private String prodStd;

	/**
	 * Engine 수량
	 */
	@Column(name="engine_amt")
	private int engineAmt;

	/**
	 * 수량 단위
	 */
	@Column(name="amt_unit", length=5)
	private String amtUnit;

	/**
	 * STOCK in Site
	 */
	@Column(name="stock_yn", length=1)
	private char stockYn;

	/**
	 * L/T (무슨뜻인가???)
	 */
	@Column(name="limit_time")
	private int limitTime;

	/***********************
	 * PmsTechOrder에서 파생됨. >>> 별도 테이블로 ??? 
	 ***********************/

	/**
	 * Q'ty ( ? 보유수량???)
	 */
	@Column(name="amt_count")
	private int amtCount;

	@Column(name="part_unit", length=15)
	private String partUnit;

	@Column(name="descEtc", length=1000)
	private String descEtc;

	/*
	 * @ManyToMany(fetch = FetchType.LAZY, mappedBy="partDtlList") private List<PmsTechOrderModel> techOrderList = new ArrayList<PmsTechOrderModel>();
	 */

}
