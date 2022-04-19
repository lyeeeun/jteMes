package kr.co.itcall.jte.spring.user.model;

import java.io.Serializable;
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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.annotations.ColumnDefault;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import kr.co.itcall.jte.spring.config.jpa.JpaBizModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
//@JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class)
@Table(name = "mb_user_info"/* , schema="public" */)
@Getter @Setter @ToString(exclude={"roles"})
@AllArgsConstructor @NoArgsConstructor
@EqualsAndHashCode(callSuper=false)
public class UserInfoVo extends JpaBizModel implements Serializable {

	private static final long serialVersionUID = 1943748841889698610L;

//	@Id
//	@GeneratedValue(generator = "sq_user_info_generator")
//	@SequenceGenerator(name = "sq_user_info_generator", sequenceName = "sq_user_info_sequence", initialValue = 1000, allocationSize = 1)
//	private Long id;
	
	// @NotBlank
	@Id
	@Size(min = 3, max = 50)
	@Column(unique=true)
	private String userId;

	@NotBlank
	@Size(min = 3, max = 50)
	private String userNm;

	@NotBlank
	@Size(min = 8, max = 250)
	private String password;

	@Column(columnDefinition = "text")
	private String description;

	// @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER)
	// @ManyToOne(cascade=CascadeType.ALL, fetch=FetchType.EAGER)
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY) /* UserInfoVo와 roles가 동시조회가 안되므로. Fetch 설정을 즉시 로딩(EAGER)으로 설정하여 권한리스트를 가져올 수 있게 한다. */
	@JoinTable(name = "mb_rtl_user_role"
			, joinColumns =        { @JoinColumn(name = "userId", nullable = false, referencedColumnName = "userId", unique=false /** 생략하면 PRIMARY.KEY가 자동지정된다. **/ ) }
			, inverseJoinColumns = { @JoinColumn(name = "roleId", nullable = false, referencedColumnName = "roleId", unique=false /** 생략하면 PRIMARY.KEY가 자동지정된다. **/ ) }
	)
	// @JsonIgnore
	private Set<RoleInfoVo> roles;

//	@ElementCollection(targetClass = RtlUserRoleVo.class, fetch = FetchType.LAZY)
//	@CollectionTable(name = "mb_rtl_user_role", joinColumns = @JoinColumn(name = "user_id", nullable = false/* , referencedColumnName = "username" 생략하면 PRIMARY.KEY가 자동지정된다. */))
//	@Column(name = "roles")
////	@JoinTable(name = "mb_rtl_user_role", joinColumns = @JoinColumn(name = "user_id", nullable = false/* , referencedColumnName = "username" 생략하면 PRIMARY.KEY가 자동지정된다. */))
//	private Set<RoleInfoVo> roles;



	@Column(/* name = "del_yn", */nullable = false/* , columnDefinition = "char(1) default 'N' not null" */)
	private boolean isDel;

	@Column(nullable = false)
	private boolean isLock;

	@Column(/* name = "fail_cnt", length = 8, */nullable = false/* , columnDefinition = "char(1) default 'N' not null" */)
	@ColumnDefault("0")
	private int failCnt;

	
	@ManyToOne(fetch=FetchType.EAGER, cascade= CascadeType.ALL)
	@JoinColumn(name="deptId")
	private DeptInfoVo deptInfo;
	
	@ManyToOne(fetch=FetchType.EAGER, cascade= CascadeType.ALL)
	@JoinColumn(name="positionId")
	private PositionInfoVo positionInfo;

	@NotBlank
	@NotNull
	@Column(length=10)
	/**
	 * 사용자별 접근 언어를 저장한다.
	 */
	private String langCd = "ko";

	@Column(length=120)
	private String testColumn;
}
