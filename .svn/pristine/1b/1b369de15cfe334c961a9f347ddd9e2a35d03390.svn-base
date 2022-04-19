package kr.co.itcall.jte.common.code;

import java.util.List;
import java.util.Optional;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import kr.co.itcall.jte.common.code.model.ComnCodeVo;
import kr.co.itcall.jte.common.code.repository.ComnCodeRepository;
import kr.co.itcall.jte.common.util.CodeUtil;
import kr.co.itcall.jte.spring.config.exception.SystemException;

@Service//("comnCodeService")
public class ComnCodeService {

	@Autowired
	private ComnCodeRepository comnCodeRepository;

	private int cacheSeconds = 10 * 60;
	private long nextReflashTime;

//	@PostConstruct
//	public void reflashComnCodeAll(){
//		List<ComnCodeVo> allComnCodeList = null;
//		synchronized (this) { // 조회는 독자적으로 한 번만...
//			if(System.currentTimeMillis() > nextReflashTime) {
//				
//				//jkkim-03-26 기본 sort 추가
//				Sort sort = new Sort(Direction.ASC, "sortNum");
//				
//				allComnCodeList = comnCodeRepository.findAll(sort);
//				//sys.flag.reflash -> cacheRefreshTime 코드 값 변경
//				cacheSeconds = Integer.parseInt(CodeUtil.getCode("cacheRefreshTime", cacheSeconds).getCdVal());
//				nextReflashTime = System.currentTimeMillis() + (cacheSeconds*1000);
//			}
//		}
//		if(!StringUtils.isEmpty(allComnCodeList))
//			CodeUtil.reflashCachedAllComnCodeList(allComnCodeList);
//	}
//
//	public List<ComnCodeVo> getComnCodeRootList() throws SystemException {
//		return comnCodeRepository.findByUpCdIdNull();
//	}
//	
//	public Page<ComnCodeVo> searchPage(String searchKey, Pageable pageable) throws RuntimeException {
//		return comnCodeRepository.searchPage(searchKey, pageable);
//	}
//
//	public List<ComnCodeVo> getComnCodeList(String cdId) throws RuntimeException {
//		return this.comnCodeRepository.findByCdIdLikeIgnoringCase("%"+cdId+"%");
//	}
//
//	public List<ComnCodeVo> getActivedComnCd(String cdId) throws SystemException {
//		return this.comnCodeRepository.searchActivedComnCd(cdId);
//	}
//
//	public ComnCodeVo getComnCode(String cdId) throws RuntimeException {
//		Optional<ComnCodeVo> result = this.comnCodeRepository.findById(cdId);
//		if(!result.isPresent())
//			return null;
//		return result.get(); // getOne(cdId);
//	}
//
//	public ComnCodeVo addComnCode(ComnCodeVo comnCodeVo) throws RuntimeException {
//		return this.comnCodeRepository.save(comnCodeVo);
//	}
//
//	public ComnCodeVo setComnCode(ComnCodeVo comnCodeVo) {
//		return this.comnCodeRepository.save(comnCodeVo);
//	}
//
//	public void rmComnCode(String cdId) throws RuntimeException {
//		this.comnCodeRepository.deleteById(cdId);
//	}
//
//	public List<ComnCodeVo> getComnCodeList(String upCdId, String cdId){
//		if(StringUtils.isEmpty(cdId)) {
//			return this.comnCodeRepository.findByUpCdId(upCdId);
//		}else if(!StringUtils.isEmpty(cdId)) {
//			return getActivedComnCd(cdId);
//		} else {
//			return null;
//		}
//	}
}
