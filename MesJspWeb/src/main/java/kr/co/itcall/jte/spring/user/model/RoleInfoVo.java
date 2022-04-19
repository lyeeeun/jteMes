package kr.co.itcall.jte.spring.user.model;

import java.io.Serializable;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

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
@JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class)
@Table(name = "mb_role_info"/* , schema="public" */)
//@Data
@Getter @Setter @ToString(exclude= "authInfos")
@AllArgsConstructor @NoArgsConstructor
@EqualsAndHashCode(callSuper=false)
public class RoleInfoVo extends JpaBizModel implements Serializable {

	private static final long serialVersionUID = 4731644159348907575L;

	public RoleInfoVo(String roleId) {
		this.roleId = roleId;
	}
	
//	@Id
//	@GeneratedValue(generator = "sq_role_info_generator")
//	@SequenceGenerator(name = "sq_role_info_generator", sequenceName = "sq_role_info_sequence", initialValue = 5000, allocationSize = 1)
//	private Long id;

	@Id
	@Size(min = 3, max = 50)
	private String roleId;

	@NotBlank
	@Size(min = 3, max = 100)
	private String roleNm;

	@Column(columnDefinition = "text")
	private String description;

	@OneToMany(fetch=FetchType.LAZY, cascade= {CascadeType.PERSIST,CascadeType.MERGE}, mappedBy="roleInfo")
	@JsonManagedReference
	private List<RtlRoleAuth> authInfos;
	
//	@ManyToMany(mappedBy = "roles")
//	// @OneToMany(mappedBy = "roles")
//	private Set<UserInfoVo> users = new HashSet<UserInfoVo>();;

//	// @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER)
//	// @ManyToOne(cascade=CascadeType.ALL, fetch=FetchType.EAGER)
//	@ManyToMany(fetch=FetchType.LAZY, cascade= {CascadeType.PERSIST,CascadeType.MERGE})
//	@JoinTable(name = "mb_rtl_role_auth"
//			, joinColumns =        { @JoinColumn(name = "roleId", nullable = false, referencedColumnName = "roleId", unique=false /** 생략하면 PRIMARY.KEY가 자동지정된다. **/ ) }
//			, inverseJoinColumns = { @JoinColumn(name = "authId", nullable = false, referencedColumnName = "authId", unique=false /** 생략하면 PRIMARY.KEY가 자동지정된다. **/ ) }
//	)
//	
//	private Set<AuthInfoModel> authInfos;
//	
//	// @JsonIgnore
//	@Transient/	private Set<AuthInfoModel> authInfos;
//	@ManyToMany(fetch=FetchType.LAZY, cascade={CascadeType.PERSIST,CascadeType.MERGE})
//	@JoinTable(name = "mb_rtl_role_auth"
//			, joinColumns =        { @JoinColumn(name = "roleId", nullable = false, unique=false /** 생략하면 PRIMARY.KEY가 자동지정된다. **/ ) }
//			, inverseJoinColumns = { @JoinColumn(name = "authId", nullable = false, unique=false /** 생략하면 PRIMARY.KEY가 자동지정된다. **/ ) }
//	)
//	private Set<AuthInfoModel> authInfos;


}
