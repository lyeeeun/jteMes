package jin.mes.common.menu;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface MenuViewRepository extends JpaRepository<MenuViewModel, MenuViewPk> {

//	public List<MenuViewModel> findByMenuViewPkRoleIdAndIsLockFalse(String roleId);
//
//	public List<MenuViewModel> findByMenuViewPkRoleIdInAndIsLockFalse(List<String> roleIds);
//
//	public List<MenuViewModel> findByMenuViewPkRoleIdNotInAndIsLockFalse(List<String> roleIds);
//
//	public List<MenuViewModel> findByMenuViewPkRoleIdInAndIsLockFalseOrderByMenuViewPkViewIdAsc(List<String> roleIds);

	/**
	 * 	@Column(nullable=false, columnDefinition="COMMENT '메인메뉴의 순서번호(자신이 어떤 최상위메뉴에 소속되어있는지의 정보)'")
	private int menuNum; // 메인메뉴 순서번호

	@Column(nullable=false, columnDefinition="COMMENT '메뉴의 DEPTH값이 며, 최초 1부터 시작하여 내려간다.'")
	private int menuLvl; // Depth

	@Column(nullable=false, columnDefinition="COMMENT '동일레벨의 메뉴에서 메뉴의 표시순서, 최초 1부터 시작하여 내려간다.'")
	private int menuSeq; // 표시순서
	 */
}
