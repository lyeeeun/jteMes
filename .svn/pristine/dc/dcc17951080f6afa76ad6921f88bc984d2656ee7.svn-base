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
@Table(name = "mb_position_info")
@Getter @Setter
@AllArgsConstructor @NoArgsConstructor
@EqualsAndHashCode(callSuper=false)
public class PositionInfoVo extends JpaBizModel implements Serializable {

	private static final long serialVersionUID = 8966494551574119541L;

	@Id
	@Size(min = 2, max = 15)
	@Column(unique=true)
	private String positionId;

	@NotBlank
	@NotNull
	@Column(length=50)
	private String positionNm;

	@NotNull
	@ColumnDefault("0")
	private int positionSeq;
	
	@NotNull
	private boolean isUse;
	
	//예비
	@ColumnDefault(value = "0")
	private float posStd01;
	@ColumnDefault(value = "0")
	private float posStd02;
	@ColumnDefault(value = "0")
	private float posStd03;
	@ColumnDefault(value = "0")
	private float posStd04;
	@ColumnDefault(value = "0")
	private float posStd05;
	@Column (length=100)
	private String posStdStr01;
	@Column (length=100)
	private String posStdStr02;
	@Column (length=100)
	private String posStdStr03;
	@Column (length=100)
	private String posStdStr04;
	@Column (length=100)
	private String posStdStr05;
}
