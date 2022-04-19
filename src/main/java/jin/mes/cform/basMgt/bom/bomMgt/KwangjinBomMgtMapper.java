package jin.mes.cform.basMgt.bom.bomMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.bom.bomMgt.KwangjinBomMgtDto;

@Mapper
public interface KwangjinBomMgtMapper {
	public List<KwangjinBomMgtDto> selectBomList(KwangjinBomMgtDto kwangjinBomMgtDto);
	public List<KwangjinBomMgtDto> selectBomTree(KwangjinBomMgtDto kwangjinBomMgtDto);
	public void insertBom(KwangjinBomMgtDto kwangjinBomMgtDto);
	public void updateBom(KwangjinBomMgtDto kwangjinBomMgtDto);
	public void deleteBom(KwangjinBomMgtDto kwangjinBomMgtDto);
	
	public String selectBomRoot(KwangjinBomMgtDto kwangjinBomMgtDto);
}