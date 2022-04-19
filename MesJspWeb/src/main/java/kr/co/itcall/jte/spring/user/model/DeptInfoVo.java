package kr.co.itcall.jte.spring.user.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.annotations.ColumnDefault;

import kr.co.itcall.jte.spring.config.jpa.JpaBizModel;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "mb_dept_info")
@Getter @Setter
@AllArgsConstructor @NoArgsConstructor
@EqualsAndHashCode(callSuper=false)
public class DeptInfoVo extends JpaBizModel implements Serializable {

	private static final long serialVersionUID = -4543754631615670L;

	@Id
	@Size(min = 2, max = 15)
	@Column(unique=true)
	private String deptId;

	@NotBlank
	@NotNull
	@Column(length=50)
	private String deptNm;

	@NotNull
	@ColumnDefault("0")
	private int deptSeq;
	
	@NotNull
	private boolean isUse;
	
}
