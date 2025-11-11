package com.pollverse.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.pollverse.model.Poll;

@Repository
public class PollDaoImpl implements PollDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	
    private final RowMapper<Poll> rm = new RowMapper<Poll>() {
        @Override
        public Poll mapRow(ResultSet rs, int rowNum) throws SQLException {
            Poll poll = new Poll();
            poll.setId(rs.getInt("id"));
            poll.setUserId(rs.getInt("user_id")); 
            poll.setQuestion(rs.getString("question"));
            poll.setOption1(rs.getString("option1"));
            poll.setOption2(rs.getString("option2"));
            poll.setOption3(rs.getString("option3"));
            poll.setOption4(rs.getString("option4"));
            poll.setCreatedAt(rs.getTimestamp("created_at"));
            return poll;
        }
    };

	@Override
	public int savePoll(Poll poll) {
		String query = "INSERT INTO polls(user_id,question,option1,option2,option3,option4) VALUES(?,?,?,?,?,?)";
		int r = this.jdbcTemplate.update(query, poll.getUserId(),poll.getQuestion(),poll.getOption1(),poll.getOption2(),poll.getOption3(),poll.getOption4());	
		return r;
	}

	@Override
	public Poll findById(int id) {
		String query = "SELECT * FROM polls WHERE id=?";
		Poll poll = this.jdbcTemplate.queryForObject(query, rm, id);
		return poll;
	}

	@Override
	public List<Poll> findAll() {
		String query = "SELECT * FROM polls ORDER By id DESC"; 
		List<Poll> polls = this.jdbcTemplate.query(query, rm); // FIXED: Renamed variable to 'polls'
		return polls;
	}

	@Override
	public List<Poll> findByUserId(int userId) {
		String query = "SELECT * FROM polls WHERE user_id=? ORDER BY id DESC";
		List<Poll> polls = this.jdbcTemplate.query(query, rm, userId); // FIXED: Renamed variable to 'polls'
		return polls;
	}

	@Override
	public int updatePoll(Poll poll) {
        // FIXED: Corrected SQL syntax and used poll.getUserId()
		String query = "UPDATE polls SET question=?, option1=?, option2=?, option3=?, option4=? WHERE id=? AND user_id=?";
		int r = this.jdbcTemplate.update(query,
            poll.getQuestion(),
            poll.getOption1(),
            poll.getOption2(),
            poll.getOption3(),
            poll.getOption4(),
            poll.getId(), // Update targets this ID
            poll.getUserId() // FIXED: Used correct method
        );
		return r;
	}

	@Override
	public int deletePoll(int id) {
		String query = "DELETE FROM polls WHERE id=?";
		int r = this.jdbcTemplate.update(query, id);
		return r;
	}

}