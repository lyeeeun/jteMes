package jin.mes.common.menu;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import kr.co.itcall.jte.spring.config.jpa.JpaBizModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "cw_menu_view")
@Data
@EqualsAndHashCode(callSuper=false)
/**
 * <pre>
 * <b>jin.mes.common.menu</b>
 * <b>MenuViewModel.java</b>
 * <p>Descriptions : </p>
 * </pre>
 * 
 * @author  : khaeng@nate.com
 * @Date    : 2019. 11. 27.
 * @Version :
 */
public class MenuViewModel extends JpaBizModel implements Serializable {

	private static final long serialVersionUID = -1995731221557253125L;

	@EmbeddedId
	private MenuViewPk menuViewPk;
	
//	@Column
//	private String menuNm;
//	
//	@Column@Size(max=100)//@ManyToOne
//	private String msgId;
//
//	@Column(columnDefinition = "text")
//	private String description;
	
//	@Column(nullable=false, columnDefinition="COMMENT '메인메뉴의 순서번호(자신이 어떤 최상위메뉴에 소속되어있는지의 정보)'")
//	private int menuNum; // 메인메뉴 순서번호
//
//	@Column(nullable=false, columnDefinition="COMMENT '메뉴의 DEPTH값이 며, 최초 1부터 시작하여 내려간다.'")
//	private int menuLvl; // Depth



}
