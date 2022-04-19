

package kr.co.itcall.jte.common.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.util.StringUtils;

import kr.co.itcall.jte.common.code.model.ComnCodeVo;
import kr.co.itcall.jte.util.AsyncUtil;

public class CodeUtil {

//	private static final List<ComnCodeVo> allComnCodeList = new ArrayList<ComnCodeVo>();
//
//	public static void reflashCachedAllComnCodeList(List<ComnCodeVo> allComnCodeList) {
//		synchronized (CodeUtil.allComnCodeList) {
//			// 코드의 캐쉬교체와 가져다 사용하는 로직은 중복되어 실행되지 않게 한다.
//			CodeUtil.allComnCodeList.clear();
//			CodeUtil.allComnCodeList.addAll(allComnCodeList);
//		}
//	}
//
//	private static ComnCodeVo getCode(String cdId, Object def) {
//		Optional<ComnCodeVo> result = null;
//		Optional<ComnCodeVo> endNode = null;
//		if(!StringUtils.isEmpty(cdId)) {
//			synchronized (CodeUtil.allComnCodeList) {
//				/*** Lambda 표현식으로 검색처리함. 검색은 병렬로 검색하여 코드량이 많아질 경우를 대비함. ***/
//				// 원하는 코드를 검색함.
//				result = CodeUtil.allComnCodeList.stream().filter(c-> c.getCdId().equals(cdId)).findFirst().map(c-> {
//// 	재귀호출에 의한 Ajax참조 무한루프 문제가 있어 제거함. // 원하는 코드의 상위코드를 삽입해준다.
////					Optional<ComnCodeVo> upCode = CodeUtil.allComnCodeList.stream().filter(p-> p.getCdId().equals(c.getUpCdId())).findFirst();
////					if(!upCode.isEmpty())
////						c.setUpComnCodeVo(upCode.get());
//					return c.clone();
//				});
//				
//				//하위 검색결과가 없는 경우 본인의 코드를 리턴하기 위함 jkkim 2020-03-27
////				endNode = result;
//				
//				// 검색된 코드의 하위코드를 검색함.
//				result.ifPresent(c-> CodeUtil.allComnCodeList.stream()
//						.filter(sub-> sub.getUpCdId()!=null && sub.getUpCdId().equals(cdId)).forEach(sub-> c.addSubCode(sub)));
//				
//				//하위 검색결과가 없는 경우 요청코드의 검색결과를 리턴한다. jkkim 2020-03-27
////				if(result.isEmpty()) {
////					result = endNode;
////				}
//			}
//			AsyncUtil.callService("comnCodeService", "reflashComnCodeAll");
//			if(!StringUtils.isEmpty(result) && result.isPresent()) {
//				return result.get();
//			}
//		}
//		if(StringUtils.isEmpty(def)) {
//			return null;
//		} else if(def instanceof Integer) {
//			int defNum = ((Integer) def).intValue();
//			return new ComnCodeVo(cdId, cdId, "코드조회결과가 존재하지 않아 기본값으로 대체함", defNum+"", defNum);
//		} else {
//			return new ComnCodeVo(cdId, cdId, "코드조회결과가 존재하지 않아 기본값으로 대체함", def+"", 0);
//		}
//	}
//
//	public static ComnCodeVo getCode(String cdId) {
//		return getCode(cdId, null);
//	}
//
//	public static ComnCodeVo getCode(String cdId, String defVal) {
//		return getCode(cdId, (Object)defVal);
//	}
//
//	public static ComnCodeVo getCode(String cdId, int defNum) {
//		return getCode(cdId, Integer.valueOf(defNum));
//	}
}
