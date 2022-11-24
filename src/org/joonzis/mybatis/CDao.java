package org.joonzis.mybatis;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

public class CDao {
	private static SqlSession sqlSession = null;
	
	private synchronized static SqlSession getSqlSession() {
		if (sqlSession == null) {
			sqlSession = DBService.getFactory().openSession(false);
		}
		
		return sqlSession;
	}
	
	public static int insertComment(CVO cvo) {
		int result = getSqlSession().insert("insert_comment", cvo);
		if (result > 0) {
			getSqlSession().commit();
		}
		return result;
	}
	
	public static List<CVO> selectAll(int b_idx) {
		return getSqlSession().selectList("select_all_comment", b_idx); 
	}
}
