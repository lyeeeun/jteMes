package kr.co.itcall.jte.common.code.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.UniqueElements;

import kr.co.itcall.jte.spring.config.jpa.JpaBizModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "cw_comn_code"/* , schema="public" */)
@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class ComnCodeVo extends JpaBizModel implements Serializable {

	private static final long serialVersionUID = -9093972726201696955L;

//	@Id
//	@GeneratedValue(generator = "sq_cw_comn_code_gen")
//	@SequenceGenerator(name = "sq_cw_comn_code_gen", sequenceName = "sq_cw_comn_code_seq", initialValue = 10000, allocationSize = 1)
//	private Long id;

	@Id
	@Size(min = 3, max = 100)
	@Column(name="cd_id", length=50, nullable=false)
	// @UniqueElements
	private String cdId;

	@NotBlank
	@Size(min = 3, max = 100)
	@Column(name="cd_nm", length=100, nullable=false)
	@UniqueElements
	private String cdNm;

	/**** 부모키이므로 vo에서는 Set으로 처리됨. ****/
//	@NotBlank
//	@Size(min = 3, max = 50)
//	@Column(name="up_cd_nm", length=50, nullable=false)
//	@ColumnDefault("-TOP-")
//	private String upCdNm;

//	@Column(name="view_cd", length=100)
//	private String viewCd;

//	@Column(name="view_nm", length=100)
//	private String viewNm;

	/**
	 * 서비스링크 : 메뉴 등에서 접근서비스를 지정할때 사용한다.
	 */
//	@Column(name="svc_link", length=1000)
//	private String svcLink;

//	@Column(name="rel_cd_ids", length=1000)
//	private String relCdIds;

	@Column(name = "sort_num", columnDefinition = "integer default 1 not null")
	private int sortNum;

	@Column(name = "cd_val", length=4000)
	private String cdVal;
	
	@Column(name = "cd_reserve01", length=4000)
	private String cdReserve01;
	
	@Column(name = "cd_reserve02", length=4000)
	private String cdReserve02;
	
	@Column(name = "cd_reserve03", length=4000)
	private String cdReserve03;
	
	@Column(name = "cd_reserve04", length=4000)
	private String cdReserve04;
	
//	@Column(name="cd_num", columnDefinition = "integer default 0 not null")
//	private int cdNum;

	@Column(columnDefinition = "text")
	private String description;

	@Column(name = "up_cd_id", length=100)
	private String upCdId;
	
	@Column(name = "use_yn"/* , length=1, nullable=false */, columnDefinition = "char(1) default 'Y' not null")
	private String useYn;

//	// @JsonManagedReference // Ajax 호출 시 상위조건 검색결과에 포함되게 함.
//	@JsonBackReference    // Ajax 호출 시 하위조건 검색결과에서 제외한다.(Self조인에서 무한루프방지)
//	// @ManyToOne(cascade = {CascadeType.ALL}, fetch = FetchType.LAZY) // FetchType.EAGER
//	// @JoinColumn(name = "up_cd_id", referencedColumnName = "cd_id"/* , unique=true */, insertable = false, updatable = false )
//	@Transient
//	private ComnCodeVo upComnCodeVo;

	// @JsonBackReference    // Ajax 호출 시 하위조건 검색결과에서 제외한다.(Self조인에서 무한루프방지)
	// @OneToMany(mappedBy="upComnCodeVo")
	@Transient
	private List<ComnCodeVo> subComnCodeList = new ArrayList<ComnCodeVo>();

	public ComnCodeVo(String cdId, String cdNm, String description, String cdVal, int cdNum) {
		this(cdId, cdNm, "Y", cdId, cdNm, null, 0, description, cdVal, cdNum);
	}
	public ComnCodeVo(String cdId, String cdNm, String useYn, String svcLink, int sortNum, String description, String cdVal, int cdNum) {
		this(cdId, cdNm, useYn, cdId, cdNm, svcLink, sortNum, description, cdVal, cdNum);
	}
	public ComnCodeVo(String cdId, String cdNm, String useYn, String viewCd, String viewNm, String svcLink, int sortNum, String description, String cdVal, int cdNum) {
		this(cdId, cdNm, useYn, cdId, cdNm, svcLink, sortNum, description, null, cdVal, cdNum);
	}
	public ComnCodeVo(String cdId, String cdNm, String useYn, String viewCd, String viewNm, String svcLink, int sortNum, String description, String upCdId, String cdVal, int cdNum) {
		this.setCdId(cdId);
		this.setCdNm(cdNm);
		this.setUseYn(useYn);
//		this.setViewCd(viewCd);
//		this.setViewNm(viewNm);
//		this.setSvcLink(svcLink);
		this.setSortNum(sortNum);
		this.setDescription(description);
		this.setUpCdId(upCdId);
		this.setCdVal(cdVal);
//		this.setCdNum(cdNum);
	}
	public ComnCodeVo(ComnCodeVo vo) {
		this.cdId = vo.getCdId();
		this.cdNm = vo.getCdNm();
//		this.cdNum = vo.getCdNum();
		this.cdVal = vo.getCdVal();
		this.description = vo.getDescription();
//		this.relCdIds = vo.getRelCdIds();
		this.sortNum = vo.getSortNum();
//		this.svcLink = vo.getSvcLink();
		this.upCdId = vo.getUpCdId();
		this.cdReserve01 = vo.getCdReserve01();
		this.cdReserve02 = vo.getCdReserve02();
		this.cdReserve03 = vo.getCdReserve03();
		this.cdReserve04 = vo.getCdReserve04();
		this.useYn = vo.getUseYn();
//		this.viewCd = vo.getViewCd();
//		this.viewNm = vo.getViewNm();
		super.clone(vo);
	}

	/**
	 * <pre>
	 * 1. 개요 : 부모코드에 소속코드를 추가한다.
	 * 2. 처리내용 : 소속코드에 부모코드를 자동으로 삽입하며, 소트번호가 없다면 이미 등록된 소속코드의 다음 순서로 소트번호를 부여한다. 최소 1부터 시작
	 * </pre>
	 * @Method : addSubCode
	 * @param codeVo
	 * @return
	 */
	public ComnCodeVo addSubCode(ComnCodeVo codeVo){
		if(!this.subComnCodeList.contains(codeVo)) {
			codeVo.setUpCdId(this.cdId);
			if(codeVo.getSortNum()<=0)
				codeVo.setSortNum(this.subComnCodeList.size()+1);
			this.subComnCodeList.add(codeVo);
		}
		return this;
	}

	@Override
	public ComnCodeVo clone() {
		return new ComnCodeVo(this);
	}

}
