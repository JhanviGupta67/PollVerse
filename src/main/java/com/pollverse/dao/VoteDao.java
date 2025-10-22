package com.pollverse.dao;

import java.util.Map;

import com.pollverse.model.Vote;

public interface VoteDao {
	public int recordVote(Vote vote);
	public boolean hasUserVoted(int userId, int pollId);
	public Map<Integer, Long> getVoteCounts(int pollId); //A Map where Key=OptionNumber (Integer) and Value=VoteCount (Long).
	
}
