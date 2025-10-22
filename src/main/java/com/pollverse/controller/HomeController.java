package com.pollverse.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    /**
     * Handles the base URL request ('/') and directs to the welcome page.
     * @return The logical view name "welcome".
     */
	 @GetMapping("/")
	    public String redirectToWelcome() {
	        return "redirect:/welcome"; 
	    }
    
}