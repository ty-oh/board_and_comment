package org.joonzis.mybatis;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public class BDao {
	//필드
	private static SqlSession sqlsession = null;
	
	//싱글톤
	private synchronized static SqlSession getSqlSession() {
		if (sqlsession == null) {
			sqlsession = DBService.getFactory().openSession(false);
		}
		
		return sqlsession;
	}
	
	public static List<BVO> getList(Map<String, Integer> map) {
		return getSqlSession().selectList("list_bbs", map); 
	}
	
	public static BVO getBbs(int b_idx) {
		return getSqlSession().selectOne("one_bbs", b_idx);
	}
	 
	//전체 데이터 개수 가져오기
	public static int totalRecord() {
		return getSqlSession().selectOne("total_record");
	}
	
	public static int insertBbs(BVO vo) {
		int result = getSqlSession().insert("insert_bbs", vo);
		if (result > 0) {
			getSqlSession().commit();
		}
		return result;
	}
	
	public static int updateBbs(BVO vo) {
		int result = getSqlSession().update("update_bbs", vo);
		if (result > 0) {
			getSqlSession().commit();
		}
		return result;
	}
	
	public static int removeBbs(int b_idx) {
		int result = getSqlSession().delete("remove_bbs", b_idx);
		if (result > 0) {
			getSqlSession().commit();
		}
		return result;
	}
	
}
