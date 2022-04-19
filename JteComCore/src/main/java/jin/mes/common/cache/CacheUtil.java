package jin.mes.common.cache;

import java.util.List;

import jin.mes.form.basMgt.codMgt.baseCodeMgt.BaseCodeMgtDto;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CacheUtil {
	
	public static CacheDto cache_body = new CacheDto();
	
	//캐시불러오기
	public static CacheDto getCacheList(){
		return cache_body;
	}

	//캐시불러오기
	public static BaseCodeMgtDto getCode(String code, Object def){
		
		List<BaseCodeMgtDto> baseCodeList = cache_body.getBaseCodeMgtDto();
		
		BaseCodeMgtDto returnCode = null;
		if(baseCodeList != null) {
			for(BaseCodeMgtDto baseCodeDto : baseCodeList) {
				if(baseCodeDto.getCdId().equals(code)) {
					returnCode = baseCodeDto;
					break;
				}
			}
		}
		
		if(returnCode == null) {
			returnCode =  new BaseCodeMgtDto(code, code, def+"");
		}
		
		return returnCode;
	}
	
	public static BaseCodeMgtDto getCode(String code){
		return getCode(code, "");
	}
}
