package com.pollverse.dao;

import com.pollverse.model.User;

public interface UserDao {
	public int saveUser(User user, String hashedPassword);
	public User findUserByName(String username);

}
