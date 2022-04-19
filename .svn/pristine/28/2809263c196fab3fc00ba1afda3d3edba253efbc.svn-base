package jin.mes.common.menu;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

/**
 * <pre>
 * <b>jin.mes.common.menu</b>
 * <b>MyMenuVo.java</b>
 * <p>Descriptions : view_id, up_view_id, menu_cd, lvl, id_path, menu_id, menu_seq, msg_id, svc_url, view_url, lang_cd, msg_view</p>
 * </pre>
 * 
 * @author  : khaeng@nate.com
 * @Date    : 2019. 12. 5.
 * @Version :
 */
@Entity
@Data
public class MyMenuVo implements Serializable{
	
	private static final long serialVersionUID = 5339743322500662352L;
	@Id
	private String menuId;
	private String upMenuId ;
	private String menuPath;
	private String menuNm; 
	private String svcUrl; 
	private String viewUrl; 
	private String description;
	private String duplYn;
	private String menuCd;
}
