package kr.co.itcall.jte.pms.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.SqlResultSetMapping;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.OrderBy;
import org.hibernate.annotations.Where;

import kr.co.itcall.jte.pms.model.support.PmsTechOrderNeedPlateInfoVo;
import kr.co.itcall.jte.pms.model.support.PmsTechOrderPk;
import kr.co.itcall.jte.spring.config.jpa.JpaBizModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * <pre>
 * <b>kr.co.itcall.jte.pms.model</b>
 * <b>PmsTechOrderModel.java</b>
 * <p>Descriptions : 국가/회사/지역/(엔진) 별 정비주기(지침) 목록</p>
 * </pre>
 * 
 * @author  : khaeng@nate.com
 * @Date    : 2019. 5. 24.
 * @Version :
 */
@Entity
@Table(name = "pms_tech_order")
@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
@SqlResultSetMapping(
	name = "MaintenanceList",
	classes = {
		@ConstructorResult(
			targetClass=OrderTableSqlMappingDTO.class,
			columns = {
				@ColumnResult(name = "pmsCd01"),
				@ColumnResult(name = "pmscd02"),
				@ColumnResult(name = "pmsCd03"),
				@ColumnResult(name = "pmsCd04"),
				@ColumnResult(name = "pmsCd05"),
				@ColumnResult(name = "descTech"),
				@ColumnResult(name = "descOrder"),
				@ColumnResult(name = "gapRunHour",type=Integer.class),
				@ColumnResult(name = "needPlateInfoJson"),
			}				
		)
	}
)
@SqlResultSetMapping(
	name = "partListForMaintenance",
	classes = {
		@ConstructorResult(
			targetClass=OrderTableSqlMappingDTO.class,
			columns = {
				@ColumnResult(name = "pmsCd01"),
				@ColumnResult(name = "pmscd02"),
				@ColumnResult(name = "pmsCd03"),
				@ColumnResult(name = "pmsCd04"),
				@ColumnResult(name = "pmsCd05"),
				@ColumnResult(name = "descTech"),
				@ColumnResult(name = "needPlateInfoJson"),
				@ColumnResult(name = "plateNo"),
				@ColumnResult(name = "prodStd")
			}				
		)
	}
)
public class PmsTechOrderModel extends JpaBizModel implements Serializable {

	private static final long serialVersionUID = -428320656359563760L;
	
	public PmsTechOrderModel(PmsTechOrderPk pmsTechOrderPk, String descTech, String descOrder
			,int gapRunHour, String descEtc) {
		this.pmsTechOrderPk = pmsTechOrderPk;
		this.descTech = descTech;
		this.descOrder = descOrder;
		this.gapRunHour = gapRunHour;
		this.descEtc = descEtc;
	}
	
	@EmbeddedId
	private PmsTechOrderPk pmsTechOrderPk;

	@Column(name="desc_tech", length=100)
	private String descTech;

	@Column(name="desc_order", length=100)
	private String descOrder;

	@Column(name="gap_run_hour")
	private int gapRunHour;

	@Column(name="descEtc", length=1000)
	private String descEtc;

	@Column(name="need_plate_count")
	private int needPlateCount;

//	@Column(name="need_plate_no_arr", columnDefinition = "varchar(15)[]")
//	private String[] needPlateNoArr;
	
	@Column(name="need_plate_info_json", columnDefinition = "text") 
	private String needPlateInfoJson;
	
	@Transient
	private int pmsQty;
	
	@Transient
	private String pmsUnit;
	
	@Transient
	private List<PmsTechOrderNeedPlateInfoVo> needPlateInfoList;

	
	@OneToMany(fetch = FetchType.LAZY)
	@Where(clause="is_recently = true AND COALESCE(parent_id,'') =''")//조회시 Where 조건 추가
	@OrderBy(clause="engine_id ASC")//조회시 OrderBy 조건 추가
	@JoinColumns({@JoinColumn(name = "nation_id", insertable = false, updatable = false, nullable = false, unique=false, referencedColumnName = "nation_id") , 
		@JoinColumn(name = "company_id", insertable = false, updatable = false, nullable = false, unique=false, referencedColumnName = "company_id" ) ,
		@JoinColumn(name = "area_id", insertable = false, updatable = false, nullable = false, unique=false, referencedColumnName = "area_id" ) , 
		@JoinColumn(name = "engine_model", insertable = false,updatable = false, nullable = false, unique=false, referencedColumnName = "engine_model" ) 
	// , @JoinColumn(name = "engine_id", insertable = false, updatable = false, nullable = false, unique=false ) 
	, @JoinColumn(name = "pms_cd_01", insertable = false, updatable = false, nullable = false, unique=false, referencedColumnName = "pms_cd_01" ) 
	, @JoinColumn(name = "pms_cd_02", insertable = false, updatable = false, nullable = false, unique=false, referencedColumnName = "pms_cd_02" )
	, @JoinColumn(name = "pms_cd_03", insertable = false, updatable = false, nullable = false, unique=false, referencedColumnName = "pms_cd_03" ) 
	, @JoinColumn(name = "pms_cd_04", insertable = false, updatable = false, nullable = false, unique=false, referencedColumnName = "pms_cd_04" ) 
	, @JoinColumn(name = "pms_cd_05", insertable = false, updatable = false, nullable = false, unique=false, referencedColumnName = "pms_cd_05" )})
	// @Where(clause="pms_tech_order_hist.seq_no in (select max(h.seq_no) from pms_tech_order_hist h group by h.engine_id)")
	private List<PmsTechOrderHistModel> pmsTechOrderHistList = new ArrayList<PmsTechOrderHistModel>();

	@ManyToMany(fetch = FetchType.LAZY) // (cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@JoinTable(name = "pms_tech_order_relate_part_dtl" // @ManyToMany는 양방향이라 중간에 Relation테이블을 꼭 두어야 하며, Relation테이블에 추가Field가 있을 경우 직접 Model을 추가로 만들고 @ManyToOne, @OneToMany을 각각 선언해줘야 한다. 즉 Relation테이블에는 2개의 @OneToMany가 존재하게 된다.
			, joinColumns =        { @JoinColumn(table="pms_tech_order", name = "nation_id", nullable = false, referencedColumnName = "nation_id", unique=false )
									, @JoinColumn(table="pms_tech_order", name = "company_id", nullable = false, referencedColumnName = "company_id", unique=false )
									, @JoinColumn(table="pms_tech_order", name = "area_id", nullable = false, referencedColumnName = "area_id", unique=false )
									, @JoinColumn(table="pms_tech_order", name = "engine_model", nullable = false, referencedColumnName = "engine_model", unique=false )
//									, @JoinColumn(table="pms_tech_order", name = "engine_id", nullable = false, referencedColumnName = "engine_id", unique=false )
									, @JoinColumn(table="pms_tech_order", name = "pms_cd_01", nullable = false, referencedColumnName = "pms_cd_01", unique=false )
									, @JoinColumn(table="pms_tech_order", name = "pms_cd_02", nullable = false, referencedColumnName = "pms_cd_02", unique=false )
									, @JoinColumn(table="pms_tech_order", name = "pms_cd_03", nullable = false, referencedColumnName = "pms_cd_03", unique=false )
									, @JoinColumn(table="pms_tech_order", name = "pms_cd_04", nullable = false, referencedColumnName = "pms_cd_04", unique=false )
									, @JoinColumn(table="pms_tech_order", name = "pms_cd_05", nullable = false, referencedColumnName = "pms_cd_05", unique=false ) }
			, inverseJoinColumns = { @JoinColumn(table="pms_part_dtl", name = "part_nation_id", nullable = false, referencedColumnName = "nation_id", unique=false )
									, @JoinColumn(table="pms_part_dtl", name = "part_company_id", nullable = false, referencedColumnName = "company_id", unique=false )
									, @JoinColumn(table="pms_part_dtl", name = "part_area_id", nullable = false, referencedColumnName = "area_id", unique=false )
									, @JoinColumn(table="pms_part_dtl", name = "part_engine_model", nullable = false, referencedColumnName = "engine_model", unique=false )
									, @JoinColumn(table="pms_part_dtl", name = "plate_no", nullable = false, referencedColumnName = "plate_no", unique=false ) }
	)
	private List<PmsPartDtlModel> partDtlList = new ArrayList<PmsPartDtlModel>();
	
//	public void setNeedPlateInfoJson(String needPlateInfoJson) {
//		this.needPlateInfoJson = needPlateInfoJson; 
//		this.needPlateInfoList = new ConvertUtil<PmsTechOrderNeedPlateInfoVo>().readListFromJson(needPlateInfoJson, PmsTechOrderNeedPlateInfoVo.class); 
//		this.needPlateCount = needPlateInfoList.size(); 
//	}
//
//	public void setNeedPlateInfoList(List<PmsTechOrderNeedPlateInfoVo> needPlateInfoList) {
//		this.needPlateInfoList = needPlateInfoList;
//		this.needPlateCount = needPlateInfoList.size();
//		this.needPlateInfoJson = new ConvertUtil<PmsTechOrderNeedPlateInfoVo>().readFromList(needPlateInfoList);
//	}
//
//	public static void main(String[] args) {
//		PmsTechOrderModel model = new PmsTechOrderModel();
//		List<PmsTechOrderNeedPlateInfoVo> infoList = new ArrayList<PmsTechOrderNeedPlateInfoVo>();
//		PmsTechOrderNeedPlateInfoVo info = new PmsTechOrderNeedPlateInfoVo();
//		info.setAddPart("addPart");
//		info.setDescPlate("descPlate");
//		info.setDrawNo("drawNo");
//		info.setPlateNo("plateNo");
//		info.setReqQuty(2);
//		info.setUnitCd("unitCd");
//		infoList.add(info);
//		info.setAddPart("addPart1");
//		info.setDescPlate("descPlate1");
//		info.setDrawNo("drawNo1");
//		info.setPlateNo("plateNo1");
//		info.setReqQuty(4);
//		info.setUnitCd("unitCd2");
//		infoList.add(info);
//		model.setNeedPlateInfoList(infoList);
//		System.out.println(model.getNeedPlateInfoJson());
//	}
	public void setOrderExcelMapping(String descTech, String descOrder,int gapRunHour, String descEtc) {
		this.descTech = descTech;
		this.descOrder = descOrder;
		this.gapRunHour = gapRunHour;
		this.descEtc = descEtc;
	}
}
