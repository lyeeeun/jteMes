package jin.mes.mapper.basMgt.altBoard;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import jin.mes.form.basMgt.altBoard.AltBoardDto;

@Mapper
public interface AltBoardMapper {

	public List<AltBoardDto> selectBoardList(AltBoardDto altBoardDto);

	public int selectBoardListCount(AltBoardDto altBoardDto);

	public AltBoardDto selectBoard(@Param("bdSeq") long bdSeq);

	public int insertBoard(AltBoardDto altBoardDto);

	public int updateBoard(AltBoardDto altBoardDto);

	public void deleteBoard(@Param("bdSeq") long bdSeq);

	

}
