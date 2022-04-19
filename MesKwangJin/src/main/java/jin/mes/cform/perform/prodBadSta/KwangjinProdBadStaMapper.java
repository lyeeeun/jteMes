package jin.mes.cform.perform.prodBadSta;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.perform.prodBadSta.KwangjinProdBadStaDto;

@Mapper
public interface KwangjinProdBadStaMapper {
	public List<KwangjinProdBadStaDto> selectProdBad(KwangjinProdBadStaDto kwangjinProdBadStaDto);
	public int selectProdBadCount(KwangjinProdBadStaDto kwangjinProdBadStaDto);
}
