package jin.mes.form.basMgt.codMgt.msgMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.querydsl.core.QueryResults;
import com.querydsl.core.types.dsl.PathBuilder;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;

import jin.mes.common.msg.MsgViewModel;
import jin.mes.common.msg.MsgViewPk;
import jin.mes.common.msg.QMsgViewModel;
import jin.mes.mapper.basMgt.codMgt.msgMgt.MsgMgtMapper;
import kr.co.itcall.jte.common.mvc.CustomQueryDslSupport;
import kr.co.itcall.jte.common.mvc.KendoPageVO;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class MsgMgtServiceImpl extends CustomQueryDslSupport {
	
	public MsgMgtServiceImpl() {
		super(MsgViewModel.class);
	}
	
	@Resource
	MsgMgtRepository msgMgtRepository;
	
	@Resource
	MsgMgtMapper msgMapper;
	
	Pageable pageable = null;
	
	/* @Override */
	public Page<MsgViewModel> getMsgList(KendoPageVO pageVO){
		//QureyDsl
		JPAQueryFactory query = new JPAQueryFactory(this.getEntityManager());
		
		final QMsgViewModel msgViewModel = QMsgViewModel.msgViewModel;
		
		QueryResults<MsgViewModel> result = null;
		 
		try {
			//동적처리를 위한 PathBuilder
			PathBuilder<QMsgViewModel> entityPath = new PathBuilder<>(QMsgViewModel.class, "msgViewModel");
			
			//동적처리를 위한 Builder(where)
			/* BooleanBuilder builder = new BooleanBuilder(); */
			
			JPAQuery<MsgViewModel> jpaQuery = query.selectFrom(msgViewModel);
			
			//페이징
			pageable = PageRequest.of(pageVO.getPage()-1, pageVO.getRows());
			
			//검색(공통) 
			this.dynamicSearch(pageVO, jpaQuery, entityPath);
			//기간검색(공통)
			/* this.periodSearch(pageVO, jpaQuery, entityPath); */
			//정렬(공통)
			this.multiSort(pageVO, jpaQuery, entityPath);
			
			result = jpaQuery 
					.offset(pageable.getOffset()).limit(pageable.getPageSize())
					.fetchResults();
			
		}catch(Exception ex){
			ex.printStackTrace();
		}	
		return new PageImpl<>(result.getResults(), pageable, result.getTotal());
	}
	
	/**<pre>
	 * 1. 개요 : 다국어 저장
	 * 2. 처리내용 : 
	 * </pre>
	 * @Method : saveMsg
	 * @param msgMgtModel
	 * @return
	 */
	
	@Transactional
	public List<MsgViewModel> saveMsg(MsgViewModel msgViewModel){
		return msgMgtRepository.saveAll(msgViewModel.getMsgList());
	}
	
	@Transactional
	public int updateMsg(List<MsgViewModel> msgModel){
		int resultInt = 0;
		try {
			msgMgtRepository.saveAll(msgModel);
		}catch(Exception ex) {
			resultInt = -1;
			throw new BusinessException("다국어 저장 에러  : "+ex.getMessage());
		}
		return resultInt;
	}
	
	public int pgSaveMsg(List<MsgViewModel> msgModel,String gubun, String pgId){
		int resultInt = 0;
		try {
			List<MsgViewModel> msgList = new ArrayList<MsgViewModel>();
			//기존 다국어가 없는 경우 키 생성 
			for(MsgViewModel msg : msgModel) {
				if(msg.getMsgViewPk().getMsgId() == null || msg.getMsgViewPk().getMsgId().equals("")) {
					MsgViewPk msgPk = new MsgViewPk(gubun+"_"+pgId, msg.getMsgViewPk().getLangCd());
					msg.setMsgViewPk(msgPk);
					msgList.add(msg);
				}else {
					msgList.add(msg);
				}
			}
			//저장
			resultInt = updateMsg(msgList);
		}catch(Exception ex) {
			resultInt = -1;
			throw new BusinessException("다국어 저장 에러  : "+ex.getMessage());
		}
		return resultInt;
	}
	
	@Transactional
	public int deleteMsg(List<MsgMgtDto> msgMgtDto){
		int resultInt = 0;
		try {
			msgMgtDto.forEach(x -> {
				msgMgtRepository.deleteByMsgId(x.getMsgId());
			});
		}catch (Exception e) {
			resultInt = -1;
			// TODO: handle exception
			throw new BusinessException("다국어 삭제 에러  : "+e.getMessage());
		}
		return resultInt;
	}

	
	public PageInfo<MsgMgtDto> getMsgMergeList(MsgMgtDto msgMgtDto, PageRequestVo pageRequestVo){
		List<MsgMgtDto> msgList = null;
		int rowCount = 0;

		// Page Setting
		msgMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		msgMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		msgMgtDto.setLangCd(JteUtils.getMyLocale().getLanguage());
		try {
			//Count
			rowCount = msgMapper.selectMsgListCount(msgMgtDto);
			if (rowCount > 0) {
				//List
				msgList = msgMapper.selectMsgList(msgMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("다국어 조회 에러  : "+e.getMessage());
		}
		if (msgList == null) {
			msgList = new ArrayList<MsgMgtDto>();
		}
		return new PageInfo<MsgMgtDto>(msgList, pageRequestVo, rowCount);
	}
	
	public List<MsgMgtDto> getMsgMergeOne(MsgMgtDto msgMgtDto){
		List<MsgMgtDto> msgList = null;
		try {
			//List
			msgList = msgMapper.selectMsgOne(msgMgtDto);
		} catch (Exception e) {
			throw new BusinessException("다국어 조회 에러 : " + e.getMessage());
		}
		if (msgList == null) {
			msgList = new ArrayList<MsgMgtDto>();
		}
		return msgList;
	}
}
