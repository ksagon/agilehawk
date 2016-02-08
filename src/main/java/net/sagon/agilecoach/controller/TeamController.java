package net.sagon.agilecoach.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import net.sagon.agilecoach.model.Team;

@Controller
@RequestMapping("/agile")
public class TeamController {

	@RequestMapping("/team")
	public String getTeam(ModelMap model) {
		model.addAttribute("team", new Team());

		return "team";
	}

	
}
