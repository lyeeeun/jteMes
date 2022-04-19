package kr.co.itcall.jte.spring.user.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import kr.co.itcall.jte.spring.config.jpa.JpaBizModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "mb_role_info"/* , schema="public" */)
@Data /* final 멤버변수는 자동으로 생성자를 생성해준다. final이 아닌경우는 생성자생성을 위해 지정해야 한다.*/
@EqualsAndHashCode(callSuper=false)
public class RoleInfoVo extends JpaBizModel implements Serializable {

	private static final long serialVersionUID = 4731644159348907575L;

//	@Id
//	@GeneratedValue(generator = "sq_role_info_generator")
//	@SequenceGenerator(name = "sq_role_info_generator", sequenceName = "sq_role_info_sequence", initialValue = 5000, allocationSize = 1)
//	private Long id;

	@Id
	@Size(min = 3, max = 50)
	private String roleId;

//	@NotBlank
//	@Size(min = 3, max = 100)
//	private String roleNm;

	@Column(columnDefinition = "text")
	private String description;

//	@ManyToMany(mappedBy = "roles")
//	// @OneToMany(mappedBy = "roles")
//	private Set<UserInfoVo> users = new HashSet<UserInfoVo>();;

	public RoleInfoVo() {
	}

	public RoleInfoVo(String roleId) {
		this.roleId = roleId;
	}

}
