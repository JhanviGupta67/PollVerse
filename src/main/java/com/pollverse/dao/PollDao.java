package com.pollverse.dao;

import java.util.List;

import com.pollverse.model.Poll;

public interface PollDao {
	 // Saves a new poll created by a user.
	public int savePoll(Poll poll);
	 // Retrieves a single poll by its ID.
	public Poll findById(int id);
	 // Retrieves all polls (for the main voting page).
	public List<Poll> findAll();
	// Retrieves only the polls created by a specific user (for the "My Polls" page).
	public List<Poll> findByUserId(int userId);
	   // Updates a poll (e.g., question or options—though complex updates might be rare).
	public int updatePoll(Poll poll);
	   // Deletes a poll by its ID.
	public int deletePoll(int id);

}
