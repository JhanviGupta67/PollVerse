package com.pollverse.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pollverse.dao.PollDao;
import com.pollverse.dao.VoteDao;
import com.pollverse.model.Poll;
import com.pollverse.model.Vote;

@Service
public class PollServiceImpl implements PollService {
	
	@Autowired
	private PollDao pollDao;
	
	@Autowired
	private VoteDao voteDao;

	@Override
	public void savePoll(Poll poll) {
		pollDao.savePoll(poll);
		
	}

	@Override
	public Poll getPollById(int pollId) {
		return pollDao.findById(pollId);
	}

	@Override
	public List<Poll> getAllPolls() {
		return pollDao.findAll();
	}

	@Override
	public List<Poll> getPollsByUser(int userId) {
		return pollDao.findByUserId(userId);
	}

	@Override
	public int deletePoll(int pollId) {
		return pollDao.deletePoll(pollId);
	}

	@Override
	public void processVote(int pollId, int userId, int selectedOption) {
		 // Step 1: CRITICAL Validation (Check if user already voted)
        if (voteDao.hasUserVoted(userId, pollId)) {
            // In a real app, you would throw a custom exception here.
            // For now, we'll just stop the process.
            throw new IllegalStateException("User has already voted on poll ID: " + pollId);
        }
        
        // Step 2: Create the Vote object
        Vote newVote = new Vote();
        newVote.setPollId(pollId);
        newVote.setUserId(userId);
        newVote.setSelectedOption(selectedOption);
        
        // Step 3: Record the vote (DAO handles persistence)
        voteDao.recordVote(newVote);
    }

	//to calculate poll result
	@Override
	public Map<Integer, Long> getPollResult(int pollId) {
	    // Fetch counts from DAO
	    Map<Integer, Long> rawCounts = voteDao.getVoteCounts(pollId); // Might return only options with votes

	    // Ensure all options exist in map
	    Map<Integer, Long> results = new HashMap<>();
	    for (int i = 1; i <= 4; i++) {
	        results.put(i, rawCounts.getOrDefault(i, 0L));
	    }

	    return results;
	}
	
	@Override
	public boolean hasUserVoted(int pollId, int userId) { 
		return voteDao.hasUserVoted(userId, pollId); }

}
