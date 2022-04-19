package jin.mes.common.menu;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import kr.co.itcall.jte.spring.config.jpa.JpaBizModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "cw_menu_bas")
@Data
@EqualsAndHashCode(callSuper=false)
/**
 * <pre>
 * <b>jin.mes.common</b>
 * <b>MenuInfoModel.java</b>
 * <p>Descriptions : 서비스 및 정지 중인 현재 메뉴FORM 서비스 기본리스트</p>
 * </pre>
 * 
 * @author  : khaeng@nate.com
 * @Date    : 2019. 11. 27.
 * @Version :
 */
public class MenuInfoModel extends JpaBizModel implements Serializable {

	private static final long serialVersionUID = -53564414635101167L;

	@Id
	@Size(min = 3, max = 50)
	private String menuId;

	@Column(nullable = true/* columnDefinition="VARCHAR(50) NULL COMMENT '부모메뉴VIEW_ID.'" */)
	@Size(min = 3, max = 50)
	private String upMenuId;
	
	@NotBlank
	@NotNull
	@Column
	private String menuNm;
	
	@Column@Size(max=100)//@ManyToOne
	private String msgId;
	
	@Column(length=1)
	/**
	 * M, F : (중)메뉴, 폼(화면)
	 */
	private String menuCd = "M";
	
	@Column(columnDefinition = "text")
	private String description;
	
	@NotBlank
	@NotNull
	@Column
	private String svcUrl;

	@NotBlank
	@NotNull
	@Column
	private String viewUrl;

	@Column(nullable = false)
	private int menuSeq = 1;

	/**
	 * 폼 중복화면 열기 여부
	 */
	@Column(length=1, nullable=true)
	private String duplYn = "N";
	
	@Column(length = 1, nullable = false/* , columnDefinition = "char(1) default 'N' not null" */)
	private boolean isDel = false;

	@Column(length=1, nullable = false)
	private boolean isLock = false;

	

}
