package org.joonzis.mybatis;

import org.apache.ibatis.session.SqlSession;

public class BDao {
	//필드
	private static SqlSession sqlsession = null;
	
	//싱글톤
	private synchronized static SqlSession getSqlSession() {
		if (sqlsession == null) {
			//factory를 선언하지 않고 바로 sqlseesion을 만든다.
			sqlsession = DBService.getFactory().openSession(false);
			// open Session(false) 수동 커밋 -> 기본 값을 수동 커밋 상태로 세션을 가져옴
		}
		return sqlsession;
	}
}
