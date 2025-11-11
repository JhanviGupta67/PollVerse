package com.pollverse.service;

import java.util.List;
import java.util.Map;

import com.pollverse.model.Poll;

public interface PollService {
	public void savePoll(Poll poll);
	public Poll getPollById(int pollId);
	public List<Poll> getAllPolls();
	public List<Poll> getPollsByUser(int userId);
	public int deletePoll(int pollId);
	public void processVote(int pollId, int userId, int selectedOption);
	public Map<Integer, Long> getPollResult(int pollId);
	boolean hasUserVoted(int pollId, int userId);

}
