package com.aurospaces.neighbourhood.db.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import com.aurospaces.neighbourhood.bean.StudentBean;
import com.aurospaces.neighbourhood.db.basedao.BaseEventDao;
import com.aurospaces.neighbourhood.db.callback.RowValueCallbackHandler;

@Repository(value = "EventDao")
public class EventDao extends BaseEventDao {
	public List<Map<String, String>> getEvents(StudentBean objStudentBean ){
		 StringBuffer objStringBuffer = new StringBuffer();
		 objStringBuffer.append("select s.id as studentId,s.name as studentName,Date(nt.created_time) as absentDate,nt.message ,"
		 		+ "ct.name as className,st.name as sectionName,bn.name as boardName,s.admissionNum from notification nt,student s,classtable ct,sectiontable st,boardname bn,mediam m where " 
				 	+" s.id=nt.studentId and s.section=st.id and "
				 	+" s.className=ct.id and st.id=s.section and s.boardName=bn.id and m.id=s.medium ");
		if (StringUtils.isNotBlank(objStudentBean.getBoardName())) {
			objStringBuffer.append(" and bn.id=" + objStudentBean.getBoardName());
		}
		if (StringUtils.isNotBlank(objStudentBean.getClassName())) {
			objStringBuffer.append(" and ct.id=" + objStudentBean.getClassName());
		}
	
		if (StringUtils.isNotBlank(objStudentBean.getSection())) {
			objStringBuffer.append(" and st.id=" + objStudentBean.getSection());
		}
		if (StringUtils.isNotBlank(objStudentBean.getMedium())) {
			objStringBuffer.append(" and m.id=" + objStudentBean.getMedium());
		}
		if (StringUtils.isNotBlank(objStudentBean.getDob1()) && StringUtils.isNotBlank(objStudentBean.getDob2() )) {
			objStringBuffer.append("  and  Date(nt.created_time) BETWEEN '"+objStudentBean.getDob1() +"' AND '"+objStudentBean.getDob2()+"' " );
		}
		
String sql = objStringBuffer.toString();
			System.out.println(sql);
			RowValueCallbackHandler handler = new RowValueCallbackHandler(new String[] { "studentId","studentName","absentDate","message","className",
					"sectionName","boardName","admissionNum"});
			jdbcTemplate.query(sql, handler);
			List<Map<String, String>> result = handler.getResult();
			return result;
			
		}

}
