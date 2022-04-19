package kr.co.itcall.jte.spring.user.model;

import java.io.Serializable;

import javax.persistence.Column;

import jin.mes.form.basMgt.authMgt.authInfo.AuthInfoModel;




public class RtlRoleAuthId implements Serializable{/**
	 * 
	 */
	private static final long serialVersionUID = -1646030148870914729L;
	
	private AuthInfoModel authInfo;
	
	private RoleInfoVo roleInfo;
	
}
