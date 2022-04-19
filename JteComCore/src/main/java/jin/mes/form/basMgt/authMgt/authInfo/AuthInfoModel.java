package jin.mes.form.basMgt.authMgt.authInfo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import kr.co.itcall.jte.spring.config.jpa.JpaBizModel;
import kr.co.itcall.jte.spring.user.model.RoleInfoVo;
import kr.co.itcall.jte.spring.user.model.RtlRoleAuth;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class)
@Table(name = "mb_auth_bas")
//@Data
@Getter @Setter @ToString(exclude= "roleInfos")
@AllArgsConstructor @NoArgsConstructor
@EqualsAndHashCode(callSuper=false)
/**
 * <pre>
 * <b>jin.mes.common.auth</b>
 * <b>AuthInfoModel.java</b>
 * <p>Descriptions : 권한기본리스트 - 접근서비스별로 ID를 지정하여 Princple에 넣어둔다.</p>
 * </pre>
 * 
 * @author  : khaeng@nate.com
 * @Date    : 2019. 11. 27.
 * @Version :
 */
public class AuthInfoModel extends JpaBizModel implements Serializable {

	private static final long serialVersionUID = -4517431058652868477L;

	@Id
	@Size(min = 3, max = 100)
	private String authId;

	@Column(unique=true)
	private String reqSvcUri;

	@Column(columnDefinition = "text")
	private String description;
	
	@Transient
	private boolean isUse;
	
	@OneToMany(fetch=FetchType.LAZY, cascade= {CascadeType.PERSIST,CascadeType.MERGE}, mappedBy="authInfo")
	@JsonManagedReference
	private List<RtlRoleAuth> roleInfos;
	
	
//	@ManyToMany
//	@JoinTable(name = "mb_rtl_role_auth"
//		, joinColumns = { @JoinColumn(name = "authId", nullable = false, unique=false /** 생략하면 PRIMARY.KEY가 자동지정된다. **/ ) }
//		, inverseJoinColumns = { @JoinColumn(name = "roleId", nullable = false, unique=false /** 생략하면 PRIMARY.KEY가 자동지정된다. **/ ) }
//	)
//	private Set<RoleInfoVo> roleInfos;
}
