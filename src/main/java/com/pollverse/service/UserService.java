package com.pollverse.service;

import com.pollverse.model.User;

public interface UserService {
	// Handles registration, including password hashing.
	public void registerUser(User user);
	 // Handles login verification and session data retrieval.
	public User loginUser(String username, String password);
    // Checks if a username already exists before registration.
	public boolean doesUserNameExists(String username);

}
