package com.pollverse.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pollverse.model.User;
import com.pollverse.service.UserService;

@Controller
//@RequestMapping("/user")
public class UserController {
	
	private final UserService userService; // Dependency is now final

    @Autowired // Apply @Autowired to the constructor for clean, immutable injection
	 public UserController(UserService userService) {
	        this.userService = userService;
	    }
	
    @GetMapping("/welcome")
    public String showWelcomePage() {
        return "welcome"; // logical view name
    }
    @GetMapping("/home")
    public String showHomePage(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        // Check if user is logged in
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            redirectAttributes.addFlashAttribute("error", "You must login first!");
            return "redirect:/login";
        }

        // Pass username and role to the view
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("userRole", session.getAttribute("role")); // important for dynamic buttons

        // Optionally, you can fetch active polls here to display on dashboard
        // e.g., model.addAttribute("activePolls", pollService.getActivePolls());

        return "home"; // home.html (Tailwind version)
    }
    
	@GetMapping("/register")
	public String showRegister(Model m) {
		m.addAttribute("user", new User());
		return "register";
	}
	
    
	@PostMapping("/register")
	public String processRegister(@ModelAttribute("user") User user, RedirectAttributes redirectAttributes) {


	    // Basic validation
	    if (user.getUsername() == null || user.getUsername().trim().isEmpty() ||
	        user.getPassword() == null || user.getPassword().isEmpty()) {
	        System.out.println("⚠️ Validation failed: Empty username or password");
	        redirectAttributes.addFlashAttribute("error", "Username and Password cannot be empty.");
	        return "redirect:/register";
	    }

	    // Check if username exists
	    System.out.println("🔍 Checking if username already exists...");
	    if (userService.doesUserNameExists(user.getUsername())) {
	        System.out.println("❌ Username already taken: " + user.getUsername());
	        redirectAttributes.addFlashAttribute("error", "Username already taken");
	        return "redirect:/user/register";
	    }

	    try {
	        
	        userService.registerUser(user);
	        redirectAttributes.addFlashAttribute("message", "Registration successful");
	        return "redirect:/login";

	    } catch (Exception e) {
	        System.out.println("❌ Exception caught during registration:");
	        e.printStackTrace();  // should print the actual cause now
	        redirectAttributes.addFlashAttribute("error", "Registration failed due to an unexpected error");
	        return "redirect:/user/register";
	    }
	}

	
    
    @GetMapping("/login") // <-- FIXED: Added missing mapping annotation
	public String showLogin(Model m) {
		m.addAttribute("user", new User());
		return "login";
	}

   
	 @PostMapping("/login")
	    public String loginUser(@ModelAttribute("user") User user, HttpSession session, RedirectAttributes redirectAttributes) {
	        
	        // Service handles authentication (hash matching)
	        User authenticatedUser = userService.loginUser(user.getUsername(), user.getPassword());

	        if (authenticatedUser != null) {
	            // Success: Store user information in the HTTP session
	            session.setAttribute("userId", authenticatedUser.getId());
	            session.setAttribute("username", authenticatedUser.getUsername());
	            redirectAttributes.addFlashAttribute("message", "Welcome back, " + authenticatedUser.getUsername() + "!");
	            
	            // Redirect to the main poll listing page
	            return "redirect:/home"; 
	        } else {
	            // Failure: User not found or password mismatch
	            redirectAttributes.addFlashAttribute("error", "Invalid username or password.");
	            return "redirect:/login"; 
	        }
	    }

	    
	    @GetMapping("/logout")
	    public String logoutUser(HttpSession session, RedirectAttributes redirectAttributes) {
	        // Invalidate the entire session
	        session.invalidate(); 
	        redirectAttributes.addFlashAttribute("message", "You have been logged out successfully.");
	        // Redirect back to the login page or the homepage
	        return "redirect:/login"; 
	    }
}
