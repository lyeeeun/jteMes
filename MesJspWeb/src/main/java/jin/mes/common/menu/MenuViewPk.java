package jin.mes.common.menu;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@Embeddable
@NoArgsConstructor
public class MenuViewPk implements Serializable {

	private static final long serialVersionUID = 6154600839130643454L;

	public MenuViewPk(String menuId, String roleId) {
		super();
		this.menuId = menuId;
		this.roleId = roleId;
	}

	@Column(nullable = false/* columnDefinition="VARCHAR(50) NOT NULL COMMENT '메뉴VIEW용.고유ID.'" */)
	@Size(min = 3, max = 50)
	private String menuId;

	@Column(length = 50, nullable = false/* columnDefinition="VARCHAR(50) NOT NULL COMMENT '권한그룹정보별로 메뉴가 그려짐.'" */)
	private String roleId;

}
