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
	
	public static List<CVO> selectAll(int b_idx) {
		return getSqlSession().selectList("select_all_comment", b_idx); 
	}
	
	public static int insertComment(CVO cvo) {
		int result = getSqlSession().insert("insert_comment", cvo);
		if (result > 0) {
			getSqlSession().commit();
		}
		return result;
	}
	
	public static int removeComment(int c_idx) {
		int result = getSqlSession().delete("remove_comment", c_idx);
		if (result > 0) {
			getSqlSession().commit();
		}
		return result;
	}
}
