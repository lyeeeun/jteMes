package kr.co.itcall.jte.pms.model.support;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EntityListeners;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import kr.co.itcall.jte.spring.config.jpa.JpaBizModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
@Data
@EqualsAndHashCode(callSuper=false)
public class PmsBaseInfoModel extends JpaBizModel implements Serializable {

	private static final long serialVersionUID = -744182350956243945L;

	// Columbia_Axia_Termonorte_Engine08
	
	@Id
	@Column(name="nation_id", length=15, nullable=false)
	private String nationId;

	@Id
	@Column(name="company_id", length=15, nullable=false)
	private String companyId;

	@Id
	@Column(name="area_id", length=15, nullable=false)
	private String areaId;

	@Id
	@Column(name="engine_model", length=15, nullable=false)
	private String engineModel;

//	@Column(columnDefinition = "text")
//	private String description;

}
