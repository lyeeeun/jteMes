package jin.mes.common.cache;

import java.io.Serializable;
import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import jin.mes.form.basMgt.codMgt.baseCodeMgt.BaseCodeMgtDto;
import jin.mes.form.basMgt.codMgt.pageSet.PageSetDto;
import jin.mes.form.basMgt.codMgt.popSet.PopSetDto;
import jin.mes.form.basMgt.menuMgt.menuInfo.MenuInfoDto;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CacheDto implements Serializable {
	
	private static final long serialVersionUID = 4885489100012365961L;

	private List<BaseCodeMgtDto> baseCodeMgtDto;
	
	private List<MenuInfoDto> menuInfoDto;
	
	private List<MsgViewModel> msgViewDto;
	
	private List<PageSetDto> pageSetDto;
	
	private List<PopSetDto> popSetDto;
}
