package com.pollverse.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.pollverse.model.Vote;

@Repository
public class VoteDaoImpl implements VoteDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public int recordVote(Vote vote) {
		String query = "Insert into votes(poll_id,user_id,selected_option) values(?,?,?)";
		int r = this.jdbcTemplate.update(query,  vote.getPollId(), vote.getUserId(), vote.getSelectedOption());
		return r;
	}

	@Override
	public boolean hasUserVoted(int userId, int pollId) {
		String query = "Select Count(*) from votes where user_id=? AND poll_id=?";
		Integer count = this.jdbcTemplate.queryForObject(query,Integer.class, userId, pollId); 
		return count != null && count >0;
	}

	@Override
	public Map<Integer, Long> getVoteCounts(int pollId) {
		  // SQL using COUNT and GROUP BY to aggregate votes per option
        String sql = "SELECT selected_option, COUNT(selected_option) AS vote_count FROM votes WHERE poll_id = ? GROUP BY selected_option";
        
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql, pollId);
        Map<Integer, Long> voteCounts = new HashMap<>();

        // Map the List<Map> results into the desired Map<Integer, Long> structure
        for (Map<String, Object> row : rows) {
            Integer option = (Integer) row.get("selected_option");
            // The COUNT function returns a Long in JdbcTemplate
            Long count = (Long) row.get("vote_count"); 
            voteCounts.put(option, count);
        }

        return voteCounts;
    }

}
