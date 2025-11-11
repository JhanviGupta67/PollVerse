package com.pollverse.controller; 
import java.util.List;
import java.util.Map; 
import javax.servlet.http.HttpSession; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller; 
import org.springframework.ui.Model; 
import org.springframework.web.bind.annotation.GetMapping; 
import org.springframework.web.bind.annotation.ModelAttribute; 
import org.springframework.web.bind.annotation.PathVariable; 
import org.springframework.web.bind.annotation.PostMapping; 
import org.springframework.web.bind.annotation.RequestMapping; 
import org.springframework.web.bind.annotation.RequestParam; 
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.pollverse.model.Poll; 
import com.pollverse.service.PollService; 

@Controller
@RequestMapping("/poll") 
public class PollController {
	private final PollService pollService; 
	
	@Autowired 
	public PollController(PollService pollService) { 
		this.pollService = pollService;
		} 
	
	// Utility method to check login 
	private Integer getUserIdFromSession(HttpSession session, RedirectAttributes redirectAttributes) { 
		Integer userId = (Integer) session.getAttribute("userId"); 
		if (userId == null) { 
			redirectAttributes.addFlashAttribute("error", "You must be logged in to access this page"); 
			return null;
			} 
		return userId; 
			} 
	
	// ✅ My Polls (created by logged in user) 
	@GetMapping("/mypolls") 
	public String getMyPolls(HttpSession session, Model model) { 
		Integer userIdObj = (Integer) session.getAttribute("userId"); 
		System.out.println("Session userId: " + userIdObj); // debug 
		if (userIdObj == null) { 
			return "redirect:/login"; 
			} 
		List<Poll> myPolls = pollService.getPollsByUser(userIdObj); 
		System.out.println("Number of polls fetched: " + myPolls.size()); // debug 
		model.addAttribute("myPolls", myPolls);
		return "myPolls"; 
		}
	
	// ✅ Show all available polls 
	@GetMapping("/list")
	public String showPollsList(Model m, HttpSession session) { 
		List<Poll> polls = pollService.getAllPolls(); 
		m.addAttribute("polls", polls); 
		m.addAttribute("username", session.getAttribute("username")); 
		return "pollList"; 
		}
	
	// ✅ Show poll creation form 
	@GetMapping("/create") 
	public String showCreatePollForm(HttpSession session, RedirectAttributes redirectAttributes, Model m) { 
		if (getUserIdFromSession(session, redirectAttributes) == null) { 
			return "redirect:/login"; 
			} 
		m.addAttribute("poll", new Poll()); 
		return "createPoll"; 
		}
	
	// ✅ Process poll creation 
	@PostMapping("/create") public String processCreatePoll(@ModelAttribute("poll") Poll poll, HttpSession session, RedirectAttributes redirectAttributes) { 
		Integer userId = getUserIdFromSession(session, redirectAttributes); 
		if (userId == null) { 
			return "redirect:/login"; 
			}
		poll.setUserId(userId); 
		try { 
			pollService.savePoll(poll); 
			redirectAttributes.addFlashAttribute("message", "Poll created successfully!"); 
			return "redirect:/home"; 
			} catch (Exception e) { 
				redirectAttributes.addFlashAttribute("error", "Failed to create poll: " + e.getMessage());
				return "redirect:/poll/create"; 
				} 
		} 
	
	// ✅ View a poll (shows either vote form OR results if user already voted)
	@GetMapping("/view/{pollId}") public String viewPoll(@PathVariable int pollId, HttpSession session, Model model) { 
		Poll poll = pollService.getPollById(pollId); 
		model.addAttribute("poll", poll); 
		Integer userId = (Integer) session.getAttribute("userId"); 
		boolean isLoggedIn = userId != null; 
		boolean hasVoted = false; 
		if (isLoggedIn) { 
			hasVoted = pollService.hasUserVoted(pollId, userId); 
			}
		model.addAttribute("isLoggedIn", isLoggedIn); 
		model.addAttribute("hasVoted", hasVoted); 
		
		// Show results if already voted 
		if (hasVoted) { 
			Map<Integer, Long> results = pollService.getPollResult(pollId); 
			long totalVotes = results.values().stream().mapToLong(Long::longValue).sum();
			model.addAttribute("results", results); 
			model.addAttribute("totalVotes", totalVotes); 
			} 
		return "viewPoll"; 
		} 
	
	// ✅ Process vote
	@PostMapping("/vote/{pollId}") 
	public String processVote(@PathVariable("pollId") int pollId, @RequestParam("selectedOption") int selectedOption, HttpSession session, RedirectAttributes redirectAttributes) { 
		Integer userId = getUserIdFromSession(session, redirectAttributes); 
		if (userId == null) { 
			return "redirect:/login"; 
			} 
		try { 
			pollService.processVote(pollId, userId, selectedOption); 
			redirectAttributes.addFlashAttribute("message", "Your vote has been recorded!"); 
			} catch (IllegalStateException e) {
				redirectAttributes.addFlashAttribute("error", e.getMessage());
				} catch (Exception e) {
					redirectAttributes.addFlashAttribute("error", "Voting failed due to an unexpected error.");
					}
		return "redirect:/poll/view/" + pollId; 
		} 
	
	// ✅ Delete a poll (only if owner) 
	@GetMapping("/delete/{pollId}") 
	
	public String deletePoll(@PathVariable("pollId") int pollId, HttpSession session, RedirectAttributes redirectAttributes) { 
		Integer userId = getUserIdFromSession(session, redirectAttributes); 
		if (userId == null) {
			return "redirect:/login"; 
			} 
		try {
			Poll poll = pollService.getPollById(pollId); 
			if (poll == null || poll.getUserId() != userId) {
				redirectAttributes.addFlashAttribute("error", "Unauthorized action: You can only delete your own polls."); 
				return "redirect:/poll/list"; 
				}
			pollService.deletePoll(pollId);
			redirectAttributes.addFlashAttribute("message", "Poll successfully deleted."); 
			} catch (Exception e) { 
				e.printStackTrace(); // 👈 Print actual error in console 
				redirectAttributes.addFlashAttribute("error", "Failed to delete poll."); 
				}
		return "redirect:/poll/list"; 
		}
	}
	
	
