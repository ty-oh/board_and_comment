package org.joonzis.mybatis;

import java.util.List;

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
	
	public static List<BVO> getList() {
		return getSqlSession().selectList("list_bbs");
	}
	
}
