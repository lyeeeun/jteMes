package jin.mes.common;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

@Repository("abstractDAO")
public class AbstractDAO {
	protected Log log = LogFactory.getLog(AbstractDAO.class);
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private DataSourceTransactionManager transactionManager;
	private DefaultTransactionDefinition def = new DefaultTransactionDefinition();
	private TransactionStatus status = null;
	
	public void setTransaction(){
		def.setName("abstract-transaction");
		def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED);
		status = transactionManager.getTransaction(def);
	}
	
	protected void printQueryId(String queryId){
		if(log.isDebugEnabled()){
			log.debug("\t Query Id \t : " + queryId);
		}
	}
	
	public HashMap setBaseParameter(Object params){
		HashMap param = (HashMap)params;
		
		if(request.getSession().getAttribute("USER_NO") != null){
			if(param.get("REG_USER_NO") == null){
				param.put("REG_USER_NO", request.getSession().getAttribute("USER_NO").toString().toUpperCase());
			}
			
			if(param.get("REG_USER_ID") == null){
				param.put("REG_USER_ID", request.getSession().getAttribute("USER_NO").toString().toUpperCase());
			}
			
			if(param.get("UPD_USER_NO") == null){
				param.put("UPD_USER_NO", request.getSession().getAttribute("USER_NO").toString().toUpperCase());
			}
			
			if(param.get("UPD_USER_ID") == null){
				param.put("UPD_USER_ID", request.getSession().getAttribute("USER_NO").toString().toUpperCase());
			}
		}
		
		if(param.get("CTR_CD") == null || param.get("CTR_CD").equals("")){
			param.put("CTR_CD", request.getSession().getAttribute("CTR_CD"));
		}
		
		if(param.get("COMP_CD") == null || param.get("COMP_CD").equals("")){
			param.put("COMP_CD", request.getSession().getAttribute("COMP_CD"));
		}
		
		return param;
	}
	
	public Object insert(String queryId, Object params){
		printQueryId(queryId);
		return sqlSession.insert(queryId, setBaseParameter(params));
	}
	
	public Object update(String queryId, Object params){
		printQueryId(queryId);
		return sqlSession.update(queryId, setBaseParameter(params));
	}
	
	public Object delete(String queryId, Object params){
		printQueryId(queryId);
		return sqlSession.delete(queryId, setBaseParameter(params));
	}
	
	public Object selectOne(String queryId){
		printQueryId(queryId);
		return sqlSession.selectOne(queryId);
	}
	
	public Object selectOne(String queryId, Object params){
		printQueryId(queryId);
		return sqlSession.selectList(queryId, params);
	}
	
	@SuppressWarnings("rawtypes")
	public List selectList(String queryId){
		printQueryId(queryId);
		return sqlSession.selectList(queryId);
	}
	
	@SuppressWarnings("rawtypes")
	public List selectList(String queryId, Object params){
		printQueryId(queryId);
		return sqlSession.selectList(queryId, setBaseParameter(params));
	}
	
	public void commit(){
		transactionManager.commit(status);
	}
	
	public void rollback(){
		transactionManager.rollback(status);
	}
	
	public Connection getConnection() {
		return sqlSession.getConnection();
	}
	
	public SqlSessionFactory getSqlSession() {
		return sqlSession.getSqlSessionFactory();
	}
	
	public SqlSession getSession() {
		return sqlSession;
	}
}
