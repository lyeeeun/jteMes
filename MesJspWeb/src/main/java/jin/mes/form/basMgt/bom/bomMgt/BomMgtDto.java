package jin.mes.form.basMgt.bom.bomMgt;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BomMgtDto implements Serializable{
	private static final long serialVersionUID = -7223763972842869911L;
	
	//BOM ID
	private String bomId;
	//BOM Target(품목, 자재)
	private String bomTarget;
	//BOM Target(품목, 자재)
	private String bomTargetId;
	//BOM Target Name
	private String bomTargetNm;
	//BOM 필요 수량
	private int bomTargetCnt;
	//BOM Target Name
	private String description;
	//BOM 순서
	private int bomSeq;
	//BOM Parent ID
	private String bomParentId;
	// 생성일시
	private String createdAt;
	// 생성자 ID
	private String creatorId;
	// 수정일시
	private String updatedAt;
	// 수정자 ID
	private String updatorId;
	// 품목(완제품) ID
	private String itemId;
	// 자재 설명
	private String mtrlDesc;
	// Level(Depth)
	private int lvl;
}
