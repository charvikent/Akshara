package com.aurospaces.neighbourhood.db.dao;

import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.simple.ParameterizedBeanPropertyRowMapper;
import org.springframework.stereotype.Repository;

import com.aurospaces.neighbourhood.bean.ClassBean;
import com.aurospaces.neighbourhood.bean.FacultyBean;
import com.aurospaces.neighbourhood.bean.FilterBean;
import com.aurospaces.neighbourhood.db.basedao.BaseClassCreationDao;
import com.aurospaces.neighbourhood.db.callback.RowValueCallbackHandler;

@Repository(value = "ClassCreationDao")
public class ClassCreationDao extends BaseClassCreationDao{
	  public List<Map<String, String>> getClassCreationData(){
			
			String sql ="select cr.id as classId,bn.name as bordName,m.name as medium,cr.className ,cr.section,bn.id as borderId,m.id as mediamId,"
					+ " ct.name as cname,st.name as sname,cr.fee from classcreation cr,boardname bn,mediam m,classtable ct,sectiontable st where "
					+ "cr.boardId=bn.id and cr.mediamId=m.id and cr.className=ct.id and st.id=cr.section" ;

			//System.out.println(sql);
			RowValueCallbackHandler handler = new RowValueCallbackHandler(new String[] { "classId","bordName","medium","className","section","borderId","mediamId","cname","sname","fee"});
			jdbcTemplate.query(sql, handler);
			List<Map<String, String>> result = handler.getResult();
			return result;
			
		}
	  
	  public ClassBean getExistingOrNot(ClassBean objClassBean) {
			String sql = "SELECT * from classcreation where boardId = ? and mediamId =? and className=? and section=? ";
			List<ClassBean> retlist = jdbcTemplate.query(sql,
			new Object[]{objClassBean.getBoardId(),objClassBean.getMediumId(),objClassBean.getClassName(),objClassBean.getSection()},
			ParameterizedBeanPropertyRowMapper.newInstance(ClassBean.class));
			if(retlist.size() > 0)
				return retlist.get(0);
			return null;
		}
    
		public List<FilterBean> getClassName(String boardId)
		{

			String query = "select ct.id,ct.name as className from classcreation cc ,classtable ct,boardname bn  "+
                          " where cc.boardId = bn.id and ct.id =cc.className and bn.id= ? group by ct.id ";
			System.out.println(query);
			List<FilterBean> handler = jdbcTemplate.query(query, new Object[]{boardId},ParameterizedBeanPropertyRowMapper.newInstance(FilterBean.class));
			 System.out.println(query);
	     
			 return handler;
	  }
		public List<FilterBean> getSectionFilter(String boardId,String classId)
		{

			String query = "select st.id,st.name as sectionName from classcreation cc ,classtable ct,boardname bn, sectiontable st "
                            +"  where cc.boardId = bn.id and ct.id =cc.className and st.id = cc.section and bn.id= ? and ct.id = ? group by st.id";
			System.out.println(query);
			List<FilterBean> handler = jdbcTemplate.query(query, new Object[]{boardId,classId},ParameterizedBeanPropertyRowMapper.newInstance(FilterBean.class));
			 System.out.println(query);
	     
			 return handler;
	  }
		public List<FilterBean> getMediumFilter(String boardId,String classId ,String sectionId)
		{

			String query = "select m.id,m.name as mediumName from classcreation cc ,classtable ct,boardname bn, sectiontable st,mediam m "+
							" where cc.boardId = bn.id and ct.id =cc.className and st.id = cc.section  and m.id = cc.mediamId "+
							" and bn.id= ? and ct.id = ? and st.id = ? group by m.id";
			System.out.println(query);
			List<FilterBean> handler = jdbcTemplate.query(query, new Object[]{boardId,classId,sectionId},ParameterizedBeanPropertyRowMapper.newInstance(FilterBean.class));
			 System.out.println(query);
	     
			 return handler;
	  }
}

