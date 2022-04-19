package kr.co.itcall.jte.pms.model;

import javax.persistence.ColumnResult;
import javax.persistence.FieldResult;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter 
@Setter
//@AllArgsConstructor
public class OrderTableSqlMappingDTO {
	private String pmsCd01;
	private String pmsCd02;
	private String pmsCd03;
	private String pmsCd04;
	private String pmsCd05;
	private String descTech;
	private String descOrder;
	private int gapRunHour;
	private String needPlateInfoJson;
	private String plateNo;
	private String prodStd;
	
	//MaintenanceList
	public OrderTableSqlMappingDTO(String pmsCd01, String pmsCd02, String pmsCd03, String pmsCd04, String pmsCd05, 
			String descTech, String descOrder,int gapRunHour,String needPlateInfoJson){
		this.pmsCd01 = pmsCd01;
		this.pmsCd02 = pmsCd02;
		this.pmsCd03 = pmsCd03;
		this.pmsCd04 = pmsCd04;
		this.pmsCd05 = pmsCd05;
		this.descTech = descTech;
		this.descOrder = descOrder;
		this.gapRunHour = gapRunHour;
		this.needPlateInfoJson = needPlateInfoJson;
	}
	
	//partListForMaintenance
	public OrderTableSqlMappingDTO(String pmsCd01, String pmsCd02, String pmsCd03, String pmsCd04, String pmsCd05,
			String descTech, String needPlateInfoJson, String plateNo,String prodStd){
		this.pmsCd01 = pmsCd01;
		this.pmsCd02 = pmsCd02;
		this.pmsCd03 = pmsCd03;
		this.pmsCd04 = pmsCd04;
		this.pmsCd05 = pmsCd05;
		this.descTech = descTech;
		this.needPlateInfoJson = needPlateInfoJson;
		this.plateNo = plateNo;
		this.prodStd = prodStd;
	}
}
