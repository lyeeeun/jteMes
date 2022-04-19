package kr.co.itcall.jte.spring.config.jpa;

import javax.persistence.Column;
import javax.persistence.EntityListeners;
import javax.persistence.MappedSuperclass;

import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * <b>kr.co.itcall.jte.spring.config.jpa</b>
 * <b>JpaBizModel.java</b>
 * <p>Descriptions : </p>
 * </pre>
 * 
 * @author  : khaeng@nate.com
 * @Date    : 2019. 5. 15.
 * @Version :
 */
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
// @JsonIgnoreProperties(value = { "creatorId", "updatorId" }, allowGetters = true)
@Data
@EqualsAndHashCode(callSuper=false)
public abstract class JpaBizModel extends JpaModel {

	@Column(name = "creator_id", nullable = false, updatable = false, length=50)
	@CreatedBy
	private String creatorId;

	@Column(name = "updator_id", nullable = false, length=50)
	@LastModifiedBy
	private String updatorId;

	public void clone(JpaBizModel vo) {
		this.creatorId = vo.getCreatorId();
		this.updatorId = vo.getUpdatorId();
		super.clone(vo);
	}

	// Getters and Setters (Omitted for brevity)

}
