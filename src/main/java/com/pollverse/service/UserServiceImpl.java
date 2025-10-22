package com.pollverse.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.pollverse.dao.UserDao;
import com.pollverse.model.User;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDao userDao;
	
	PasswordEncoder encoder = new BCryptPasswordEncoder();

	@Override
	public void registerUser(User user) {
		String hashedPassword = encoder.encode(user.getPassword());
		
		userDao.saveUser(user, hashedPassword);
		
	}

	@Override
	public User loginUser(String username, String password) {
		User storedUser = userDao.findUserByName(username);
		
		if(storedUser == null) {
			return null;
		}
		String hashPassword = storedUser.getPassword();
		
		if(encoder.matches(password, hashPassword)) {
			return storedUser;
		}else {
			return null;
		}
	}

	@Override
	public boolean doesUserNameExists(String username) {
		
		return userDao.findUserByName(username) != null;
	}

}
