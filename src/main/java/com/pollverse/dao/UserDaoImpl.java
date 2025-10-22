package com.pollverse.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.pollverse.model.User;

@Repository
public class UserDaoImpl implements UserDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	
	private RowMapper<User> rm = (rs, rowNum) -> {
	    User u = new User();
	    u.setId(rs.getInt("id"));
	    u.setUsername(rs.getString("username"));
	    u.setPassword(rs.getString("password"));
	    u.setEmail(rs.getString("email"));
	    return u;
	  };

	@Override
	public int saveUser(User user, String hashedPassword) {
		String query = "Insert into users(username,password,email) values(?,?,?)";
		int r = this.jdbcTemplate.update(query, user.getUsername(),hashedPassword, user.getEmail());
		return r;
	}

	@Override
	public User findUserByName(String username) {
		String query = "Select * from users where username=?";
		try {
			User u = this.jdbcTemplate.queryForObject(query, rm,username);
			return u;
		}catch(EmptyResultDataAccessException e) {
			return null;
		}
		
	}

}
