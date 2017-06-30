package com.aurospaces.neighbourhood.db.dao;

import java.util.List;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.simple.ParameterizedBeanPropertyRowMapper;
import org.springframework.stereotype.Repository;

import com.aurospaces.neighbourhood.bean.StudentBean;
import com.aurospaces.neighbourhood.bean.UsersBean;
import com.aurospaces.neighbourhood.daosupport.DaoSupport;
import com.aurospaces.neighbourhood.db.basedao.BaseUserDao;

@Repository(value = "usersDao1")
public class usersDao1 extends BaseUserDao  {

	 public UsersBean loginDetails(UsersBean userBean ) {
			String sql = "SELECT * from users where name = ? and password = ? and rolId =? ";
			List<UsersBean> retlist = jdbcTemplate.query(sql,
			new Object[]{userBean.getName(),userBean.getPassword(),userBean.getRolId()},
			ParameterizedBeanPropertyRowMapper.newInstance(UsersBean.class));
			if(retlist.size() > 0)
				return retlist.get(0);
			return null;
		}
}
