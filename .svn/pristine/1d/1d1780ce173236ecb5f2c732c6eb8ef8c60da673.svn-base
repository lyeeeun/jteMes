package kr.co.itcall.jte.spring.config.jpa;

import java.time.LocalDateTime;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.EntityListeners;
import javax.persistence.MappedSuperclass;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;

/**
 * @author haeng
 * @see The following AuditModel class will be extended by other entities. It
 *      contains @EntityListeners(AuditingEntityListener.class) annotation that
 *      will automatically populate createdAt and updatedAt values when the
 *      entities are persisted.
 */

@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
@JsonIgnoreProperties(value = { "createdAt", "updatedAt" }, allowGetters = true)
@Getter
public abstract class JpaModel {
	
	@Column(name = "created_at", nullable = false, updatable = false)
	@CreatedDate
	private Date createdAt;

	@Column(name = "updated_at", nullable = false)
	@LastModifiedDate
	private Date updatedAt;

	public void clone(JpaModel vo) {
		this.createdAt = vo.getCreatedAt();
		this.updatedAt = vo.getUpdatedAt();
	}

	// Getters and Setters (Omitted for brevity)

}
