package kr.co.itcall.jte.spring.user.model;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import jin.mes.form.basMgt.authMgt.authInfo.AuthInfoModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Entity
@Table(name = "mb_rtl_role_auth"/* , schema="public" */)
@Data
@JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class)
@Getter @Setter @ToString(exclude={"authInfo","roleInfo"})
@AllArgsConstructor @NoArgsConstructor
@IdClass(RtlRoleAuthId.class)
public class RtlRoleAuth implements Serializable{/**
	 * 
	 */
	private static final long serialVersionUID = -1646030148870914729L;
	
	@Id
	@ManyToOne(cascade= {CascadeType.PERSIST,CascadeType.MERGE})//(fetch=FetchType.LAZY, cascade= {CascadeType.PERSIST,CascadeType.MERGE})
	@JoinColumn(name="authId")
	@JsonBackReference
	private AuthInfoModel authInfo;
	
	@Id
	@ManyToOne(cascade= {CascadeType.PERSIST,CascadeType.MERGE})//(fetch=FetchType.LAZY, cascade= {CascadeType.PERSIST,CascadeType.MERGE})
	@JoinColumn(name="roleId")
	@JsonBackReference
	private RoleInfoVo roleInfo;
	
}
