package com.pollverse.model;

public class Vote {
	private int id;
	private int pollId;
	private int userId;
	private int selectedOption;
	
	@Override
	public String toString() {
		return "Vote [id=" + id + ", pollId=" + pollId + ", userId=" + userId + ", selectedOption=" + selectedOption
				+ "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPollId() {
		return pollId;
	}
	public void setPollId(int pollId) {
		this.pollId = pollId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getSelectedOption() {
		return selectedOption;
	}
	public void setSelectedOption(int selectedOption) {
		this.selectedOption = selectedOption;
	}
	

	
	
	
}
